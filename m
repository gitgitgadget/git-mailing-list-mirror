From: Sam Vilain <sam@vilain.net>
Subject: Re: Multi-headed branches (hydra? :)) for basic patch calculus
Date: Mon, 03 Apr 2006 11:15:43 +1200
Message-ID: <44305B1F.7030509@vilain.net>
References: <1143950852.21233.23.camel@localhost.localdomain> <e0ns59$uq2$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 01:16:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQBnc-0000c1-MT
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 01:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWDBXP6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Apr 2006 19:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWDBXP6
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 19:15:58 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:3729 "EHLO watts.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751527AbWDBXP5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 19:15:57 -0400
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id 7A19C5FE5; Mon,  3 Apr 2006 11:15:53 +1200 (NZST)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id 7B1201C21;
	Mon,  3 Apr 2006 11:15:47 +1200 (NZST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e0ns59$uq2$1@sea.gmane.org>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18296>

Jakub Narebski wrote:

>>However, if there was support for "hydra", or heads that are multiple
>>commit IDs (and necessarily, no blobs in corresponding paths in their
>>trees that are not identical), then you would not need to destroy and
>>recreate this dummy merge head commit to model your patch history in
>>this manner.
>>   =20
>>
>[...]
>
>I'm not sure if "hydras", i.e. multi-commit 'heads' are what would mak=
e
>GIT able to use some of Darcs patches calculus ideas. If I understand
>correctly in GIT 'head' (and 'tag') not only identifies commit (commit=
s
>in hydra[1]) but also tree (in hydra it is result of trivial (?) merge=
).
> =20
>

Whether it is stored as a procession of trees or as a sequence of
patches does not actually make a difference to a mathematician.

This might not sound right at first, but think that it does not matter
whether you have the number "4" which came after "3" that you store it
as "4 (3 was prior)" or "1+1+1+1".  =E2=84=95 (the set of natural numbe=
rs) is
itself defined by induction, yet this is not important for functions
that deal with natural number elements.

>Wouldn't it be better to somehow represent rather partial ordering bet=
ween
>commits in history, to have something from Darcs in GIT?  Although I'm=
 not
>sure about efficiency, and if we should do detect commits dependency -=
- or
>in other words partial ordering of commits/patches -- at commit or at
>merge.
>

That is more or less what I proposed, except that the ordering is built
at commit time to pick a best head rather than when you try to pull the
patch, which seems a trivial difference at best.

I think git-commit --hydra is called for.

=46irst we define a "hydra leash", I can think of two definitions:

 - a hydra leash is a specially marked commit
 - a hydra leash is a commit that has multiple parents, and is
   the result of just an index merge of its parents

We must also define the concept of a commit being "against" the head(s)
of a hydra.

With that term in mind, we can make "--hydra" do as follows:

 a) find the head(s) of the hydra that the commit is against;
 b) apply the commit, and set its parents to those head(s)
 c) put the hydra leash back on.

Ideally the leash should not have the previous leash as one of its
parents; that leash was always transient and keeping its history is
perhaps not required, and would break the latter leash detection method
described above.

Instead, git-pull et al should know what to do.

> And if we should remember (or cache) partial ordering/dependency
>info...
>
>[1] I've detected some confusion in this terminology. "Hydra" is
>multi-headed moster, yet in your ptoposal it is one head that has mult=
iple
>bodies... and "octopus" is taken. I guess the terminology should be
>switched (octopus <-> hydra).
> =20
>

A head is a head because there is only one of it, and it's at the top.=20
If the leash is transient then it doesn't really exist, and therefore
can't be called a head.  So, you look instead at the heads remaining,
and where you expected to see an entity with a single head you see many
heads.

Sam.

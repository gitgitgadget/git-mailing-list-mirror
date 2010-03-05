From: Jonathan Nieder <jrnieder@gmail.com>
Subject: git reset --keep (Re: What's cooking in git.git (Mar 2010, #01;
 Wed, 03))
Date: Fri, 5 Mar 2010 10:25:21 -0600
Message-ID: <20100305162521.GA25120@progeny.tock>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
 <7vmxynydac.fsf@alter.siamese.dyndns.org>
 <7vk4trlhim.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 17:25:27 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnaL6-0004oz-M8
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 17:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279Ab0CEQZO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Mar 2010 11:25:14 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54419 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab0CEQZM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 11:25:12 -0500
Received: by pvb32 with SMTP id 32so770448pvb.19
        for <git@vger.kernel.org>; Fri, 05 Mar 2010 08:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=f+aK4bE7zCnT2kR1dvxFK6l20Zy9Wn8wFhYUKbG6xjk=;
        b=DMxezc2qlMrWIZvtyBnTP50YXhJaYa5acyaR1LayDlrOH2nV/1vcbnPKyBz4lWTu9p
         7Z4tZ76nOKtxRHE9YtWwGC6qu4ZBzESj1g2HVNBXQj4mLVjQKvKMndo/Ab56SXSL42tE
         wxNfkuqWxybtPQvTPhGGr7ngvF1o6b1chQ/ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=t8eZ7KBcSlbmzL5p66ONJfJPmtvltYpRj6oytxPddHj9LCbn05BlkYPbBo3e0LO1Rv
         l492awZQQzRnZ+CXKpTNv4xdi6KyCFnnpwXP2EDU2MHZAmG89I+NWB+9Tw9iB/ZX3H6z
         2OQbWGZqspo+Hq0uErcytoAVTIMEjz2J3yMnI=
Received: by 10.115.100.37 with SMTP id c37mr830638wam.126.1267806310701;
        Fri, 05 Mar 2010 08:25:10 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1557443iwn.0.2010.03.05.08.25.09
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 05 Mar 2010 08:25:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vk4trlhim.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141587>

Junio C Hamano wrote:

> Do you think I finally understood what "reset --keep" is about?

Probably. :)  Let me take the opportunity to give some examples of what
I am hoping to use it for, to see if I am crazy.

> Nah, what was I thinking.  If I rephrase your side note <2> and <3> a
> little bit, everything makes sense.  Perhaps like so:
>=20
>     <2> In the ideal world, you could have realized that the earlier
>     commit did not belong to the new topic when you created and switc=
hed
>     to branch2 (i.e. "git checkout -b branch2 start"), but nobody is
>     perfect.
>=20
>     <3> But you can use "reset --keep" to remove the unwanted commit =
after
>     you switched to "branch2".
>=20
> And it becomes very clear that "reset --keep" is a sensible way to re=
cover
> from this mistake.  No need to do "read-tree -m -u" followed by "rese=
t"
> anymore.

Yes, this (recovery from a wrong choice of starting commit for a new
branch) makes sense.  Here are some other planned uses:

1. Helping people new to git.

A person not very familiar with git comes to me asking how to undo
the last couple of commits.  After a quick conversation, it becomes
clear that the commits in question were not pushed out to any public
repository and that this person does not feel it would be useful to
publish the problem commits.

Currently, I would have to advise such a person to use

	git reset --hard HEAD^^

I would prefer to recommend

	git reset --keep HEAD^^

because if there are uncommitted changes then it will give a "needs
update" message (right?) and I can help the person to deal with it.

2. Splitting up a huge patch.

Suppose I have a huge patch consisting of several unrelated changes
applied to the work tree but not commited.  I want to split it into
logical changes, commiting each one, and when I am done I will use a
loop reading from git rev-list to test all the resulting commits
automatically.  A workflow for this looks something like the
following:

 git checkout -b series1
 git add -p
 git commit
 git add -p
 git commit
 git checkout -b series2 appropriate-base
 git add -p
 git commit
 ...

Having 'git reset --keep' available would add some flexibility:

 * As you mentioned, reset --keep would let me recover from 'git
   checkout -b' to the wrong commit.
 * As in example 1, if some part of the patch turns out to be a
   bad idea after all, I can try to discard it.

A 'git stash' might be worth avoiding in some cases because it touches
unrelated files, which means wasted time rebuilding everything.

3. Keeping unrelated extra changes around.

Suppose I am Linus, and I keep on forgetting to update the version
number in a file named version.h or something.  So I update it in
advance as soon as I remember, but I do not commit the change or
register it in the index because it is not time yet.

Then in almost every instance when I would have normally used
'reset --hard', I should use 'reset --keep' instead.  The only
exception is when I am mean =E2=80=9Cscrew it all, reset to a completel=
y
known state=E2=80=9D; in that case, I will have to update version.h by =
hand
again.

From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] pathspec: reserve some letters after a colon pathspec
Date: Thu, 24 Mar 2011 08:15:39 +0100
Message-ID: <4D8AEF9B.9050001@drmicha.warpmail.net>
References: <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <1300894353-19386-1-git-send-email-pclouds@gmail.com> <7vvcz9emrn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 08:19:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2epG-0004st-1V
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 08:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933291Ab1CXHTQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 03:19:16 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:47603 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933034Ab1CXHTP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2011 03:19:15 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A7FEA2086C;
	Thu, 24 Mar 2011 03:19:14 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 24 Mar 2011 03:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=wIb1s+QunwQ31GEBEuh+283mMa8=; b=Vpo+M58fymssIcCsJMAPeiXTPFJsDDHbrP5giWMVbQPqnc6jw21/h9oWTlVo3OrUOBqnzixZaLo6U3BcIZe5A/D8HxEmZA2UBXAkD0UnF/NQlx94KUfyDIP2/myFdAFtPvVTjxRC2q+MolgHJSDz08doHZZ0CsUm5DFUF/P7u7k=
X-Sasl-enc: 6UXbjRz+ouV/Z+suxYN/L5TNx48siEd2pN3eG0X13S1L 1300951154
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DDE4D40652B;
	Thu, 24 Mar 2011 03:19:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vvcz9emrn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169895>

Junio C Hamano venit, vidit, dixit 23.03.2011 19:04:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>=20
>> Pathspec ':something' means 'something' at top directory. Limit it a
>> bit so that ':<non-alnum>something' can be reserved for future
>> extensions. ':\<non-alnum>something' can be used to achieve
>> ':something' before this patch.
>>
>> All non-alphanumeric chars on the en_US keyboard, except \ and ., ar=
e
>> currently reserved.
>=20
> While I was writing the other message, I really was hoping that peopl=
e
> would notice that trying to limit the magic signature (i.e. "which ma=
gic I
> want" in my previous message) to a non-alnum letter that cannot easil=
y be
> remembered would be a bad direction.  A set of short mnemonic is fine=
, but
> we probably should prepare the syntax framework to reserve spelled ou=
t
> magic names for readability.
>=20
> Here is a weather-baloon.  I will use colon below as the magic introd=
ucer,
> as I don't care very deeply about the choice of it.
>=20
>  - "^:([^\w\d]+)(.*)$", that is "a magic introducer followed by a seq=
uence
>    of non-alnum followed by the remainder" means that the part that i=
s
>    given to the matching engine is $2, and each gibberish character i=
n $1
>    determines what magic is requested when the matching engine does i=
ts
>    work.  Among the gibberish that can be in $1, we currently would w=
ant
>    to support:
>=20
>     . '/' denotes that $2 is relative to root of the working tree, i.=
e. do
>       not add 'prefix' to it at the left.
>=20
>     . '!' denotes that the matching with $2 should not honor globbing=
=2E
>=20
>    e.g.
>=20
>     ":/*lib/**/foo.h", if '*' denoted recursive glob support for '**/=
' to
>     mean "zero-or-more levels of any directory" [*1*], it would find =
any
>     foo.h in a directory 'lib' or its subdirectory that is found in
>     anywhere in the working tree.
>=20
>  - "^:((?:[-a-z]+)(?:,[-a-z+]+)*):(.*)$", that is "a magic introducer=
,
>    followed by one or more alpha-string separated with comma, followe=
d
>    by a magic terminator, and the remainder" means that the remainder=
 is
>    what is given to the matching engine, and the alpha-strings spell =
out
>    the name of the magic.  We currently would want to support:
>=20
>     . 'full-tree' means exactly the same as '/' mnemonic above.
>     . 'noglob' means exactly the same as '!' mnemonic.
>=20
>    e.g.
>=20
>    ":full-tree,recursive-glob:lib/**/foo.h" would be how you fully sp=
ell
>    the above example in the mnemonic section [*2*].

I like this a lot, especially the fact that we would have descriptive
long names as well as short versions for a subset! Two remarks:

:(symlink|submodule|directory|file): would fit into that scheme (for us=
e
in .gitattributes), though I'm not sure we want that for general
pathspecs. We probably want textconv applied to :file: only by default,
attributes to match with :file only?

We already have ":./cdwfile" as in "commit:./cwdfile", and this looks
like a preexisting instance, although it is not ("commit:" gets strippe=
d
and "./cwdfile" is the pathspec). People will probably try something
like "commit:/rootfile", and we may or may not want to support this.
That particular one is easy, but "commit:full-tree:name" has a defined
meaning now...

Michael

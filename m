From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Proper tracking of copies in git log and others
Date: Tue, 07 Jul 2009 15:48:52 +0200
Message-ID: <4A535244.60502@drmicha.warpmail.net>
References: <4A4F8258.5070701@trn.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+dfhy@trn.iki.fi>
X-From: git-owner@vger.kernel.org Tue Jul 07 15:49:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOB2t-0000Ro-Pe
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 15:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754975AbZGGNtN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2009 09:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754655AbZGGNtM
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 09:49:12 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:51720 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754618AbZGGNtL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jul 2009 09:49:11 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 081973AF383;
	Tue,  7 Jul 2009 09:49:11 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 07 Jul 2009 09:49:11 -0400
X-Sasl-enc: H1qt4r99bReFDaEgdHSqXk02hp60DsmypHxrWF+5EjM1 1246974550
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 764BF3BAE;
	Tue,  7 Jul 2009 09:49:10 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.1pre) Gecko/20090707 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <4A4F8258.5070701@trn.iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122846>

Lasse K=E4rkk=E4inen venit, vidit, dixit 04.07.2009 18:24:
> Getting full history of a file, including that beyond copies, is rath=
er=20
> important and apparently not currently supported by git tools.
>=20
> An example use case:
>=20
> # Create repository
> mkdir courses
> cd courses
> git init
> # Course 2007
> mkdir -p 2007/exercise1
> echo Hello > 2007/exercise1/description.txt
> mkdir 2007/exercise2
> echo World > 2007/exercise2/description.txt
> git add 2007
> git commit -m "Course 2007"
> # Course 2008
> mkdir -p 2008/exercise1
> echo New one > 2008/exercise1/description.txt
> git add 2008
> git commit -m "Course 2008 exercise 1 (new)"
> cp -R 2007/exercise1 2008/exercise2
> git add 2008/exercise2
> git commit -a -m "Course 2008 exercise 2 (from 2007 exercise 1)"
> # Course 2009
> cp -R 2008 2009
> git add 2009
> git commit -m "Course 2009 recycled entirely from 2008"
>=20
> Now, if we do git log --follow 2009/exercise2/description.txt or=20
> 2009/exercise2, it only prints the "Course 2009" commit instead of th=
e=20
> full history because --follow doesn't follow copies. What we actually=
=20
> want is:
>=20
> commit 9e17341497b29735bc55b6631b43db6e2f50ed30
> Author: Lasse Karkkainen <tronic@trn.iki.fi>
> Date:   Sat Jul 4 19:05:57 2009 +0300
>=20
>      Course 2009 recycled entirely from 2008
>=20
> commit 8fd13a8667f0bc5c4851b366864a207fa85519bc
> Author: Lasse Karkkainen <tronic@trn.iki.fi>
> Date:   Sat Jul 4 19:05:57 2009 +0300
>=20
>      Course 2008 exercise 2 (from 2007 exercise 1)
>=20
> commit 593346660872ada80ba751688fffc7af7a31e124
> Author: Lasse Karkkainen <tronic@trn.iki.fi>
> Date:   Sat Jul 4 19:05:57 2009 +0300
>=20
>      Course 2007
>=20
> Note: the "Course 2008 exercise 1 (new)" commit is not listed, as it =
is=20
> unrelated to 2009/exercise2.
>=20
> Some nice people from #git suggested various commands that would find=
=20
> the previous version (e.g. 2008/exercise2) etc, but none of those got=
=20
> even close to getting this full history over multiple copies, with lo=
g=20
> messages.
>=20
> It would be useful if the git tools could produce history like this w=
ith=20
> all the tools (log, blame, gitk, etc), preferably with proper branchi=
ng=20
> guesses (guesses because there is no info on where the copy came from=
),=20
> but even a linear history (sorted by commit time?) would do much bett=
er=20
> than not having anything.

While there is a pending patch as Sean pointed out it still has issues.
=46or moves, "there is always only one", for copies there are at least
two. So which one do you follow?

If you want to know where the current contents of
2009/exercise2/description.txt come from then a simpler approach may be

git log -S$(git show HEAD:2009/exercise2/description.txt)

This gives you three commits. Guess which ones ;)

Michael

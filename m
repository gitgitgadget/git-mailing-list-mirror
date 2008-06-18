From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH v4] Implementation of fnmatch and the ignore rules
Date: Wed, 18 Jun 2008 08:43:43 +0200
Message-ID: <200806180843.43518.robin.rosenberg.lists@dewire.com>
References: <4852BCCA.4030404@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Florian =?utf-8?q?K=C3=B6berle?= <FloriansKarten@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 18 08:48:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8rSu-0000Rn-Hl
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 08:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756597AbYFRGrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jun 2008 02:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756585AbYFRGrZ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 02:47:25 -0400
Received: from av9-2-sn3.vrr.skanova.net ([81.228.9.186]:35673 "EHLO
	av9-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565AbYFRGrY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 02:47:24 -0400
Received: by av9-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 7B31537EC2; Wed, 18 Jun 2008 08:47:22 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av9-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 45D753886D; Wed, 18 Jun 2008 08:47:22 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 616D537E4A;
	Wed, 18 Jun 2008 08:47:21 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4852BCCA.4030404@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85365>

fredagen den 13 juni 2008 20.30.34 skrev Florian K=C3=B6berle:
> Hi
>=20
> Thanks for the suggestions and comments, the new patches are availabl=
e here:
> http://repo.or.cz/w/egit/florian.git?a=3Dshortlog;h=3Drefs/heads/mail=
inglist-patches-4
>=20
> I will send them as a reply to this email soon.
>=20
>=20
> The most noticeable change is that I improved the fnmatch functionali=
ty.
>=20
> All character classes of the type [:class:] work now.
> Other character classes, including the character classes [=3Dclass=3D=
] and
> [.class.] will cause a InvalidPatternException. The last two aren't
> supported at my bash neighter, but are defined in the POSIX standard.
>=20
> Two other implementation differences are:
>=20
> The bash shell doesn't support the full range of digits, but my
> implementatiton does. e.g. =DB=B9 (U+06F9 EXTENDED ARABIC-INDIC DIGIT=
 NINE)

Interesting. I'm not sure what to say here. Full compatibility with Git=
 or "better"?

> A pattern like [[:] results in a InvalidPatternException in my
> implementation. The shell has there a strange behavior: if the files =
"["
> and ":" exists then "ls [[:]" shows only ":".

Having : in  a filename is asking for trouble. I think the parser think=
s [[: as=20
in [[:alpha:]] and break the parsing somhow. This is possibly even unde=
fined,
so I think you should disallow this. [[\:] works in bash btw.

> The other main change is that I introduced a AbstractTestCase class
> which which offers functionality to create temporary folders.
> RepositoryTestCase extends now from this new class.
>=20
> An other patch reducing the duplication between AbstractTestCase and
> RepositoryTestCase class will follow soon, if you like the change.

Not trying to clean up got me into trouble with tons and tons of garbag=
e, that
is why I placed new repos in a directory and try to delete it if possib=
le. That
ofcourse excludes parallell runs. Anyone with a good idea on how to
really handle this?

> I also updated all license statements to the 3-clause BSD.
>=20
> Even if you don't like the last change (the AbstractTestCase change) =
it
> would be cool if you would accept at least some patches.

The patch constituents are somwehat loose. Would this rebase do?

pick e331b13 Added the package fnmatch and two exceptions.
squash 64d8aa2 Added the interface FilePattern.
squash ae7915f Added the class Rule.
squash 48496f5 Added the interface Rules.
squash d7f58cb Added the class FileNamePattern.
squash f757bf1 Added the class FilePathPattern.
pick 39ea57e Added the class IgnoreRuleListFactory.
squash b61bf41 Added a Rules interface implementation and a factory for=
 it.
pick f1c6c47 Added test class OverallIgnoreRulestest.
pick 5321c90 Formatted Constants class.
pick b59c160 Added constant REPOSITORY_DIRECTORY_NAME to Constants clas=
s.
squash 435b176 Added path related constants to the Constants class.
pick 76ad8d2 Added the class NoGitRepositoryFoundException.
pick 0164c9e Formatted Repository class.
pick fab1279 Added WorkTree class which can be constructed over Reposit=
ory.
squash afda1f4 Added findWorkTree method to Repository class.
pick eb61f60 Formatted RepositoryTestCase.
pick 5aca2f0 Added a super class for RepositoryTestCase with a createTe=
mporaryDirectory() method.
pick 9b6a188 Added the class LightFileTreeIterator and a test for it.
squash c9a4795 Added class LightFileTreeIterable.
pick 3b068aa Added the class PathNotInProjectDirectoryException.
pick ef7be7f Added the class AddRuleListFactory.
squash 0b81a9c Added class AddRulesFactory.
pick 9bbb0c3 Added the test class AddCommandIterationTest.

This groups patches into related chunks.

I had to run native2ascii -encoding UTF-8 on FileNameMatcherTest.java t=
o make it pass. The reason
ofcourse is that java doesn't specify a source file encoding. You can t=
ell javac which encoding to use,
but I think we better avoid it. For author names in comments I think we=
 have no choice but to state
that UTF-8 is the one and only encoding for comments and documentation =
where ascii is unavoidable.

native2ascii does these kinds of things

        public void testWordroupCase1() throws Exception {
-               assertMatch("[[:word:]]", "=C3=83=C2=B6", true, false);
+               assertMatch("[[:word:]]", "\u00f6", true, false);
        }

-- robin

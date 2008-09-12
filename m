From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 1/2] Issue 23: Resolve tag^0 as tag^{commit}
Date: Fri, 12 Sep 2008 08:47:13 +0200
Message-ID: <200809120847.13541.robin.rosenberg.lists@dewire.com>
References: <20080911213927.GA20238@diku.dk> <200809120047.58484.robin.rosenberg.lists@dewire.com> <20080912000007.GA31931@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Sep 12 08:53:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke2XW-00051K-Qr
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 08:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbYILGre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Sep 2008 02:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbYILGre
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 02:47:34 -0400
Received: from av9-1-sn2.hy.skanova.net ([81.228.8.179]:52545 "EHLO
	av9-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbYILGrd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2008 02:47:33 -0400
Received: by av9-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id D5A4838127; Fri, 12 Sep 2008 08:47:30 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av9-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id AAB0C3812E; Fri, 12 Sep 2008 08:47:30 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 2026437E46;
	Fri, 12 Sep 2008 08:47:30 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080912000007.GA31931@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95687>

fredagen den 12 september 2008 02.00.07 skrev Jonas Fonseca:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote Fri, Sep 12,=
 2008:
> > torsdagen den 11 september 2008 23.39.27 skrev Jonas Fonseca:
> > > Repository.resolve("tag^0") failed with "not a commit". Fix it an=
d add a
> > > test case for it.
> >=20
> > It seems this case is not *that* special. It is tag^N =3D=3D tag^{c=
ommit}^N
> > Same for tag~N =3D=3D tag^{commit}~N-
> =20
> git-rev-parse(1) says:
>=20
>  =B7 A suffix ^ to a revision parameter means the first parent of tha=
t
>    commit object.  ^<n> means the <n>th parent (i.e.  rev^ is
>    equivalent to rev^1). As a special rule, rev^0 means the commit
>    itself and is used when rev is the object name of a tag object tha=
t
>    refers to a commit object.
>=20
> but does take tag^1, however not tag^2. It looks like tag~N is broken=
 in
tag^2 means you have a merge commit. I think rev^0 is mentioned here
to mean that it is actually defined (and how).

> JGit ("not a commit") so should also be fixed if we want to be
> compatible with git-rev-parse.
>=20
> BTW, I just noticed that ^{} is not handled correctly either for tags=
=2E
>  =B7 A suffix ^ followed by an empty brace pair (e.g.  v0.99.8^{}) me=
ans
>    the object could be a tag, and dereference the tag recursively
>    until a non-tag object is found.
>=20
> Only one derefence is performed.
Good catch!

> > My fault, i guess, but it would be nice of you fixed it while you a=
re at it.
>=20
> I will try to make fixes for the above cases tomorrow.
>=20
> > Second, the testcase in the second patch fails on my machine.
> >=20
> > testDerefTaggedTagTree(org.spearce.jgit.lib.T0008_testparserev)
> > junit.framework.ComparisonFailure: expected:<[269e1253bad5c247c6bde=
37aa48ae1e03138206c]> but was:<[be83157b4ffe650d728ba4f98ad47b623b0d0c2=
0]>
> > 	at junit.framework.Assert.assertEquals(Assert.java:81)
> > 	at junit.framework.Assert.assertEquals(Assert.java:87)
> > 	at org.spearce.jgit.lib.T0008_testparserev.testDerefTaggedTagTree(=
T0008_testparserev.java:123)
>=20
> I reran all the test before formatting the patch, but after doing som=
e
> last minut changes. When I run all the tests using maven (inside
> NetBeans or from the command line) it tells me:
>=20
> 	Tests run: 428, Failures: 0, Errors: 0, Skipped: 0
>=20
> From the output it looks like the tests in the files named T000* are
> never run. However, where the breakage is (could be my setup) I don't
> know. Imran?
>=20
> Anyway, for now I will just run the single test specifically. Perhaps=
 I
> should just put this into the same patch. Anyway, the following shoul=
d
> fix it.
Yes, please resubmit after updating the rev-parsing code.

> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_tes=
tparserev.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_t=
estparserev.java
> index 2a1a4ad..1fc73b4 100644
> --- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparser=
ev.java
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparser=
ev.java
> @@ -117,7 +117,7 @@ public void testDerefTagIssue23() throws IOExcept=
ion {
>  	}
> =20
>  	public void testDerefTaggedTagTree() throws IOException {
> -		assertEquals("269e1253bad5c247c6bde37aa48ae1e03138206c",db.resolve=
("refs/tags/C").name());
> +		assertEquals("be83157b4ffe650d728ba4f98ad47b623b0d0c20",db.resolve=
("refs/tags/C").name());
>  		assertEquals("d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864",db.resolve=
("refs/tags/C^{commit}").name());
>  		assertEquals("856ec208ae6cadac25a6d74f19b12bb27a24fe24",db.resolve=
("refs/tags/C^{tree}").name());
>  	}
>=20
My guess is you added to original test tag C manually so it got an "non=
-deterministic" time stamp.

-- robin

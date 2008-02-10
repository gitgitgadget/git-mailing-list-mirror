From: David Watson <dwatson@mimvista.com>
Subject: Re: [EGIT PATCH 2/2] Resort entries in "normal" order before
	looking for conflicts
Date: Sun, 10 Feb 2008 16:11:09 -0500
Message-ID: <20080210211108.GB2026@mimvista.com>
References: <1202255166-4581-1-git-send-email-robin.rosenberg@dewire.com> <200802060150.37222.robin.rosenberg@dewire.com> <200802102113.50578.robin.rosenberg.lists@dewire.com> <200802102118.29647.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"Roger C. Soares" <rogersoares@intelinet.com.br>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:44:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOJyb-0006TQ-7T
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 22:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbYBJVnt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 16:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbYBJVnt
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 16:43:49 -0500
Received: from net-207-58-228-27.arpa.fidelityaccess.net ([207.58.228.27]:40632
	"EHLO zimbra.mimvista.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751039AbYBJVns (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 16:43:48 -0500
X-Greylist: delayed 1948 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Feb 2008 16:43:47 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.mimvista.com (Postfix) with ESMTP id E6743375DCC;
	Sun, 10 Feb 2008 16:07:47 -0500 (EST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -1.168
X-Spam-Level: 
X-Spam-Status: No, score=-1.168 tagged_above=-10 required=6.6
	tests=[AWL=-0.615, BAYES_00=-2.599, RCVD_IN_SORBS_DUL=2.046]
Received: from zimbra.mimvista.com ([127.0.0.1])
	by localhost (zimbra.mimvista.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 85Jdss2Iarov; Sun, 10 Feb 2008 16:07:45 -0500 (EST)
Received: from localhost (cpe-71-64-107-224.neo.res.rr.com [71.64.107.224])
	by zimbra.mimvista.com (Postfix) with ESMTP id B9325375C1E;
	Sun, 10 Feb 2008 16:07:44 -0500 (EST)
Mail-Followup-To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org,
	"Roger C. Soares" <rogersoares@intelinet.com.br>,
	"Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <200802102118.29647.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73419>

Looks reasonable enough to me.=20

On Sun, Feb 10, 2008 at 09:18:29PM +0100, Robin Rosenberg wrote:
> s=F6ndagen den 10 februari 2008 skrev Robin Rosenberg:
> > In order to fix a bug where everything is marked as modified, or in=
 some cases
> > not modified the unit tests. The fixes here continue to work, but I=
 want to
> > emphasize the tests. Comments?
>=20
> Actually the reverse. This the extension that works, the previous mai=
l contains
> the test that fails, i.e. testUnchangedComplex().
>=20
> You need this patch first though.=20
>=20
> -- robin
>=20
> From 6d169c4e682359d8832047662591e341e91d186d Mon Sep 17 00:00:00 200=
1
> From: Robin Rosenberg <robin.rosenberg@dewire.com>
> Date: Sun, 10 Feb 2008 20:01:53 +0100
> Subject: [PATCH] Tighten IndexDiffTest to make it test better what it=
 claims to test
>=20
> ---
>  .../tst/org/spearce/jgit/lib/IndexDiffTest.java    |   22 ++++++++++=
++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
>=20
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiff=
Test.java=20
> b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTest.java
> index ba5d8d7..629c06c 100644
> --- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTest.ja=
va
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTest.ja=
va
> @@ -31,8 +31,12 @@ public class IndexDiffTest extends RepositoryTestC=
ase {
>  		index.add(trash, new File(trash, "dir/subfile"));
>  		IndexDiff diff =3D new IndexDiff(tree, index);
>  		diff.diff();
> +		assertEquals(2, diff.getAdded().size());
>  		assertTrue(diff.getAdded().contains("file1"));
>  		assertTrue(diff.getAdded().contains("dir/subfile"));
> +		assertEquals(0, diff.getChanged().size());
> +		assertEquals(0, diff.getModified().size());
> +		assertEquals(0, diff.getRemoved().size());
>  	}
> =20
>  	public void testRemoved() throws IOException {
> @@ -44,11 +48,20 @@ public class IndexDiffTest extends RepositoryTest=
Case {
>  		tree.addFile("file2");
>  		tree.addFile("dir/file3");
>  		assertEquals(2, tree.memberCount());
> +		tree.findBlobMember("file2").setId(new ObjectId("30d67d4672d5c0583=
3b7192cc77a79eaafb5c7ad"));
> +		Tree tree2 =3D (Tree) tree.findTreeMember("dir");
> +		tree2.findBlobMember("file3").setId(new ObjectId("873fb8d667d05436=
d728c52b1d7a09528e6eb59b"));
> +		tree2.setId(new ObjectWriter(db).writeTree(tree2));
> +		tree.setId(new ObjectWriter(db).writeTree(tree));
> =20
>  		IndexDiff diff =3D new IndexDiff(tree, index);
>  		diff.diff();
> +		assertEquals(2, diff.getRemoved().size());
>  		assertTrue(diff.getRemoved().contains("file2"));
>  		assertTrue(diff.getRemoved().contains("dir/file3"));
> +		assertEquals(0, diff.getChanged().size());
> +		assertEquals(0, diff.getModified().size());
> +		assertEquals(0, diff.getAdded().size());
>  	}
> =20
>  	public void testModified() throws IOException {
> @@ -65,10 +78,19 @@ public class IndexDiffTest extends RepositoryTest=
Case {
>  		tree.addFile("dir/file3").setId(new ObjectId("01234567890123456789=
01234567890123456789"));
>  		assertEquals(2, tree.memberCount());
> =20
> +		Tree tree2 =3D (Tree) tree.findTreeMember("dir");
> +		tree2.setId(new ObjectWriter(db).writeTree(tree2));
> +		tree.setId(new ObjectWriter(db).writeTree(tree));
>  		IndexDiff diff =3D new IndexDiff(tree, index);
>  		diff.diff();
> +		assertEquals(2, diff.getChanged().size());
>  		assertTrue(diff.getChanged().contains("file2"));
>  		assertTrue(diff.getChanged().contains("dir/file3"));
> +		assertEquals(1, diff.getModified().size());
>  		assertTrue(diff.getModified().contains("dir/file3"));
> +		assertEquals(0, diff.getAdded().size());
> +		assertEquals(0, diff.getRemoved().size());
> +		assertEquals(0, diff.getMissing().size());
>  	}
> +
>  }
> --=20
> 1.5.4.rc4.25.g81cc
>=20

--=20
Dave Watson
Software Engineer
MIMvista Corp

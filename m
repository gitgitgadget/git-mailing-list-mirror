From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH JGit 05/19] Made tests for listLocalPacks function on ObjectDirectory and made them pass
Date: Tue, 15 Sep 2009 18:13:47 +0200
Message-ID: <200909151813.47782.robin.rosenberg.lists@dewire.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com> <1252867475-858-5-git-send-email-mr.gaffo@gmail.com> <1252867475-858-6-git-send-email-mr.gaffo@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "mike.gaffney" <mike.gaffney@asolutions.com>
To: mr.gaffo@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 15 18:15:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnag2-00006C-Ig
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 18:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358AbZIOQNu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 12:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbZIOQNu
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 12:13:50 -0400
Received: from mail.dewire.com ([83.140.172.130]:10569 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755139AbZIOQNt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 12:13:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 01D1F146D00C;
	Tue, 15 Sep 2009 18:13:50 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lxu0Vps33Q2S; Tue, 15 Sep 2009 18:13:50 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id F13251434E81;
	Tue, 15 Sep 2009 18:13:49 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1252867475-858-6-git-send-email-mr.gaffo@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128574>

s=C3=B6ndag 13 september 2009 20:44:21 skrev mr.gaffo@gmail.com:
> From: mike.gaffney <mike.gaffney@asolutions.com>
>=20
> ---
>  .../org/spearce/jgit/lib/ObjectDirectoryTest.java  |   24 ++++++++++=
++++++++++
>  .../jgit/lib/UpdateDirectoryInfoCacheTest.java     |   11 +++++++++
>  .../tst/org/spearce/jgit/util/JGitTestUtil.java    |   21 ++++++++++=
++++++-
>  .../src/org/spearce/jgit/lib/ObjectDirectory.java  |    6 +++++
>  .../spearce/jgit/lib/UpdateDirectoryInfoCache.java |   22 ++++++++++=
++++++++
>  5 files changed, 83 insertions(+), 1 deletions(-)
>  create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/Up=
dateDirectoryInfoCacheTest.java
>  create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/UpdateD=
irectoryInfoCache.java
>=20
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDir=
ectoryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/Object=
DirectoryTest.java
> index fe019af..8e4d8e5 100644
> --- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryT=
est.java
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryT=
est.java
> @@ -1,11 +1,17 @@
>  package org.spearce.jgit.lib;
> =20
>  import java.io.File;
> +import java.util.List;
>  import java.util.UUID;
> =20
> +import org.spearce.jgit.util.JGitTestUtil;
> +
>  import junit.framework.TestCase;
> =20
>  public class ObjectDirectoryTest extends TestCase {
> +	private static final String PACK_NAME =3D "pack-34be9032ac282b11fa9=
babdc2b2a93ca996c9c2f";
> +	private static final File TEST_PACK =3D JGitTestUtil.getTestResourc=
eFile(PACK_NAME + ".pack");
> +	private static final File TEST_IDX =3D JGitTestUtil.getTestResource=
=46ile(PACK_NAME + ".idx");
>  =09
>  	private File testDir;
> =20
> @@ -58,6 +64,24 @@ public void testGettingObjectFile() throws Excepti=
on {
>  				 od.fileFor(ObjectId.fromString("b052a1272310d8df34de72f60204dee=
7e28a43d0")));
>  	}
>  =09
> +	public void testListLocalPacksNotCreated() throws Exception {
> +		assertEquals(0, new ObjectDirectory(testDir).listLocalPacks().size=
());
> +	}
> +=09
> +	public void testListLocalPacksWhenThereIsAPack() throws Exception {
> +		createTestDir();
> +		File packsDir =3D new File(testDir, "pack");
> +		packsDir.mkdirs();
> +	=09
> +		JGitTestUtil.copyFile(TEST_PACK, new File(packsDir, TEST_PACK.getN=
ame()));
> +		JGitTestUtil.copyFile(TEST_IDX, new File(packsDir, TEST_IDX.getNam=
e()));
> +
> +		ObjectDirectory od =3D new ObjectDirectory(testDir);
> +		List<PackFile> localPacks =3D od.listLocalPacks();
> +		assertEquals(1, localPacks.size());
> +		assertEquals(TEST_PACK.getName(), localPacks.get(0).getPackFile().=
getName());
> +	}
> +=09
>  	public boolean deleteDir(File dir) {
>          if (dir.isDirectory()) {
>              String[] children =3D dir.list();
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDir=
ectoryInfoCacheTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/l=
ib/UpdateDirectoryInfoCacheTest.java
> new file mode 100644
> index 0000000..11d183e
> --- /dev/null
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryI=
nfoCacheTest.java
> @@ -0,0 +1,11 @@
> +package org.spearce.jgit.lib;
> +
> +import junit.framework.TestCase;
> +
> +public class UpdateDirectoryInfoCacheTest extends TestCase {
> +=09
> +	public void testBase() throws Exception {
> +		fail("nyi");
> +	}
> +
> +}
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTest=
Util.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUti=
l.java
> index eee0c14..04184d7 100644
> --- a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.ja=
va
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.ja=
va
> @@ -38,6 +38,12 @@
>  package org.spearce.jgit.util;
> =20
>  import java.io.File;
> +import java.io.FileInputStream;
> +import java.io.FileNotFoundException;
> +import java.io.FileOutputStream;
> +import java.io.IOException;
> +import java.io.InputStream;
> +import java.io.OutputStream;
>  import java.net.URISyntaxException;
>  import java.net.URL;
> =20
> @@ -60,11 +66,24 @@ public static File getTestResourceFile(final Stri=
ng fileName) {
>  		}
>  		try {
>  			return new File(url.toURI());
> -		} catch(URISyntaxException e) {
> +		} catch (URISyntaxException e) {
>  			return new File(url.getPath());
>  		}
>  	}
> =20
> +	public static void copyFile(final File fromFile, final File toFile)=
 throws IOException {
> +		InputStream in =3D new FileInputStream(fromFile);
> +		OutputStream out =3D new FileOutputStream(toFile);
> +
> +		byte[] buf =3D new byte[1024];
> +		int len;
> +		while ((len =3D in.read(buf)) > 0) {
> +			out.write(buf, 0, len);
> +		}
> +		in.close();
> +		out.close();
> +	}

You need to check for short reads, i.e. read could retrieve
fewer bytes than requested, Less important, a larger buffer size could
perhaps be used too (like 8192 which is the default BufferedReader buff=
er size).

>  	private static ClassLoader cl() {
>  		return JGitTestUtil.class.getClassLoader();
>  	}
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirector=
y.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
> index fe219c6..a90ae00 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
> @@ -511,6 +511,12 @@ boolean tryAgain(final long currLastModified) {
> =20
>  	@Override
>  	public List<PackFile> listLocalPacks() {
> +		tryAgain1();
mmmm. probably good.

> +	public void execute() {
> +//		File objectFile =3D objectDatabase.
> +//		String packsContents =3D new PacksFileContentsCreator(this.objec=
tDatabase.listLocalPacks()).toString();

Out commented code is a no-no.

-- robin

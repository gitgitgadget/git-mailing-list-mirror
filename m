From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH JGit 01/19] adding tests for ObjectDirectory
Date: Tue, 15 Sep 2009 17:38:05 +0200
Message-ID: <200909151738.05742.robin.rosenberg.lists@dewire.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com> <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "mike.gaffney" <mike.gaffney@asolutions.com>
To: mr.gaffo@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 15 17:38:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mna6j-000446-Pd
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 17:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbZIOPiJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 11:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754790AbZIOPiH
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 11:38:07 -0400
Received: from mail.dewire.com ([83.140.172.130]:9989 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754760AbZIOPiG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 11:38:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9351C1481DBB;
	Tue, 15 Sep 2009 17:38:08 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PrxthIg15crO; Tue, 15 Sep 2009 17:38:07 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id CAB6C9E4A6A;
	Tue, 15 Sep 2009 17:38:07 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128572>

s=C3=B6ndag 13 september 2009 20:44:17 skrev mr.gaffo@gmail.com:
> From: mike.gaffney <mike.gaffney@asolutions.com>
>=20
> ---
>  .../org/spearce/jgit/lib/ObjectDirectoryTest.java  |   80 ++++++++++=
++++++++++
>  1 files changed, 80 insertions(+), 0 deletions(-)
>  create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/Ob=
jectDirectoryTest.java
>=20
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDir=
ectoryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/Object=
DirectoryTest.java
> new file mode 100644
> index 0000000..fe019af
> --- /dev/null
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryT=
est.java
> @@ -0,0 +1,80 @@
> +package org.spearce.jgit.lib;
> +
> +import java.io.File;
> +import java.util.UUID;
> +
> +import junit.framework.TestCase;
> +
> +public class ObjectDirectoryTest extends TestCase {
> +=09
> +	private File testDir;
> +
> +	@Override
> +	protected void setUp() throws Exception {
> +		testDir =3D new File(new File(System.getProperty("java.io.tmpdir")=
), UUID.randomUUID().toString());
> +	}

Good. Now that we're on Java5 we might use this more.

> +	public void testGettingObjectFile() throws Exception {
> +		ObjectDirectory od =3D new ObjectDirectory(testDir);
> +		assertEquals(new File(testDir, "02/829ae153935095e4223f30cfc98c835=
de71bee"),=20
> +					 od.fileFor(ObjectId.fromString("02829ae153935095e4223f30cfc98c=
835de71bee")));
> +		assertEquals(new File(testDir, "b0/52a1272310d8df34de72f60204dee7e=
28a43d0"),=20
> +				 od.fileFor(ObjectId.fromString("b052a1272310d8df34de72f60204dee=
7e28a43d0")));
> +	}
> +=09
> +	public boolean deleteDir(File dir) {

RepositoryTestcase already contains a recursive delete, including a sta=
tic one
that you can use even without inheritance since you are within the same=
 package. It is rather
standalone so it could perhaps move to JGitTestUtil.

> +        if (dir.isDirectory()) {
> +            String[] children =3D dir.list();
> +            for (int i=3D0; i<children.length; i++) {
> +                boolean success =3D deleteDir(new File(dir, children=
[i]));
> +                if (!success) {
> +                    return false;
> +                }
> +            }
> +        }
> +   =20
> +        // The directory is now empty so delete it
> +        return dir.delete();
> +    }
> +
> +	private void createTestDir(){
> +		testDir.mkdir();

No error checking. If mkdirfails the test probably fails for mysterious=
  reasons,

> +	}
> +=09
> +}

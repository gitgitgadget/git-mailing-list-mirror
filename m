From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/1] Generate javadoc when making jgit. Also,
	package docs into a zip for distribution.
Date: Mon, 10 Aug 2009 07:56:29 -0700
Message-ID: <20090810145629.GO1033@spearce.org>
References: <76596580908092132h1aab0c22qb364914ce9e827b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Nicholas Campbell <nicholas.j.campbell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 16:57:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaWJB-0001lW-OW
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 16:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbZHJO4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 10:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753033AbZHJO43
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 10:56:29 -0400
Received: from george.spearce.org ([209.20.77.23]:33869 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbZHJO42 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 10:56:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4BFFD381FD; Mon, 10 Aug 2009 14:56:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <76596580908092132h1aab0c22qb364914ce9e827b2@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125452>

Nicholas Campbell <nicholas.j.campbell@gmail.com> wrote:
> Runs through defined "PLUGINS" and creates Javadoc. Assumes src is a subdir.
> 
> Signed-off-by: Nick Campbell <nicholas.j.campbell@gmail.com>
> ---
>  make_jgit.sh |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)

Thanks.  This didn't apply cleanly to tip of tree, so I hand merged
it in, but then modified it a bit.  This is what I actually applied:
 
--8<--
From: Nicholas Campbell <nicholas.j.campbell@gmail.com>
Subject: [PATCH] Generate javadoc during ./make_jgit.sh

Package docs into a zip for distribution.  Runs through defined
"PLUGINS" and creates Javadoc. Assumes src is a subdir.

Signed-off-by: Nick Campbell <nicholas.j.campbell@gmail.com>
[sp: cleaned up docs/ directory after build; removed docs/ from zip]
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .gitignore   |    1 +
 make_jgit.sh |   13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index baf2766..5219cbc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
 /jgit
 /jgit.jar
 /jgit_src.zip
+/jgit_docs.zip
diff --git a/make_jgit.sh b/make_jgit.sh
index baaa3af..9608b70 100755
--- a/make_jgit.sh
+++ b/make_jgit.sh
@@ -3,6 +3,7 @@
 O_CLI=jgit
 O_JAR=jgit.jar
 O_SRC=jgit_src.zip
+O_DOC=jgit_docs.zip
 
 PLUGINS="
 	org.spearce.jgit
@@ -39,6 +40,7 @@ cleanup_bin() {
 	do
 		rm -rf $p/bin2
 	done
+	rm -rf docs
 }
 
 die() {
@@ -49,7 +51,7 @@ die() {
 }
 
 cleanup_bin
-rm -f $O_CLI $O_JAR $O_SRC
+rm -f $O_CLI $O_JAR $O_SRC $O_DOC
 
 VN=`git describe --abbrev=4 HEAD 2>/dev/null`
 git update-index -q --refresh
@@ -118,4 +120,13 @@ chmod 555 $O_CLI+ &&
 mv $O_CLI+ $O_CLI &&
 echo "Created $O_CLI." || die "Build failed."
 
+echo "Building Javadocs ..."
+for p in $PLUGINS; do
+	javadoc -sourcepath "$p/src/" -d "docs/$p/" \
+	`find "$p/src" -name "*.java"`
+done
+
+(cd docs && jar cf "../$O_DOC" .)
+echo "Created $O_DOC."
+
 cleanup_bin
-- 
1.6.4.70.g9c084

-- 
Shawn.

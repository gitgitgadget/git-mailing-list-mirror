From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH 4/4] configure: Fixes for Solaris
Date: Fri, 07 Jul 2006 18:26:44 +0200
Message-ID: <20060707162644.25746.78865.stgit@leonov.stosberg.net>
References: <20060707162513.25746.57374.stgit@leonov.stosberg.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Jul 07 18:27:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FytAK-0000c8-RD
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 18:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWGGQ0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 12:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWGGQ0s
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 12:26:48 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:951 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S932197AbWGGQ0q (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 12:26:46 -0400
Received: from leonov.stosberg.net (p213.54.86.102.tisdip.tiscali.de [213.54.86.102])
	by ncs.stosberg.net (Postfix) with ESMTP id 94FE1AEBA004
	for <git@vger.kernel.org>; Fri,  7 Jul 2006 18:26:37 +0200 (CEST)
Received: from leonov.stosberg.net (localhost [127.0.0.1])
	by leonov.stosberg.net (Postfix) with ESMTP id D3EE21149B7
	for <git@vger.kernel.org>; Fri,  7 Jul 2006 18:26:44 +0200 (CEST)
To: git@vger.kernel.org
In-Reply-To: <20060707162513.25746.57374.stgit@leonov.stosberg.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23448>

From: Dennis Stosberg <dennis@stosberg.net>

- Solaris' /bin/sh will not find a function if there is a variable 
  with the same name.
- 'test -z $var' fails if $var is empty.  Needs to be 'test -z "$var"' 

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---

 config-lib.sh |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/config-lib.sh b/config-lib.sh
index 0bcd4c3..4dd4d00 100755
--- a/config-lib.sh
+++ b/config-lib.sh
@@ -181,7 +181,7 @@ add_library() { # --with
 	lib_help="$lib_help
 $desc [$hdefault]"
 	switches="$switches switch_lib \"$name\" \"$switch\" \"\$ac_option\" || "
-	mkvars="$mkvars mkvar \"\$$name\" \"$mkvar\";"
+	mkvars="$mkvars print_mkvar \"\$$name\" \"$mkvar\";"
 	eval "$name=$default"
 }
 
@@ -196,7 +196,7 @@ add_feature() { # --enable
 	feature_help="$feature_help
 $desc [$hdefault]"
 	switches="$switches switch_feature \"$name\" \"$switch\" \"\$ac_option\" || "
-	mkvars="$mkvars mkvar \"\$$name\" \"$mkvar\";"
+	mkvars="$mkvars print_mkvar \"\$$name\" \"$mkvar\";"
 	eval "$name=$default"
 }
 
@@ -226,7 +226,7 @@ switch_feature() {
 	return 0
 }
 
-mkvar() {
+print_mkvar() {
 	value="$1"; shift; mkvar="$1"; shift
 	noval=""; yesval="ConfigureYesPlease"
 	case $mkvar in
@@ -533,15 +533,15 @@ PERL_PATH = $_perl
 INSTALL = $_install
 
 EOF
-		test -z $_prefix || echo "prefix = $_prefix"
-		test -z $_bindir || echo "bindir = $_bindir"
-		test -z $_gitexecdir || echo "gitexecdir = $_gitexecdir"
-		test -z $_mandir || ( echo "mandir = $_mandir" && echo "export mandir" )
-		test -z $_templatedir || echo "template_dir = $_templatedir"
-		test -z $_gitpythondir || echo "GIT_PYTHON_DIR = $_gitpythondir"
-
-		test -z $_python || echo "PYTHON_PATH = $_python"
-		test -z $_no_python || echo "NO_PYTHON = $_no_python"
+		test -z "$_prefix" || echo "prefix = $_prefix"
+		test -z "$_bindir" || echo "bindir = $_bindir"
+		test -z "$_gitexecdir" || echo "gitexecdir = $_gitexecdir"
+		test -z "$_mandir" || ( echo "mandir = $_mandir" && echo "export mandir" )
+		test -z "$_templatedir" || echo "template_dir = $_templatedir"
+		test -z "$_gitpythondir" || echo "GIT_PYTHON_DIR = $_gitpythondir"
+
+		test -z "$_python" || echo "PYTHON_PATH = $_python"
+		test -z "$_no_python" || echo "NO_PYTHON = $_no_python"
 
 		echo
 		eval "$mkvars"

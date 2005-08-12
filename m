From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add "--sign" option to git-format-patch-script
Date: Fri, 12 Aug 2005 15:32:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508121532051.25606@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Aug 12 15:34:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3ZeQ-00062x-1N
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 15:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVHLNcn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 09:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbVHLNcn
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 09:32:43 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:20873 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751170AbVHLNcn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 09:32:43 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 2FDFFE243E
	for <git@vger.kernel.org>; Fri, 12 Aug 2005 15:32:42 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 14D59B3512
	for <git@vger.kernel.org>; Fri, 12 Aug 2005 15:32:42 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id F019DA2FAC
	for <git@vger.kernel.org>; Fri, 12 Aug 2005 15:32:41 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id E4FA4E243E
	for <git@vger.kernel.org>; Fri, 12 Aug 2005 15:32:41 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds the option "--sign" to git-format-patch-script which adds
a Signed-off-by: line automatically.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-format-patch-script |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

a72d370d43c397238a26c1c7f260a3fd6401f4e6
diff --git a/git-format-patch-script b/git-format-patch-script
--- a/git-format-patch-script
+++ b/git-format-patch-script
@@ -6,7 +6,7 @@
 . git-sh-setup-script || die "Not a git archive."
 
 usage () {
-    echo >&2 "usage: $0"' [-n] [-o dir] [--mbox] [--check] [-<diff options>...] upstream [ our-head ]
+    echo >&2 "usage: $0"' [-n] [-o dir] [--mbox] [--check] [--sign] [-<diff options>...] upstream [ our-head ]
 
 Prepare each commit with its patch since our-head forked from upstream,
 one file per patch, for e-mail submission.  Each output file is
@@ -46,6 +46,8 @@ do
     date=t author=t mbox=t ;;
     -n|--n|--nu|--num|--numb|--numbe|--number|--numbere|--numbered)
     numbered=t ;;
+    -s|--s|--si|--sig|--sign)
+    signoff=t ;;
     -o=*|--o=*|--ou=*|--out=*|--outp=*|--outpu=*|--output=*|--output-=*|\
     --output-d=*|--output-di=*|--output-dir=*|--output-dire=*|\
     --output-direc=*|--output-direct=*|--output-directo=*|\
@@ -174,6 +176,14 @@ Date: '"$ad"
 	b body'
 
 	sed -ne "$mailScript" <$commsg
+
+	test "$signoff" = "t" && {
+		offsigner=`git-var GIT_COMMITTER_IDENT | sed -e 's/>.*/>/'`
+		echo
+		echo "Signed-off-by: $offsigner"
+		echo
+	}
+
 	echo '---'
 	echo
 	git-diff-tree -p $diff_opts "$commit" | git-apply --stat --summary

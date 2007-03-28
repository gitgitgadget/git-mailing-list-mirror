From: Eric Lesh <eclesh@ucla.edu>
Subject: [PATCH guilt] guilt-fork: Rename patches sequentially (ala quilt)
Date: Tue, 27 Mar 2007 20:43:58 -0700
Message-ID: <1175053438.5945.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Wed Mar 28 05:44:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWP5Z-000399-8m
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 05:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbXC1DoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 23:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753042AbXC1DoK
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 23:44:10 -0400
Received: from smtp-5.smtp.ucla.edu ([169.232.47.137]:52365 "EHLO
	smtp-5.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbXC1DoI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 23:44:08 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.47.145])
	by smtp-5.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l2S3hxVT023630;
	Tue, 27 Mar 2007 20:43:59 -0700
Received: from [192.168.1.7] (adsl-75-26-189-151.dsl.scrm01.sbcglobal.net [75.26.189.151])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l2S3hw21003250
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Tue, 27 Mar 2007 20:43:59 -0700
X-Mailer: Evolution 2.8.1 
X-Probable-Spam: no
X-Scanned-By: smtp.ucla.edu on 169.232.47.137
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43349>

From: Eric Lesh <eclesh@ucla.edu>
Date: Tue, 27 Mar 2007 20:18:10 -0700
Subject: [PATCH] guilt-fork: Rename patches sequentially (ala quilt)

Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
 guilt-fork |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/guilt-fork b/guilt-fork
index 4ab55d7..ae31739 100755
--- a/guilt-fork
+++ b/guilt-fork
@@ -19,8 +19,12 @@ if ! must_commit_first; then
 	die "Uncommited changes detected. Refresh first."
 fi
 
-# FIXME: Be smarter about the new patchname (ala what quilt does)
-newpatch="$patch-2"
+# Rename patches smartly
+base=$(echo "$patch" \
+	| sed -r -e 's:(\.diff?|\.patch)$::')
+num=$(echo "$base" | sed -nre 's:.*-([0-9]+)$:\1:'p)
+[ -n "$num" ] || num=1
+newpatch="${base%-$num}-$((num+1))${patch#$base}"
 
 # copy the patch
 cp "$GUILT_DIR/$branch/$patch" "$GUILT_DIR/$branch/$newpatch"
-- 
1.5.1-rc1.GIT

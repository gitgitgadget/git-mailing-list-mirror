X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Add support for commit.signoff config option
Date: Tue, 28 Nov 2006 12:02:43 +0000
Message-ID: <200611281202.43394.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 12:03:10 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: 7d5883eb7f62d763
X-UID: 174
X-Length: 1316
Content-Disposition: inline
X-OriginalArrivalTime: 28 Nov 2006 12:04:23.0671 (UTC) FILETIME=[58026070:01C712E5]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32513>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp1fn-00070A-D1 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 13:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756025AbWK1MCs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 07:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757337AbWK1MCs
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 07:02:48 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:49439 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S1756025AbWK1MCr
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 07:02:47 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Tue, 28 Nov 2006 12:04:23 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1Gp1fh-0004nI-00 for <git@vger.kernel.org>; Tue, 28 Nov
 2006 12:02:45 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Whether patches require signing off or not is probably a per-project
setting rather than a per-commit setting.  Therefore as a convenience to
the user, the commit.signoff setting will automtically add --signoff to
commits.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---

 git-commit.sh |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 81c3a0c..c45af10 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -66,9 +66,7 @@ trap '
 	rm -f "$NEXT_INDEX"
 ' 0
 
-################################################################
-# Command line argument parsing and sanity checking
-
+# Init
 all=
 also=
 only=
@@ -85,6 +83,17 @@ signoff=
 force_author=
 only_include_assumed=
 untracked_files=
+
+# Config
+case "$(git-repo-config --get commit.signoff)" in
+1|on|yes|true)
+	signoff=t
+	;;
+esac
+
+################################################################
+# Command line argument parsing and sanity checking
+
 while case "$#" in 0) break;; esac
 do
 	case "$1" in
-- 
1.4.3.GIT-dirty

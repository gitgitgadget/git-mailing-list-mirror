From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Fix minor issue with t6120-describe.
Date: Sun, 14 Jan 2007 04:37:01 -0500
Message-ID: <20070114093701.GA15007@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 10:37:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H61nc-0005Y6-E8
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 10:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbXANJhJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 04:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbXANJhI
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 04:37:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52930 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbXANJhH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 04:37:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H61nS-0001yh-Cv; Sun, 14 Jan 2007 04:37:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B9EBE20FBAE; Sun, 14 Jan 2007 04:37:02 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36799>

The tests for B wind up matching exactly, as in the test repository
B is exactly HEAD^^2^.  So we cannot match on B-* as we will never
get additional SHA1 data appended to the tag name.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t6120-describe.sh |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index e6c6160..3e9edda 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -18,8 +18,8 @@ check_describe () {
 	R=$(git describe "$@") &&
 	test_expect_success "describe $*" '
 	case "$R" in
-	"$expect"-*)	echo happy ;;
-	*)	echo "Oops - $R??? expected $expect";
+	$expect)	echo happy ;;
+	*)	echo "Oops - $R is not $expect";
 		false ;;
 	esac
 	'
@@ -82,16 +82,16 @@ test_expect_success setup '
 
 '
 
-check_describe A HEAD
-check_describe A HEAD^
-check_describe D HEAD^^
-check_describe A HEAD^^2
+check_describe A-* HEAD
+check_describe A-* HEAD^
+check_describe D-* HEAD^^
+check_describe A-* HEAD^^2
 check_describe B HEAD^^2^
 
-check_describe A --tags HEAD
-check_describe A --tags HEAD^
-check_describe D --tags HEAD^^
-check_describe A --tags HEAD^^2
+check_describe A-* --tags HEAD
+check_describe A-* --tags HEAD^
+check_describe D-* --tags HEAD^^
+check_describe A-* --tags HEAD^^2
 check_describe B --tags HEAD^^2^
 
 test_done
-- 
1.5.0.rc1.g4494

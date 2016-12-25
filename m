Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B241FCC7
	for <e@80x24.org>; Sun, 25 Dec 2016 14:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752329AbcLYOYF (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Dec 2016 09:24:05 -0500
Received: from master.debian.org ([82.195.75.110]:54665 "EHLO
        master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbcLYOYE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2016 09:24:04 -0500
X-Greylist: delayed 1047 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Dec 2016 09:24:04 EST
Received: from pabs by master.debian.org with local (Exim 4.84_2)
        (envelope-from <pabs@master.debian.org>)
        id 1cL9RY-0000Ra-Hu; Sun, 25 Dec 2016 14:06:32 +0000
From:   Paul Wise <pabs3@bonedaddy.net>
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@samba.org>, Paul Wise <pabs3@bonedaddy.net>
Subject: [PATCH] gitk: use right colour for remote refs in the "Tags and heads" dialog
Date:   Sun, 25 Dec 2016 22:06:11 +0800
Message-Id: <20161225140611.30536-1-pabs3@bonedaddy.net>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Makes it easier to see which refs are local and which refs are remote.
Adds consistency with the remote background colour in the graph display.

Signed-off-by: Paul Wise <pabs3@bonedaddy.net>
---
 gitk-git/gitk | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 805a1c703..8d2868148 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3399,6 +3399,8 @@ set rectmask {
 }
 image create bitmap reficon-H -background black -foreground lime \
     -data $rectdata -maskdata $rectmask
+image create bitmap reficon-R -background black -foreground "#ffddaa" \
+    -data $rectdata -maskdata $rectmask
 image create bitmap reficon-o -background black -foreground "#ddddff" \
     -data $rectdata -maskdata $rectmask
 
@@ -9908,6 +9910,7 @@ proc sel_reflist {w x y} {
     set n [lindex $ref 0]
     switch -- [lindex $ref 1] {
 	"H" {selbyid $headids($n)}
+	"R" {selbyid $headids($n)}
 	"T" {selbyid $tagids($n)}
 	"o" {selbyid $otherrefids($n)}
     }
@@ -9937,7 +9940,11 @@ proc refill_reflist {} {
     foreach n [array names headids] {
 	if {[string match $reflistfilter $n]} {
 	    if {[commitinview $headids($n) $curview]} {
-		lappend refs [list $n H]
+		if {[string match "remotes/*" $n]} {
+		    lappend refs [list $n R]
+		} else {
+		    lappend refs [list $n H]
+		}
 	    } else {
 		interestedin $headids($n) {run refill_reflist}
 	    }
-- 
2.11.0


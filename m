Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725441FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933337AbcLSQp1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:45:27 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:64930 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933195AbcLSQp0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 11:45:26 -0500
X-AuditID: 12074414-773ff70000004a85-13-58580ea566a5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id B7.85.19077.5AE08585; Mon, 19 Dec 2016 11:45:25 -0500 (EST)
Received: from bagpipes.fritz.box (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJGjKQu011292
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 11:45:24 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Paul Mackerras <paulus@samba.org>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/13] gitk: use a type "tags" to indicate abbreviated tags
Date:   Mon, 19 Dec 2016 17:45:02 +0100
Message-Id: <3430c26d58763ec7c91af1f942af34bab14efef7.1482164633.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1482164633.git.mhagger@alum.mit.edu>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsUixO6iqLuULyLCYNtnXYuuK91MFrdXzGe2
        WHNkMbsDs8ff9x+YPObu6mP0+LxJLoA5issmJTUnsyy1SN8ugStjzu+SgkN8Feee1DUwrufq
        YuTkkBAwkei69o25i5GLQ0jgMqPEhMl7WSCcU0wSOy58YQapYhPQlVjU08zUxcjBISKgKrH+
        ghBImFnAQWLz50ZGEFtYwFtiRdstJhCbBajk+PpOdhCbVyBKYtK7OcwQy+QkLm2DGMkpYCFx
        c/4VsBohAXOJDc9+s0xg5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdCLzezRC81pXQT
        IyQcRHYwHjkpd4hRgINRiYe34H1YhBBrYllxZe4hRkkOJiVR3v08ERFCfEn5KZUZicUZ8UWl
        OanFhxglOJiVRHj38gLleFMSK6tSi/JhUtIcLErivN8Wq/sJCaQnlqRmp6YWpBbBZGU4OJQk
        eO+DNAoWpaanVqRl5pQgpJk4OEGG8wANTwcbXlyQmFucmQ6RP8WoKCXO6wiSEABJZJTmwfXC
        4vUVozjQK8K8nMDoFeIBxjpc9yugwUxAgxd2h4MMLklESEk1MHKHHpApFngkk/3w2k8P+57j
        d7mqDzzpuLRLauuWGcccLHbG1YT9Wef6ce3va7Jn368pKNsh4fJOwmb6//MKz/oX+dlazzfV
        vGVycLfm/Dsx3jK/ZR4J9DzXfVvMoqNhrvqrVfW1qHKT21njCvlCPomrMULKQk93B1nO0XL+
        +OHZ7nln2d0c+pRYijMSDbWYi4oTAQbM0CyyAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This replaces the functionality of the old `singletag` variable.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 gitk | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index 7c830c3..502f0aa 100755
--- a/gitk
+++ b/gitk
@@ -6561,7 +6561,6 @@ proc drawtags {id x xt y1} {
 
     set marks {}
     set types {}
-    set singletag 0
     set maxtags 3
     set maxtagpct 25
     set maxwidth [expr {[graph_pane_width] * $maxtagpct / 100}]
@@ -6574,8 +6573,7 @@ proc drawtags {id x xt y1} {
 	if {$ntags > $maxtags ||
 	    [totalwidth $tags mainfont $extra] > $maxwidth} {
 	    # show just a single "n tags..." tag
-	    set singletag 1
-	    lappend types tag
+	    lappend types tags
 	    if {$ntags == 1} {
 		lappend marks "tag..."
 	    } else {
@@ -6626,13 +6624,13 @@ proc drawtags {id x xt y1} {
 	set xl [expr {$x + $delta}]
 	set xr [expr {$x + $delta + $wid + $lthickness}]
 	set font mainfont
-	if {$type eq "tag"} {
+	if {$type eq "tag" || $type eq "tags"} {
 	    # draw a tag
 	    set t [$canv create polygon $x [expr {$yt + $delta}] $xl $yt \
 		       $xr $yt $xr $yb $xl $yb $x [expr {$yb - $delta}] \
 		       -width 1 -outline $tagoutlinecolor -fill $tagbgcolor \
 		       -tags tag.$id]
-	    if {$singletag} {
+	    if {$type eq "tags"} {
 		set tagclick [list showtags $id 1]
 	    } else {
 		set tagclick [list showtag $tag_quoted 1]
@@ -6663,7 +6661,7 @@ proc drawtags {id x xt y1} {
 	}
 	set t [$canv create text $xl $y1 -anchor w -text $tag -fill $headfgcolor \
 		   -font $font -tags [list tag.$id text]]
-	if {$type eq "tag"} {
+	if {$type eq "tag" || $type eq "tags"} {
 	    $canv bind $t <1> $tagclick
 	} elseif {$type eq "head"} {
 	    $canv bind $t $ctxbut [list headmenu %X %Y $id $tag_quoted]
-- 
2.9.3


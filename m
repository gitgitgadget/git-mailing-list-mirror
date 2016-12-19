Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B451B1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933583AbcLSQqX (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:46:23 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:55802 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933396AbcLSQpb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 11:45:31 -0500
X-AuditID: 1207440e-7dfff700000009ec-64-58580ea68f8f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id DF.06.02540.6AE08585; Mon, 19 Dec 2016 11:45:26 -0500 (EST)
Received: from bagpipes.fritz.box (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJGjKQv011292
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 11:45:25 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Paul Mackerras <paulus@samba.org>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/13] gitk: use a type "mainhead" to indicate the main HEAD branch
Date:   Mon, 19 Dec 2016 17:45:03 +0100
Message-Id: <e51c497cfbc592bd6f7a7e55d3179b740d5523c7.1482164633.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1482164633.git.mhagger@alum.mit.edu>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsUixO6iqLuMLyLC4Md7A4uuK91MFrdXzGe2
        WHNkMbsDs8ff9x+YPObu6mP0+LxJLoA5issmJTUnsyy1SN8ugSvj+aX5TAVfeCrmrpjI0sDY
        y9nFyMkhIWAiMfH1NNYuRi4OIYHLjBKXl61hgnBOMUnMvLyQDaSKTUBXYlFPM1CCg0NEQFVi
        /QUhkDCzgIPE5s+NjCC2sECwxOZ/y5lBbBagkkP7JoHZvAJREiemb2WGWCYncWnbFzCbU8BC
        4ub8K+wgtpCAucSGZ79ZJjDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6yXm1mil5pS
        uokREhJ8Oxjb18scYhTgYFTi4S14HxYhxJpYVlyZe4hRkoNJSZR3P09EhBBfUn5KZUZicUZ8
        UWlOavEhRgkOZiUR3m+8QDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeH
        kgTvfZBGwaLU9NSKtMycEoQ0EwcnyHAeoOEPwIYXFyTmFmemQ+RPMSpKifM6giQEQBIZpXlw
        vbCYfcUoDvSKMC8nMIKFeIDxDtf9CmgwE9Dghd3hIINLEhFSUg2MC1ijuguX/DlbGnJviu8k
        MWnbfzde1R6SsbreMyVyqXSu9oK5L+epzry2hv3Tp+7ty05e23fl1p9oi/7slfPzjVjcr/Pd
        d9N4GtXYuv3/KtmDc/7ExwSzXp7JPmvL7Y2rHh06JSXy/pnR6WMrX1ZVyOjXSjGnn3n6yvpW
        QhZPSqJdHOPiW9PUPymxFGckGmoxFxUnAgDgdj+/tAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 gitk | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/gitk b/gitk
index 502f0aa..d2e3803 100755
--- a/gitk
+++ b/gitk
@@ -6588,7 +6588,11 @@ proc drawtags {id x xt y1} {
     }
     if {[info exists idheads($id)]} {
 	foreach head $idheads($id) {
-	    lappend types head
+	    if {$head eq $mainhead} {
+		lappend types mainhead
+	    } else {
+		lappend types head
+	    }
 	    lappend marks $head
 	}
     }
@@ -6607,7 +6611,7 @@ proc drawtags {id x xt y1} {
     set xvals {}
     set wvals {}
     foreach tag $marks type $types {
-	if {$type eq "head" && $tag eq $mainhead} {
+	if {$type eq "mainhead"} {
 	    set wid [font measure mainfontbold $tag]
 	} else {
 	    set wid [font measure mainfont $tag]
@@ -6639,11 +6643,11 @@ proc drawtags {id x xt y1} {
 	    set rowtextx([rowofcommit $id]) [expr {$xr + $linespc}]
 	} else {
 	    # draw a head or other ref
-	    if {$type eq "head"} {
+	    if {$type eq "mainhead"} {
+		set col $headbgcolor
+		set font mainfontbold
+	    } elseif {$type eq "head"} {
 		set col $headbgcolor
-		if {$tag eq $mainhead} {
-		    set font mainfontbold
-		}
 	    } else {
 		set col "#ddddff"
 	    }
@@ -6663,7 +6667,7 @@ proc drawtags {id x xt y1} {
 		   -font $font -tags [list tag.$id text]]
 	if {$type eq "tag" || $type eq "tags"} {
 	    $canv bind $t <1> $tagclick
-	} elseif {$type eq "head"} {
+	} elseif {$type eq "head" || $type eq "mainhead"} {
 	    $canv bind $t $ctxbut [list headmenu %X %Y $id $tag_quoted]
 	}
     }
-- 
2.9.3


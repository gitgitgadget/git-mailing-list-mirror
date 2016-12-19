Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A5021FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933567AbcLSQqV (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:46:21 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:61897 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933410AbcLSQpd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 11:45:33 -0500
X-AuditID: 12074411-fbbff700000009b7-55-58580eac4c13
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 67.97.02487.CAE08585; Mon, 19 Dec 2016 11:45:32 -0500 (EST)
Received: from bagpipes.fritz.box (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJGjKR3011292
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 11:45:32 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Paul Mackerras <paulus@samba.org>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/13] gitk: use type "remote" for remote-tracking references
Date:   Mon, 19 Dec 2016 17:45:09 +0100
Message-Id: <07f3367fc10b58fe7c36580e4e784139a76198c4.1482164633.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1482164633.git.mhagger@alum.mit.edu>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsUixO6iqLuGLyLC4MlTQ4uuK91MFrdXzGe2
        WHNkMbsDs8ff9x+YPObu6mP0+LxJLoA5issmJTUnsyy1SN8ugSvj6POj7AW/uSsuTP3O2MD4
        mqOLkZNDQsBE4sq0T4wgtpDAZUaJWZ+Nuhi5gOxTTBLz1x5mB0mwCehKLOppZupi5OAQEVCV
        WH9BCCTMLOAgsflzI1ivsICvxP5fb5lBbBagkrYV/1lBbF6BKIn3Ly6xQuySk7i07QtYDaeA
        hcTN+VfYIfaaS2x49ptlAiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6pnq5mSV6qSml
        mxghASG4g3HGSblDjAIcjEo8vAXvwyKEWBPLiitzDzFKcjApifLu54mIEOJLyk+pzEgszogv
        Ks1JLT7EKMHBrCTC+40XKMebklhZlVqUD5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV4eBQ
        kuC9D9IoWJSanlqRlplTgpBm4uAEGc4DNPwB2PDigsTc4sx0iPwpRkUpcV5HkIQASCKjNA+u
        FxaxrxjFgV4R5uUExq8QDzDa4bpfAQ1mAhq8sDscZHBJIkJKqoEx824n38KDC/3DLROMTjnM
        amIpY1ZoOMLDIf3KfO+sDF7PSUYtuT0zljs6CDjc8n4V6TRv6jKH6/eExX8Xbj9i6XJ6xYvV
        3x81C1srOL1/wnpi/8LdcotSeAPOJm/PZZvha1l8v3aty5FIDxE28YyOuv2vty53q1rVo7l+
        cUtZ+WmO1qjHuwSVWIozEg21mIuKEwHf/O6mswIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is clearer, and also lets us avoid calling `remotereftext` a second
time for normal branches.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 gitk | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index d22ce5f..44f4d70 100755
--- a/gitk
+++ b/gitk
@@ -6613,9 +6613,11 @@ proc drawtags {id x xt y1} {
 	    if {$head eq $mainhead} {
 		lappend types mainhead
 		lappend wvals [font measure mainfontbold $head]
+	    } elseif {[remotereftext $head text remoteprefix]} {
+		lappend types remote
+		lappend wvals [font measure mainfont $text]
 	    } else {
 		lappend types head
-		remotereftext $head text remoteprefix
 		lappend wvals [font measure mainfont $text]
 	    }
 	    lappend marks $head
@@ -6666,7 +6668,7 @@ proc drawtags {id x xt y1} {
 	    if {$type eq "mainhead"} {
 		set col $headbgcolor
 		set font mainfontbold
-	    } elseif {$type eq "head"} {
+	    } elseif {$type eq "head" || $type eq "remote"} {
 		set col $headbgcolor
 	    } else {
 		set col "#ddddff"
@@ -6674,7 +6676,8 @@ proc drawtags {id x xt y1} {
 	    set xl [expr {$xl - $delta/2}]
 	    $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
 		-width 1 -outline black -fill $col -tags tag.$id
-	    if {[remotereftext $tag text remoteprefix]} {
+	    if {$type eq "remote"} {
+		remotereftext $tag text remoteprefix
 	        set rwid [font measure mainfont $remoteprefix]
 		set xi [expr {$x + 1}]
 		set yti [expr {$yt + 1}]
-- 
2.9.3


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8FB41FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933591AbcLSQqX (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:46:23 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:42349 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933378AbcLSQpa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 11:45:30 -0500
X-AuditID: 1207440f-46bff700000009ea-76-58580ea8d9d8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 75.0D.02538.8AE08585; Mon, 19 Dec 2016 11:45:29 -0500 (EST)
Received: from bagpipes.fritz.box (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJGjKQx011292
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 11:45:27 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Paul Mackerras <paulus@samba.org>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/13] gitk: simplify regexp
Date:   Mon, 19 Dec 2016 17:45:05 +0100
Message-Id: <d81788d824842d72dbca7234ca9c3572c82f3855.1482164633.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1482164633.git.mhagger@alum.mit.edu>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsUixO6iqLuSLyLC4NpfdYuuK91MFrdXzGe2
        WHNkMbsDs8ff9x+YPObu6mP0+LxJLoA5issmJTUnsyy1SN8ugStj57nKgqWsFbOXrWFuYGxg
        6WLk5JAQMJFYcXAlYxcjF4eQwGVGiUkH3rGCJIQETjFJnHngCmKzCehKLOppZupi5OAQEVCV
        WH9BCCTMLOAgsflzIyOILSygI7H1wAVmEJsFqGTG7tlg83kFoiTePvrNBLFLTuLSti9gNZwC
        FhI3519hh1hlLrHh2W+WCYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmujlZpbopaaU
        bmKEhAP/Dsau9TKHGAU4GJV4eAveh0UIsSaWFVfmHmKU5GBSEuXdzxMRIcSXlJ9SmZFYnBFf
        VJqTWnyIUYKDWUmEVwwkx5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS
        4L3PC9QoWJSanlqRlplTgpBm4uAEGc4DNPwBSA1vcUFibnFmOkT+FKMux4H3K54yCbHk5eel
        SonzOoIUCYAUZZTmwc2BxfErRnGgt4R5p4JU8QBTANykV0BLmICWLOwOB1lSkoiQkmpgVDn8
        kdVmbcYFu2NMPJN3Bj93erLt+snNP148uvCJ5dXxI18Zjs9Ya9GcpFFR8F0ufNE9o5Qtr81v
        PH2S3Ka/ZlPC3lfzLwm/S1q8zHPqT7anye+Zzh2WelprPvVPbxfHh9fBbWfyym0nsr5jfe/9
        cYNO4K9qvbLem0xVSl/0RG0/hpl1Ciy+9k6JpTgj0VCLuag4EQDd3qtLvgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index fb2f653..84a5326 100755
--- a/gitk
+++ b/gitk
@@ -6654,7 +6654,7 @@ proc drawtags {id x xt y1} {
 	    set xl [expr {$xl - $delta/2}]
 	    $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
 		-width 1 -outline black -fill $col -tags tag.$id
-	    if {[regexp {^(remotes/.*/|remotes/)} $tag match remoteprefix]} {
+	    if {[regexp {^(remotes/(.*/|))} $tag match remoteprefix]} {
 	        set rwid [font measure mainfont $remoteprefix]
 		set xi [expr {$x + 1}]
 		set yti [expr {$yt + 1}]
-- 
2.9.3


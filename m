Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2823B2022D
	for <e@80x24.org>; Tue,  8 Nov 2016 00:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbcKHAxK (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 19:53:10 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:46579 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbcKHAxF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 19:53:05 -0500
Received: from [172.18.45.5] (helo=zealot.relativity.greenend.org.uk)
        by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with esmtp
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c3ueu-0003Jx-08; Tue, 08 Nov 2016 00:53:04 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
To:     git@vger.kernel.org
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH GITK 1/6] gitk: Internal: drawtags: Abolish "singletag" variable
Date:   Tue,  8 Nov 2016 00:52:37 +0000
Message-Id: <20161108005241.19888-2-ijackson@chiark.greenend.org.uk>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are going to want to make the contents of `marks' somewhat more
complicated in a moment, so it won't be possible to use what is
effectively a single variable to represent the status of the whole of
the non-heads part of the marks list.

Luckily the strings that replace actual tag names, in the `singletag'
case, are not themselves valid tag names.  So they can be detected
directly.

(Also, `singletag' was not quite right anyway: really it meant that
the tag name(s) had been abbreviated.)

No functional change.

Signed-off-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
---
 gitk | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 805a1c7..42fa41a 100755
--- a/gitk
+++ b/gitk
@@ -6570,7 +6570,6 @@ proc drawtags {id x xt y1} {
 	if {$ntags > $maxtags ||
 	    [totalwidth $marks mainfont $extra] > $maxwidth} {
 	    # show just a single "n tags..." tag
-	    set singletag 1
 	    if {$ntags == 1} {
 		set marks [list "tag..."]
 	    } else {
@@ -6620,7 +6619,7 @@ proc drawtags {id x xt y1} {
 		       $xr $yt $xr $yb $xl $yb $x [expr {$yb - $delta}] \
 		       -width 1 -outline $tagoutlinecolor -fill $tagbgcolor \
 		       -tags tag.$id]
-	    if {$singletag} {
+	    if {[regexp {^tag\.\.\.|^\d+ } $tag]} {
 		set tagclick [list showtags $id 1]
 	    } else {
 		set tagclick [list showtag $tag_quoted 1]
-- 
2.10.1


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2BB72022A
	for <e@80x24.org>; Mon,  7 Nov 2016 19:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933371AbcKGTDU (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 14:03:20 -0500
Received: from ud03.udmedia.de ([194.117.254.43]:53240 "EHLO
        mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933173AbcKGTDU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 14:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=jump-ing.de; h=subject:to
        :references:cc:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=k1; bh=Ts7aTofZUiGLWB
        xyxAo9K4GI3+enVx5PQckeuYtofh4=; b=TXvWEZ0hy2H2kbDIHF4scYVt8rq/+T
        D6kcQge2QB03qkel1WXqiNdrW1Y/sxUwzbLgxzlKX9c1zJ383cIH6oCqiNXpQ0AD
        ciSE6mcXrppYKFI2nPPKdl+cRKrJkAlM/ccv+ECLfGZmFNQ7Ge/eLmOxQfqlkhQs
        IyI9XoAQtP9D0=
Received: (qmail 12572 invoked from network); 7 Nov 2016 20:03:18 +0100
Received: from hsi-kbw-37-209-119-31.hsi15.kabel-badenwuerttemberg.de (HELO ?10.0.0.102?) (ud03?291p1@37.209.119.31)
  by mail.ud03.udmedia.de with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted, authenticated); 7 Nov 2016 20:03:18 +0100
Subject: [PATCH 3/3] gitk: clear array 'commitinfo' on reload
To:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <de7cd593-0c10-4e93-1681-7e123504f5d5@jump-ing.de>
 <e09a5309-351d-d246-d272-f527f50ad444@jump-ing.de>
 <8e1c5923-d2a6-bc77-97ab-3f154b41d2ea@jump-ing.de>
Cc:     Paul Mackerras <paulus@ozlabs.org>
From:   Markus Hitter <mah@jump-ing.de>
Message-ID: <2cb7f76f-0004-a5b6-79f1-9bb4f979cf14@jump-ing.de>
Date:   Mon, 7 Nov 2016 20:03:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <8e1c5923-d2a6-bc77-97ab-3f154b41d2ea@jump-ing.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From 8359452f426c68cc02250f25f20eaaacd2ddd001 Mon Sep 17 00:00:00 2001
From: Markus Hitter <mah@jump-ing.de>
Date: Mon, 7 Nov 2016 19:02:51 +0100
Subject: [PATCH 3/3] gitk: clear array 'commitinfo' on reload

After a reload we might have an entirely different set of commits,
so keeping all of them leaks memory. Remove them all because
re-creating them is not more expensive than testing wether they're
still valid. Lazy (re-)creation is already well established, so
a missing entry can't cause harm.

Signed-off-by: Markus Hitter <mah@jump-ing.de>
---
 gitk | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 518a4ce..aef6db6 100755
--- a/gitk
+++ b/gitk
@@ -588,7 +588,7 @@ proc updatecommits {} {
 proc reloadcommits {} {
     global curview viewcomplete selectedline currentid thickerline
     global showneartags treediffs commitinterest cached_commitrow
-    global targetid
+    global targetid commitinfo
 
     set selid {}
     if {$selectedline ne {}} {
@@ -609,6 +609,7 @@ proc reloadcommits {} {
 	getallcommits
     }
     clear_display
+    unset -nocomplain commitinfo
     unset -nocomplain commitinterest
     unset -nocomplain cached_commitrow
     unset -nocomplain targetid
-- 
2.9.3


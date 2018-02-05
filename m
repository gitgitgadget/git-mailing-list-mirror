Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 118A21F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeBEX4Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:56:25 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44127 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeBEXz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:58 -0500
Received: by mail-pg0-f66.google.com with SMTP id r1so100434pgn.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R0w5JSITGmJuovywlzufyJlDWFceGNGKYmd75yrMU7I=;
        b=MXItWbYIrBPh6Rs+JSEObtddw72or85gcZFeKeG4TImwTCuM4vJ2biCIupJnJUbggp
         dehPjnZXNS8VAaxZhcrT/x+zvBhjfz7scHOcXSPoq71H71NDnymhZNJLs6ODnxauyeYX
         DkMuqMxv2pnoTPMRi7Z6bN6LxnUx4nF6Y6pcVFfWWdViVtqgkiHT8aKVH/d89t3JKNTm
         c9N8oUQmetcnie5LaECOwgQYrP3BP0akoiXlZpQqir/NSVKUwuFUUn5t/ktY7YEPpUmb
         ehvnYioik0ZxIE9q9wcuNg0klu2WuKiUlLvkhH4LPLuMzSrDFUSCYpTVjCQv9CiFz53Y
         S5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R0w5JSITGmJuovywlzufyJlDWFceGNGKYmd75yrMU7I=;
        b=n3EyVQVF2i9aCJakrO2grz9ZJtkiSRW/dUcMx8FIsazbkyaWLj/tHg/oa4qrPvk82Z
         LV9W0gGJBIoVko3mCCT5/Q+R2UdHq+VIFzcV03gzaaRzsy/ahxfSCMcgUjL+wfo/CPrs
         mhiU1PwMbcBVZkyexPPRYKkQ6L4mwBTmFzB+kpGkTfyDT5A6h7qb/QCKAV7pv10vTKFk
         QexlxpBycIuOgEW6RtX5VDGdCW7Vquf16HyHkUJkW6vtcSItE+p0VLQvYuQ27d6aVFZC
         xLG8WB8MLpCo/jfBaEsiM+emQRzHIcHam38V9QiA0ROh+zFsEu95cjExJbDuH4ewWjL4
         earQ==
X-Gm-Message-State: APf1xPBR2e1QqAZ7F3jS3D6WSBbq2+bUa2KXlIqw+H6UZDpPGtZHUFfv
        cb52bLvGYhK3SMV7pcKni/Zpn3G6Fdc=
X-Google-Smtp-Source: AH8x224vUEDhACU0W+JE9LFTIHYXUZmOIf3YCH5YFlu6H4Duh+RHckXADzK4NkS7uTkp7T0NdCDOWQ==
X-Received: by 10.101.67.65 with SMTP id k1mr386589pgq.159.1517874957358;
        Mon, 05 Feb 2018 15:55:57 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id k7sm669934pgt.20.2018.02.05.15.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:56 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 018/194] pack: add repository argument to rearrange_packed_git
Date:   Mon,  5 Feb 2018 15:52:12 -0800
Message-Id: <20180205235508.216277-19-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow the rearrange_packed_git caller to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 packfile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 58473660cd..52cf9182c4 100644
--- a/packfile.c
+++ b/packfile.c
@@ -857,7 +857,8 @@ static int sort_pack(const void *a_, const void *b_)
 	return -1;
 }
 
-static void rearrange_packed_git(void)
+#define rearrange_packed_git(r) rearrange_packed_git_##r()
+static void rearrange_packed_git_the_repository(void)
 {
 	the_repository->objects.packed_git = llist_mergesort(
 		the_repository->objects.packed_git, get_next_packed_git,
@@ -883,7 +884,7 @@ void prepare_packed_git(void)
 	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(the_repository, alt->path, 0);
-	rearrange_packed_git();
+	rearrange_packed_git(the_repository);
 	prepare_packed_git_mru();
 	the_repository->objects.packed_git_initialized = 1;
 }
-- 
2.15.1.433.g936d1b9894.dirty


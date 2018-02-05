Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E384A1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeBEX7R (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:59:17 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39089 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeBEX7I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:59:08 -0500
Received: by mail-pg0-f65.google.com with SMTP id w17so117241pgv.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QWSPBtoSf44uqHRzhgRCpXaL7EhLo3M40FvozVqEjaM=;
        b=sd+0MZvcAyvla62zfi3kf/b7y8Gv9/tRVW5W1UisGHCLt/XbYAhQaM/55ZUr2PwXeP
         hzuEBfaXgtoHhEXSk3dsAcfQO/LJMj7vAYxLrzRWH4NYAcYWopUSSycxeIcmloNWVQzj
         oq4+wP94S2Y10GzdljCwwwcDkPdsiWh9R1eGVNer8r3Ex73m0dyC2OMLGhgYHvFJOChU
         k1ABM01crjGVpfAAa7B9Ltf4UTXy0MZfHNBugP9OExENdSvkwqTJTVWQwLesQ4ljy5k7
         SWZksH5EzrRrf03BDepug167QdslYjI6FrcAzI9lk77QyA1MDm27ojWWwOPuRg5ASNf6
         0GEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QWSPBtoSf44uqHRzhgRCpXaL7EhLo3M40FvozVqEjaM=;
        b=PZuKiS8ZwJA4lWXAeAg42kvH/tqDazCxXOpW/E0KG4rGMBeXh3/DWWfZEsNF+T86WP
         HZe4MHh3RGhPbTzU6QvnHkFBKEAypSTORMPr+WKEX77pki8iLJuxDc6DjARxwMJ3gG5X
         SV6KuWWyttTAocZiKWYIixLqcJEJlxxrp98BjDtey52SUIpACZrOalLzdHiTpuo3XPGm
         +2CXHeks7DEp9/MBGPw4h8jN/Ii0D7Ym9Nz+pY12C0+p1RxVagXr07gDQgdeWSBw00pj
         n0Fz/6hXEEWs1LspgjO1A9kY6j0Q8G2XXV+JrjDPDJjBZCwA/dF2ONfeeq6wxB0xeITR
         Bq8A==
X-Gm-Message-State: APf1xPDI6INZbdhFNd7CtN66Z4PqGvKn/e8h/2mrJThfTU2sVMxkTjr2
        ZxIVpYZhesdzDXA+aCgN950HLtav4NE=
X-Google-Smtp-Source: AH8x2242aFMwrz+qhMjBJhFSV7ChOiq5bTVewfSBC9qlLxKB6HZc4IW+XA4SAS4Zq6cufmVM/vDUeA==
X-Received: by 10.101.74.4 with SMTP id s4mr403890pgq.105.1517875147614;
        Mon, 05 Feb 2018 15:59:07 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id v1sm17676803pfg.33.2018.02.05.15.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:59:07 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 028/194] pack: allow rearrange_packed_git to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:54:49 -0800
Message-Id: <20180205235735.216710-8-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 packfile.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 05b4505b2c..d1533ec948 100644
--- a/packfile.c
+++ b/packfile.c
@@ -857,11 +857,10 @@ static int sort_pack(const void *a_, const void *b_)
 	return -1;
 }
 
-#define rearrange_packed_git(r) rearrange_packed_git_##r()
-static void rearrange_packed_git_the_repository(void)
+static void rearrange_packed_git(struct repository *r)
 {
-	the_repository->objects.packed_git = llist_mergesort(
-		the_repository->objects.packed_git, get_next_packed_git,
+	r->objects.packed_git = llist_mergesort(
+		r->objects.packed_git, get_next_packed_git,
 		set_next_packed_git, sort_pack);
 }
 
-- 
2.15.1.433.g936d1b9894.dirty


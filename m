Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67E0C1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeB1BGl (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:06:41 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45250 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbeB1BG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:06:27 -0500
Received: by mail-pg0-f66.google.com with SMTP id i133so309711pgc.12
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JTYivMu/7/3Co6XH/cUxJpcZJyefynKraGlYWbQLK/w=;
        b=CgZQsV/oZ5/+dEdHtQTdCpOY/eiObWxqVocswOTkivBQzGC36ewGAq5I+Pynf9W5FB
         gLelgDk/s+itVCBqAt9xp8r1tEnCKk7zhZPIl9I+PEs1tMTD26Pa/HuZtV5xw8baYNGe
         UYL0Pk6AxZ3v2wemCK37zmEWFr+uOpipYhVrf205idYSEq0rvlaV/7Th/9Mswi7KhoMa
         5Rj7Z45IyNR1yAszHhfeWs6af626ApeStSqv2hXsrJEFjkK8xDy1D1bpb5/fmCMf41rr
         LqmqaCJUEqHK6RkU7ijJCZ2tedhXRdHSlBKrLCSaQC1DL0eyHJyUiJBFGPtQCnecsmjF
         aYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JTYivMu/7/3Co6XH/cUxJpcZJyefynKraGlYWbQLK/w=;
        b=Z+XB2caAGWikYSnmCN8ppMcuD7+UPZNmuatW6r5Z03ZilQ11TDuGbeLw/f759Slje9
         Z+d4EVrYodiHWheGGy2HkZ6VT9reis18ozic9pLntd58z+8DSDMAR+0UZcsR7MZFs0fj
         XwsLRSRrmmsaKiBwXS8mEa644lSRcYWXnWNhZUmuvUMWIGT7FsaAnyuhs2nWFF5OMIYO
         QfSUg9PqJxcabykSqMSijsFU754Wp3yRjbsIyEXW1ivmFJx9oESUa5gyA7KRVGQpHV/p
         cc6KjrQ5WcoK8Ok56y3T36GxV4UwPbJAn3mJULscYcvnl2Yov9275ZpzzJNorGliKfJu
         u4VA==
X-Gm-Message-State: APf1xPDtvKSg/uJCkEUiMoC4K6x9TPKq5NqP59eDhfe04SnmkRqO+FF9
        YYhI7WX2n8Ss/EFy/cO44ajsbd0h8rQ=
X-Google-Smtp-Source: AH8x225i+Gzrv+xh0VyIU+tleCsA6zGoY+RCf5EZkG4z/aBD7RkH219Q/BL0G7iXTQcUB7xyOAZiZA==
X-Received: by 10.101.73.141 with SMTP id r13mr12742425pgs.161.1519779986729;
        Tue, 27 Feb 2018 17:06:26 -0800 (PST)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id p79sm467033pfi.115.2018.02.27.17.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 17:06:26 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/11] packfile: allow reprepare_packed_git to handle arbitrary repositories
Date:   Tue, 27 Feb 2018 17:06:06 -0800
Message-Id: <20180228010608.215505-10-sbeller@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <20180228010608.215505-1-sbeller@google.com>
References: <20180228010608.215505-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 8 ++++----
 packfile.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/packfile.c b/packfile.c
index 9a3efc01555..b12fc0789e0 100644
--- a/packfile.c
+++ b/packfile.c
@@ -898,11 +898,11 @@ void prepare_packed_git(struct repository *r)
 	r->objects.packed_git_initialized = 1;
 }
 
-void reprepare_packed_git_the_repository(void)
+void reprepare_packed_git(struct repository *r)
 {
-	the_repository->objects.approximate_object_count_valid = 0;
-	the_repository->objects.packed_git_initialized = 0;
-	prepare_packed_git(the_repository);
+	r->objects.approximate_object_count_valid = 0;
+	r->objects.packed_git_initialized = 0;
+	prepare_packed_git(r);
 }
 
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
diff --git a/packfile.h b/packfile.h
index 9142866c8ae..99f4741bd95 100644
--- a/packfile.h
+++ b/packfile.h
@@ -35,8 +35,7 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 extern void prepare_packed_git(struct repository *r);
-#define reprepare_packed_git(r) reprepare_packed_git_##r()
-extern void reprepare_packed_git_the_repository(void);
+extern void reprepare_packed_git(struct repository *r);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
 /*
-- 
2.16.2.395.g2e18187dfd-goog


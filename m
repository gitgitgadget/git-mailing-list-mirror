Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EE33200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755716AbcLZKXP (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:23:15 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34733 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755590AbcLZKWu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:50 -0500
Received: by mail-wj0-f195.google.com with SMTP id qs7so10343303wjc.1
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q2LnTFhya4qkNZO6T1PsrfbO18xSl4t7348E+XJ65m4=;
        b=ZYR4Gw8RihYIsd0kSGex3azkuOfYs0YBRtDPM6xy/z+I3EpiSw/gHxvK1DLCothGWx
         sgEKWITb/+P4HFGbgBvcFFABMJirbBxfQBwGA/Kc66ArzhPsWoYvBdEqge1A/te6soek
         zq+H74mT5E40QeuQJF8H6d0nAvptOngQStc6F8xBR/d4v7/d51Jmxy8JSqbXlBmoSpjL
         Lr8P7m0u56EpuLPU8T+Ypgor5DAhNHfYB3dGbd+HXym+7ej4ELKSMZfp/tRQG7ULHzxi
         KIVaiK4b+J7WnAqPbOPgvg57wVs/DcXgVnhdJvbRfw9dc5j8H4bXmnJaug9Af2M5sgPw
         qhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q2LnTFhya4qkNZO6T1PsrfbO18xSl4t7348E+XJ65m4=;
        b=YiSvn4mZ4XES9f/IGghaWT5NaWFlBY4eeQBkJx2lm6eSrCsJT46e2B0IBQ9UPA/jD5
         ljn71V0qO4z7tWxzU0Y9yMsEIcwv8TxchY2+gqECvwRY/dnIRuAEcuFANjHbwLzs0TKA
         syUtSv035HHcd6hXjOVYVOYjtKiFMdW9Je1CP3Tys+TufATelcTS00niXqbcF77PT0yL
         sspbSYIsxzBm5D1kb+UBaHIoEFUyt4ITexiWvdiwKO8HTqCLfPSM4TTi0L3eMk+0OQHQ
         M7ylYhQAZXwhrismB8zNhT1hbdDfkvHhmERY7cy+HgBqA2Dn3xSuG6SugjUsfofg0szZ
         8ZEg==
X-Gm-Message-State: AIkVDXJ0RyVOZgJd+4pCNpp1cxjgaarNT36TenIsnhPwprxRK6Q24YV8x0s5xpv6JzxWXA==
X-Received: by 10.194.222.132 with SMTP id qm4mr27228672wjc.150.1482747769341;
        Mon, 26 Dec 2016 02:22:49 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:48 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 14/21] read-cache: touch shared index files when used
Date:   Mon, 26 Dec 2016 11:22:15 +0100
Message-Id: <20161226102222.17150-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a split-index file is created, let's update the mtime of the
shared index file that the split-index file is referencing.

In a following commit we will make shared index file expire
depending on their mtime, so updating the mtime makes sure that
the shared index file will not be deleted soon.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index a1aaec5135..9fbad2044b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1682,6 +1682,19 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	die("index file corrupt");
 }
 
+/*
+ * Signal that the shared index is used by updating its mtime.
+ *
+ * This way, shared index can be removed if they have not been used
+ * for some time. It's ok to fail to update the mtime if we are on a
+ * read only file system.
+ */
+void freshen_shared_index(char *base_sha1_hex)
+{
+	const char *shared_index = git_path("sharedindex.%s", base_sha1_hex);
+	check_and_freshen_file(shared_index, 1);
+}
+
 int read_index_from(struct index_state *istate, const char *path)
 {
 	struct split_index *split_index;
@@ -2273,6 +2286,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		int ret = write_shared_index(istate, lock, flags);
 		if (ret)
 			return ret;
+	} else {
+		freshen_shared_index(sha1_to_hex(si->base_sha1));
 	}
 
 	return write_split_index(istate, lock, flags);
-- 
2.11.0.209.gda91e66374.dirty


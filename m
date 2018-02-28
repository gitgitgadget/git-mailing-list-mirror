Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D78BA1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbeB1BGm (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:06:42 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37346 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeB1BGU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:06:20 -0500
Received: by mail-pg0-f65.google.com with SMTP id y26so317485pgv.4
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xQ9O47os6moAKo0bgjl3Kl0mv0JIefdYO7dowBaoPsA=;
        b=P+uLdYY1h+lWpsODTPF1icSvBxWHKoCVLdeib2cIrZ28mVyS9zYcU29a8WucG1/cOy
         5CB8CG5zKXcodbB4IKa9IpF6jyj7pOUy53XLoIB4E7MuNipKSykT/WGaaOkS6eyk97hz
         5GVbLwjFrXjDMIVuvxq0a3WGzg7KvzeHpzgVEYGiFphBB8zoPKdNuSsdM8hK82tghLfA
         9Hp488rrqXrfUthssG5MfBoOkrekoHJ25ZGeyveJ4tOd9wUM9l90xe+Oc/56rYB7I1WI
         rOTXJRIZkwrLk58wkVFlrZy7m0DNAaX+czDyriWWmXFBqOlLDf9QLsiV+//UGkMl+9/c
         ZKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xQ9O47os6moAKo0bgjl3Kl0mv0JIefdYO7dowBaoPsA=;
        b=nFu2XoqPlWEEWiYPqCq8VdKAUNAIxGSgqwImKymGljm3Wi53ko7rDDTTcetEqw7JkK
         5T0uzDhzM56EGH9Kns/3sW7rKoudcNWDu3ZbUTkckA4toQx9IPFul0R0Z/CQHeno/5FP
         cm5ybt+WVdALSw5xWIs/dd1K2vE5vKI0GCJVQ+5wY5R5Lb/wRDlPJosuCxtB546NueLK
         Cjbp3eOOGkeIv3pQwWkNiEEDeGO/MFkM9e4KTndTEau+b+UoeGlQJSQL+dNIPMs5wRuF
         8vDdaSl9Lm4l0maQUplje83awxwKM0firUEoY5t8hfj7ctxBMBzMOub7a50H7IbQdP/R
         dCgg==
X-Gm-Message-State: APf1xPD0sA5RRth5nwPw84eBSpHg5Jq+cerckGvytwgCPpvIBSQVx7eD
        /5BamJoeQwyrXI8TS1Yhowgylamn/D8=
X-Google-Smtp-Source: AH8x225mNyPpE0x43Co48ga4Xgx7uFiBRmyL/Opl5NpBPhSgkwADIVpcuJB5pqMZBGEhQPwcwN6q9w==
X-Received: by 10.99.161.2 with SMTP id b2mr11525934pgf.130.1519779979647;
        Tue, 27 Feb 2018 17:06:19 -0800 (PST)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id n7sm362991pgd.87.2018.02.27.17.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 17:06:18 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/11] packfile: add repository argument to prepare_packed_git_one
Date:   Tue, 27 Feb 2018 17:06:01 -0800
Message-Id: <20180228010608.215505-5-sbeller@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <20180228010608.215505-1-sbeller@google.com>
References: <20180228010608.215505-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index 1c24b02cc84..8bb158fc84e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -735,7 +735,8 @@ static void report_pack_garbage(struct string_list *list)
 	report_helper(list, seen_bits, first, list->nr);
 }
 
-static void prepare_packed_git_one(char *objdir, int local)
+#define prepare_packed_git_one(r, o, l) prepare_packed_git_one_##r(o, l)
+static void prepare_packed_git_one_the_repository(char *objdir, int local)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t dirnamelen;
@@ -889,10 +890,10 @@ void prepare_packed_git(void)
 
 	if (the_repository->objects.packed_git_initialized)
 		return;
-	prepare_packed_git_one(get_object_directory(), 1);
+	prepare_packed_git_one(the_repository, get_object_directory(), 1);
 	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
-		prepare_packed_git_one(alt->path, 0);
+		prepare_packed_git_one(the_repository, alt->path, 0);
 	rearrange_packed_git(the_repository);
 	prepare_packed_git_mru(the_repository);
 	the_repository->objects.packed_git_initialized = 1;
-- 
2.16.2.395.g2e18187dfd-goog


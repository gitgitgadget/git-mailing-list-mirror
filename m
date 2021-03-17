Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE021C433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A44564F50
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhCQN2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhCQN2e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 09:28:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50305C06175F
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:28:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v11so1819884wro.7
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i+pCy7WoqO74l7bWg2UK8UI4TswBi9zS2rQx38AxTvI=;
        b=Rx3Quq2tOEu0Eq9Ztp6OkLzfPmKcUMJfMNImLT1yunSJ+dlRS3KA4LCOo5rg7+DUz7
         OrPsDHvnwXceRPlkQgZjI2vqk5hAKcEea2ZlXdFmza2NY+9ym9LhFY20zz2Ynz/q/dK3
         j44eIQ554VXa+xnpAZnO+3OQj+MXzmyq5ujwHr0KVdsh3SASNmgrWvGvnvK+jmpon0p2
         bo83n3Ry3m93XXOTEzz9VmSTToh5qCb6f5Q4JyQb00pmceNxb2LE/UL+mDZ1woZ8vAtn
         BfM7OOAm/5TVTziUG0+4zeLNaQDoCU8N5+cmuv5uu6kqyXUuSfxk14ioLionivkPkqiF
         5oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+pCy7WoqO74l7bWg2UK8UI4TswBi9zS2rQx38AxTvI=;
        b=WkpxEl41Ltqh+qe82ir7/5PFmjoyWatGQlbX5v92Dl9BvCytW13+kGR4XYhSfZ+Ckc
         tsn8byMui35sc8Cr413g2PZsZFwDkFzBwzE+4nuEPtxM0YWccAqZLuojMTzlHKle7fiG
         3aHxpi2y0z7l6+FZ4X0pA7atVCYImZ204hEMQzFI4zf7po38bejQFnahucBI2190p5kZ
         9TDB9fct+sShJAjH3QEC+Z8aR1UhQIrt0W9HrjIi3Bxi9N3HpoLdz9//0Ji1qI0Wj9u9
         5Lknh17JUJpSXzIVT0tvh74xZxdWVs6vzB96318QdcGSBt+VVX/38J5deazRNHFMbZYl
         vcxg==
X-Gm-Message-State: AOAM5339hvA7xy3Ep7S4zeWnNTDP60wQ/Bo7yyX6KpLTwzheCEiFMGKN
        5SDMUsCPkuiHRPpLocev+nEK4e9vchqJpw==
X-Google-Smtp-Source: ABdhPJxrfdx4DWp+XltBzyOgnpSf3uhboXNWoLlKiVhkSgw1XJUWSxIPBkJEhnpPIK3eLF7FVUBi4w==
X-Received: by 2002:a5d:468e:: with SMTP id u14mr4488125wrq.359.1615987712818;
        Wed, 17 Mar 2021 06:28:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm26061448wrt.70.2021.03.17.06.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:28:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        dstolee@microsoft.com
Subject: [RFC/PATCH 1/5] ls-files: defer read_index() after parse_options() etc.
Date:   Wed, 17 Mar 2021 14:28:10 +0100
Message-Id: <20210317132814.30175-2-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the reading of the index below the parsing of options. We'll need
to setup some index options in the next commit after option parsing,
but in any case it makes sense to give parse_options() handling a
chance to die early before we perform the more expensive operation of
reading the index.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-files.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 13bcc2d847..eb72d16493 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -681,9 +681,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		prefix_len = strlen(prefix);
 	git_config(git_default_config, NULL);
 
-	if (repo_read_index(the_repository) < 0)
-		die("index file corrupt");
-
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
 	pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
@@ -743,6 +740,12 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		max_prefix = common_prefix(&pathspec);
 	max_prefix_len = get_common_prefix_len(max_prefix);
 
+	/*
+	 * Read the index after parse options etc. have had a chance
+	 * to die early.
+	 */
+	if (repo_read_index(the_repository) < 0)
+		die("index file corrupt");
 	prune_index(the_repository->index, max_prefix, max_prefix_len);
 
 	/* Treat unmatching pathspec elements as errors */
-- 
2.31.0.260.g719c683c1d


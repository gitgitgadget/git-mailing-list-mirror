Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772F4C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D652073E
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB/E8J/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGGOVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgGGOVk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:40 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E824CC061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so45290605wrw.12
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p5g8xb98EZqONV4gRjINUh5FvFFqu5L6v0upEJJo9qY=;
        b=nB/E8J/ILS9iwsEfCfiFtnDgBrbWEzxnyVJpp6CRw5VtyOe7X/4yhe/4omS7fPVLfi
         YZm1ctvYCymBADigp4BAUZQg7AMMgj5d2qQRMPEEcNpqc1BL1kwvwDTcBmYepY/pcTgk
         ptm7pZPQpJ1qR6PWmiaRNcOMGnoZrp8+lsgnaYa5E+uvZwIe7oTOAd4Z5JkCPvUI9cII
         0J7nmrKbn46mzQTY4mHZo3INRaE+mQLHducGBkhNDNO9dVDQQK0Gbzf7fPUTpjo5P3tu
         ZzCUPKz0ui0B/5kBGoHg05h0Emw+27AF5xnalKsPWI+8VoUmQBH+p30T8rbGT46qCb+w
         cRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p5g8xb98EZqONV4gRjINUh5FvFFqu5L6v0upEJJo9qY=;
        b=tz1dVYgy26dgZjgVAZbJgnxyS+Ch/ldzh7Z4gCKbjQwYblIzNH++yBuV5tZgoMRlZ2
         tQku1mwHsU7xRXlHD8l1nLyn5o6/QUMzVyFe6lq2MPR4wuIX1IiWA2G7LxfpXCVnYvzl
         a7ZosW+HYEsTlf0SiHBoP3WS7qrF2Jwnz7KNdBCtTxAouiuf5/HnZM91Y9XKY6I1vS+b
         hA27iyHqYmljoL9RIb8XU/boaUwhI0QU/NC32pjJ0hL+Uk7pKlFuwMj58hDU2lhKXwdo
         S3Wj2SCzLMOlmqexl8dP5gGyO2NB69b3zxhfc0Nd/ASdaS0WMecVmD/yvkHrLtSBptCa
         gp+Q==
X-Gm-Message-State: AOAM530CgRprDttXCsR3/kAgucjchlyIY5B5meS3DFdwtQnwf25eX/dV
        f3JIGKeljUXzTU63DH7rWjvLT9ny
X-Google-Smtp-Source: ABdhPJxpz/aqU38Uolak5WVXI7N3Ynx00MzPbSemW55R0WQqpdTzzzZOvb1MRKrnNb361BR2z3pfPg==
X-Received: by 2002:adf:ee05:: with SMTP id y5mr56130139wrn.185.1594131698579;
        Tue, 07 Jul 2020 07:21:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm1201716wrw.24.2020.07.07.07.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:38 -0700 (PDT)
Message-Id: <303ad4bdc7286522e83439b3c6bfdb408ed69407.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:16 +0000
Subject: [PATCH 02/21] gc: use repository in too_many_loose_objects()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous change performed a mechanical change to swap the_repository
for a struct repository pointer when the use of the_repository was
obvious. However, the too_many_loose_objects() method uses git_path()
instead of repo_git_path(), which implies a hidden dependence on
the_repository.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 5c5e0df5bf..6d8267cecb 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -159,7 +159,7 @@ static void gc_config(void)
 	git_config(git_default_config, NULL);
 }
 
-static int too_many_loose_objects(void)
+static int too_many_loose_objects(struct repository *r)
 {
 	/*
 	 * Quickly check if a "gc" is needed, by estimating how
@@ -174,7 +174,7 @@ static int too_many_loose_objects(void)
 	int needed = 0;
 	const unsigned hexsz_loose = the_hash_algo->hexsz - 2;
 
-	dir = opendir(git_path("objects/17"));
+	dir = opendir(repo_git_path(r, "objects/17"));
 	if (!dir)
 		return 0;
 
@@ -378,7 +378,7 @@ static int need_to_gc(struct repository *r)
 
 		add_repack_all_option(&keep_pack);
 		string_list_clear(&keep_pack, 0);
-	} else if (too_many_loose_objects())
+	} else if (too_many_loose_objects(r))
 		add_repack_incremental_option();
 	else
 		return 0;
@@ -692,7 +692,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 					     !quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
 					     NULL);
 
-	if (auto_gc && too_many_loose_objects())
+	if (auto_gc && too_many_loose_objects(r))
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
 
-- 
gitgitgadget


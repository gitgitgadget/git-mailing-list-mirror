Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC44C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA41764F94
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhCPVR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhCPVR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661F3C0613D7
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j7so8173647wrd.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5mJy/cBtDy0ry57TKts3aAMccIoiFUeW11pLCdGtBDk=;
        b=E08r8NueBEsoMC3AqpnH1oKVGrHIsPxqld4RqHe7dLLJBh5QHjDZQHSr/aOnTV+zhL
         eZmQBE9tvH04pwNMM8+2Bp8VZf7mGPapSek0o5ttOKOIeLA0ljhAqp48UPagWzFdBgGb
         rV+Ggh9D/wNzF7y6Xlj0lot7UH7X2+zBqjX5969t9KQCTkZ8qOQEBryEo3FsPAjO+3r/
         aQLgGViTtYA7bz7c8ITWT7J1uXnK0SvYHdfStTAmPDdZvw7eEEgYiuX3N6Y6Sw7JTbQt
         oqDm0SvNagJZGgFn9T0XrkkEQ8MwFZU2eblLNE3lcnxJhzdlGGkHpYrL0MEzAX45q1CK
         pUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5mJy/cBtDy0ry57TKts3aAMccIoiFUeW11pLCdGtBDk=;
        b=chLs/qIDvr1qWdJ1W4HNheVruvdDoq98DVAHe3LSGBRrUDAPwCIRv2xtnfijHC2U49
         GTva3l8hQJ4b5nogjGZI1WJh8II3xDVnl3Sh25UOOgriPOB11+roDE4ewMgd+ypJb0Gx
         U/brTmwsEjiXxdFsdw7MnhkLPBAIp7v1BRMXZ1vsLHCG2ZkcybUBFBUdAL2ZFkmegiRK
         Iivz9idM1zgNuh1Yph6Q0Z3BSFjQUX9mJHBTZkzoAFdH8eyoTX77ksZ1M2pNpEFv90lS
         NsAwqzsUh0VsfyepRv9D7AADWDk6cTjqJ/VYA9lPIFyqySesGqeBP2G2Eci0OO1RWJiT
         aI6Q==
X-Gm-Message-State: AOAM531MrJ2HJ5NhrSXNS6B8XxEGIeRV3EgtD+aTwx1wKgpHttRpbi/l
        oqi11wBoG8D+ApU5AH6hRJksPlD3EAQ=
X-Google-Smtp-Source: ABdhPJwleCBQPLsJKTgw9JR7ycFeqFo4QNs8sw16wpx+UWSPEXPpB7HWlgdZSwT2unVqgQokwruP6Q==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr990530wrd.132.1615929445260;
        Tue, 16 Mar 2021 14:17:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm188145wrr.35.2021.03.16.14.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:25 -0700 (PDT)
Message-Id: <00c8a7e1d119fa3b403227eb415200bba01f4bda.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:17:00 +0000
Subject: [PATCH 12/27] ls-files: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full one to avoid missing files.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/ls-files.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 76a0d35c1a01..8fbef2b14f29 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -317,6 +317,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 
 	if (!(show_cached || show_stage || show_deleted || show_modified))
 		return;
+	ensure_full_index(repo->index);
 	for (i = 0; i < repo->index->cache_nr; i++) {
 		const struct cache_entry *ce = repo->index->cache[i];
 		struct stat st;
@@ -495,6 +496,7 @@ void overlay_tree_on_index(struct index_state *istate,
 		die("bad tree-ish %s", tree_name);
 
 	/* Hoist the unmerged entries up to stage #3 to make room */
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		if (!ce_stage(ce))
-- 
gitgitgadget


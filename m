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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF313C43332
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEEF064F9F
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhCPVSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhCPVR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E052AC061765
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso189448wmi.0
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ce+cL5L/eS+p6DqIyjHoY8Pw72agrko9sK8k5zz68K0=;
        b=nHSzAS565Cpe9aySV4M964MqKQ/2ebV8GbJ5LFvyW2Ne6EbAHSrChepnTLlvuBbNu2
         gqyiFEnRj0oMbw/rj4LcYkveK5HitMFr8Cv1sBGjwoSI8IyhGcqIBj6nDbQK7PpJ9Rdp
         nB6QgLO7gXh7c1sf7k6bc1qqQciMD0Ti6SmI8Qp/nB/cgi23iAHwibajT66WY1vm4OOh
         pKLJDTuok7ClohfPzi5YM9Ge/XpBMfbHKN28JDxOP3cfDdttkYhVRCEUlInjl13trGKl
         Dxtc6ZOPWddnD0IUcvCutuaWGLLp8V92yNBQt95/H0hIHm1E5++L1zf/3xUUSy25nHi8
         eO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ce+cL5L/eS+p6DqIyjHoY8Pw72agrko9sK8k5zz68K0=;
        b=Fprfsn6ACIv7roGNnMVZIwp3iyHzVmosr2n7hNiO2nm1HKi0UlrbBI4aWptxlMbfJ2
         h7arXVsqb817ZjhzP3zz11t6OxBqD1CLFIRDfPET5KC5ezQmLDs7GBFgbVw4PDsLXZ/9
         5yJ5uvqLcYTyOQjpXKVf1nRkhVoJ6C5vAY4BkBFbSlPjQvMgGYJJhTHGGjsNhbPcRqWH
         J/UCgW7xAcitbollGzi0JvyjnGYWGGxx1U2NvKkFMtp73t4F9DN8GVw6x4cQ/0y5wi6Y
         EMS4721K6GGOkJPTgpKBGWAWi95/XDWygtmz+d1BUxxKuqNmIwn5i5XSudDC3H70NVdr
         E3EA==
X-Gm-Message-State: AOAM530if3ssw/nyxxsD050jw1e7J6jSmh9HuR6w8Co+lGeMjrRMEZER
        gPYfHa8B0Y77LSYlqXTqGRnORAnFd/g=
X-Google-Smtp-Source: ABdhPJzfRWAUFNgICqPVgECYbKrVWVbDUB9d7BIq4e1XLOGGfopquneU1OGGQAlYWH2HuPUD2CNJjQ==
X-Received: by 2002:a7b:cf16:: with SMTP id l22mr678016wmg.26.1615929444759;
        Tue, 16 Mar 2021 14:17:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s18sm27000677wrr.27.2021.03.16.14.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:24 -0700 (PDT)
Message-Id: <abe189051a0c6e4cb083ff3ab8a240fd375b2581.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:16:59 +0000
Subject: [PATCH 11/27] grep: ensure full index
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
expanded to a full one so we do not miss blobs to scan. Later, this can
integrate more carefully with sparse indexes with proper testing.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/grep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 4e91a253ac3b..652d6d60f644 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -504,6 +504,7 @@ static int grep_cache(struct grep_opt *opt,
 	if (repo_read_index(repo) < 0)
 		die(_("index file corrupt"));
 
+	ensure_full_index(repo->index);
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
 
-- 
gitgitgadget


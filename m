Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B3BC4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B05611C1
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhFWRvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhFWRu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:50:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1D0C061768
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n23so2212045wms.2
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UbL8etVolC5mVHVfP9+IwHrYsNT6lAVGdp5OId3OMzE=;
        b=M4fotfGYQDeUbtCdTQXeemenMH0LHQSHtyV8yxVlC1E0s5XIg2BircWO7p90YsgXGf
         GMDIf9mjs/vZLCvIU3NDPrh8Ns+wa7IyFCZu3MqCc6y70zOgsMbpI/tX2sLMB1rLaWea
         fLFYi829ss1MpxKmcHhQxK3zEt7ybzUMAz1zdzS4pVZ3YIdtAr+mj5OsFP0t9JmOX225
         AnqwvzmVyYuozeqGkwyeIo+XuOrcogt7sth1xbaG56y//kQXZOds4OAyq0T5FHmAvq3c
         1hyKyso0D+pbsVRS/3PdG/h0dkBHmpDH80XKpBGq3KZuN9sUXxgkyAknd6bGo3g/f5Sn
         NJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UbL8etVolC5mVHVfP9+IwHrYsNT6lAVGdp5OId3OMzE=;
        b=N4rn+IIpLMAfRSbxXdtHy8lrKhsCUEbTpm+rNLDhP8tqvnl7wvSASuhjPWdxWLyOAU
         Aydaj8hYDnDoc2e9QZXj6qdbtxVDms8RRsSUL6/qfIbUeC5mjzJv0iwLifxzZ66SShgs
         oxxJefBpNqN6fFYepucZWhXDcwFBdhvaCYcy0w6q/+IJl91NgJW0WmB4JQ6wbNRG/kbS
         ge1ZVGCe1MlKKs1VgA5vXmMnmaiXJpkgwW4M7HrLKlyedYoqXgCNX4etdJa81bK6bUWo
         ySxfqhVPB+aG48Xm8LbjKSazapIn2BvOdhSvT22mvguLC1DuJX9IOiYeDRbqengb9+vL
         fwKg==
X-Gm-Message-State: AOAM532MSdV69k7mzX3HpJE1OrMnBc0lEIMKMZKw1/dXbTz5dx02l04T
        /Fuey7VQoFYQYbpGHYlV9xB14Ro1qKEfGg==
X-Google-Smtp-Source: ABdhPJww9rg6ZZUebaLdIULNVEj1dhvTzoeuxHRvbh73WTGJ7vvAF97M92R5fQzYTsIiS6DJy5Dqug==
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr1101965wma.2.1624470517265;
        Wed, 23 Jun 2021 10:48:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/25] pack-bitmap-write.c: add a missing stop_progress()
Date:   Wed, 23 Jun 2021 19:48:11 +0200
Message-Id: <patch-11.25-7f5b71fe1be-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug that's been here since 7cc8f971085 (pack-objects: implement
bitmap writing, 2013-12-21), we did not call stop_progress() if we
reached the early exit in this function. This will matter in a
subsequent commit where we BUG(...) out if this happens, and matters
now e.g. because we don't have a corresponding "region_end" for the
progress trace2 event.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 pack-bitmap-write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 88d9e696a54..6e110e41ea4 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -550,6 +550,7 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 	if (indexed_commits_nr < 100) {
 		for (i = 0; i < indexed_commits_nr; ++i)
 			push_bitmapped_commit(indexed_commits[i]);
+		stop_progress(&writer.progress);
 		return;
 	}
 
-- 
2.32.0.599.g3967b4fa4ac


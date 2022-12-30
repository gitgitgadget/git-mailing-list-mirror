Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C12C3DA7C
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 07:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiL3H2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 02:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiL3H22 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 02:28:28 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2760418E09
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:28 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so12461030wms.0
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1ZPJmXOYH57q9HWDEn50ZNiTN5ANy7LrvddcO7M0zQ=;
        b=dt88fQmEjoQsyIgwuYP8/H8G9KlzU1Chutp0Ih6RuVXFHtIqFf5eavzdR7hylOqpgO
         +23NzASBY+MSgcfPH4O57RIJtOIgsGqJPKbp34RJ1D5n2Lk1dgWpkhkLhb3DqiwKuUr0
         FjWPBHgZo+hrsYtUUYJcsr9GKQY9V6ktA5LQqZibOUsWEbZR6Gk8r2yxWZNHMfe6MhQi
         WJHuxRw4SkukyaqmgmajF5aPUNt2QEYQcyzvbif+lLiaiLRRO7XIaT4UvOIC7BZgTIqq
         D2A1pD8xlkuhsv+JYjgKmfToXyVQMBt/hPrMGgRrQ91zZtnX6hElzGKyGzM4NtGz0XDZ
         t6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1ZPJmXOYH57q9HWDEn50ZNiTN5ANy7LrvddcO7M0zQ=;
        b=pER/59Un5yjjGk9wixvDScYkbeh+NWgXP6ck5yi4zjjLq3lhUwrA74gf1HIonLRtVd
         JD1HOpkA00/Ul5nztdJoD654AA19sIsjYPL6x/fRaNV8dp8+6PK7sl3eE5fDD1NF1ZlS
         GxPPO28b2Ctp6vEYJahnvqHoCbpaeO3P47AiiPOajNERyjmV92E6QKpNaQE65cFpcd/j
         h8JbgXXvo0MKAC3cBCqwYgdg0smgxLG0rNT//DIDAb45wk9zaFpa66XRsriMN+F4B82p
         IWHcTR85b7eejdNuZSZ2aC0hofKocSmsXbheK/vELmYDYDFiH32vbNyTty2e6IcMlkf4
         tGBw==
X-Gm-Message-State: AFqh2kpUJiNP5w55PkpmmMFg5LLCTTSgSRTtdXDG1BM8TKMvl/xnbeow
        g78o0OfjBmLpThlpk2CSs9DRWYLCt0Pqew==
X-Google-Smtp-Source: AMrXdXvHa7AHZjOWGujlMngfAEv9t1O/Pp9Nt69pfebM7eM5DOiQmY8mckgPhpVqYBg26oRe2pczwQ==
X-Received: by 2002:a05:600c:3485:b0:3d0:761b:f86 with SMTP id a5-20020a05600c348500b003d0761b0f86mr21665354wmq.28.1672385307028;
        Thu, 29 Dec 2022 23:28:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b003d998412db6sm6526449wmn.28.2022.12.29.23.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 23:28:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/10] builtin/rebase.c: free() "options.strategy_opts"
Date:   Fri, 30 Dec 2022 08:28:14 +0100
Message-Id: <patch-09.10-cd0489a2384-20221230T071741Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "strategy_opts" member was added in ba1905a5fef (builtin
rebase: add support for custom merge strategies, 2018-09-04) the
corresponding free() for it at the end of cmd_rebase() wasn't added,
let's do so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index f7fd20d71c0..70b037dc43a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1833,6 +1833,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	free(options.gpg_sign_opt);
 	free(options.cmd);
 	free(options.strategy);
+	free(options.strategy_opts);
 	strbuf_release(&options.git_format_patch_opt);
 	free(squash_onto_name);
 	string_list_clear(&exec, 0);
-- 
2.39.0.1153.g589e4efe9dc


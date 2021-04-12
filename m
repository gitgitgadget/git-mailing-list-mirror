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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B810C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB4761278
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244072AbhDLRQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244048AbhDLRQE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:04 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664BAC061342
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g66-20020a1c39450000b0290125d187ba22so6835806wma.2
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FNjkW0VoFbhd/Z9wvapwyno1ManCvvFceWRlLXmEadM=;
        b=GNaNM5Uzm7lf3zk5bJs5M3OZdVmu7e79SVUOE9w6dOdKJjwiMc77sGwinOCTpRKRj1
         vxABLetm9uZuTZjJe0oJEhSi8BZ0t/GXjfbQtTr4VdV4hajQzxGSrRRGr1Nha6AwtJZb
         1jq5GZxWPapdIxkkxpc+bsz8akA+gmjfFgSEgMYiieN5rsw301pzXpuUzEM9zoGuaSbA
         7h/NubWwVpq16WxQSqgMP0+lGA8uwo5YDm7z4nlqcyeRbdosp9xVxYaar9NsqMQN7GZW
         6O8Mmi/HyTiKN6euX0jTkCPaDJ2Q5i+f6XYUT3MmrCSmfTE24bwq/rtbteFj3ZTlEYy9
         0tnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FNjkW0VoFbhd/Z9wvapwyno1ManCvvFceWRlLXmEadM=;
        b=lVTa/IfVL4PiI+WffFBLBSDd9TDXZRbIyOxFX9TyiKe+/5r5HgffxM9k9+XN9FB+/U
         VYlVL3txPcsAXclGkDEvzIFI2x9UENTk0uOi7XRd6ih9SSzRitFDdzZiO/MmGF8qJYzx
         PRZagsGBzd8CegusbPC4ujNXffTUAuP/8s1w0+tkMfiFKg70ZWRDRoblof7g5GByi6CS
         piUkWTR9lfmMfcv6+Sdj7rF7qwPzAzM4GELjuE6yHU3KJWJfeRvrfxehqkZWGXT9bHSH
         hd+cB+ink3o0B5RR9doThS1BKpHnVJ2H5isZycpO7UtjOy5hejMAPtTCdhpuVdG7cva0
         MATA==
X-Gm-Message-State: AOAM5318eDAtDEnH5XJAxtBDFdrPb58LmsVL/kFPW4NPklt9qryPfbjf
        ErJ/O9EIBBK8RQ93yKiBnN2j1ZcdnyDShw==
X-Google-Smtp-Source: ABdhPJy45MIU8AjQ4d6BofX/MooNqQ18/XQhpoDFYxeDUz4ZH+aTnb8WKTcU/SjGyXtPNmhw35h6OQ==
X-Received: by 2002:a05:600c:2148:: with SMTP id v8mr121168wml.167.1618247743981;
        Mon, 12 Apr 2021 10:15:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/22] pickaxe: die when --find-object and --pickaxe-all are combined
Date:   Mon, 12 Apr 2021 19:15:15 +0200
Message-Id: <patch-08.22-749c3ca3f98-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neither the --pickaxe-all documentation nor --find-object's has ever
suggested that you can combine the two. See f506b8e8b5 (git log/diff:
add -G<regexp> that greps in the patch text, 2010-08-23) and
15af58c1ad (diffcore: add a pickaxe option to find a specific blob,
2018-01-04).

But we've silently tolerated it, which makes the logic in
diffcore_pickaxe() harder to reason about. Let's assert that we won't
have the two combined.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c                 | 3 +++
 diff.h                 | 2 ++
 t/t4209-log-pickaxe.sh | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/diff.c b/diff.c
index f9e86bca04e..c1f47a7f013 100644
--- a/diff.c
+++ b/diff.c
@@ -4631,6 +4631,9 @@ void diff_setup_done(struct diff_options *options)
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_G_REGEX_MASK))
 		die(_("-G and --pickaxe-regex are mutually exclusive, use --pickaxe-regex with -S"));
 
+	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_ALL_OBJFIND_MASK))
+		die(_("---pickaxe-all and --find-object are mutually exclusive, use --pickaxe-all with -G and -S"));
+
 	/*
 	 * Most of the time we can say "there are changes"
 	 * only by checking if there are changed paths, but
diff --git a/diff.h b/diff.h
index 5e110d349be..82254396f95 100644
--- a/diff.h
+++ b/diff.h
@@ -558,6 +558,8 @@ int git_config_rename(const char *var, const char *value);
 				 DIFF_PICKAXE_KIND_OBJFIND)
 #define DIFF_PICKAXE_KINDS_G_REGEX_MASK (DIFF_PICKAXE_KIND_G | \
 					 DIFF_PICKAXE_REGEX)
+#define DIFF_PICKAXE_KINDS_ALL_OBJFIND_MASK (DIFF_PICKAXE_ALL | \
+					     DIFF_PICKAXE_KIND_OBJFIND)
 
 #define DIFF_PICKAXE_IGNORE_CASE	32
 
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 772c6c1a7c8..16166ffd3e6 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -63,6 +63,9 @@ test_expect_success 'usage' '
 	grep "mutually exclusive" err &&
 
 	test_expect_code 128 git log -Sstring --find-object=HEAD 2>err &&
+	grep "mutually exclusive" err &&
+
+	test_expect_code 128 git log --pickaxe-all --find-object=HEAD 2>err &&
 	grep "mutually exclusive" err
 '
 
-- 
2.31.1.639.g3d04783866f


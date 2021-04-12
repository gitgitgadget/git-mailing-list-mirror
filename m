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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A987C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2807F61278
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244285AbhDLRQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243911AbhDLRQD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC25C06138E
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a6so13748660wrw.8
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ko2kjonu3mf3avjr0iD2rbpAf1Fl0uClj23Pt3AASGk=;
        b=lZbDfmwueWbFee1HKMRERj5VtN2fqKb+JkXAGHZBGY+FuPc3XySQYrY6cz7Vro9AiH
         w+T+84S9qp0q3C8nYzfEKCuFP8EbaNf/iE4cnQFf41p0rBCTeiH+GkNydDAyfZJnmgsS
         zDTFaDL4yWXF9WrzGCz4MUnLjNB2rpRsKHSDQMiWYaQdph/kTrrhCcfv19/GgodMDV8L
         yfWVlTlEydyxzN4PBPPhAYFliGNwpCVUOWxO4pdEUJuGoT7G1fx0Z7TWGv9cQnlTjZSK
         ksEmTKMPQXEUTQ7Wc6Fy0A516inYtH3JkP989YD0V1mbIjhkXFbpdZfWHhhI2zupiTqP
         F5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ko2kjonu3mf3avjr0iD2rbpAf1Fl0uClj23Pt3AASGk=;
        b=myVsUuugnwfj80276pC35zoeeSCoU88x1vo/ozt9WeseSUrY+IpFt0snemuvVU/LQM
         7ymkj2N1gyVboYjFV6Tgmv6CNvAm1XRZWlQiaSaDWlE5yT06VHCSKjTXy+xaD4ZAAt82
         u2p0wV33wXQRVTBe0XHwD1gmY80QxAhRTapQIX4JsQWfYUhe8iliEHYn7gxYhuCDkF4i
         y/sPNOTI6wG/0qdfoyGdJg1A4DI7J2WpsQNCvgEb8WPHmEa3CX4Ph176XnYbk7RSRiDU
         xzXSyS5prc/lTGp/wHDHUlpjpRdNm5OYW9XzgOTQEC81M1KozbPQFY1/Rx/k1JAqQhkM
         aYeg==
X-Gm-Message-State: AOAM530fsbCDRWAQVOcAnBCFznabcvyIOWFrBe/9FvMszzFo1bJpNdE0
        eOLr7Qfzf2tnRU2y4gocKl3MWvZRqUs7Ug==
X-Google-Smtp-Source: ABdhPJzF4cW+teOGHMKP7RdFa0nWman0+nQrkbbSNNSeMttZGwJ0FyKe/z7XhMWtsLIiUEOW7JGFTw==
X-Received: by 2002:a5d:4307:: with SMTP id h7mr32369977wrq.227.1618247743183;
        Mon, 12 Apr 2021 10:15:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/22] pickaxe: die when -G and --pickaxe-regex are combined
Date:   Mon, 12 Apr 2021 19:15:14 +0200
Message-Id: <patch-07.22-83e7b4793b6-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the -G and --pickaxe-regex options are combined we simply ignore
the --pickaxe-regex option. Let's die instead as suggested by our
documentation, since -G is always a regex.

When --pickaxe-regex was added in d01d8c6782 (Support for pickaxe
matching regular expressions, 2006-03-29) only the -S option
existed. Then when -G was added in f506b8e8b5 (git log/diff: add
-G<regexp> that greps in the patch text, 2010-08-23) neither the
documentation for --pickaxe-regex was updated accordingly, nor was
something like this assertion added.

Since 5bc3f0b567 (diffcore-pickaxe doc: document -S and -G properly,
2013-05-31) we've claimed that --pickaxe-regex should only be used
with -S, but have silently tolerated combining it with -G, let's die
instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c                 | 3 +++
 diff.h                 | 2 ++
 t/t4209-log-pickaxe.sh | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/diff.c b/diff.c
index 4acccd9d7ed..f9e86bca04e 100644
--- a/diff.c
+++ b/diff.c
@@ -4628,6 +4628,9 @@ void diff_setup_done(struct diff_options *options)
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
 		die(_("-G, -S and --find-object are mutually exclusive"));
 
+	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_G_REGEX_MASK))
+		die(_("-G and --pickaxe-regex are mutually exclusive, use --pickaxe-regex with -S"));
+
 	/*
 	 * Most of the time we can say "there are changes"
 	 * only by checking if there are changed paths, but
diff --git a/diff.h b/diff.h
index c8f3faea8aa..5e110d349be 100644
--- a/diff.h
+++ b/diff.h
@@ -556,6 +556,8 @@ int git_config_rename(const char *var, const char *value);
 #define DIFF_PICKAXE_KINDS_MASK (DIFF_PICKAXE_KIND_S | \
 				 DIFF_PICKAXE_KIND_G | \
 				 DIFF_PICKAXE_KIND_OBJFIND)
+#define DIFF_PICKAXE_KINDS_G_REGEX_MASK (DIFF_PICKAXE_KIND_G | \
+					 DIFF_PICKAXE_REGEX)
 
 #define DIFF_PICKAXE_IGNORE_CASE	32
 
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 532bb875f02..772c6c1a7c8 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -66,6 +66,11 @@ test_expect_success 'usage' '
 	grep "mutually exclusive" err
 '
 
+test_expect_success 'usage: --pickaxe-regex' '
+	test_expect_code 128 git log -Gregex --pickaxe-regex 2>err &&
+	grep "mutually exclusive" err
+'
+
 test_expect_success 'usage: --no-pickaxe-regex' '
 	cat >expect <<-\EOF &&
 	fatal: unrecognized argument: --no-pickaxe-regex
-- 
2.31.1.639.g3d04783866f


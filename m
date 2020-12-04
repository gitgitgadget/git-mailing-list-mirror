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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06B4C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE90922583
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgLDGRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLDGRz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:17:55 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694D4C08E861
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:16:46 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id t142so1127067oot.7
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4CqxZuY5ClZcezYpuu9BG5Qp6NclUxvC9oXw8k33WpM=;
        b=V3yFN8h88gm+D8UKiuoNVZuQ4W4912CwRyZy/HUg1saJkgJ7g/bsk+GEqwpDG35MFA
         ulitXOgsRt/kDLfci+DyR58tijPLf2ePz0DCyPKBxFi/sU25/BStDth0HZyqkJ5EYT5t
         BE1feVwUmSI+mXe1r4O8VfLQo+cZNcldFFtahqywm56hm6J3U5AaKags5OM2enyFs6Ug
         Oru4tgc9as+Q5a08LSMTEfcr4bNwCpBkZ3+DJJN+XBgolRxMMZaQfm946n75nAjJZ60x
         +GV5VbkaLlIkjZ3yEboFO/TE+WaKaE4/mEnoM0yTsncZ5S3Rdml+6qVTHJn7VD/gmApf
         SZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4CqxZuY5ClZcezYpuu9BG5Qp6NclUxvC9oXw8k33WpM=;
        b=EeEYgIq5ppscDdTwocWngbSz8Cb28M0aY1S5ZhgcOTUJsE47g795E7YEIPnu7+x98E
         nDqau2Fr3un2BBPxEw2ZHfld5nGYgLY+h6fatbHCUEKSRqNOJlA4locsT3wKHD21Vqco
         m48fbRgGaA5ifouEcPSvXXxlvDngdsejH+0vADucZxXHPmXLinBnM6/bKhV9RD5q3AlK
         RbBHEWQTW8JBd1eoCZGqAQys7oezwn+ZIPDXO1MkqkeVVUCgC/hYIso3pipWsVQM7z1O
         2S6KXW7eloCDt5Yl/cb2yN/vLK+5xoZ2a7HJUewrskkLwjPCEDRk7Am/z4eYcm+8L5h4
         +T5w==
X-Gm-Message-State: AOAM530CsJ7OkUHp2Mvda/l5h31jYFpX0GPRXg4wk7FnfWNgX2KzY49S
        0W938T8fzBMBZ2cceB5eHpFSNZH7COKKKA==
X-Google-Smtp-Source: ABdhPJwuPbZDk+7mltT+74TBc5+ZvqXA08kPOklisFR2COAvWBTM5Xok/OGQdcHXS7ljHswawxmT8g==
X-Received: by 2002:a4a:dc1:: with SMTP id 184mr2337508oob.40.1607062605634;
        Thu, 03 Dec 2020 22:16:45 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h3sm436421otq.33.2020.12.03.22.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:16:45 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 11/14] tentative: pull: change the semantics of --ff-only
Date:   Fri,  4 Dec 2020 00:16:20 -0600
Message-Id: <20201204061623.1170745-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204061623.1170745-1-felipe.contreras@gmail.com>
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want --ff-only to make sense only when no --merge or --rebase option
is specified.

Currently --rebase already ignores --ff-only (or any other --ff option),
but --merge fails.

Make it so --ff-only is only considered in the default mode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c  | 4 ++++
 t/t5520-pull.sh | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index f54ff36b57..ebf2ac687b 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1037,6 +1037,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	/* Disable --ff-only when --merge is specified */
+	if (!can_ff && !default_mode && !opt_rebase && opt_ff && !strcmp(opt_ff, "--ff-only"))
+		opt_ff = NULL;
+
 	if (opt_rebase) {
 		int ret = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index fdd1f79b06..eec6224fb0 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -843,7 +843,7 @@ test_expect_success 'git pull non-fast-forward (ff-only)' '
 	test_must_fail git pull
 '
 
-test_expect_failure 'git pull non-fast-forward with merge (ff-only)' '
+test_expect_success 'git pull non-fast-forward with merge (ff-only)' '
 	test_when_finished "git checkout master && git branch -D other test" &&
 	test_config pull.ff only &&
 	git checkout -b other master^ &&
-- 
2.29.2


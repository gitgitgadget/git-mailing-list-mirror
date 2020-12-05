Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65E5C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B01230FA
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgLETyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgLETyu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:54:50 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC44C08E85E
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:37 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id t23so2271963oov.4
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0c1tLf5NnIZPfC09YAx2DtCiMhMlSBI6uhXPoaXsLQ=;
        b=lD9Okr9yEzZAiIsN9Z6Ysjoa1ax2oC5hz0zj8DLgaDi6DU8KXhFtzAToDlSy/eWCNK
         jlOgbxr0Oddw2L40Sut3KWoKHYKoYefHmap1hWoD90+SPqWdPpWlGizy1UxuumbBiByb
         FF3xjFSpH4BTUXzPNsaDNO554jV0gn6xAPKb5BTEmWaoDx2bKc29DhpDEGqlNGKDXR2t
         A5eT5eVKhiRhcUqPaJ26OdVED+JyNnXSLcPL3vmwmjAegtLjqFpZGm8urHLzQH03utXQ
         9Ski6T1OVLQcGNQrgjv7zK93AXUWHU/Q1pISoQsDHdL7CDWloE1LXkIsC/a5LD+oG1go
         bjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0c1tLf5NnIZPfC09YAx2DtCiMhMlSBI6uhXPoaXsLQ=;
        b=GZpwDyqWrOSJOJsmMwi7xuGp4Xly0jOX0itGF5TebSgeEPcxlpzsvd8qRsTsMik3dB
         6v5kBuwvQ74lCG+I9BZHIrEXZ6VMDQsbbxObL/U4rIoIIVZQmICTFMM/hioVl9Ht4iuZ
         F+ThjhNWKXfCdbUovIs98KNPE7LE/wBZEp3IfoOhIAkHz208JA3bWGzxlypqCmLJ9aAr
         M+Lk3e0rdUmyIvSUuFbsku9q24qIooCri+tnt1cTSAFLKS/lviHLGmCodMFyy/zGJEmM
         7s/hzaGtHKq0yN04SOdNolJb8um2kZlYnMfiB2ztkCrdKqZ3h/bEYelC9R4JXK/fa1nf
         hEWw==
X-Gm-Message-State: AOAM532bgtFBoYfYdn8pZoR7dzptUjWY95RrSXxIEiBP+3jSa5QQw4TU
        6uy/b5qXTNTujGFMurSXsQMWGphxQthhkg==
X-Google-Smtp-Source: ABdhPJwxxEkylnc1fmp54ZgYEeGrRLf4l9zIunb9ohpmLixUY+u2hpdG8NxZEexcNZVM5sjpYzYjMg==
X-Received: by 2002:a4a:bb07:: with SMTP id f7mr7869587oop.44.1607198016558;
        Sat, 05 Dec 2020 11:53:36 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id b23sm1534011ooa.13.2020.12.05.11.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:36 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 10/16] pull: show warning with --ff
Date:   Sat,  5 Dec 2020 13:53:07 -0600
Message-Id: <20201205195313.1557473-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205195313.1557473-1-felipe.contreras@gmail.com>
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's unclear why --ff should remove the warning, since:

  git pull --ff

Is implicitly the same as:

  git pull

Unless of course pull.ff is specified otherwise.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c               | 2 +-
 t/t7601-merge-pull-config.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index da91d78a22..2bd6ee9d19 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1015,7 +1015,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (default_mode && !can_ff && opt_verbosity >= 0 && !opt_ff) {
+	if (default_mode && !can_ff && opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
 		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
 			"you need to specify if you want a merge, a rebase, or a fast-forward.\n"
 			"You can squelch this message by running one of the following commands:\n"
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 1de64e6cc5..d709799f8b 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -46,7 +46,7 @@ test_expect_success 'pull.rebase not set and pull.ff=true' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false' '
@@ -78,7 +78,7 @@ test_expect_success 'pull.rebase not set and --merge given' '
 test_expect_success 'pull.rebase not set and --ff given' '
 	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given' '
-- 
2.29.2


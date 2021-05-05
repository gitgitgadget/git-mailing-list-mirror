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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FE7C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D280613CD
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhEEOxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 10:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhEEOxM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 10:53:12 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E9DC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 07:52:14 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s25so2882270lji.0
        for <git@vger.kernel.org>; Wed, 05 May 2021 07:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yEilO6R3LXruubCToyIud0mdATa6waOVKEka3EzNXU=;
        b=CV0xXZlSBTJA2QrYcTd63k1YyXq5+QIgI1iHm26M5ukEEhu5f5KRtmqu0jBXcyghul
         zHRPS02P7HD+IQgTBZm6UghKVudtu+kXYBKIxKHE+9NkKk8q5FGo5ldjAPbogtO/7ob5
         UyTEwP54Sk6H2KfdWEdvTkEMcuUBHOrvBsrJhsiRntuljbt/REH+wBx0GEzilomMgpRj
         3cgNdd5TvZUw1v5Dhszz7pRoHEH5IIM4pm7ocFLirqNgpMUXy9G7mlkGkat6dfId4Be9
         tKuXa28JquvWn5yPOU/tqX2tcc1UF1+kV8hSpUjMfnoz82cRLS/ZcYKDeen5VqacfwZx
         lrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yEilO6R3LXruubCToyIud0mdATa6waOVKEka3EzNXU=;
        b=KUrWThGlDI86s3BSmPeQgAQbUuPJJgG7gAH2MZxKPu1B745xXQaH5vDSv0hx4lCSvX
         x/UWGEbDcZUxjUWejg6C7BdeEqL6kqRzzRd7dr6Les9bQm9GGgHYvZck5QlJ9Mpu2Img
         ARfEoVrs49mC4Z5TCA+D7XBpD8zLpi5YPel1vscFVSjaB0Pco9WL05e6lQFnh3VEKGe7
         L8aExhazPAsW/bVZcNYIkgRqKOsIxxoE0c1hiRFnqI0bnfWQeFpJ1lCuj1i6pMr8WWKb
         i0wN8BQEsgVzi+vHZphYHotvIOoZkTLwuJI60DID2is3/li5F1q8QCj2T57mFpOiE5oK
         RQQw==
X-Gm-Message-State: AOAM531S0izVfegNLZB4E9XLtphQ5C5IDT5BMbrTxkLLHMNsRM7kZHjM
        FTnAk9j/nxBHmbVnuTm0ptyGyfTpSFpa9g==
X-Google-Smtp-Source: ABdhPJyUg/eeTmBHndcRm24U/ZHp2EPqm3YZ7cdm70t53ONu8aGk5WCsnPkdlvIPQt8r3AR6f+q8tw==
X-Received: by 2002:a2e:b44f:: with SMTP id o15mr15307684ljm.497.1620226332710;
        Wed, 05 May 2021 07:52:12 -0700 (PDT)
Received: from paasan.lan (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id t3sm2162043lji.37.2021.05.05.07.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 07:52:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] add: die if both --dry-run and --interactive are given
Date:   Wed,  5 May 2021 16:52:04 +0200
Message-Id: <20210505145204.51614-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The interactive machinery does not obey --dry-run. Die appropriate if
both flags are passed.

Signed-off-by: Øystein Walle <oystwa@gmail.com>
---
I think a better solution would be to allow this and improve the
interactive machinery to handle --dry-run. This is what I could muster
up at the moment.

 builtin/add.c  | 2 ++
 t/t3700-add.sh | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index ea762a41e3..6077eb189f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -457,6 +457,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive) {
+		if (show_only)
+			die(_("--dry-run is incompatible with --interactive/--patch"));
 		if (pathspec_from_file)
 			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
 		exit(interactive_add(argv + 1, prefix, patch_interactive));
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index b3b122ff97..171b323f50 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -343,6 +343,10 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
 	test_cmp expect.err actual.err
 '
 
+test_expect_success 'git add --dry-run --interactive should fail' '
+	test_must_fail git add --dry-run --interactive
+'
+
 test_expect_success 'git add empty string should fail' '
 	test_must_fail git add ""
 '
-- 
2.27.0


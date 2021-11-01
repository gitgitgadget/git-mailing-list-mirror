Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC896C433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F9460F58
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhKATMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhKATMB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:12:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71593C06120B
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:09:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso595120wme.3
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzxcFHQVtEZW9iywmr5Ek4mRkrzTo4elB00GDlu2nkU=;
        b=JebI1TWSQALthQ7u+UznuscOeNPnpfSguIRtsHLM7RXl1dVxAIpawpg1An/STZJhi0
         PpxwhDOUBa4GG6ZLraKVG7p/VbkaVzgthUq6mQy+0dnroekDnSMvLp6yvmc5JTO2ngMH
         UEQ8xZsuvlrxEtiRmPRzXQnbyCTuEV/XgvZiQiU9UHF5hmfzQ7rqEVQ+Wb+yVp6SCZVI
         nCANZywNLpqEJCn70lsMO6VOvmyY8QzswrEaGM55Hxo+7UnxHVPi8nAzEBdjqKWl7Oz/
         H8sKQXD0Dbje1mlxOCse87+DZc9027+1HAYjYmyA8xt9ADmkMz0PzNexyVVDsw0Hqwkc
         qOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzxcFHQVtEZW9iywmr5Ek4mRkrzTo4elB00GDlu2nkU=;
        b=LjdnfMxRBW457fE4h4RfHmp5xJA94f5cOSQq2j5RGZ7S0oahVumJZT45I6WGFi1Ray
         /cHpwu3m6DC+oT4zlPODgRrZKfSbQkahOJt8KNSFvGEqFST07+XufRkuS2FyNx/dGCJH
         pbCEzp/QjT7rLPO+QjzFwOIdns4oJ5bnCpwhFQOLg17M8rInpg/7AX0gMUTC8GEiLaO1
         Xo7PEtkpLZuVJ5ugKCBxHUhaMXHXdhsRmYjX7KLeZtoogvPSn0/P6MRbvB3p3AeOscXT
         Lneg4jvG940+EpUuOwixBjfOnUP4ms9Mu3F88yFCj4nOXLbiFuBwhqZxW+22/5vrT5nn
         /z1Q==
X-Gm-Message-State: AOAM533zdXnyM2AMAdTTWupgKWUFm+S2Kp444B8loHQuN5+l3znAG9yV
        jsL78OOLBewIWXi8vqcKYm5f2SHyoE+mEPPa
X-Google-Smtp-Source: ABdhPJzzhiFJ3oRCkAh+P82pkF+cJOzuN+bYdXk3P4n1EQ2hrjtLVQUnKbHyU63rWGyyDu8XFRFNpw==
X-Received: by 2002:a1c:4d8:: with SMTP id 207mr979123wme.2.1635793763826;
        Mon, 01 Nov 2021 12:09:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p12sm4337211wro.33.2021.11.01.12.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:09:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 7/8] various *.c: use isatty(1|2), not isatty(STDIN_FILENO|STDERR_FILENO)
Date:   Mon,  1 Nov 2021 20:09:13 +0100
Message-Id: <patch-v5-7.8-4795d4835b0-20211101T190630Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
References: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com> <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have over 50 uses of "isatty(1)" and "isatty(2)" in the codebase,
only these two used the stdlib.h macros to refer to them.

Let's change these for consistency, and because a subsequent commit's
commit message outlines a recipe to change all of these for ad-hoc
testing, not needing to match these with that ad-hoc regex will make
things easier to explain.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 builtin/bundle.c         | 2 +-
 compat/mingw.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a5750..1727cb051fb 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -830,7 +830,7 @@ static int bisect_autostart(struct bisect_terms *terms)
 	fprintf_ln(stderr, _("You need to start by \"git bisect "
 			  "start\"\n"));
 
-	if (!isatty(STDIN_FILENO))
+	if (!isatty(1))
 		return -1;
 
 	/*
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 5a85d7cd0fe..df69c651753 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -56,7 +56,7 @@ static int parse_options_cmd_bundle(int argc,
 
 static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 	int all_progress_implied = 0;
-	int progress = isatty(STDERR_FILENO);
+	int progress = isatty(2);
 	struct strvec pack_opts;
 	int version = -1;
 	int ret;
diff --git a/compat/mingw.c b/compat/mingw.c
index 9e0cd1e097f..0f545c1a7d1 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2374,7 +2374,7 @@ int mingw_raise(int sig)
 	switch (sig) {
 	case SIGALRM:
 		if (timer_fn == SIG_DFL) {
-			if (isatty(STDERR_FILENO))
+			if (isatty(2))
 				fputs("Alarm clock\n", stderr);
 			exit(128 + SIGALRM);
 		} else if (timer_fn != SIG_IGN)
-- 
2.33.1.1570.g069344fdd45


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D962AC4320E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04BC610A0
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345093AbhIBNNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345152AbhIBNNG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E968C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m9so2881308wrb.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qvkw2rh1v07dKjdJW16zWvEdglTDlF1uoylnzvQ8e4=;
        b=YOscLXrVvrxoqYxh7CIsIDXZBHn/L1RTH3YHftgKGfOh8KxsWrXTX20jheOm7VZOYO
         W0cKes5SAnfCvt64N2o1GbMRfa0LLJf1cBdGi7fPXzeUx/7T0llUCcVGWTknj/gfwwvV
         ZT5zY59bBwCld/ZcvaMK2JwUyPoR9Hvf8Jb7xqtJ3QX4OStqq9CwnYNEHWYrZErTcov9
         a2DjOwnaaRPkuDPGZStcRfUdXFZrIfLjoWcbAvZGO9x9Uu2OgEzzBDL0ME7PdcMjQilA
         tsfFGGe609nj6aL28/ySfcONW2FU39F1wVg9DBvrRbODGRiOXBJG6micAJjub3lqu68A
         QMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qvkw2rh1v07dKjdJW16zWvEdglTDlF1uoylnzvQ8e4=;
        b=HQqeqZbd/EG3bjcvcaexKhYyWgD2qWtecExWuzTunowFq+NQahzTejZK7vUF+Y1kML
         NIC75kcsI1fj2UcGVIKDlicjRYBCmVELPErcOJX2GylmtCGTysopBW0iKFO3N85xz+X8
         uu1Lz9cvCbORsqPiIliQvz4nrpo06mlGfcmGsk7AGobZq2NzD9ykOOnU6I42oS3F1EZG
         jl8cpfnOW9RAt/QqME7EOB03gc8jzjUUVA/sfCqgGM1dYWdWj+2gGySOfwrhXp+CmQCO
         GhAB8vqbRg6rm8r2z++cCyJpE1Jcj5zVbrPwePW5KjViHPeIrEKGqbtL6mQUeDMJ53B2
         v19A==
X-Gm-Message-State: AOAM530qB2ciHQbih1Sjg21AW2QR4mv0Yzo0SVEGd3C0IaayPhhFtE+X
        aY6+dzeiRbfOSW+6AH+yuTNpiWNJx2FTrg==
X-Google-Smtp-Source: ABdhPJw92MiI2lu9zGu0cE66M6xXMBs+rHGMGx6CZ3DNzyoOwyCW4GXn+iO0QFHr1uJKZtvvsv+G4g==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr3805812wrr.382.1630588323742;
        Thu, 02 Sep 2021 06:12:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 20/36] run-command: remove old run_hook_{le,ve}() hook API
Date:   Thu,  2 Sep 2021 15:11:20 +0200
Message-Id: <patch-v5-20.36-428bb5a6792-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

The new hook.h library has replaced all run-command.h hook-related
functionality. So let's delete this dead code.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 32 --------------------------------
 run-command.h | 16 ----------------
 2 files changed, 48 deletions(-)

diff --git a/run-command.c b/run-command.c
index b4341ba1c7b..1399243de8a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1320,38 +1320,6 @@ int async_with_fork(void)
 #endif
 }
 
-static int run_hook_ve(const char *const *env, const char *name, va_list args)
-{
-	struct child_process hook = CHILD_PROCESS_INIT;
-	const char *p;
-
-	p = find_hook(name);
-	if (!p)
-		return 0;
-
-	strvec_push(&hook.args, p);
-	while ((p = va_arg(args, const char *)))
-		strvec_push(&hook.args, p);
-	hook.env = env;
-	hook.no_stdin = 1;
-	hook.stdout_to_stderr = 1;
-	hook.trace2_hook_name = name;
-
-	return run_command(&hook);
-}
-
-int run_hook_le(const char *const *env, const char *name, ...)
-{
-	va_list args;
-	int ret;
-
-	va_start(args, name);
-	ret = run_hook_ve(env, name, args);
-	va_end(args);
-
-	return ret;
-}
-
 struct io_pump {
 	/* initialized by caller */
 	int fd;
diff --git a/run-command.h b/run-command.h
index 7a867d41217..cfb6887e4ae 100644
--- a/run-command.h
+++ b/run-command.h
@@ -204,22 +204,6 @@ int finish_command_in_signal(struct child_process *);
  */
 int run_command(struct child_process *);
 
-/**
- * Run a hook.
- * The first argument is a pathname to an index file, or NULL
- * if the hook uses the default index file or no index is needed.
- * The second argument is the name of the hook.
- * The further arguments correspond to the hook arguments.
- * The last argument has to be NULL to terminate the arguments list.
- * If the hook does not exist or is not executable, the return
- * value will be zero.
- * If it is executable, the hook will be executed and the exit
- * status of the hook is returned.
- * On execution, .stdout_to_stderr and .no_stdin will be set.
- */
-LAST_ARG_MUST_BE_NULL
-int run_hook_le(const char *const *env, const char *name, ...);
-
 /*
  * Trigger an auto-gc
  */
-- 
2.33.0.816.g1ba32acadee


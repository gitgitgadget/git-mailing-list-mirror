Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E633C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 12:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5125020708
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 12:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9X7frwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgGGMR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGMRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 08:17:25 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9FBC061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 05:17:24 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id o4so24589970lfi.7
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 05:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GqLI6ApJgJGqM5QomYLGeZ+hyaY70q/xlvlcE81psKs=;
        b=l9X7frwg3PaxbsjZgBaCAHNtswnr6oS9CpxbsImpjo5NyP1d27oM2UGRq9TvYa3wSY
         m5vW1h2pxlU6E3ctKDoYkyGZk6nUiaXGDpLUmqGOkiZ98SLXyuPyhTW+xR0RkQbHJMoT
         FVODcrn1vDZ9JASwK1/xauo9yXwjNO+TOMKBk3HygOSk6Mhq7VM4ySZKtUzlVOOssgJY
         yINeojSG8csYo/pXv8URmpOPGO4/JqIg/mALcQ6dt17xSEOWkGm8cNqTXLadW/4rx440
         sVB0cBDXDH/8OR3Wp5QBgBAxsuLSNeGIYr9hrnpUiuqyyg8K0uv34AGsmpzl0rudFB6y
         SWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GqLI6ApJgJGqM5QomYLGeZ+hyaY70q/xlvlcE81psKs=;
        b=CUl+JSpnv6cB6xfEaR+qXHtso+RWN/km8lWHgi5UvRknMQQKj1moas9yVlnlUWrd19
         Da1HeFGLkbA0l/cV6tvvTLryqZVka9Sq5wU8sdD9kWd9tML2hj6UlPN9/eh+T+LSaqkm
         gX7F0jrkIVhB25y8aUFkada/7UBL6Sz/6PcUg4jbWwhJoRP/0meM/Q0EUMaxpDFP8I6d
         XPS4QtzQQJpTXyV4F6tUWUT9CyEL1itLENRVrMcfZK8EQvaOVgSuFEc6utDmWM5Fj249
         fYJpzuClNZmrBT2zfIb2IWyRMSsfX1/2HWTON6q0vVjtsffu7cthQPwKoPvbVT66GZwm
         +nDQ==
X-Gm-Message-State: AOAM532B08IKE6T62X2p0BSU4JRTfBICe0Vl1E2rbRR3k9PZQPxFsLTk
        erBgR3MY8CafWsEecW8+io6s5IMNwY0=
X-Google-Smtp-Source: ABdhPJw8j24YfRTcg3fm7wvQAiJ6mXvaawV93AJWjkpdQQ4GpCK5NjM5gNQo1rChntNO+4bd6jaRgQ==
X-Received: by 2002:a19:c214:: with SMTP id l20mr32664672lfc.56.1594124243011;
        Tue, 07 Jul 2020 05:17:23 -0700 (PDT)
Received: from george.localdomain ([2a01:79c:cebf:1be0:aa5e:45ff:fecd:fe25])
        by smtp.gmail.com with ESMTPSA id w4sm132724ljw.16.2020.07.07.05.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 05:17:21 -0700 (PDT)
From:   trygveaa@gmail.com
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Trygve Aaberge <trygveaa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Heba Waly <heba.waly@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH v2 1/2] Wait for child on signal death for aliases to builtins
Date:   Tue,  7 Jul 2020 14:17:14 +0200
Message-Id: <20200707121716.438318-1-trygveaa@gmail.com>
X-Mailer: git-send-email 2.26.2.2.g2208536367
In-Reply-To: <20200704221839.421997-1-trygveaa@gmail.com>
References: <20200704221839.421997-1-trygveaa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Trygve Aaberge <trygveaa@gmail.com>

When you hit ^C all the processes in the tree receives it. When a git
command uses a pager, git ignores this and waits until the pager quits.
However, when using an alias there is an additional process in the tree
which didn't ignore the signal. That caused it to exit which in turn
caused the pager to exit. This fixes that for aliases to builtins.

This was originally fixed in 46df6906f3 (see that for a more in-depth
explanation), but broke by a regression in ee4512ed48 and b914084007.

Signed-off-by: Trygve Aaberge <trygveaa@gmail.com>
---
 git.c         | 2 +-
 run-command.c | 1 +
 run-command.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 7be7ad34bd..9b8d3c92e6 100644
--- a/git.c
+++ b/git.c
@@ -768,7 +768,7 @@ static int run_argv(int *argcp, const char ***argv)
 			 * OK to return. Otherwise, we just pass along the status code.
 			 */
 			i = run_command_v_opt_tr2(args.argv, RUN_SILENT_EXEC_FAILURE |
-						  RUN_CLEAN_ON_EXIT, "git_alias");
+						  RUN_CLEAN_ON_EXIT | RUN_WAIT_AFTER_CLEAN, "git_alias");
 			if (i >= 0 || errno != ENOENT)
 				exit(i);
 			die("could not execute builtin %s", **argv);
diff --git a/run-command.c b/run-command.c
index f5e1149f9b..5d65335d13 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1039,6 +1039,7 @@ int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
 	cmd.silent_exec_failure = opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
 	cmd.use_shell = opt & RUN_USING_SHELL ? 1 : 0;
 	cmd.clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
+	cmd.wait_after_clean = opt & RUN_WAIT_AFTER_CLEAN ? 1 : 0;
 	cmd.dir = dir;
 	cmd.env = env;
 	cmd.trace2_child_class = tr2_class;
diff --git a/run-command.h b/run-command.h
index 0f3cc73ab6..1641ccf94b 100644
--- a/run-command.h
+++ b/run-command.h
@@ -224,6 +224,7 @@ int run_hook_ve(const char *const *env, const char *name, va_list args);
 #define RUN_SILENT_EXEC_FAILURE 8
 #define RUN_USING_SHELL 16
 #define RUN_CLEAN_ON_EXIT 32
+#define RUN_WAIT_AFTER_CLEAN 64
 
 /**
  * Convenience functions that encapsulate a sequence of
-- 
2.26.2.2.g2208536367


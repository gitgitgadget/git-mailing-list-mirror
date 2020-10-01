Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65A9C4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2E921D46
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRIoIZ+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgJADq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 23:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgJADqW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 23:46:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D825C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:46:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k10so3956990wru.6
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wFtXGfoZReg53g6R+Ofk7FNuP4sOHiZPekqNtKfDthw=;
        b=pRIoIZ+MyEPXqxitM1ME6HESo3tMFqx66asjcyeLdmVekequpuY+pA2exY6cauCxQn
         J0iEWVOPLs/kHFjwcWmXH6jbwU4AjrgBoMZ6xUlMnCLay+yfY+/RGERBRAoYG5hY7n/g
         yVdUJNj9bGIyUMdclKL0c53a80ZrmCGYaWKQ6vCEtIDtRjfsMjlMPGsrP8f983qEpSEA
         ppYBKFIbCNei8XDAtm3mQ3jYvD9i5OsPx4JH6t60XaQipFvg5aRE/t7uwXDPpPBBaSaC
         nWdypQsJR0gjz7fcgmIpUB3/NOH1L9/MHiea72vUm9hSmIzM7VgUCp7WWR3Heb8F9Lxq
         l7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wFtXGfoZReg53g6R+Ofk7FNuP4sOHiZPekqNtKfDthw=;
        b=bq+v9YfUzEwClp7c6VyhsLRoKfPI1qxJgjp8LIMf1oEjMLJ8YXdEIoWVY3LIL1P4hH
         amfuX1PkHP9ZUJ2nnayMdgeok8AlYTjRDR/loUu6oi3gC1Fp5iWSQQtSBxk4yqRLvuRU
         cJYd+yEzQQS7R70lE3Cy77JA4qy+3Ib/APUjyAzaGaL9eTmSryUbFkeJ3LemnDqTbb0x
         z2hMpBvZPnMVnEKfzxaPLGKuGG4zTa+PmZtcUNBCwQGI5MuZ8T2lfn5ckjCU41qi8GTN
         PjBb78YHciwjucpbpZ5hksFDSZ7LpAtiufcnGYjR1kxUeIYvK/wKegG7mepHm2f1KtQU
         ktcg==
X-Gm-Message-State: AOAM530akCmhDxepNpm7QOVDP9HGaOrGai62Zd8LlEcc9PBQmPJGSPg5
        UswcfogeHu/DfKDCYOuFH7t/moGU8YY=
X-Google-Smtp-Source: ABdhPJzr7z1htu3jm3bFrQavu47FKkwntGjJhh0aKxangDq3LVQPBk6wNP9YFzfb29S+5KLJuxBsow==
X-Received: by 2002:adf:c64e:: with SMTP id u14mr6175032wrg.373.1601523980174;
        Wed, 30 Sep 2020 20:46:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4sm7585827wrm.54.2020.09.30.20.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 20:46:19 -0700 (PDT)
Message-Id: <1abcf417d91128e09632f6c74cc14de3dce29623.1601523977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
References: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
        <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Oct 2020 03:46:11 +0000
Subject: [PATCH v3 2/7] clone: use more conventional config/option layering
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Sean Barag <sean@barag.org>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Sean Barag <sean@barag.org>, Sean Barag <sean@barag.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Barag <sean@barag.org>

Parsing command-line options before reading from config required careful
handling to ensure CLI options were treated with higher priority.  Read
config first to let parsed CLI naively overwrite matching config values.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Sean Barag <sean@barag.org>
---
 builtin/clone.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 391aa41075..a76dacd988 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -851,8 +851,22 @@ static int checkout(int submodule_progress)
 	return err;
 }
 
+static int git_clone_config(const char *k, const char *v, void *cb)
+{
+	return git_default_config(k, v, cb);
+}
+
 static int write_one_config(const char *key, const char *value, void *data)
 {
+	/*
+	 * give git_clone_config a chance to write config values back to the
+	 * environment, since git_config_set_multivar_gently only deals with
+	 * config-file writes
+	 */
+	int apply_failed = git_clone_config(key, value, data);
+	if (apply_failed)
+		return apply_failed;
+
 	return git_config_set_multivar_gently(key,
 					      value ? value : "true",
 					      CONFIG_REGEX_NONE, 0);
@@ -963,6 +977,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct strvec ref_prefixes = STRVEC_INIT;
 
 	packet_trace_identity("clone");
+
+	git_config(git_clone_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
 
@@ -1124,9 +1141,17 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (real_git_dir)
 		git_dir = real_git_dir;
 
+	/*
+	 * additional config can be injected with -c, make sure it's included
+	 * after init_db, which clears the entire config environment.
+	 */
 	write_config(&option_config);
 
-	git_config(git_default_config, NULL);
+	/*
+	 * re-read config after init_db and write_config to pick up any config
+	 * injected by --template and --config, respectively.
+	 */
+	git_config(git_clone_config, NULL);
 
 	if (option_bare) {
 		if (option_mirror)
-- 
gitgitgadget


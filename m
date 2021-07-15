Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7297C12002
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF76061377
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhGOCnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 22:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhGOCnq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 22:43:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5B6C061760
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:40:52 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j34so2731760wms.5
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CSIz9YDdUnOe4L/xkt9QMXDMUaeHcEtzG87P17Gd9J4=;
        b=KRQn7Ip3NRxwGQAMeuFwrhZ4Nm6bHdcSRztS5gkgNGoyUyOBNPtYaiaPGugRGek5Wp
         quv4IiGt0pFsaPuVz/sYXN6OhZhrbxA38f7ml1n6pTAccFn8oahKiBvJukWLAbPIKcjB
         bAIGDpUzPqeqWfl2Tkq77xicGdbIEvvyrushDtdiz60CHASTyZoRwaTQ/ZU74KoQWGH2
         sCdnutcx2t8iCA7c0Sz5KoZK2fnEcAnEq2PlVxZCzmAozo4CZOUAW8jt+kWS+JvYg0gb
         52LykP4OVBFvTG+cVgokzXNQ4aMvBZyWqQei5peTIviZT03pyFYAuZaR3GF71T1hMdQX
         Ik9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CSIz9YDdUnOe4L/xkt9QMXDMUaeHcEtzG87P17Gd9J4=;
        b=hatzQIx4X/IopVeXH4LpbeQWRGQWiMa2YC6g9qESVj3kbW4zESVR2xjvVaU4POMv59
         xGo/xiNLcT6ar1pJFoYwSq15F1SHV4/aoDjaE8JnZ6xckNlhv8lpYcUT27WGjlwucCzN
         WJIpxq/eajujI7FR2zcpz/w+FD17946bjY5aw4HHThEhOY5GHcvtdRIXa7SK7kuHKVOt
         quyPe8xbNJBu3r4kAlTsaAYUkPPJ7+7wYWplrWxAWkRSbx6UhAH+S1gHaPMPfpHjFnrH
         caCFi/s+SeYTj5WaVQ3u1qbmd05XRb6hjX82YhBrlAeThRH65zH8GVFzAmFQJnIUf7p1
         Hasw==
X-Gm-Message-State: AOAM530+MdTm71EEWYVRgf1u8RZaD3YqK62Rmpaz1qxaDdfdvmFdBeti
        0G5vItEKZBcf0Ue7rWEk5KmqkmvhIRs=
X-Google-Smtp-Source: ABdhPJyLS+ewkHQzku0Y7r3hblH5e+ej8ISN6mrTcz6D3DIEMykR6bIFfMR8xivPCL0w9qgrOxxVhA==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr1461225wmp.165.1626316851499;
        Wed, 14 Jul 2021 19:40:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v30sm5053143wrv.85.2021.07.14.19.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 19:40:51 -0700 (PDT)
Message-Id: <dc7163aae728d23539406b77faf0d55168e1bd05.1626316849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 02:40:45 +0000
Subject: [PATCH 1/5] pull: move definitions of parse_config_rebase and
 parse_opt_rebase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

No code changes, just moving these so a subsequent change will have
access to some variables.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/pull.c | 72 +++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 3e13f810843..61c68e4143f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -27,42 +27,6 @@
 #include "commit-reach.h"
 #include "sequencer.h"
 
-/**
- * Parses the value of --rebase. If value is a false value, returns
- * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
- * "merges", returns REBASE_MERGES. If value is "preserve", returns
- * REBASE_PRESERVE. If value is a invalid value, dies with a fatal error if
- * fatal is true, otherwise returns REBASE_INVALID.
- */
-static enum rebase_type parse_config_rebase(const char *key, const char *value,
-		int fatal)
-{
-	enum rebase_type v = rebase_parse_value(value);
-	if (v != REBASE_INVALID)
-		return v;
-
-	if (fatal)
-		die(_("Invalid value for %s: %s"), key, value);
-	else
-		error(_("Invalid value for %s: %s"), key, value);
-
-	return REBASE_INVALID;
-}
-
-/**
- * Callback for --rebase, which parses arg with parse_config_rebase().
- */
-static int parse_opt_rebase(const struct option *opt, const char *arg, int unset)
-{
-	enum rebase_type *value = opt->value;
-
-	if (arg)
-		*value = parse_config_rebase("--rebase", arg, 0);
-	else
-		*value = unset ? REBASE_FALSE : REBASE_TRUE;
-	return *value == REBASE_INVALID ? -1 : 0;
-}
-
 static const char * const pull_usage[] = {
 	N_("git pull [<options>] [<repository> [<refspec>...]]"),
 	NULL
@@ -112,6 +76,42 @@ static int opt_show_forced_updates = -1;
 static char *set_upstream;
 static struct strvec opt_fetch = STRVEC_INIT;
 
+/**
+ * Parses the value of --rebase. If value is a false value, returns
+ * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
+ * "merges", returns REBASE_MERGES. If value is "preserve", returns
+ * REBASE_PRESERVE. If value is a invalid value, dies with a fatal error if
+ * fatal is true, otherwise returns REBASE_INVALID.
+ */
+static enum rebase_type parse_config_rebase(const char *key, const char *value,
+		int fatal)
+{
+	enum rebase_type v = rebase_parse_value(value);
+	if (v != REBASE_INVALID)
+		return v;
+
+	if (fatal)
+		die(_("Invalid value for %s: %s"), key, value);
+	else
+		error(_("Invalid value for %s: %s"), key, value);
+
+	return REBASE_INVALID;
+}
+
+/**
+ * Callback for --rebase, which parses arg with parse_config_rebase().
+ */
+static int parse_opt_rebase(const struct option *opt, const char *arg, int unset)
+{
+	enum rebase_type *value = opt->value;
+
+	if (arg)
+		*value = parse_config_rebase("--rebase", arg, 0);
+	else
+		*value = unset ? REBASE_FALSE : REBASE_TRUE;
+	return *value == REBASE_INVALID ? -1 : 0;
+}
+
 static struct option pull_options[] = {
 	/* Shared options */
 	OPT__VERBOSITY(&opt_verbosity),
-- 
gitgitgadget


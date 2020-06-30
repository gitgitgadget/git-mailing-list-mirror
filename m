Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E2FC433E1
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 12:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778102073E
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 12:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He1WcfCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbgF3MFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387426AbgF3MFo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 08:05:44 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA824C03E97A
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 05:05:43 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n26so6308932ejx.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 05:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HrYI9Mx2eeIzo3R0ewjP/R8rLxtFEodXejq8QewzwMY=;
        b=He1WcfCKBhyg2flcrRUWzgxa3g/aVcjOSsfPLBSwZOFn3m8z/Xtr71EaRKoF+D+tYF
         QaYp6g1HITUrpp/hC1DDpj2V8FsEjlHz6u208kTRXyvONEZOPaUg/Y9KC5zbVIzI3rtK
         pf6aZxhoB3J0dlLBlz5g4yLB6ZgxMLKiHeZTpNBNeve1qX0V2j+T1EclFrxxcsEDyDj0
         P6Nn8ldzkHTu6y9laY5wM/tFZiZ7SlxEMoBkRpnGDuMTmenhVodO/diH9Tl4IvrrrIiW
         UnIGoxjVKSPFEjLY/uJuhWK57X17ve+kKtCKnzRNx+/uCjSaO8IofsH/T8HjSQ4a/dWL
         yWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HrYI9Mx2eeIzo3R0ewjP/R8rLxtFEodXejq8QewzwMY=;
        b=unD6PoVEOyLMBqsHRCPMlI+eOFGgrTqXlJYDUhNY9FUwhN4Dib26HpHHGXqsAP4A8U
         wOmSZZiKtwQsRSTLqjC8oSTThvnIL/3lX8Z0cQ4iKlvJsll/EDCj3tNPBzYHbWGSotf8
         9zTfBcgaYj1tW7lO4tAGYlbKBzwQsOrtnsK9/TFmC/EGmvAA8gIZE1HbFUH1GDH6ZHaD
         DBslWMmf1C5nfhDijcKCMFSGFkbuPV3or0QOxWvCHoXyF/0YKt0bu6me907BvN4NEGWU
         Zapg8ab2OkVrGYodNx3a4h9Xh1jgUxOfV9XZZUJdpgzyoKr/CPuJgtft/uJJWA2z7D2b
         2eAA==
X-Gm-Message-State: AOAM531tCl8xF0Hy0wk8wjUW1avjcpyd7fMqIO7its8gmz+uXtQ4Dco4
        DDIq3Nad3CTn4inDod/wcheo8tinpo8=
X-Google-Smtp-Source: ABdhPJxkBT0vQN1SSFsmMzWJT7nMVeboi03qyhq1TpEH4Apmxr4GHXSQi0AGi7kgKeTiertTebZNww==
X-Received: by 2002:a17:906:8406:: with SMTP id n6mr1528266ejx.250.1593518742535;
        Tue, 30 Jun 2020 05:05:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17sm1809720eje.74.2020.06.30.05.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 05:05:42 -0700 (PDT)
Message-Id: <2b7eb58c1556971d128fc7596bf8abf7a993432d.1593518738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.669.git.1593518738.gitgitgadget@gmail.com>
References: <pull.669.git.1593518738.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Jun 2020 12:05:38 +0000
Subject: [PATCH 4/4] Treat BISECT_HEAD as a pseudo ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Both the git-bisect.sh as bisect--helper inspected the file system directly.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/bisect--helper.c | 3 +--
 git-bisect.sh            | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ec4996282e..73f9324ad7 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -13,7 +13,6 @@ static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
-static GIT_PATH_FUNC(git_path_bisect_head, "BISECT_HEAD")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
@@ -164,7 +163,7 @@ static int bisect_reset(const char *commit)
 		strbuf_addstr(&branch, commit);
 	}
 
-	if (!file_exists(git_path_bisect_head())) {
+	if (!ref_exists("BISECT_HEAD")) {
 		struct argv_array argv = ARGV_ARRAY_INIT;
 
 		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
diff --git a/git-bisect.sh b/git-bisect.sh
index 08a6ed57dd..f03fbb18f0 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -41,7 +41,7 @@ TERM_GOOD=good
 
 bisect_head()
 {
-	if test -f "$GIT_DIR/BISECT_HEAD"
+	if git rev-parse --verify -q BISECT_HEAD > /dev/null
 	then
 		echo BISECT_HEAD
 	else
@@ -153,7 +153,7 @@ bisect_next() {
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD $TERM_GOOD|| exit
 
 	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
+	git bisect--helper --next-all $(git rev-parse --verify -q BISECT_HEAD > /dev/null && echo --no-checkout)
 	res=$?
 
 	# Check if we should exit because bisection is finished
-- 
gitgitgadget

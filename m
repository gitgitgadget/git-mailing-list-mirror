Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7754AC2B9F7
	for <git@archiver.kernel.org>; Tue, 25 May 2021 03:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9C36140A
	for <git@archiver.kernel.org>; Tue, 25 May 2021 03:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhEYDml (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 23:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhEYDmk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 23:42:40 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA40C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 20:41:10 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id m13so22196848qtk.13
        for <git@vger.kernel.org>; Mon, 24 May 2021 20:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aR9al1COJtCUoHL/UTYPPA6O3nscuDQpLjVSLl/tGKY=;
        b=bSXyV2Htg3bl/ymRBSzJ02cv2um4M03qfBbsKal7cwS8nVe7ciUl5+bgxwwwwtLIDW
         iqMNwlEpEFGCe19Y3IczRl1f5czo74HZwAUVL7vjM1MAwI1YbEyyOqFI1CqNAN3tjVfg
         nTe6b0bC0slSW/oopjQB7yqEDMAer/ojMMmrAG7FWyGZAShPm7Wv8QqWbuP+qoI0W31j
         FUXaUP32U2SGR5sL9gFt910kRfYx89rspFs0LGAwFPYIDPCr8d7AaSBgco9sSldIFyZM
         YD3LHKTOzjZN+DWeYpjHvm7zwZXtAgjyf2YLrv5PEeWg0Sis7JFR/EWe+eIhGvmeIBMg
         xBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aR9al1COJtCUoHL/UTYPPA6O3nscuDQpLjVSLl/tGKY=;
        b=ukigfoOlC6WjtbAz9hIL62bZZyzraJevULK4Y/4Ub3+OlGWbbbIIzDLWFReuxWM/Up
         n6nms17KnzoUYAUQFDVl4+KcAYyxZdMkxmAAQ0BS2hcflXtVq6NVPr13m9YzoQE/4KvU
         +Btj9CyVKBRvwNVIhZOVOPk1pDbsVEDjeFiJNUeWT/qzAcsAv5JkU126SLkPVH8QV4os
         0dKlQhWKE1ZRUhFj178iaKIddEAKCBvxM28ndOpe81JAQpqaUGj9UTO9g0ydVxnCM2VB
         TUd0B3YKTgEN/PB68Hc82xeMjoVa+VfGY3Iif9VUSvEV/JHMrSZUeJa1yIf76JmmIKat
         zeDw==
X-Gm-Message-State: AOAM532HNAoI3iMwK63/WZjj3KoAjjhOnEZCOlhMtCG83HbzpgDgOQGc
        Q+o3qtYwEJHONmkXAQW7xkAX5gkq9wbrHui7
X-Google-Smtp-Source: ABdhPJyVEnvPtx40Ullz7enXAxcADvHPgfLEHYbzI9ofM21T5xEaX4LwD+vo+Md/iaVHpxeFcijPoQ==
X-Received: by 2002:ac8:678b:: with SMTP id b11mr30839980qtp.150.1621914069358;
        Mon, 24 May 2021 20:41:09 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id s20sm12449624qke.2.2021.05.24.20.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 20:41:08 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     ajrhunt@google.com, peff@peff.net
Subject: [PATCH] init: fix bug regarding ~/ expansion in init.templateDir
Date:   Tue, 25 May 2021 00:41:01 -0300
Message-Id: <b079bc0288429919aca482a689ee87e70b719303.1621914058.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We used to read the init.templateDir setting at builtin/init-db.c using
a git_config() callback that, in turn, called git_config_pathname(). To
simplify the config reading logic at this file and plug a memory leak,
this was replaced by a direct call to git_config_get_value() at
e4de4502e6 ("init: remove git_init_db_config() while fixing leaks",
2021-03-14). However, this function doesn't provide path expanding
semantics, like git_config_pathname() does, so paths with '~/' and
'~user/' are treated literally. This makes 'git init' fail to handle
init.templateDir paths using these constructs:

	$ git config init.templateDir '~/templates_dir'
	$ git init
	'warning: templates not found in ~/templates_dir'

Replace the git_config_get_value() call by git_config_get_pathname(),
which does the '~/' and '~user/' expansions. Also add a regression test.
Note that unlike git_config_get_value(), the config cache does not own
the memory for the path returned by git_config_get_pathname(), so we
must free() it.

Reported on IRC by rkta.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/init-db.c |  3 ++-
 t/t0001-init.sh   | 28 ++++++++++++++++++++--------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index c19b35f1e6..2167796ff2 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -212,8 +212,9 @@ static int create_default_files(const char *template_path,
 	 * values (since we've just potentially changed what's available on
 	 * disk).
 	 */
-	git_config_get_value("init.templatedir", &init_template_dir);
+	git_config_get_pathname("init.templatedir", &init_template_dir);
 	copy_templates(template_path, init_template_dir);
+	free((char *)init_template_dir);
 	git_config_clear();
 	reset_shared_repository();
 	git_config(git_default_config, NULL);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 0803994874..acd662e403 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -186,21 +186,33 @@ test_expect_success 'init with --template (blank)' '
 	test_path_is_missing template-blank/.git/info/exclude
 '
 
+init_no_templatedir_env () {
+	(
+		sane_unset GIT_TEMPLATE_DIR &&
+		NO_SET_GIT_TEMPLATE_DIR=t &&
+		export NO_SET_GIT_TEMPLATE_DIR &&
+		git init "$1"
+	)
+}
+
 test_expect_success 'init with init.templatedir set' '
 	mkdir templatedir-source &&
 	echo Content >templatedir-source/file &&
 	test_config_global init.templatedir "${HOME}/templatedir-source" &&
-	(
-		mkdir templatedir-set &&
-		cd templatedir-set &&
-		sane_unset GIT_TEMPLATE_DIR &&
-		NO_SET_GIT_TEMPLATE_DIR=t &&
-		export NO_SET_GIT_TEMPLATE_DIR &&
-		git init
-	) &&
+
+	init_no_templatedir_env templatedir-set &&
 	test_cmp templatedir-source/file templatedir-set/.git/file
 '
 
+test_expect_success 'init with init.templatedir using ~ expansion' '
+	mkdir -p templatedir-source &&
+	echo Content >templatedir-source/file &&
+	test_config_global init.templatedir "~/templatedir-source" &&
+
+	init_no_templatedir_env templatedir-expansion &&
+	test_cmp templatedir-source/file templatedir-expansion/.git/file
+'
+
 test_expect_success 'init --bare/--shared overrides system/global config' '
 	test_config_global core.bare false &&
 	test_config_global core.sharedRepository 0640 &&
-- 
2.31.1


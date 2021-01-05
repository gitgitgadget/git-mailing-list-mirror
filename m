Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4A0C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 14:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB6122B49
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 14:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbhAEOne (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 09:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbhAEOnd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 09:43:33 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E941AC061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 06:42:52 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i9so36417494wrc.4
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 06:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=QidGZ/7MOb/KEy6A2Oft5GOFjIsXdT8dbKjaLrcMdvA=;
        b=o0FkjsJPyDyM55+c1oHudJTRJ19TJYf6IZHPUNFWBqqtB093s2VGPHXSBVBlN0/fyl
         e5f+WgEhsvf2SslZL9BsdysH6Nwy/GGlF413ZhQ/FNdb8NwOXLwdV5gdU+vRzKtIx6eY
         ImrBEd/HRdk8KONlQy1TZDTALf/Qw+6KGFEvUaRP9sFUKfMe/aVJY6PiNu87J1wyvlH7
         Fh/LSSxkiLNvKI9rX645XGaWuJqjzahm1ScB5cZDdfUOGQBUS+I1zSohi2pazh8fx/D8
         Wk6OUHo30gQitwk7NGOOlb2TjTmCZyrYTkfB9RuUNS6PLrFVJ9FXp/DTVYR5X/gh6Ol4
         Y1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=QidGZ/7MOb/KEy6A2Oft5GOFjIsXdT8dbKjaLrcMdvA=;
        b=FO+yrNRVWw7W6fZmTd44Pf/7X8lvp7+JmXZXd7d8DG6WFcu58V3vA3Db/2Ac1vnk9e
         H7s9hF46+CNdlVDFhIFum5mAQO4Bda2WGMP0njw0W0NsM4CVqz/O4EfdkXzC8MwhSy5n
         ugTRCMlVcX12bvUQuHLGVTlvl0n8vjVsLbkgvzjn+hCkNfwPSot9LXe1m8Y3h8gkQnds
         fm2pHlLKIqt5PDFKVQx0XaBTZ1KIeocP2q0cd6+EPRYaqOcU94CQW1K5F3xtoT8GwfCd
         1AiwhZQu8Gddyx/mpQKz0WD40S1MEmPkNPKRuHxBHhBQoDTWHTPgzPKWTx6rpZh4XMfS
         1sgQ==
X-Gm-Message-State: AOAM533Aroy5zp3yf5r4xhCoL2p6llii0FuB6bf7aiX+HM4KpW5Zr0ug
        yZt9JuEDliXavFnK+a6ZF5PR1Cft6fM=
X-Google-Smtp-Source: ABdhPJweZj81lkFRoho1zEA5F7VbTYDazwckKKYCxN8TNZKws+Sp7BykPwq0SNm+ntUeDv1UdTTQFw==
X-Received: by 2002:a05:6000:18c:: with SMTP id p12mr83803531wrx.7.1609857771545;
        Tue, 05 Jan 2021 06:42:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7sm781wrv.47.2021.01.05.06.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 06:42:50 -0800 (PST)
Message-Id: <pull.834.git.1609857770445.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 14:42:50 +0000
Subject: [PATCH] for-each-repo: do nothing on empty config
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

'git for-each-repo --config=X' should return success without calling any
subcommands when the config key 'X' has no value. The current
implementation instead segfaults.

A user could run into this issue if they used 'git maintenance start' to
initialize their cron schedule using 'git for-each-repo
--config=maintenance.repo ...' but then using 'git maintenance
unregister' to remove the config option. (Note: 'git maintenance stop'
would remove the config _and_ remove the cron schedule.)

Add a simple test to ensure this works.

Reported-by: Andreas Bühmann <dev@uuml.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    for-each-repo: do nothing on empty config
    
    Thanks, Andreas, for drawing my attention to this bug.
    
    [1] https://github.com/gitgitgadget/git/issues/833

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-834%2Fderrickstolee%2Ffor-each-repo-empty-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-834/derrickstolee/for-each-repo-empty-config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/834

 builtin/for-each-repo.c  | 3 +++
 t/t0068-for-each-repo.sh | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 5bba623ff12..9b9d2364f1a 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -51,6 +51,9 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	values = repo_config_get_value_multi(the_repository,
 					     config_key);
 
+	if (!values)
+		return result;
+
 	for (i = 0; !result && i < values->nr; i++)
 		result = run_command_on_repo(values->items[i].string, &args);
 
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 136b4ec8392..adc1b81826a 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -27,4 +27,8 @@ test_expect_success 'run based on configured value' '
 	grep again message
 '
 
+test_expect_success 'do nothing on empty config' '
+	git for-each-repo --config=bogus.config -- these args would fail
+'
+
 test_done

base-commit: 4950b2a2b5c4731e4c9d5b803739a6979b23fed6
-- 
gitgitgadget

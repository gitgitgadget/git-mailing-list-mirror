Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8BCC4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 23:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiKAXGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 19:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKAXFk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 19:05:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80D6201A8
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 16:05:39 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id t25so40938218ejb.8
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RPxqC2iVTs6jp3Y5kJb8QMksxZQk5Rnth8UJ9skmZs=;
        b=hE72/2s1Z0o8u1EZA4XhOO4sbmlgMyaY0Y9jKe0/m1rQxjDN6QG+FtVjCEIcYKUcp+
         rSoJwmt15j1sXZRJfvwSZyVx3tYovsuDTncD2asyoyrmU6NNDHc535jSaWxCkddX0hvD
         DCzsmlJWHMzmN24FNrGA9FsPD1GmVAoxNLvrwuVnZF9ek1gJ+muppMTS9JXLutGzUSLh
         2WwvlHW9bsw5aGdXv50CCMX1MgFMu9onD2kSzR+9qp+2wi4bTnsFbZpPc8ka5N+504JU
         w++iGmNJtPPnYWYKK8nEuuBD6k5HBtWS3vMB0xJ3XW6ivuVbJ2ricvKbpDC+hvfHYiBf
         7kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RPxqC2iVTs6jp3Y5kJb8QMksxZQk5Rnth8UJ9skmZs=;
        b=PeA8sENmWnoSQm92odDwOeoyj6RNXOrUY9OwYqXaKh/DFtLB25oHEb/wBr2Kcbtig6
         MVkuovue3JBz7YF5KFRto2zVEs6NFHrDwFf7+SofDi8dLpJDBPf1CwmnPkndNMJZ5Gku
         XXatW01yS41X2GmCNQ9DuCYg9nt2AZiKv9itd5muJnHcUF6vDKfQuxgF960Lcabqxf9A
         v79lJUWkNmFpKDaWNxsJRHDOXUSXjh6lGH5joo2Z7ptSZCpLwd6CvgR7i3FJQDwkCmAZ
         NHWYfHPk6Lk2pjl1/+2oUuQy332fqi5PC6K2ta96vQBKLDYlPL8B6HKK5mZSrgu183dG
         hEoQ==
X-Gm-Message-State: ACrzQf3Gv7tm98W10WWD6FexxbSx3pyQhfGJv3TMiME4WP/l5rCpSE7c
        amf9hsYGoScuqk8hMxu7eMnFmir3DluMlA==
X-Google-Smtp-Source: AMsMyM6ocgpoTnrvzTGArIRhWmxRx/wTsKxBVcXBrF3qC1X8jAI63JSeqdLVLNrNDsPcsH7lntPFyQ==
X-Received: by 2002:a17:906:9be3:b0:7ad:d3a4:9df3 with SMTP id de35-20020a1709069be300b007add3a49df3mr11843576ejc.682.1667343937948;
        Tue, 01 Nov 2022 16:05:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020a17090631d200b0078cb06c2ef9sm4645202ejf.8.2022.11.01.16.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:05:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/9] for-each-repo: error on bad --config
Date:   Wed,  2 Nov 2022 00:05:17 +0100
Message-Id: <patch-v2-6.9-a0c29d46556-20221101T225823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in 6c62f015520 (for-each-repo: do nothing on empty config,
2021-01-08) this command wants to ignore a non-existing config key,
but let's not conflate that with bad config.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/for-each-repo.c     | 3 ++-
 builtin/submodule--helper.c | 8 ++++----
 t/t0068-for-each-repo.sh    | 8 ++++----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 7d7685c8a1a..96caf90139b 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -45,7 +45,8 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 
 	err = repo_config_get_value_multi(the_repository, config_key, &values);
 	if (err < 0)
-		return 0;
+		usage_msg_optf(_("got bad config --config=%s"),
+			       for_each_repo_usage, options, config_key);
 	else if (err)
 		return 0;
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53afc2de4af..ad7ecaafc83 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -541,7 +541,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 		NULL
 	};
 	int ret = 1;
-	const struct string_list *values;
+	const struct string_list *unused;
 
 	argc = parse_options(argc, argv, prefix, module_init_options,
 			     git_submodule_helper_usage, 0);
@@ -553,7 +553,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	 * If there are no path args and submodule.active is set then,
 	 * by default, only initialize 'active' modules.
 	 */
-	if (!argc && !git_config_get_value_multi("submodule.active", &values))
+	if (!argc && !git_config_get_value_multi("submodule.active", &unused))
 		module_list_active(&list);
 
 	info.prefix = prefix;
@@ -2717,7 +2717,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	if (opt.init) {
 		struct module_list list = MODULE_LIST_INIT;
 		struct init_cb info = INIT_CB_INIT;
-		const struct string_list *values;
+		const struct string_list *unused;
 
 		if (module_list_compute(argv, opt.prefix,
 					&pathspec2, &list) < 0) {
@@ -2730,7 +2730,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		 * If there are no path args and submodule.active is set then,
 		 * by default, only initialize 'active' modules.
 		 */
-		if (!argc && !git_config_get_value_multi("submodule.active", &values))
+		if (!argc && !git_config_get_value_multi("submodule.active", &unused))
 			module_list_active(&list);
 
 		info.prefix = opt.prefix;
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 6bba0c5f4c2..115221c9ca5 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -33,10 +33,10 @@ test_expect_success 'do nothing on empty config' '
 	git for-each-repo --config=bogus.config -- help --no-such-option
 '
 
-test_expect_success 'bad config keys' '
-	git for-each-repo --config=a &&
-	git for-each-repo --config=a.b. &&
-	git for-each-repo --config="'\''.b"
+test_expect_success 'error on bad config keys' '
+	test_expect_code 129 git for-each-repo --config=a &&
+	test_expect_code 129 git for-each-repo --config=a.b. &&
+	test_expect_code 129 git for-each-repo --config="'\''.b"
 '
 
 test_done
-- 
2.38.0.1280.g8136eb6fab2


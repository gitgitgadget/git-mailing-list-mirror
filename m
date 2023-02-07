Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98302C6379F
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 16:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjBGQLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 11:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjBGQLF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 11:11:05 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8FC126DD
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 08:11:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v10so16249147edi.8
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 08:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoFoSLV4Cky6Mcz57oKK4z/6Zvyh7B8Q1ukFWpc1xJ8=;
        b=MEHczKq4kBUacmEdzXdFBdQzkJi9V9x81I554A+IzoJyLpIv8g4xpvYqlEjCGipQfb
         Zm6PSiNZorEMLPOmjQWG3vJGpzaKsmL9M0achF3mk6xZLGvFbsEtty3COrrzbtNfSYdq
         dMlqAmgICOKZz2ud2i7uLUXoDxUWcK2DUCgCfTCLcicCm+9mFx1gsfhdZsv4pPHt3WRI
         emS/V6hrXkbPG3M0mDHhXB2PsinBn81fr5z2BB9pGeHUeD1iEzWXnzaBfkHUNmKQXtEY
         nDh8jFu0a/7eXUaxe9x7yyR4M+oRQkWTIWZt1yqk6cuNWkRWNI7b+jEw5xCuGA1KZlEv
         5f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoFoSLV4Cky6Mcz57oKK4z/6Zvyh7B8Q1ukFWpc1xJ8=;
        b=e1E49sDcrTuSbFq/g/vrscgdpjXtA5Q2Opgb08sVy7YYwALYlDfei+cLchstmUT0p/
         5xMHPHXfq4E9dhdFVkCUCaduTZdk6pwNHP4IWh5NcCiww0u62n0l7ZoZ1pkIzK+5FnLo
         mRSOOXOxjMlRdg08ofZDWMoUYBooj1dDqdt7l1H5Q1WBxYFmgJTY51wLL4l3YdhWAR5y
         sznAf9FcYB2kLeGwY1nKZRnvTnYoDgK6+YP8LDIXUTtBEgL+2g/RIjJ6nCU0NNZ7vK1h
         L75wvV+DmzmTGHXYrrawTn2rG9qPF4lOkyILZS0fUe1N1xxYpYjnLx+5W5G/cnMTHZT1
         RqsQ==
X-Gm-Message-State: AO0yUKV2O4158BUFi1R2hB69LxbXnY670m/rSOTtaJjhIMpQXccvso/D
        Hic7KA92yzfz7tbH4P0Akg+Ui8HXXOB/5AAO
X-Google-Smtp-Source: AK7set85uocdfJokZvN69FaH2450HYvT8zXi/dAQ4Qjri4QSCeNae/A0eOG2Av4wA9BPAsNbPoYhRg==
X-Received: by 2002:a17:906:3950:b0:887:3c7e:5df with SMTP id g16-20020a170906395000b008873c7e05dfmr4024851eje.73.1675786262696;
        Tue, 07 Feb 2023 08:11:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906080400b008a60ed04e42sm2401167ejd.110.2023.02.07.08.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:11:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 07/10] for-each-repo: error on bad --config
Date:   Tue,  7 Feb 2023 17:10:47 +0100
Message-Id: <patch-v5-07.10-8a83c30ea78-20230207T154000Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1430.gb2471c0aaf4
In-Reply-To: <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in 6c62f015520 (for-each-repo: do nothing on empty config,
2021-01-08) this command wants to ignore a non-existing config key,
but let's not conflate that with bad config.

Before this, all these added tests would pass with an exit code of 0.

We could preserve the comment added in 6c62f015520, but now that we're
directly using the documented repo_config_get_value_multi() value it's
just narrating something that should be obvious from the API use, so
let's drop it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/for-each-repo.c  | 11 ++++++-----
 t/t0068-for-each-repo.sh |  6 ++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index fd0e7739e6a..224164addb3 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -32,6 +32,7 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	static const char *config_key = NULL;
 	int i, result = 0;
 	const struct string_list *values;
+	int err;
 
 	const struct option options[] = {
 		OPT_STRING(0, "config", &config_key, N_("config"),
@@ -45,11 +46,11 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	if (!config_key)
 		die(_("missing --config=<config>"));
 
-	/*
-	 * Do nothing on an empty list, which is equivalent to the case
-	 * where the config variable does not exist at all.
-	 */
-	if (repo_config_get_value_multi(the_repository, config_key, &values))
+	err = repo_config_get_value_multi(the_repository, config_key, &values);
+	if (err < 0)
+		usage_msg_optf(_("got bad config --config=%s"),
+			       for_each_repo_usage, options, config_key);
+	else if (err)
 		return 0;
 
 	for (i = 0; !result && i < values->nr; i++)
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 3648d439a87..6b51e00da0e 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -40,4 +40,10 @@ test_expect_success 'do nothing on empty config' '
 	git for-each-repo --config=bogus.config -- help --no-such-option
 '
 
+test_expect_success 'error on bad config keys' '
+	test_expect_code 129 git for-each-repo --config=a &&
+	test_expect_code 129 git for-each-repo --config=a.b. &&
+	test_expect_code 129 git for-each-repo --config="'\''.b"
+'
+
 test_done
-- 
2.39.1.1430.gb2471c0aaf4


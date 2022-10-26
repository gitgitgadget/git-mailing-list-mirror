Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BD7C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 15:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiJZPgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 11:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbiJZPgk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 11:36:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4E412A371
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:38 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k8so18357979wrh.1
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMe0F6isGj0OhIsQEnAue1kKs7CYrNzKni4aRD/aOt4=;
        b=l3qEVb/9xS91v59T8DMyzYxRbHorBz4ay9gBF9LJpNyW3mfVuZ9KUZ4zOdt7bJZEGq
         Bh3BYNUyykZBnEjIXSKOiAAM/57HjArBunKRJJi4nL01qM6BdDf6OlsiYEbO3S5U1riZ
         nS1AOKEhBhAbMuFMSJIFlUgwkfFMsFL2pSflrPX1FEfQy55kmsrhUMkMjPcVulXMSHe0
         srT+/K1I1HbstL9FKD7Jdz/+BSD2OANR17n34w4HjP4668KKhLTHRYe7BuBqUEyJ5eaI
         PbNcWrmKPN+HlgsiADu2kDo0E81e0h6wFNLaj8deCNdgP6sjk/h/kSBvH2FzA9AWs2IS
         RQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMe0F6isGj0OhIsQEnAue1kKs7CYrNzKni4aRD/aOt4=;
        b=BSXVC3uNBDffM7PQstkIPUj2TNB7TvMajXau/yeOOGZ/bS514fNhVm9XsQDH61BeQI
         qc13KZboHya7a+1Mgr1r1utxV5kqp6KZAKh5z5ozknxxyYZwbqG09YukzT3qhMMK6aQi
         1uSE/yPnT+h7oc5C4dWCrGOqCgDtd3BxW0g1yyZQIM0L5jRryZtlp6OQ45Hc7L0vanu0
         eqOQumdXiWZXBjYIhLqkjDL/JEd0Uv9zrfIrjaeg5v54Nrr+59/wgIU6bnsWFsS35uiS
         hZMQ6YElE6HY6wR++GFqKp58M1e6vZbo5ZTKqhY/6RTv58xrMqNe58yB3/0/dT7hLWsz
         Ny1g==
X-Gm-Message-State: ACrzQf1GcJNOOSDOL++K8DyPX9chikzRN5iomiRWzQDqC36tHItk2XYO
        bEOkmiMkJtglNybzSU1uyXgF2zSsELwStQ==
X-Google-Smtp-Source: AMsMyM440MnWtXwp6WhwlzAM3Si82x4tpP3SRjYJP4hoShyRZOJBIUJyPYAFUdWirk453X3CMN418g==
X-Received: by 2002:a05:6000:15cf:b0:230:ba81:cefc with SMTP id y15-20020a05600015cf00b00230ba81cefcmr29540257wry.544.1666798597102;
        Wed, 26 Oct 2022 08:36:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a0560001b8100b002366f300e57sm5581884wru.23.2022.10.26.08.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:36:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/10] for-each-repo: error on bad --config
Date:   Wed, 26 Oct 2022 17:35:15 +0200
Message-Id: <patch-02.10-e17de2a2664-20221026T151328Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in 6c62f015520 (for-each-repo: do nothing on empty config,
2021-01-08) this command wants to ignore a non-existing config key,
but let's not conflate that with bad config.

We could preserve the comment added in 6c62f015520, but now that we're
directly using the documented repo_config_get_value_multi() value it's
just narrating something that should be obvious from the API use, so
let's drop it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/for-each-repo.c  | 15 +++++++--------
 t/t0068-for-each-repo.sh |  6 ++++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index b01721762ef..16e9a76d04a 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -28,7 +28,8 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 {
 	static const char *config_key = NULL;
 	int i, result = 0;
-	const struct string_list *values = NULL;
+	const struct string_list *values;
+	int err;
 
 	const struct option options[] = {
 		OPT_STRING(0, "config", &config_key, N_("config"),
@@ -42,13 +43,11 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	if (!config_key)
 		die(_("missing --config=<config>"));
 
-	repo_config_get_value_multi(the_repository, config_key, &values);
-
-	/*
-	 * Do nothing on an empty list, which is equivalent to the case
-	 * where the config variable does not exist at all.
-	 */
-	if (!values)
+	err = repo_config_get_value_multi(the_repository, config_key, &values);
+	if (err < 0)
+		usage_msg_optf(_("got bad config --config=%s"),
+			       for_each_repo_usage, options, config_key);
+	else if (err)
 		return 0;
 
 	for (i = 0; !result && i < values->nr; i++)
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 4675e852517..115221c9ca5 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -33,4 +33,10 @@ test_expect_success 'do nothing on empty config' '
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
2.38.0.1251.g3eefdfb5e7a


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE8EC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjC1OGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjC1OGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:06:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F5DC165
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:05:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so4194657wmq.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680012282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDdnQ6yERIbX0aCwM5dihvL4YSD4XPKsQZRZTjX1yG4=;
        b=L+URwPBcZ9dDdPtYN0YEQEvRnlEmriiy0p58T55xB0Zl1PN1qpJlEqr6+ftTt6vZkt
         TItZNmdegal9s2yeIRjztbiXFzeHvQerENpCv3E0LOlx4Y4fg9okGmZW0tIGTmHa6hdy
         VYTEK88XoO6DsQROdabD9pd8moHoKSblxX669upLXzdNqJExhvY5pKQd7yoqneikbSyH
         bN9kNCqe7PpkS3T8IajblqToVzT3OIIMqybHNAfVy/nsTKloagOUSA46Bj/OjyXJHK0X
         k8tmRNAiquo3LZmzemV7vPpdl64x0rhK5Abc+JdXu+5QNIlR8Z20odvav61D8OqilewP
         X5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDdnQ6yERIbX0aCwM5dihvL4YSD4XPKsQZRZTjX1yG4=;
        b=WsYoRAIrW4Tt1yj+Z6XQhrzOoh9jat9DsFREGxr0iPkgUEGJzqZWCizOcXfRdswXiC
         I2YPO12DNqEsACdH3Z+/4IjD2o6lGSz72/vysMJ/kAdfx6rLaIE4XKEhZy6KAG6+DxzI
         2oOcHomItRXIcs77MRD0eT1O+DR53aKUbZorRiwRWG3L7VYU6n3RuHeljghwSERgfMpr
         EpASD+PEe5ZlBU4Z+sbUAAvcwQ51xqY0YpdLz8Nmgv/6Z88eE5cfSldxwOFR0zqoqSeL
         M05nJ4/T0n8jADsjcT3rtJB8u4DstqKIoEd9rN7tyolK1a14LuMhr1gApH+qa538YG8q
         yVCw==
X-Gm-Message-State: AO0yUKV3Hx+fDcwLKlgKV1MZ2VMub031KOZlb4PIC4SpeHJvLr9Ao6s7
        WSNtdPGzN+oZ/87msTOaHNdvZykeTbd4ow==
X-Google-Smtp-Source: AK7set8S7buWsbTh938umWIzVMCjea+isfohTa+RW6vOkGMt2RPQfzcsHT5mf81NoMwd1Q94zJd2Cw==
X-Received: by 2002:a05:600c:21da:b0:3ed:346d:452f with SMTP id x26-20020a05600c21da00b003ed346d452fmr12919422wmj.26.1680012282182;
        Tue, 28 Mar 2023 07:04:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c3b8a00b003ede3f5c81fsm12903622wms.41.2023.03.28.07.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:04:41 -0700 (PDT)
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
Subject: [PATCH v8 6/9] for-each-repo: error on bad --config
Date:   Tue, 28 Mar 2023 16:04:25 +0200
Message-Id: <patch-v8-6.9-75a68b14217-20230328T140127Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
References: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com> <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
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
2.40.0.rc1.1034.g5867a1b10c5


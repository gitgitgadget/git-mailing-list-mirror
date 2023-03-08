Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F918C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 09:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCHJIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 04:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCHJIC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 04:08:02 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F08085B01
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 01:07:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id f11so14609364wrv.8
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 01:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDdnQ6yERIbX0aCwM5dihvL4YSD4XPKsQZRZTjX1yG4=;
        b=DbZlMvhwRJCI83b35pX7724KeA1bh24eXwn8QNIAFh2ZCj+lJGwouerKpjJUHbBn8M
         U3aUrv/xkkSThCQgwMK0R95VxEzZxhE3WUV90Q/LF3720nLJhLanRy6uPKPzc48H/r5+
         Nk/tbQDYuVwqWioZuWc0udCoO3Srv4FbI/Gz8RkxSEnJrgRG5+E3GsKpxv1ltno42qFv
         hq7ZSHVZRQtP7W1Tr+RgQtn/Spmj6XShmzDq5Bg+1jOXSNIfFTSQFz8ppCHCNR9cRPO4
         cexpiBw7vIkFQw2QgSOv39ygKju7MZC75cDAIcPtEeHq3OLiNP3iCDNzL37Ak4JblnAc
         cdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDdnQ6yERIbX0aCwM5dihvL4YSD4XPKsQZRZTjX1yG4=;
        b=GrHc23pdcS62wEzbLC2T/MUMJA8+W//x9c7h/se3YLcwW5ApgzzavB6iBF9bUPtaXX
         ZG7ygLX5SAaYGfjRgGT7IaG4L0oAyfMjkvI5QI9Zm+MbMf82/9dhW7jqMUD/a9b518Mk
         kwebXPfK++dpAlArG1tf8ey8kShQmWCmD7hz+v2g4BRjwqQkcYKWykqItPqOjFjtX+Ml
         DNFM9J23xRms+8J2xg8sl+fKoWRtm95zfZLJp2zsgNilfz0HgRtqWO3/Pmd+JMQeDRAC
         8REBwHbi1UF3MAMq3K61Dm7OoSIrC5HgQRkeZAg5+iqqdHp0fm53HTzOcXlFaf8kwWg1
         wKdA==
X-Gm-Message-State: AO0yUKU3zsa2WV9V3zMz88RxZt+QvRPE1qR8M5hxv87jbQNtjiIyLE+r
        BW+CgLJLhvGF0he1KTMaMS7cU7QC9uCJSg==
X-Google-Smtp-Source: AK7set9AhwW4VoBCOazTyo1aygKvmqPVxiClM5w0xDftGbpSSFHEgDKz8duOoN0atkcEn/Hv6JuK/g==
X-Received: by 2002:a5d:5544:0:b0:242:1809:7e17 with SMTP id g4-20020a5d5544000000b0024218097e17mr11691885wrw.6.1678266444175;
        Wed, 08 Mar 2023 01:07:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s17-20020adfea91000000b002c6e8cb612fsm14435156wrm.92.2023.03.08.01.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:07:23 -0800 (PST)
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
Subject: [PATCH v7 6/9] for-each-repo: error on bad --config
Date:   Wed,  8 Mar 2023 10:06:48 +0100
Message-Id: <patch-v7-6.9-d910f7e3a27-20230308T090513Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
References: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com> <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
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


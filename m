Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDCAC4167B
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 09:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiKYJy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 04:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiKYJyc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 04:54:32 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487C31F2E8
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:51:56 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso2985819wmp.5
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+vAlRKZ6YB7y9RwWasF5mCe4XNpLLczSEMKdagapu4=;
        b=jZaOlpQBLhgyp0d/cMXIZeYsmOd3iQc3NCPh9KT7bL1DK8cEX5i3TLVbPOSJcG3Vbj
         Rb1AcLorY5Wb/jepBydVIPLRDpuhaQmMCXEgsEnVj8yuZ0VNwdOZcPbAPF03RB5ExPhm
         1Ef/ZZod8+C99nia8W3pT7BTtO7yZHmQBQE1IDoWo8m2e5fUqoV5Hn2hufF4D5Decgca
         hVNxmmy1FUWYE8/gyRbEH4GdDJnFQo7co84gBmB9LS0EeqyNztMD9UhQTUE76ZKMpuND
         bFPmW/B08+/J8sZhZ1ZmsbLJIzTMnSDBMz2FEB4DPPeqb4FjzHv3xABoxx/ql9/ejxQ8
         Y9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+vAlRKZ6YB7y9RwWasF5mCe4XNpLLczSEMKdagapu4=;
        b=gvMPyDHSuUFB5Cxbv9FG72eXYkZUdC37ZAiI6iEr/c51QojMC/zPmPWVA7Sfzj/6+l
         m8F5Xo4qm10+/U2rhqtkiYX60e6szhHxUg/KgRTICQFVg/e2/ceIEajL0spGiITqudh7
         rQp8DpqpyWARF4UKqhStQ9UsSfMBpj1HvRlpjzAapD+gkjMv/L0ehhj9USllhhEz3Y7E
         f6th71TQZG1L5ppl5ZLtms8TQBrcVcbfsr+zeMi6ChuLqrakxo7iDNSVxwaSa5YR7ukO
         EquBUOWrOO76S886UEyxkR0xynNyaH4EloT/ZG7xFjKNG/iCh05Zar17z0LYnQZMxmSD
         KFFg==
X-Gm-Message-State: ANoB5pn/tGuO5J30nn6H3K7YZIDS+ThSi8S8JG0e//pWPsAAb/082JvZ
        DCu3/GO0+Gf7gTEl4R3WhgoczEUwHuANkLsN
X-Google-Smtp-Source: AA0mqf4D20YmhwZ/riod/RPecSTIpjyTLQK26iTPhtRihq9VPIQYj+vofiuGQL3/I05/tHt2pE7/Xg==
X-Received: by 2002:a05:600c:384d:b0:3cf:7217:d5fa with SMTP id s13-20020a05600c384d00b003cf7217d5famr15981158wmr.191.1669369887451;
        Fri, 25 Nov 2022 01:51:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020adfe546000000b0023655e51c33sm3420975wrm.4.2022.11.25.01.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:51:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/9] for-each-repo: error on bad --config
Date:   Fri, 25 Nov 2022 10:50:07 +0100
Message-Id: <patch-v3-6.9-06d502bc577-20221125T093159Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.955.ge9b241be664
In-Reply-To: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
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
 builtin/for-each-repo.c  | 3 ++-
 t/t0068-for-each-repo.sh | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 7cc41847635..224164addb3 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -48,7 +48,8 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 
 	err = repo_config_get_value_multi(the_repository, config_key, &values);
 	if (err < 0)
-		return 0;
+		usage_msg_optf(_("got bad config --config=%s"),
+			       for_each_repo_usage, options, config_key);
 	else if (err)
 		return 0;
 
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index a099abc652e..19ceaa546ea 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -39,10 +39,10 @@ test_expect_success 'do nothing on empty config' '
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
2.39.0.rc0.955.ge9b241be664


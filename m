Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A91AC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EA9B61100
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhIJLbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhIJLb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:31:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F32C061756
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:30:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so1120475wms.4
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QLj1FaGTL6kqpvAeFqjsjkt45ihlgB05mwo0ufGgBhI=;
        b=fSMrPIlXA1zQ5DenJQxLoJn8GC3Q/izK/N/DLau8RLwQDwyyCotUPYrAvXgospmlKb
         ZO+St6r1qIIgF0nKFbq6Mn+CrSNwttt42zLXQLyzIeU/fA32XSO6wx+Amb7XIfiwBJ3Q
         PVgm/xiGVsccbiay3Mbrohq7SZo2DKJ6+sGTILjEW9s8fCLb4GWOyocAxabSERhp7vbD
         z5oeraQhqYRSmTfsBxz8Ldc9AyqiTRs8uzAM0Nzl9ZmSML3r2UU2HDQ351HA4FDSoWp3
         cKqvG66kjtAPtkC4aM+uOMLROAXNoCrSulELQtNL7tGVcuk2Dk14h3YeUkdznNVWUtYh
         m8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QLj1FaGTL6kqpvAeFqjsjkt45ihlgB05mwo0ufGgBhI=;
        b=Kx0kgHU0eobZbC0NNUmaxffPJZJLmwitK5JmhzHgP1UWmO1QONmYjrYD0EOKwxJsPl
         FaSAXretHDiNOHs4vsXnYGs2zUOG1iSiNlsK3/KelA9/jVr91oTH8wRmE3xGrldZLgmQ
         4nSiuy+HvrEH4jdNundSuVUVyH293iA+85YzcadU1+qAbwffukzJNqB3hsLb82+tnWMe
         00BJB/6PAEWP1uz6s5q0F0v4vTxxwIFm32NZKJKag0dizU7omnf1IJ5cCSyK65bcX3Wp
         zRDmH1mRKnqfupymHXhs0EqY50/uODtQGb+q4V2m+i3oElUV9lFbBGdTpY68LEeACXfL
         0jfw==
X-Gm-Message-State: AOAM533Zq6cQyp/iPnT19yWlUWQBKUN1IHzJ2+dV0WYo2ZULRg7bzluQ
        lxPiWCxg1b9PtNRGh6MlNtq78uTFMAdlSg==
X-Google-Smtp-Source: ABdhPJwLhL0EtqL/lyoj7/S1fUkXtfxSy+mgZNNs0PGyml9DJqEayuFJV2u3Os3QV0m9Pd1oj7CaNA==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr2421221wmc.101.1631273417166;
        Fri, 10 Sep 2021 04:30:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm4103278wmp.1.2021.09.10.04.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:30:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] help tests: add test for --config output
Date:   Fri, 10 Sep 2021 13:28:44 +0200
Message-Id: <patch-v2-3.5-258282095de-20210910T112545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.873.g125ff7b9940
In-Reply-To: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing test for checking what the --config output added in
ac68a93fd2 (help: add --config to list all available config,
2018-05-26) looks like. We should not be emitting anything except
config variables and the brief usage information at the end here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0012-help.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index c3aa016fd30..595bf81f133 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -77,6 +77,19 @@ test_expect_success 'git help -g' '
 	test_i18ngrep "^   tutorial   " help.output
 '
 
+test_expect_success 'git help -c' '
+	git help -c >help.output &&
+	cat >expect <<-\EOF &&
+
+	'"'"'git help config'"'"' for more information
+	EOF
+	grep -v -E \
+		-e "^[^.]+\.[^.]+$" \
+		-e "^[^.]+\.[^.]+\.[^.]+$" \
+		help.output >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'generate builtin list' '
 	git --list-cmds=builtins >builtins
 '
-- 
2.33.0.873.g125ff7b9940


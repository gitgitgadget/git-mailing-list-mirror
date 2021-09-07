Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DAFC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB41760E52
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343831AbhIGK7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343798AbhIGK7f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F063BC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id s24so908052wmh.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZ8ux2fJFm1ThSxAdzfsS9LGMbQ1RnQhrszlzbvc+gE=;
        b=ojfX/oMqfzJ3+NcUAEZ7rrjPlbmCktq5+NjR5xO88XUsCvL6ieUkjveor0tj+pTJZJ
         IGubBN6UvVC9ClRlXjqe+jvY4mrdVTH4xSq0Oin7tU5uYupG+3zN/Sm81dfxAEm6RWTY
         13I4/EiipTgUx7tQWv4IG9vn6Z/qrT6rHcJhaM/Imyr981GsMWUzkBp+2zkXtcLwlXqz
         4QycFnxqzABPEfTs31opKcvlOBaZrSe8KVgM+kLQQLHBU1O/Xtz6dVQ7VZwRzYNMwj+2
         539RUILUpOSuhQpcHoDtjxPbIAOUK92IeFippTbgOc5eIRBnIj7yNOTM3PCwEB8LIiLg
         9RRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZ8ux2fJFm1ThSxAdzfsS9LGMbQ1RnQhrszlzbvc+gE=;
        b=gDhJw5glDjchL7CFLNRk4bnUEvpf+BDIgM61cYcZkRmi0TF+lyc40fnSxWMygbX7k2
         kn1vLMJo8SBGEMC2cCM/QcueqGrEolYRIHGEmacQaREREnaQHIVfoZ7MkyWrtvUyhO22
         0x7AVtrHvcWeDxggl8e3Dcg+/nDnbfLUAqBykjVoB2yA9olOfDY2CzNdjE8PU9uqRuMo
         b2+tNwpap6wWbYQSLXhjftH1mMr76CIXqM0aGjh/ALNd4R9rk1jqjrMDoG9nXZ9lN8eU
         YWNh3i79gnIvCNpzMSesWEatUhxEjAn/eWikoE4BvKLv/acUl6HWQaq8LL5nyETWxyA4
         14SQ==
X-Gm-Message-State: AOAM530Z0Ci6o6aAUl41oKZrZuIOFGxRQli0VG3BM+c/pT4zekJ/cixg
        eRaFjjFQNwt5J9sZBV/IS18t0IViwYIWWQ==
X-Google-Smtp-Source: ABdhPJw69qGNvI3EnoZ0EVRlhnPwAKpsUdi7CC+MML2yl/OuO6hdfEbxUU9eughXKt0OoVoAt4vblw==
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr3306894wml.142.1631012307337;
        Tue, 07 Sep 2021 03:58:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 04/22] cat-file tests: test that --allow-unknown-type isn't on by default
Date:   Tue,  7 Sep 2021 12:57:59 +0200
Message-Id: <patch-v6-04.22-0358273022f-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the tests for the --allow-unknown-type feature
added in 39e4ae38804 (cat-file: teach cat-file a
'--allow-unknown-type' option, 2015-05-03). We should check that
--allow-unknown-type isn't on by default.

Before this change all the tests would succeed if --allow-unknown-type
was on by default, let's fix that by asserting that -t and -s die on a
"garbage" type without --allow-unknown-type.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 3a7b138fe4e..5e05ea0861e 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -347,6 +347,20 @@ bogus_content="bogus"
 bogus_size=$(strlen "$bogus_content")
 bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
 
+test_expect_success 'die on broken object under -t and -s without --allow-unknown-type' '
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type
+	EOF
+
+	test_must_fail git cat-file -t $bogus_sha1 >out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out.actual &&
+
+	test_must_fail git cat-file -s $bogus_sha1 >out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out.actual
+'
+
 test_expect_success "Type of broken object is correct" '
 	echo $bogus_type >expect &&
 	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
@@ -363,6 +377,21 @@ bogus_content="bogus"
 bogus_size=$(strlen "$bogus_content")
 bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
 
+test_expect_success 'die on broken object with large type under -t and -s without --allow-unknown-type' '
+	cat >err.expect <<-EOF &&
+	error: unable to unpack $bogus_sha1 header
+	fatal: git cat-file: could not get object info
+	EOF
+
+	test_must_fail git cat-file -t $bogus_sha1 >out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out.actual &&
+
+	test_must_fail git cat-file -s $bogus_sha1 >out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out.actual
+'
+
 test_expect_success "Type of broken object is correct when type is large" '
 	echo $bogus_type >expect &&
 	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
-- 
2.33.0.815.g21c7aaf6073


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF86C43460
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E506611ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhETM1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhETM0r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF341C0438DB
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n2so24655062ejy.7
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wwnOwso6Xzm0e73vrG/Ct+tR69VMpLcONZz8qyaKAaY=;
        b=NGoVNIwQSjhLPmCOy4hEtNFOvV2Z5fEHGw85E1lmAbq5fHe2qN9lTR7p1RJ8oscXGf
         tJOEa/Jcnt7wqdIGYGK2oSQAIjsyOQGyMk2ck5kktoWEt2Gft/v1F/lNMhWaSAwvTsGF
         MnJZgLYYlX4lqK3wuEoqq/o4u4evUg8hQhy2C9pzmbjnT2DwWk+YqZSEQi7WxSnRD8cF
         EB8UFLXHWzaAReCCVkxiujdI40LhL+wwX9cdTyvybNeka0caqNYT3gRA3XSVQt8Fzjze
         XKud00JTt45DgwAvjvgLE03wBhQqlbTboKUpuugX0XNEK8kD/w9yTIbG6q/J6B9rkquR
         Usqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwnOwso6Xzm0e73vrG/Ct+tR69VMpLcONZz8qyaKAaY=;
        b=m0+ikr4HIjGtxq0Nvekp+++3gmGD6Q1I8C8AqVdjF9sz2KHJ+VLlgKR1HoHeyfCAhd
         P8vMCaSgHnYQsxAwKvaIxXI2JsXe7jb6NKsW3GDFjGWOsg61eLJG0X5YlviuIHOB1/Ao
         20aW5aERnCrmvQAMh2Yj9RXcOYV2ix9RJun+DRHgf8HxMsI2cwq59eQWsgo0gXaGet5g
         ve+9e9RiLKvMJ4pqccangjV6mxtM35KzP+Wd0DDy1AP3kNPWG1pX94Q18H2Y1ck5GxkX
         yLY0xdomafT03cDq7HF/HFWIIE3usGTiGymdZvkirCBEdHLgag9GWBfcQ92jyNFvYASr
         hZaQ==
X-Gm-Message-State: AOAM533zbepDdn8H1HsTphFwMzg4MCp+IyemBEWHH/bWxG5VHBgioa1L
        JBNzuz8ML69cSxT+6QY6hfp8bN3SNhk2eg==
X-Google-Smtp-Source: ABdhPJw91ltmcy4htMRakG0KDaAvTBdtzWLmfRF0Egc4+Gq4SaVuQS0MVWY8M3YUj05+/Vog4L50+g==
X-Received: by 2002:a17:907:7654:: with SMTP id kj20mr4207918ejc.439.1621509798205;
        Thu, 20 May 2021 04:23:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/17] cat-file tests: test that --allow-unknown-type isn't on by default
Date:   Thu, 20 May 2021 13:22:58 +0200
Message-Id: <patch-04.17-871b820003-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the tests added in the tests for the
--allow-unknown-type feature, added in 39e4ae38804 (cat-file: teach
cat-file a '--allow-unknown-type' option, 2015-05-03).

Before this change all the tests would succeed if --allow-unknown-type
was on by default, let's fix that by asserting that -t and -s die on a
"garbage" type without --allow-unknown-type.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index b71ef94329..dc01d7c4a9 100755
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
2.32.0.rc0.406.g73369325f8d


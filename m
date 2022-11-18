Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF05C433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241547AbiKRLS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbiKRLSl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:18:41 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE4DDF6A
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:38 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id n20so12402064ejh.0
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/F97DB+WLmIomP20QV790iAT4lkS7Ulx/aH28hqS23U=;
        b=hkhOsiuDBZj1wgPPRL5z06EwTTDSIODQqzvEwGqwiFuxK9kxuDnQZJi5XK1PSftQiz
         V+8Veyqq3iVqCCtCijZs6tZFe/fG9ukKD2EKppSfz5fn13rXBXG0lw9A9OOdb3pj9wy+
         OarfWY0fijyQqzcACZO1TYAr6APs4/6jbeoYHZ+b+9ZMUqD4/4/zXjSTFc1f+oH8Saf1
         FQeeh8i51BpKRj2igQ9omycMap4UwwKfg22cpV8SbNyiLThqbibG4WB5PkxdAE3FBA7i
         jk2ORahNj2FsulF1QsRgyOUn5CdDLMsIF02GcsxdggQ95dOIWKdoIML6UYUWlBrus2E2
         A8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/F97DB+WLmIomP20QV790iAT4lkS7Ulx/aH28hqS23U=;
        b=7hrblYK9Tgq1uWvlXzJYA+8Gwui6A17lNZxLl8uXFplZHQ5TZohcaIrS8jd9acVyiD
         meDtmqktSzR9pecpCsv/ZE25Tty/ddMMPQd7/cEf2PSuKPWmTtzRuaWziIlak2y+YbZK
         HXGn0rFyTBYLI04aL01EwG8fZUtZKbXETG//pqRKuM/YZJz0Z8xCZr92DHdGajOJmWVd
         qM94m79BAv7XNEMDYY8ahd8/Rpuzk56jYZpc9cTJmjjpIGOLtqpkGnqDX9L7m31xmriz
         ieEIWirS5vaHRCiXNM4b0LpQrCipPzEAqTCTw+H+nARfG3zMPMOpwd4h0CE2iSeSv7Gm
         OQ3g==
X-Gm-Message-State: ANoB5pmIfW95tOjNvoHBfnZvosxu01epusIzMp8lOL1pex6pKuYyjy81
        G1ErRTyL/haSuxb3d/slktdMte3tCB35qw==
X-Google-Smtp-Source: AA0mqf4w0OaT5ck1x2fWOM76VnfMpAIFFzT14058OD3uollH0QXUz3bfmYAiQYjuWPjYqy4z2aD5lA==
X-Received: by 2002:a17:906:da0f:b0:7ad:95cf:726e with SMTP id fi15-20020a170906da0f00b007ad95cf726emr5695114ejb.60.1668770316800;
        Fri, 18 Nov 2022 03:18:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id fy20-20020a1709069f1400b00788c622fa2csm1558955ejc.135.2022.11.18.03.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:18:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 04/12] merge-index tests: add usage tests
Date:   Fri, 18 Nov 2022 12:18:21 +0100
Message-Id: <patch-v9-04.12-7d686637fa3-20221118T110058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
References: <20220809185429.20098-1-alban.gruin@gmail.com> <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests that stress the current behavior of the options parsing in
cmd_merge_index(), in preparation for moving it over to
parse_options().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6060-merge-index.sh | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index 079151ee06d..edc03b41ab9 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -5,6 +5,50 @@ test_description='basic git merge-index / git-merge-one-file tests'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+test_expect_success 'usage: 1 argument' '
+	test_expect_code 129 git merge-index a >out 2>err &&
+	test_must_be_empty out &&
+	grep ^usage err
+'
+
+test_expect_success 'usage: 2 arguments' '
+	cat >expect <<-\EOF &&
+	fatal: git merge-index: b not in the cache
+	EOF
+	test_expect_code 128 git merge-index a b >out 2>actual &&
+	test_must_be_empty out &&
+	test_cmp expect actual
+'
+
+test_expect_success 'usage: -a before <program>' '
+	cat >expect <<-\EOF &&
+	fatal: git merge-index: b not in the cache
+	EOF
+	test_expect_code 128 git merge-index -a b program >out 2>actual &&
+	test_must_be_empty out &&
+	test_cmp expect actual
+'
+
+for opt in -q -o
+do
+	test_expect_success "usage: $opt after -a" '
+		cat >expect <<-EOF &&
+		fatal: git merge-index: unknown option $opt
+		EOF
+		test_expect_code 128 git merge-index -a $opt >out 2>actual &&
+		test_must_be_empty out &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "usage: $opt program" '
+		test_expect_code 0 git merge-index $opt program
+	'
+done
+
+test_expect_success 'usage: program' '
+	test_expect_code 129 git merge-index program
+'
+
 test_expect_success 'setup diverging branches' '
 	test_write_lines 1 2 3 4 5 6 7 8 9 10 >file &&
 	cp file file2 &&
-- 
2.38.0.1511.gcdcff1f1dc2


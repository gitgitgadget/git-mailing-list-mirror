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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB42C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E4C61037
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240251AbhHCTkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240190AbhHCTj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44BDC061764
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so78931wmb.5
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PiqLEIHOkfureZWRUdx3XIkLM531MzLFlVZ4HciqwD4=;
        b=QdsoDq78URXWs6+ooGEAhKg6i5T0i23CAtvDsOEzYaqfwvAnqFxzMRreZ6ZWArDPje
         wj5EXOXJhkwjXQfZIzCd0AGbg31ALXgoul0FdkP7m0E7BJYeK7urWcK0g18upBywgEZ0
         RGpdEwoOm8wo51Y7mhcreeRvYDccUG5N835AMelZdnZzvBTxVNLTC7xm7iSCGVKnDbaW
         h7VeI63FYjB5/PeFIlQCnp/Lzw9V8xLSw+R8tBec3jNEzBAhe2Moox9LyWO6AqAc+PT+
         JjVApES2QtZy40BEIPNDIDIxds8vp3CcS1unj6xvHbz4MqVdLfZ5/LX5jsqVgEx3vYib
         KEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PiqLEIHOkfureZWRUdx3XIkLM531MzLFlVZ4HciqwD4=;
        b=m5Bu+NsNfjlO3bm4iHlCOwfvPQ7Ar8qAtGlAl0w073O7iq3xgbDs+PsNJAiy5G0t8U
         Qs4mJXE4dSVLrV5tgoLOpsmEG2qsqmvpAeqhut+8hP0gQrfT4WWMvfPFfl7UDrpCYZh0
         RQ/hZ2RTi11Fa3ie8kv7KZ7OKWsBelHDYjHFE5S1Wma3ruP04suhApeX6iLLiojRI9hn
         XQEtZcKv9ZRdq07LpgdviPeyr8ZdEC4F37as1Ntw4SoJDhOrcokGWCKv6w2ZM8RbtdpU
         aEVatAIzZBc0n/+66iWiWX4wm0m7ykq9q7IKaeRXGRd5i7rlKNjt5vosMGLaDsZhFwb+
         ZhVQ==
X-Gm-Message-State: AOAM532qgpTHu6P1HZghjHjg5WJtnn2g1yZPZ910EwiJegNtFHr6Ny4h
        HsDK+JvwEXd1nf2kqm2m+FWVdJgK8dQ8dQ==
X-Google-Smtp-Source: ABdhPJz1pOzoFNm954vbWeiyoo3vSZ36WlHMMHsnKMMGLiXrVZOiSGemBFDh2eerG6dq0+fHvCk16w==
X-Received: by 2002:a05:600c:4103:: with SMTP id j3mr24431896wmi.12.1628019578296;
        Tue, 03 Aug 2021 12:39:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 29/36] hook tests: use a modern style for "pre-push" tests
Date:   Tue,  3 Aug 2021 21:38:55 +0200
Message-Id: <patch-v4-29.36-2c961be94b4-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Indent the here-docs and use "test_cmp" instead of "diff" in tests
added in ec55559f937 (push: Add support for pre-push hooks,
2013-01-13). Let's also use the more typical "expect" instead of
"expected" to be consistent with the rest of the test file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5571-pre-push-hook.sh | 71 ++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 36 deletions(-)

diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index d2857a6fbc0..6d0d5b854ea 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -61,15 +61,15 @@ echo "$2" >>actual
 cat >>actual
 EOF
 
-cat >expected <<EOF
-parent1
-repo1
-refs/heads/main $COMMIT2 refs/heads/foreign $COMMIT1
-EOF
-
 test_expect_success 'push with hook' '
+	cat >expected <<-EOF &&
+	parent1
+	repo1
+	refs/heads/main $COMMIT2 refs/heads/foreign $COMMIT1
+	EOF
+
 	git push parent1 main:foreign &&
-	diff expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'add a branch' '
@@ -80,49 +80,48 @@ test_expect_success 'add a branch' '
 COMMIT3="$(git rev-parse HEAD)"
 export COMMIT3
 
-cat >expected <<EOF
-parent1
-repo1
-refs/heads/other $COMMIT3 refs/heads/foreign $COMMIT2
-EOF
-
 test_expect_success 'push to default' '
+	cat >expect <<-EOF &&
+	parent1
+	repo1
+	refs/heads/other $COMMIT3 refs/heads/foreign $COMMIT2
+	EOF
 	git push &&
-	diff expected actual
+	test_cmp expect actual
 '
 
-cat >expected <<EOF
-parent1
-repo1
-refs/tags/one $COMMIT1 refs/tags/tag1 $ZERO_OID
-HEAD~ $COMMIT2 refs/heads/prev $ZERO_OID
-EOF
-
 test_expect_success 'push non-branches' '
+	cat >expect <<-EOF &&
+	parent1
+	repo1
+	refs/tags/one $COMMIT1 refs/tags/tag1 $ZERO_OID
+	HEAD~ $COMMIT2 refs/heads/prev $ZERO_OID
+	EOF
+
 	git push parent1 one:tag1 HEAD~:refs/heads/prev &&
-	diff expected actual
+	test_cmp expect actual
 '
 
-cat >expected <<EOF
-parent1
-repo1
-(delete) $ZERO_OID refs/heads/prev $COMMIT2
-EOF
-
 test_expect_success 'push delete' '
+	cat >expect <<-EOF &&
+	parent1
+	repo1
+	(delete) $ZERO_OID refs/heads/prev $COMMIT2
+	EOF
+
 	git push parent1 :prev &&
-	diff expected actual
+	test_cmp expect actual
 '
 
-cat >expected <<EOF
-repo1
-repo1
-HEAD $COMMIT3 refs/heads/other $ZERO_OID
-EOF
-
 test_expect_success 'push to URL' '
+	cat >expect <<-EOF &&
+	repo1
+	repo1
+	HEAD $COMMIT3 refs/heads/other $ZERO_OID
+	EOF
+
 	git push repo1 HEAD &&
-	diff expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'set up many-ref tests' '
-- 
2.33.0.rc0.595.ge31e012651d


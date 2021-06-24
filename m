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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ED2C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11614613EE
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhFXT0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbhFXT02 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E715C061756
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j2so7861261wrs.12
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1cfZsb4iuPQw6LaCh3xR/8Iwu2r0vH+aA9pQuVd1Ccw=;
        b=XxWsT4hLPgLbFus6sMtf/Z0op+q7zkmO3pyn3es/qDHuQn3JYnXn0Mq7ehjXRUrGoX
         ZRFAVxM7+kErBrV8hVbx6pS0JaCj9lPGUtY59Dt57t06Fo3HHoOaGZm8UOM/J4uYBAyu
         EGMEb7iS0hrXBfREyv08s9RePCC1h1d1otd3YD7fcYjZfPbMrvsA95H0Etsh16N7IUEp
         5n6YovXqQxWJYuP70NNu33N/fK8VORvCmXkN1Qn5E23ZLevyOpx7KOR9e331ClzIkFhA
         zL4IeuxJ1bmA6IZcAUi8lXuXkPjc5LzkMEAv10RtAXdPgRY73WPZ710QpxipgPcPka9M
         Pskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1cfZsb4iuPQw6LaCh3xR/8Iwu2r0vH+aA9pQuVd1Ccw=;
        b=i6d6Al67eA+Wx/PyIlofmcijjq9EHfkb7ZBkFSi0VDQYCb8hih1kfAt+RAWDWBMMMc
         zRdJ51k+SmQ8oEXCsqqg3U4R4u2Opl1tO0Vz4xNgmXqvk8Y4rD2QXrNu8913WFd1eQsR
         JCIpbDmPoc5K+doCmReg5Y1ZrS6A9BV4CwkLzzjezC2ibcqBOEivFCfW3A6vjUxW0qrJ
         njQ1zhKdOsZbsGxPaoEkMM2o79ajlEUpA8TxrbJ9aGbJ3VRcXeYsoB0lnZsaQFftrTFa
         lPVBMqvpMW4Qg5g7z16kExExc8ogCZtV+SPIGzv09C4sog0XyEkZhc8rDfO0IzA2Ud1V
         5/ag==
X-Gm-Message-State: AOAM532MiHfbvsGUpcDqS5XXH9RQ02xAWxj/ESFuQ3z7PohoGK13EjXG
        oRrusF++dZmfF9oLtslLQy3g8Fqx8u9Zpg==
X-Google-Smtp-Source: ABdhPJxXYiwXhuOmZ0Tom4DsU7CNToVl7hZ+7hfA0Xxh8MyHgpkXMLhsFhZLKsY4/HVPJJP+RhraYw==
X-Received: by 2002:adf:ffd2:: with SMTP id x18mr6272892wrs.256.1624562646540;
        Thu, 24 Jun 2021 12:24:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/21] cat-file tests: test for missing object with -t and -s
Date:   Thu, 24 Jun 2021 21:23:41 +0200
Message-Id: <patch-03.21-2b5366bfb9d-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test for what happens when the -t and -s flags are asked to operate on
a missing object, this extends tests added in 3e370f9faf0 (t1006: add
tests for git cat-file --allow-unknown-type, 2015-05-03). The -t and
-s flags are the only ones that can be combined with
--allow-unknown-type, so let's test with and without that flag.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 5d2dc99b74a..b71ef94329e 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -315,6 +315,33 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	}
 '
 
+missing_oid=$(test_oid deadbeef)
+test_expect_success 'error on type of missing object' '
+	cat >expect.err <<-\EOF &&
+	fatal: git cat-file: could not get object info
+	EOF
+	test_must_fail git cat-file -t $missing_oid >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect.err err &&
+
+	test_must_fail git cat-file -t --allow-unknown-type $missing_oid >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect.err err
+'
+
+test_expect_success 'error on size of missing object' '
+	cat >expect.err <<-\EOF &&
+	fatal: git cat-file: could not get object info
+	EOF
+	test_must_fail git cat-file -s $missing_oid >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect.err err &&
+
+	test_must_fail git cat-file -s --allow-unknown-type $missing_oid >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect.err err
+'
+
 bogus_type="bogus"
 bogus_content="bogus"
 bogus_size=$(strlen "$bogus_content")
-- 
2.32.0.606.g2e440ee2c94


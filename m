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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F84C63797
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4890F61249
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhGUW77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhGUW7v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:59:51 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89099C061796
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l7so3894428wrv.7
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ROvVWEQgNBQJB0Q2UUhPlVHl8wCJCFFQGecrdev6tZA=;
        b=LP47NeEgS0NzL8ICRGGf1vE3tNlld7DF+LEG0xe2+651w9vzoeSLehWNSutNn1sjB9
         j5mVV8qHZ/5Dx9lWuWmz4qZRfOiDaByewqIA9JtfvfRbiU0HR4I9dWNDt9Ywty2NWD4d
         sAFnEdq42jnPatBr5zptzjshchzhQ5DqqKhgksPD9OMlcQvISZvESPCzgSqvZW0ZCFPU
         B8xH/ICSmUoZeDXsejZFTcE7vQ3tmVJom6ylSCKX2bX02y/5cXJnIhsFt4uzhu8akV1x
         SqgMqeUcMhYziLNwz5lIftFtxC8qOFvgstijG9KApBK/P/PE0Bp//5F4lWeyP/RnRou6
         EZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ROvVWEQgNBQJB0Q2UUhPlVHl8wCJCFFQGecrdev6tZA=;
        b=HI+uRHahPGE3EAUuUQ4Nex9jiP8z2HKQTMc+jk1Czpa4vf9GG89UJ+2VxZtLUf4/6A
         n6LCogszXi/Kh4UngJhFzPq9QVOz6Unw0VPgyqW8P6qKsBC1DxRPbcWOrB8+Q3yw3NKQ
         0hnwgRcPg5hvNZEEw0DNEXk4Kcl7hps/xUf6UYfnhNm7SWGk6K4KyOMF319IiAQmSkgT
         MQKwYyjTRSVOtzb0k5KlpEs3aRPQODqVrN8MGdVIflrb96u72+cfKJH5l/o+di+eJc/5
         m+aixwTico/Z9loUwokJzBKmIZesEVkUuaLWIwLNK2nfIVe2mLOsWHm/M0Ayzr+TZVy0
         dKEA==
X-Gm-Message-State: AOAM532ZYYm77XbEspAUmDoaXH9MFcDqJPm2WjfdoeYcG368vqxrUyKp
        Uvv1PemyocGYy0wS1lZgwZ8gjdMrStnkDA==
X-Google-Smtp-Source: ABdhPJzUYckt+jeN1nls6A+hIa7PGFqM/O1MHX/d2/JwRX72+zzkInTjFg42pnCmPCcYhLwb0pL8AA==
X-Received: by 2002:adf:a287:: with SMTP id s7mr44537853wra.120.1626910824825;
        Wed, 21 Jul 2021 16:40:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm1145649wmc.12.2021.07.21.16.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:40:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/12] {upload,receive}-pack tests: add --advertise-refs tests
Date:   Thu, 22 Jul 2021 01:40:10 +0200
Message-Id: <patch-09.12-beafe9811c1-20210721T233307Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com> <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --advertise-refs option had no explicit tests of its own, only
other http tests that would fail at a distance if it it was
broken. Let's test its behavior explicitly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5555-http-smart-common.sh | 145 +++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100755 t/t5555-http-smart-common.sh

diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
new file mode 100755
index 00000000000..389ee96987b
--- /dev/null
+++ b/t/t5555-http-smart-common.sh
@@ -0,0 +1,145 @@
+test_description='test functionality common to smart fetch & push'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit --no-tag initial
+'
+
+test_expect_success 'git upload-pack --advertise-refs' '
+	cat >expect <<-EOF &&
+	$(git rev-parse HEAD) HEAD
+	$(git rev-parse HEAD) $(git symbolic-ref HEAD)
+	0000
+	EOF
+
+	# We only care about GIT_PROTOCOL, not GIT_TEST_PROTOCOL_VERSION
+	sane_unset GIT_PROTOCOL &&
+	GIT_TEST_PROTOCOL_VERSION=2 \
+	git upload-pack --advertise-refs . >out 2>err &&
+
+	test-tool pkt-line unpack <out >actual &&
+	test_must_be_empty err &&
+	test_cmp actual expect &&
+
+	# The --advertise-refs alias works
+	git upload-pack --advertise-refs . >out 2>err &&
+
+	test-tool pkt-line unpack <out >actual &&
+	test_must_be_empty err &&
+	test_cmp actual expect
+'
+
+test_expect_success 'git upload-pack --advertise-refs: v0' '
+	# With no specified protocol
+	cat >expect <<-EOF &&
+	$(git rev-parse HEAD) HEAD
+	$(git rev-parse HEAD) $(git symbolic-ref HEAD)
+	0000
+	EOF
+
+	git upload-pack --advertise-refs . >out 2>err &&
+	test-tool pkt-line unpack <out >actual &&
+	test_must_be_empty err &&
+	test_cmp actual expect &&
+
+	# With explicit v0
+	GIT_PROTOCOL=version=0 \
+	git upload-pack --advertise-refs . >out 2>err &&
+	test-tool pkt-line unpack <out >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp actual expect
+
+'
+
+test_expect_success 'git receive-pack --advertise-refs: v0' '
+	# With no specified protocol
+	cat >expect <<-EOF &&
+	$(git rev-parse HEAD) $(git symbolic-ref HEAD)
+	0000
+	EOF
+
+	git receive-pack --advertise-refs . >out 2>err &&
+	test-tool pkt-line unpack <out >actual &&
+	test_must_be_empty err &&
+	test_cmp actual expect &&
+
+	# With explicit v0
+	GIT_PROTOCOL=version=0 \
+	git receive-pack --advertise-refs . >out 2>err &&
+	test-tool pkt-line unpack <out >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp actual expect
+
+'
+
+test_expect_success 'git upload-pack --advertise-refs: v1' '
+	# With no specified protocol
+	cat >expect <<-EOF &&
+	version 1
+	$(git rev-parse HEAD) HEAD
+	$(git rev-parse HEAD) $(git symbolic-ref HEAD)
+	0000
+	EOF
+
+	GIT_PROTOCOL=version=1 \
+	git upload-pack --advertise-refs . >out &&
+
+	test-tool pkt-line unpack <out >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp actual expect
+'
+
+test_expect_success 'git receive-pack --advertise-refs: v1' '
+	# With no specified protocol
+	cat >expect <<-EOF &&
+	version 1
+	$(git rev-parse HEAD) $(git symbolic-ref HEAD)
+	0000
+	EOF
+
+	GIT_PROTOCOL=version=1 \
+	git receive-pack --advertise-refs . >out &&
+
+	test-tool pkt-line unpack <out >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp actual expect
+'
+
+test_expect_success 'git upload-pack --advertise-refs: v2' '
+	cat >expect <<-EOF &&
+	version 2
+	agent=FAKE
+	ls-refs=unborn
+	fetch=shallow wait-for-done
+	server-option
+	object-format=$(test_oid algo)
+	object-info
+	0000
+	EOF
+
+	GIT_PROTOCOL=version=2 \
+	GIT_USER_AGENT=FAKE \
+	git upload-pack --advertise-refs . >out 2>err &&
+
+	test-tool pkt-line unpack <out >actual &&
+	test_must_be_empty err &&
+	test_cmp actual expect
+'
+
+test_expect_success 'git receive-pack --advertise-refs: v2' '
+	# There is no v2 yet for receive-pack, implicit v0
+	cat >expect <<-EOF &&
+	$(git rev-parse HEAD) $(git symbolic-ref HEAD)
+	0000
+	EOF
+
+	GIT_PROTOCOL=version=2 \
+	git receive-pack --advertise-refs . >out 2>err &&
+
+	test-tool pkt-line unpack <out >actual &&
+	test_must_be_empty err &&
+	test_cmp actual expect
+'
+
+test_done
-- 
2.32.0.955.ge7c5360f7e7


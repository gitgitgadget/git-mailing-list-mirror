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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7D8C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731C060E78
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbhHEB0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbhHEB0I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 21:26:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCD7C06179C
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 18:25:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o7-20020a05600c5107b0290257f956e02dso5105415wms.1
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 18:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R0bUCQVINTGZ9WPetWdFfspXt1lZvTI5uGiPUeXWRh8=;
        b=JvuzNsT8LSxvYtr9ejEE/K8P95fpNcpyRI+muRCxI47H4ZzgyoKlmLsA5S4W/aZSl/
         aPwbWcdOcz8/ny4SWbU8WYbKCkTlpfpkLfdcpMgg3unROejpz3G85Hc4BB6iWp8haLsp
         3uRG0GdQUAEWzJUxrJCbOtUszPw9Ht+W8segLuk9nHseJeVizy3YooJogI4K2UkzNmX/
         d8uSS0rVZpgT+m4FqQI7lrX8JhjfeyJVZCM1Namc8VT7MiBlMGBX5MdE3eAYCUpaavxh
         zm3KbubbMP5YNTRegShE7boy5gV9kmX52tCVyqCZCisT1UEQpfen7E5PUtGtDBtpAtvT
         vE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R0bUCQVINTGZ9WPetWdFfspXt1lZvTI5uGiPUeXWRh8=;
        b=ipYxS1ep8FNnolrwnL4h2NGagCVLm+UnMgDWLTyR2g6OW2LM5SDnK7Zc9eXF9XhGh5
         NcvH7EDIaRs/jOJ+hZg9q0eMrzjy0LwqxM3g3qfcCDldE2rakGOV+TDn2k3+uceZGbAO
         Uz43GoHK6I0BSDTmSLWOXdJkz1NNSY+VKU+vSSVwGRPGdCfARjcHnIkPOYY1xLJjokOc
         KoNzZOloXUp4IPDAdTrH74IIcHfhVg054tdqeVqK7tFPvl3p3+m8Llzv9EmljLlwi7es
         Wy6hadFA0CXNz6XiuCyGrbLwgUhCeMTu2PvE+10hRHMp9sj3dv7Sbm2ffbWw4UvLIuvR
         suYQ==
X-Gm-Message-State: AOAM532k3TAWPmog6Orq6ULasVdHtlUR5PTSnKJtHNiiQs2UM+zr6bdT
        1k1Y8mM8H8l0iaDtxy9Mu1z21GXy41EjPg==
X-Google-Smtp-Source: ABdhPJxLHWfGlQn4gRVka8mntQ7OoPj5RpqeVEFhloGP1xgnv3QkccMb8i5gyKHBscor/VKTt1/tlg==
X-Received: by 2002:a1c:3886:: with SMTP id f128mr12618267wma.85.1628126752065;
        Wed, 04 Aug 2021 18:25:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6sm4120176wru.50.2021.08.04.18.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 18:25:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 08/10] {upload,receive}-pack tests: add --advertise-refs tests
Date:   Thu,  5 Aug 2021 03:25:41 +0200
Message-Id: <patch-v4-08.10-fd58abb7420-20210805T011823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com> <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
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
 t/t5555-http-smart-common.sh | 147 +++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100755 t/t5555-http-smart-common.sh

diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
new file mode 100755
index 00000000000..b813099ed2c
--- /dev/null
+++ b/t/t5555-http-smart-common.sh
@@ -0,0 +1,147 @@
+#!/bin/sh
+
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
2.33.0.rc0.597.gc569a812f0a


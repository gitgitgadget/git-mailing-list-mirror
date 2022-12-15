Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AE5C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiLOJdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiLOJdC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:33:02 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E3120BCB
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:33:00 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so50873890ejc.4
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duhIhRObTCIhUHol1lqkMZxVr2N04VUvo01VQYLo6pk=;
        b=I0xZBfXGJwAiisKtFv9xP5++oO3x6DskvyPL8UfPN7zzeJ0tiiTeWeoTVbf8EGOFSk
         ffYN7j/JQT0jf+84Pea7ua39PeHn9FW71jCdh79d3eDhQ8Gb0hRRZiEjdwyaxuT1OU7C
         5B9KzNv6JK0lZAiCR0F0fkw1JmgGrSJ0bn+YOwN36aamrwMAi56g0gtEFUdWxbPnjcwc
         U/DJB6mfgpiWLmQWedfX1Rk/DfD/b/N2QWHHfGQzsaeM4fVVUAE3lf2MCcrI+28GPIKN
         la+62R0iTX9MT/3UaJDbhDsdWuPw+BoLEhOtFzt1hSyExgL4mOwfwhGdffx0N+230K1e
         Bokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duhIhRObTCIhUHol1lqkMZxVr2N04VUvo01VQYLo6pk=;
        b=umb6a05YQnVg4nFgcIqUS8WtVwbKC7USF8etOWE+UTr3uyUY72jNecU6EDOE7WYpzZ
         yFR/iPsIrS0f13h1ikfKEGzXktzU45ug0pXKLx8LaNHRoVb3IMOjB1+qKIzCpG/V+z6B
         qdB8nfqUo+MSBbHj0vaYbBoCCwb86MTTc3NSyS+6RjGGRwI5x+G5MtskvL782BJugZu8
         IS1z46lx1LzZG+IA2uxnv9y4ljuhJc6SciIAfUPec6Iqf4PrV4qBbGH6qFY69gKUq+RM
         42SFg0qsvOw83tZqKYp9XBBnW9l9h/vtWEIwHP4QDluE81s/6HuE2Cp4beeIbnUneKh6
         JgTw==
X-Gm-Message-State: ANoB5pnrtRc3aLbm8VqjrhMnykzzxxJ+AvifwSGkagoSD02jyD1Y49lz
        HyQzYuljSQEIDP12MMHd+uzF+XUfXcqQCw==
X-Google-Smtp-Source: AA0mqf7GN8MlVy+gcgMI72dNCN8pfCjN5BX9Jo6tnUbEyDutZ9x0/8wO/oO5wsHJmuNKUKo5ng9GiQ==
X-Received: by 2002:a17:906:411b:b0:7c0:a48b:2dff with SMTP id j27-20020a170906411b00b007c0a48b2dffmr12784984ejk.43.1671096778375;
        Thu, 15 Dec 2022 01:32:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906210100b007c1675d2626sm5457702ejt.96.2022.12.15.01.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:32:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/9] read-tree + fetch tests: test failing "--super-prefix" interaction
Date:   Thu, 15 Dec 2022 10:32:43 +0100
Message-Id: <patch-v4-2.9-6424307a432-20221215T083502Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Ever since "git fetch --refetch" was introduced in 0f5e8851737 (Merge
branch 'rc/fetch-refetch', 2022-04-04) the test being added here would
fail. This is because "restore" will "read-tree .. --reset <hash>",
which will in turn invoke "fetch". The "fetch" will then die with:

	fatal: fetch doesn't support --super-prefix

This edge case and other "--super-prefix" bugs will be fixed in
subsequent commits, but let's first add a "test_expect_failure" test
for it. It passes until the very last command in the test.

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5616-partial-clone.sh | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 037941b95d2..2846ec6629c 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -644,6 +644,49 @@ test_expect_success 'repack does not loosen promisor objects' '
 	grep "loosen_unused_packed_objects/loosened:0" trace
 '
 
+test_expect_failure 'lazy-fetch in submodule succeeds' '
+	# setup
+	test_config_global protocol.file.allow always &&
+
+	test_when_finished "rm -rf src-sub" &&
+	git init src-sub &&
+	git -C src-sub config uploadpack.allowfilter 1 &&
+	git -C src-sub config uploadpack.allowanysha1inwant 1 &&
+
+	# This blob must be missing in the subsequent commit.
+	echo foo >src-sub/file &&
+	git -C src-sub add file &&
+	git -C src-sub commit -m "submodule one" &&
+	SUB_ONE=$(git -C src-sub rev-parse HEAD) &&
+
+	echo bar >src-sub/file &&
+	git -C src-sub add file &&
+	git -C src-sub commit -m "submodule two" &&
+	SUB_TWO=$(git -C src-sub rev-parse HEAD) &&
+
+	test_when_finished "rm -rf src-super" &&
+	git init src-super &&
+	git -C src-super config uploadpack.allowfilter 1 &&
+	git -C src-super config uploadpack.allowanysha1inwant 1 &&
+	git -C src-super submodule add ../src-sub src-sub &&
+
+	git -C src-super/src-sub checkout $SUB_ONE &&
+	git -C src-super add src-sub &&
+	git -C src-super commit -m "superproject one" &&
+
+	git -C src-super/src-sub checkout $SUB_TWO &&
+	git -C src-super add src-sub &&
+	git -C src-super commit -m "superproject two" &&
+
+	# the fetch
+	test_when_finished "rm -rf client" &&
+	git clone --filter=blob:none --also-filter-submodules \
+		--recurse-submodules "file://$(pwd)/src-super" client &&
+
+	# Trigger lazy-fetch from the superproject
+	git -C client restore --recurse-submodules --source=HEAD^ :/
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.39.0.rc2.1048.g0e5493b8d5b


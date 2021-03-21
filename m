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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC689C433E1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 22:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA10E6192B
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 22:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhCUWhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 18:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhCUWgk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 18:36:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C569C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 15:36:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z2so14748549wrl.5
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 15:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sqnk2RMTfB/g5sha6D9BJ59d+rqqeZw6bx+M9hchoIU=;
        b=VIZe+CKhGKJ5GxoYDZfcQBnkbq3B/XhehQqCW1oB4ye9D/2iKSb0KcWvWsmRTKtE1X
         oeCIyB03/BVMMLPeRYGx1O1tUEUiM93ElC84ouZnBzu3o5nlcxVmNumI701FwTreS/hF
         WyupKQWSHXx5TmGTIik16rM7dpP58tenB82/MWWAroLeTbJBWkNXRHIlJE0LQoMwQnU+
         6C3+6RpmJsiCpWf6+Hplg38we55ir0b30nI22cmYr1MjAEiR2thEhsd3VukiWdoRpeJG
         1r5vu319PXbJIhLVK5lUEUUfGBVCG6hhlKadVXQBYwSJS4Ds/1Z4MX9UrdYei+vPMLR3
         X4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sqnk2RMTfB/g5sha6D9BJ59d+rqqeZw6bx+M9hchoIU=;
        b=hoTZIfxqfzJenr2gl1VT0vgPjOM8yTCBoeCeHInSrwa0yuxRO4lb8Taj4D2K5uZDSr
         iRiB9rOcFagd/JWytWp8u6EFrSQQ1h4iIekR9aKTN3J1OLzO2aDCCYgG1w96wQv/t2Wc
         MgiRCe5OSnapmwLxmLCctnyjGtYSscDStjKhUz9kmTf8lXGDW0oUoYVZyk/dtufvm2zA
         IeZ4HoNbqzDyfAW6ZRQqzm5mhgz8Opqiol1zQiNpg63anXAlpE/ChK4tFXKa5dUzIqmE
         wOUUCAUxa7smOQuXRhAp2RQFUBklTsONj6NoskptvCdgCitPkbN8l4ifyowM4AZf8kOj
         zwmw==
X-Gm-Message-State: AOAM531TrxAkaoI4wA6upgBUdLO0a+N4M95ArQG0WglB5qRoIzRcUPCD
        VnAwQdkAmTDhJSzwiWKJmEq4V/v5WGDmUw==
X-Google-Smtp-Source: ABdhPJxHC3WvLvouVG8UmTzRyHbGGXu17i27wdf7hL2uYyOGrSMu8heDGtqjAoJcniea0wsE7kIPKQ==
X-Received: by 2002:a5d:47a9:: with SMTP id 9mr15307220wrb.368.1616366198039;
        Sun, 21 Mar 2021 15:36:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c131sm14922156wma.37.2021.03.21.15.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 15:36:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] diff --no-index tests: test mode normalization
Date:   Sun, 21 Mar 2021 23:36:20 +0100
Message-Id: <a1ab6a323f2e0aeed781a95d286740d3013ff5f0.1616366036.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.285.gb40d23e604f
In-Reply-To: <cover.1616366036.git.avarab@gmail.com>
References: <cover.1616330120.git.avarab@gmail.com> <cover.1616366036.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "git diff --no-index X Y" is run the modes of the files being
differ are normalized by canon_mode() in fill_filespec().

I recently broke that behavior in a patch of mine[1] which would pass
all tests, or not, depending on the umask of the git.git checkout.

Let's test for this explicitly. Arguably this should not be the
behavior of "git diff --no-index". We aren't diffing our own objects
or the index, so it might be useful to show mode differences between
files.

On the other hand diff(1) does not do that, and it would be needlessly
distracting when e.g. diffing an extracted tar archive whose contents
is the same, but whose file modes are different.

1. https://lore.kernel.org/git/20210316155829.31242-2-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4053-diff-no-index.sh | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 44b932fbb20..39d1da1f362 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -149,4 +149,59 @@ test_expect_success 'diff --no-index allows external diff' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff --no-index normalizes mode: no changes' '
+	echo foo >x &&
+	cp x y &&
+	git diff --no-index x y >out &&
+	test_must_be_empty out
+'
+
+test_expect_success POSIXPERM 'diff --no-index normalizes mode: chmod +x' '
+	chmod +x y &&
+	cat >expected <<-\EOF &&
+	diff --git a/x b/y
+	old mode 100644
+	new mode 100755
+	EOF
+	test_expect_code 1 git diff --no-index x y >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success POSIXPERM 'diff --no-index normalizes: mode not like git mode' '
+	chmod 666 x &&
+	chmod 777 y &&
+	cat >expected <<-\EOF &&
+	diff --git a/x b/y
+	old mode 100644
+	new mode 100755
+	EOF
+	test_expect_code 1 git diff --no-index x y >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success POSIXPERM,SYMLINKS 'diff --no-index normalizes: mode not like git mode (symlink)' '
+	ln -s y z &&
+	X_OID=$(git hash-object --stdin <x) &&
+	Z_OID=$(echo -n y | git hash-object --stdin) &&
+	cat >expected <<-EOF &&
+	diff --git a/x b/x
+	deleted file mode 100644
+	index $X_OID..$ZERO_OID
+	--- a/x
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-foo
+	diff --git a/z b/z
+	new file mode 120000
+	index $ZERO_OID..$Z_OID
+	--- /dev/null
+	+++ b/z
+	@@ -0,0 +1 @@
+	+y
+	\ No newline at end of file
+	EOF
+	test_expect_code 1 git -c core.abbrev=no diff --no-index x z >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.31.0.285.gb40d23e604f


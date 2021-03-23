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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CE2C433E2
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 16:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE5D9619C3
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 16:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbhCWQkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhCWQk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 12:40:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BA5C0613D8
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 09:40:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o16so21474644wrn.0
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 09:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0W8zGqB4vd4JaQD5cfEnfobOgmqcMbBhP+a/gY/ZDPU=;
        b=Byavmq/hqieS0SBZpjXzZRom5NZ3EDgX0UWAz8BJ2dTIBCBUVXYVM6UrCPwqqGpe0X
         l+liHKh7NgG02eyMb9o39cwh8qkBJWobXfTup02dVsg2t//srqAtgyh9mzBD08RcL578
         RkgWr+F7H9QRWh+u4YG5Aek1WFblcdOeI2CzYcYNxwz8mRuTeeRKX9t9NA3s3t/5nYxp
         dB70N0uZrZE4T28RL/pgPBXyXeIDZBx+CeZlLUYTu8HFsmif0xvEoI4BwKxzQMjxSHeb
         FwxgnZf3y802aludkPKboVqVXWxa4BGIFO36y8ftGGemmRRMRYNUriE9oHjemSB/nHkx
         uXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0W8zGqB4vd4JaQD5cfEnfobOgmqcMbBhP+a/gY/ZDPU=;
        b=nf38+4W2AeRlcMIjGJXncJ/Dbv5+a+soBE8cTMKTYi0G4UxdA4G7iaGRTk3ZQoBEEP
         8OsD9DOvGU5BKyOEgLufMccldEYBT6RTKmXsJ85fuQEq/QPO+YrxpMbO0+jdL6U6ykCS
         gnjbBkbxS78j1uV7h7svf8XT5o+wXm5vHnAnVWNMAkKg7sqJlC9iaotjnb4pgfohQLNF
         sWgqU93SDZzVPIJQwkkDQkqUVz5yjB+Q29W7i/GiF7ib9c7wUH6A1ZQd47NlVkKctiE/
         fG4DWDFCBgl5u2rmdfSi2kFFnEDnCkrsgvRLNhfC2fsq9tKxaK5hKRx+CLzOblObJpLF
         MHyg==
X-Gm-Message-State: AOAM531OhYHV73AhndIa9UniySHF5/Sj0dmue9EXUr0FR68iMCK8m/Dq
        Ala0lGnATkwwVNF+/y7ldqZz4Q2UalVbAQ==
X-Google-Smtp-Source: ABdhPJwLm9T/nDLjoqHiOqK8yJfK9xyD7tNpmytO3VLD/tjF1smLrHnfNdKlvjCY7SaCs7Dwdxnz7A==
X-Received: by 2002:adf:f648:: with SMTP id x8mr4906952wrp.157.1616517628013;
        Tue, 23 Mar 2021 09:40:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i3sm25037488wra.66.2021.03.23.09.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 09:40:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/2] diff --no-index tests: test mode normalization
Date:   Tue, 23 Mar 2021 17:40:14 +0100
Message-Id: <patch-2.3-e5bb094b783-20210323T163917Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.366.g871543fb182
In-Reply-To: <cover-0.3-00000000000-20210323T163917Z-avarab@gmail.com>
References: <cover.1616366036.git.avarab@gmail.com> <cover-0.3-00000000000-20210323T163917Z-avarab@gmail.com>
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
index 44b932fbb20..5c5545f91bf 100755
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
+	Z_OID=$(printf "y" | git hash-object --stdin) &&
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
2.31.0.366.g871543fb182


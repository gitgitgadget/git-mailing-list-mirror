Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0605EC433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbiCGMu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242605AbiCGMun (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC4C4EF75
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:49:38 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso6579252wms.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ND1qy3hgZt3ojTaFs9/rMP6UyuYKsnQfYKNXQubuqvk=;
        b=TQWiFPpYhGD6n+0cfVyk1eVpLD4dPfkBWYQHXKysP33Z80dlKAzDpYmytXpFAMjA93
         URx2bGugxhRryrNFGVKkw9/dcljtSRaaJ13AU5qdt+XmuYzrdhEEUZuNSLZFBluj+kRg
         EdRTTQhqkwNgJ7/idOaagaBbjfFLPfJBzIHL6K+5q8Wm2tGZ6bzSzjZrl/lCD8mkMwYz
         euo7QbxFFNJl00rrlX9eXWUJRp0diqLteD1loLn8tT7jjblMmnmEFmtnMVRpm2r5JuAl
         LQSJahN9JV43HukoW0/c2kpmFSuJTNoKbYLkSDjVpt/jGmOPOyrd68LnMqCLrW8uw8fD
         CjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ND1qy3hgZt3ojTaFs9/rMP6UyuYKsnQfYKNXQubuqvk=;
        b=CYB2j2etB/PZpbAf0N0cAerCOMmwHnLjb7FFOS1NmBhMeBq20nPQu4POeULxgEfSVI
         UMB2+m9u0ybI20d7V73uOZJgPs+Kxq6Ar824F7NDu0FjLW21kE9w36kVCg9JFn/YA9zS
         6u779yyiR/pCivFVKeqKzBUUaA3EXGzdvbhLxDVPy11T32luSvCTSpyxGhDg/PZn8zz4
         sPYiGib42IrgPGTd1qv07tsX5oo6f2k9iOf0o2qanLtQEMul+eGvdMVuJLz7PYIbvZ9z
         PgZTjskWczfu6j4pQm0U7zDdd2Hq72uwlevoKuEpIK7xoIiyGXkz5faW0/3YvsTOX2Sx
         xuGQ==
X-Gm-Message-State: AOAM532fhQSgD1M+kwgPso1Kb7FhpiFL9WZDLTFRHgDx12rRQD6906u8
        deQrtWec9Edb2+a4u4mgZgzDla9/YKOnUA==
X-Google-Smtp-Source: ABdhPJw9TqDsRU0+WmCmqLwfc2gBdNLGJwymYdtwpIfVIJ3ief6Vx7AXjmQarsu/WjuzkmByHHz7xQ==
X-Received: by 2002:a7b:c055:0:b0:37b:dc5f:7f48 with SMTP id u21-20020a7bc055000000b0037bdc5f7f48mr9166984wmc.110.1646657377068;
        Mon, 07 Mar 2022 04:49:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm12729091wmc.47.2022.03.07.04.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:49:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/15] gettext tests: don't ignore "test-tool regex" exit code
Date:   Mon,  7 Mar 2022 13:49:03 +0100
Message-Id: <patch-v2-12.15-552dcac705d-20220307T124817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a prerequisite check added in 5c1ebcca4d1 (grep/icase: avoid
kwsset on literal non-ascii strings, 2016-06-25) to do invoke
'test-tool regex' in such a way that we'll notice if it dies under
SANITIZE=leak due to having a memory leak, as opposed to us not having
the "ICASE" support we're checking for.

Because we weren't making a distinction between the two I'd marked
these tests as passing under SANITIZE=leak in 03d85e21951 (leak tests:
mark remaining leak-free tests as such, 2021-12-17).

Doing this is tricky. Ideally "test_lazy_prereq" would materialize as
a "real" test that we could check the exit code of with the same
signal matching that "test_must_fail" does.

However lazy prerequisites aren't real tests, and are instead lazily
materialized in the guts of "test_have_prereq" when we've already
started another test.

We could detect the abort() (or similar) there and pass that exit code
down, and fail the test that caused the prerequisites to be
materialized.

But that would require extensive changes to test-lib.sh and
test-lib-functions.sh. Let's instead simply check if the exit code of
"test-tool regex" is zero, and if so set the prerequisites. If it's
non-zero let's run it again with "test_must_fail". We'll thus make a
distinction between "bad" non-zero (segv etc) and "good" (exit 1 etc.).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7812-grep-icase-non-ascii.sh | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index ca3f24f8079..9047d665a10 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -11,9 +11,19 @@ test_expect_success GETTEXT_LOCALE 'setup' '
 	export LC_ALL
 '
 
-test_have_prereq GETTEXT_LOCALE &&
-test-tool regex "HALLÓ" "Halló" ICASE &&
-test_set_prereq REGEX_LOCALE
+test_expect_success GETTEXT_LOCALE 'setup REGEX_LOCALE prerequisite' '
+	# This "test-tool" invocation is identical...
+	if test-tool regex "HALLÓ" "Halló" ICASE
+	then
+		test_set_prereq REGEX_LOCALE
+	else
+
+		# ... to this one, but this way "test_must_fail" will
+		# tell a segfault or abort() from the regexec() test
+		# itself
+		test_must_fail test-tool regex "HALLÓ" "Halló" ICASE
+	fi
+'
 
 test_expect_success REGEX_LOCALE 'grep literal string, no -F' '
 	git grep -i "TILRAUN: Halló Heimur!" &&
-- 
2.35.1.1242.gfeba0eae32b


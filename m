Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CB6C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F7D61289
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbhDLLWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239825AbhDLLWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:22:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13DAC06174A
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:21:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c15so3567506wro.13
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z44EjCzhenP3pkakjwaJMRikahN11hvIq8ng10ca2e0=;
        b=MFz6gbc+wkZuYMATXSgici+2r9xTVt0g2QOazT4Are7O16EVCHjYCUahmaDBUAgNLV
         RgNjprSic6Jk+3ShZmMpLUgiHbzU1Z9v0S4LNisRRHZbYmEkbuJpj69icSyztQ009BGH
         iMO4ziCj+/tFrDDdnoI+pRyj/G+2Sk2Fmf1DLPmZ7YCyZCyrYSK1bPGJYICSZ18bCJYK
         7i4cyb4h5X/RtV6bfMA4yEVcXREfE3AZRyLvrDFnb28xNXruyFUFdi30yocw9xE8YUl5
         GAC0hS5I7yRncxK7R3BIuFDEEUDrSIUO0WO5Q/uvtjrWJrzbCzdZTewunDu1TADUdNK3
         es1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z44EjCzhenP3pkakjwaJMRikahN11hvIq8ng10ca2e0=;
        b=eyZ+CIfpjo3RlUDAIPKnEQUU+3jB7n46EUgAus7LUqkXHq8sXu+Ay8OgwfEbjPU2an
         B0WHWJNgVJAhJwOHqVIO405gCZZwzabrRZbADsHutiik6rpzwbzQ300cp7MC3FXOJ8WO
         VQ7uQabGfFqtzaOX5cysdaQHaaFdEElDSGTJ8el821G+flHbKvhgZeqwI1rEghZdYTzd
         I4rOvQDfrGHvooJ7get1VeQ7FKAftverp7OIPqReVhLzsJXIYbByGeZTE/EDiMMJvvzy
         MRVNNjMEVWPVIQFo5hPEqgEAQLO1FPTruziJ5azP65SZdNrK8pPOLnqtjRXMYL7kZeYf
         JovQ==
X-Gm-Message-State: AOAM533tpf+b9cO2JFFSa6cV7QevYw2pOSMSigEMqEtHfqP2IzVfuwSw
        /85sIXcOMsi2bHf7qU3HJvrLxSuCz57wuw==
X-Google-Smtp-Source: ABdhPJwVDVDbOKFvxOd9Rfs0v13a9LyyVgDm2TEi1+RNKkCGkvyJdIvWzCHDU2iFe9QV3ZVzxVGIkg==
X-Received: by 2002:a5d:4b12:: with SMTP id v18mr9550968wrq.45.1618226517102;
        Mon, 12 Apr 2021 04:21:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v185sm14580907wmb.25.2021.04.12.04.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:21:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] describe tests: improve test for --work-tree & --dirty
Date:   Mon, 12 Apr 2021 13:21:43 +0200
Message-Id: <patch-1.5-c41a777462e-20210412T111601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-0.5-00000000000-20210412T111601Z-avarab@gmail.com>
References: <20210228195414.21372-1-avarab@gmail.com> <cover-0.5-00000000000-20210412T111601Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve tests added in 9f67d2e8279 (Teach "git describe" --dirty
option, 2009-10-21) and 2ed5c8e174d (describe: setup working tree for
--dirty, 2019-02-03) so that they make sense in combination with each
other.

The "check_describe" being removed here was the earlier test, we then
later added these --work-tree tests which really just wanted to check
if we got the exact same output from "describe", but the test wasn't
structured to test for that.

Let's change it to do that, which both improves test coverage and
makes it more obvious what's going on here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6120-describe.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 88fddc91424..a83ea15faaf 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -151,24 +151,24 @@ test_expect_success 'set-up dirty work tree' '
 	echo >>file
 '
 
-check_describe "A-*[0-9a-f]-dirty" --dirty
-
 test_expect_success 'describe --dirty with --work-tree (dirty)' '
+	git describe --dirty >expected &&
 	(
 		cd "$TEST_DIRECTORY" &&
 		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
 	) &&
-	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+-dirty$" out
+	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+-dirty$" out &&
+	test_cmp expected out
 '
 
-check_describe "A-*[0-9a-f].mod" --dirty=.mod
-
 test_expect_success 'describe --dirty=.mod with --work-tree (dirty)' '
+	git describe --dirty=.mod >expected &&
 	(
 		cd "$TEST_DIRECTORY" &&
 		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty=.mod >"$TRASH_DIRECTORY/out"
 	) &&
-	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+.mod$" out
+	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+.mod$" out &&
+	test_cmp expected out
 '
 
 test_expect_success 'describe --dirty HEAD' '
-- 
2.31.1.634.gb41287a30b0


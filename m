Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37024C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 23:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E737C20878
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 23:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r74hAoUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbgJLX0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 19:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732248AbgJLX0L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 19:26:11 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11C8C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 16:26:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d3so19571886wma.4
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 16:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CzrCPnbUvNSakWF2bvkdGZ4dwzkAgsYCMdLnhb7Mw8c=;
        b=r74hAoUtv07NVZqMhBvtHGhgS4Y6Nhi3x4HXo0gqHS/nUbEMThv96ZBeMsxfHiROWb
         zr2pbFMmrzV5jmfN+20r8W0pxc+FD9IWPu1CFlpijxyyAThCuNlIoIA/qlJ0UtvZrInF
         K5RCqpxYkyZ1Gl+gWbRnED56QlNjmvjqgTPKBLx04Tc2xtjBqnED+MCoRn0A3XkQgurK
         ZVbDSOGJXAsDvJc2/TxEF732Q1Y/TUawXBa3EW5KyMYPHpwP2REytI13/qlLd0/BZvc+
         pCh9ooOmIIuogbxosT4aECkTNfXt11IEaWZMlymo74NP+WRDX1NWuMoAu2n8G6Tp0KlV
         0bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CzrCPnbUvNSakWF2bvkdGZ4dwzkAgsYCMdLnhb7Mw8c=;
        b=dNVOtl5et/jmWnrAQR3cz9HIZm9WTbRusunkpwNkFAxRA8Km9EYIlvxCGf1vlDKLyh
         v0j4kuHUIP58MuGBj6wM0CXXGBcMkxjZ6iDIIPbjw87uc8B/nokGJC5B+Lyoyta98cob
         6m8m8pxGuYHxVTucs2bANOk7CWKsoW0RU3G2iCm6/l2ytlWLuTcJM9Oe7KEKz6yGYSkT
         3ZrT9NVn0DRZpWA3T5uGDlKprGhVdnSaQ5VK1bBVe6KFhp7TO9LBInBb2AylMdWXPT8L
         jsFe78cTKOUTctdA0YnH3JOrtHmlZGh222LHUUggZx7naet+YKNCZO1P5n9LYvUrh87h
         Ou2A==
X-Gm-Message-State: AOAM533f8nulu+2SxeG60AmkaaYqc4Ov9xsOZB52ots4tuJozimkN3iS
        0LSE6b+T/Fg6/2U0O9cJnm3LT2ytd2o=
X-Google-Smtp-Source: ABdhPJwPvesZtj30PY/BFUjDt6u+RdGIXhZns2iYXlWvl5zrVyFRaEEzr/p5GvvPQ2+ZOxCLCHKO5Q==
X-Received: by 2002:a1c:7d54:: with SMTP id y81mr12179203wmc.114.1602545167263;
        Mon, 12 Oct 2020 16:26:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm27707016wrt.53.2020.10.12.16.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 16:26:06 -0700 (PDT)
Message-Id: <d1d73400e838107b7a9a8562a20ec24a2a9a2ba6.1602545164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Oct 2020 23:26:03 +0000
Subject: [PATCH 2/3] t6006, t6012: adjust tests to use 'setup' instead of
 synonyms
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

With the new ability to pass --run=setup to select which tests to run,
it is more convenient if tests use the term "setup" instead of synonyms
like 'prepare' or 'rebuild'.  There are undoubtedly many other tests in
our testsuite that could be changed over too, these are just a couple
that I ran into.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6006-rev-list-format.sh   | 2 +-
 t/t6012-rev-list-simplify.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index bc95da8a5f..99a1eaf332 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -339,7 +339,7 @@ commit $head1
 .. (hinzugef${added_utf8_part_iso88591}gt) foo
 EOF
 
-test_expect_success 'prepare expected messages (for test %b)' '
+test_expect_success 'setup expected messages (for test %b)' '
 	cat <<-EOF >expected.utf-8 &&
 	commit $head3
 	This commit message is much longer than the others,
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index b6fa43ace0..7254060240 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -168,7 +168,7 @@ test_expect_success '--full-diff is not affected by --parents' '
 #
 # This example is explained in Documentation/rev-list-options.txt
 
-test_expect_success 'rebuild repo' '
+test_expect_success 'setup rebuild repo' '
 	rm -rf .git * &&
 	git init &&
 	git switch -c main &&
-- 
gitgitgadget


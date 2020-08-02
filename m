Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D36C433E1
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 06:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FBE62076B
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 06:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l08UUrp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHBGdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 02:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgHBGdK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 02:33:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E025C06174A
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 23:33:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t14so7452322wmi.3
        for <git@vger.kernel.org>; Sat, 01 Aug 2020 23:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QSqIS22JH6HGyeIdne1x4lI2cgyJOLuB1JQ3W5nl7/Y=;
        b=l08UUrp1ddehBiT72F5t7jcOaaAE+/GRtltbeVMfWfTxXWntegCxbSShOWM952z8j6
         +3Mfwp9ypOnwr0FfgSH7Tuw6DLYNOFs4yWyfCvavLL7bP7YL5BO87h2IAcijRV72bnAH
         RQcsOP/tH6ZCEmJ+f4+y6QrNqdzsrxsyGk2xG9jUvSY1vKUwlprxLILoZ5321LR6Oizj
         XavTX6RUDzYmXelJ4p1l3nNcmRZ6TZ74NQ0qzVXweHqmqNqOAXg5JQ72BuQmLrgZZAZt
         Xe5h3ERqOTnTr0O/sd7tK3ahqupMWEGLT6RL/ob4BxfMjhYrkDAbgG4ttXlZhQAvc5km
         e/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QSqIS22JH6HGyeIdne1x4lI2cgyJOLuB1JQ3W5nl7/Y=;
        b=QtGKrL8CeTgndEypmMMFRQr3CZOHJ45U9zrytMOlnjTp/Y8ds8Vn07cgzyvEI8SyKB
         nDXiMWXye97ofi45tQE1/eNNBtxPwJuwI8ceerPDIOaa4AVxPqJmjvtulXdwTqYDwfvJ
         qWjUw1xc1VjIQiySjgiSwQHfqFD42YE646Ve7i4nxW2yyYZo0DyCozVEg+8QPcQ0I6Qd
         0Xvwn1BAx/hsrBa/jLnTZjo+CACeLACaN5bQKw1QOXqA2IKsmM/y2y8OsVfko8qVtjOd
         LZiRo+la84q1eEt96H2XB1E4Gz7NJHCCFPGlHINEYIE60GfjsAIMHWkF5k4CpFxvlTTU
         vbIQ==
X-Gm-Message-State: AOAM533TV/sPEx+LXIh0O5S/UA7KvXqlInFxPyySNFcce/4Dx1I5jtg1
        yhNre1MzB1aU5GjIlvEm8Vnm8j3X
X-Google-Smtp-Source: ABdhPJwWFaUEY05sJUt+QddSPaRl/kbuliqXEoCPcVoRNk0PD+XNWdSVO0pwEAUYsSb0/dXGusqDiw==
X-Received: by 2002:a1c:7702:: with SMTP id t2mr4858664wmi.169.1596349988743;
        Sat, 01 Aug 2020 23:33:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14sm17513285wml.30.2020.08.01.23.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 23:33:08 -0700 (PDT)
Message-Id: <361911817559104672d273e199221e8367e8d595.1596349986.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 02 Aug 2020 06:33:03 +0000
Subject: [PATCH 1/4] t6038: make tests fail for the right reason
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

t6038 had a pair of tests that were expected to fail, but weren't
failing for the expected reason.  Both were meant to do a merge that
could be done cleanly after renormalization, but were supposed to fail
for lack of renormalization.  Unfortunately, both tests has staged
changes, and checkout -m would abort due to the presence of those staged
changes before even attempting a merge.

Fix this first issue by utilizing git-restore instead of git-checkout,
so that the index is left alone and just the working directory gets the
changes we want.

However, there is a second issue with these tests.  Technically, they
just wanted to verify that after renormalization, no conflicts would be
present.  This could have been checked for by grepping for a lack of
conflict markers, but the test instead tried to compare the working
directory files to an expected result.  Unfortunately, the setting of
"text=auto" without setting core.eol to any value meant that the content
of the file (in particular, the line endings) would be
platform-dependent and the tests could only pass on some platforms.
Replace the existing comparison with a call to 'git diff --no-index
--ignore-cr-at-eol' to verify that the contents, other than possible
carriage returns in the file, match the expected results and in
particular that the file has no conflicts from the checkout -m
operation.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6038-merge-text-auto.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 5e8d5fa50c..27cea15533 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -168,9 +168,9 @@ test_expect_failure 'checkout -m after setting text=auto' '
 	git rm -fr . &&
 	rm -f .gitattributes &&
 	git reset --hard initial &&
-	git checkout a -- . &&
+	git restore --source=a -- . &&
 	git checkout -m b &&
-	compare_files expected file
+	git diff --no-index --ignore-cr-at-eol expected file
 '
 
 test_expect_failure 'checkout -m addition of text=auto' '
@@ -183,9 +183,9 @@ test_expect_failure 'checkout -m addition of text=auto' '
 	git rm -fr . &&
 	rm -f .gitattributes file &&
 	git reset --hard initial &&
-	git checkout b -- . &&
+	git restore --source=b -- . &&
 	git checkout -m a &&
-	compare_files expected file
+	git diff --no-index --ignore-cr-at-eol expected file
 '
 
 test_expect_failure 'cherry-pick patch from after text=auto was added' '
-- 
gitgitgadget


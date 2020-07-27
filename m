Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61310C433E3
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 16:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E032206E7
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 16:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="framGbmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgG0QZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbgG0QZv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 12:25:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F87C061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 09:25:51 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a14so15526670wra.5
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4tPbBuOlUBUJNGrzExajIWDAcijCiaD6SsrE7Y63AMM=;
        b=framGbmfdH/qq1KpT9bI0YKKdCxNYRQUvbuvqHqQwhTtQ17OvJeaUtr0Vwo6xYn2Di
         TVBMB/wHSWQV9EXW6p9z9jAVLog/GKpkCZMxNPmlCyVsx3lYUH/QY21LNBbJ0+QuDOkN
         6siC0aT/jyzVCkCHIFlsgMUmylvPQw7ad0AeRzBg5133pJlFyE+0QqtnRcekVRgl+CIU
         iY0stvQXIduE4EayKVoV7b0vAGnuGdg11bgy5tRhqgDoSP7M88xCCldHz4JVREqa0bZb
         iM21PNcCv0nQKlRnIlJvLKALj6tKqmJc6afcNzOCRmsyNDlil9NuJoRZCy9Nl/Iu9dG1
         Zm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4tPbBuOlUBUJNGrzExajIWDAcijCiaD6SsrE7Y63AMM=;
        b=id9w3NI0gOKpVHgQ/aE8sg0TWCgbPnQmBseSQUIh3F0VXsHzu4H0i3rgtG5grmQG78
         21MVWyltRQMMWIKE2V5JGu1aq+YzXBd356cihtKQbD4dsRiw2sqi5vVaZQwJezd6pnxi
         KLB6AukuKSfernpF6md1wNT7vntO0kUvQczh6/QBzJmrfmkAmBsInSaVZgqhpMpdZXXS
         j8j5t9QTJnuromLLR7F3H3aTHB/a7dIeY3VYoxH3FdVpAluq22kgiCm8WUXT4FLOeEJz
         LlfMsyrmLzlzSv3sPrl1TH5vCc1RePBxB/GNMHfZmMdmjQpE8jDI1z6YsyLvsp7HCnRb
         DfTw==
X-Gm-Message-State: AOAM532jNQjN+zvzGB0Lbk/M50OWoZKgzGHziTPGfG1cU8IsIsDsA8RR
        0B7BfqNUMLuwfvkiWF3vJ1xmAHSG
X-Google-Smtp-Source: ABdhPJw71V2hDoKLlpu/WJ1khWtcovSN/BDZdhKN6I06/UnVS1ySszneiWCw1Mv00cCkL8873jRbXg==
X-Received: by 2002:a05:6000:120c:: with SMTP id e12mr20670707wrx.354.1595867149913;
        Mon, 27 Jul 2020 09:25:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8sm13752876wrd.85.2020.07.27.09.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 09:25:49 -0700 (PDT)
Message-Id: <b5274d9053ffa9a56923cc9ba3e10e3bd1d07f0f.1595867147.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.673.v4.git.1595867147.gitgitgadget@gmail.com>
References: <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
        <pull.673.v4.git.1595867147.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jul 2020 16:25:45 +0000
Subject: [PATCH v4 1/3] t1400: use git rev-parse for testing PSEUDOREF
 existence
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This will allow these tests to run with alternative ref backends

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1400-update-ref.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 27171f8261..7414b898f8 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -475,57 +475,57 @@ test_expect_success 'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER
 
 test_expect_success 'given old value for missing pseudoref, do not create' '
 	test_must_fail git update-ref PSEUDOREF $A $B 2>err &&
-	test_path_is_missing .git/PSEUDOREF &&
+	test_must_fail git rev-parse PSEUDOREF &&
 	test_i18ngrep "could not read ref" err
 '
 
 test_expect_success 'create pseudoref' '
 	git update-ref PSEUDOREF $A &&
-	test $A = $(cat .git/PSEUDOREF)
+	test $A = $(git rev-parse PSEUDOREF)
 '
 
 test_expect_success 'overwrite pseudoref with no old value given' '
 	git update-ref PSEUDOREF $B &&
-	test $B = $(cat .git/PSEUDOREF)
+	test $B = $(git rev-parse PSEUDOREF)
 '
 
 test_expect_success 'overwrite pseudoref with correct old value' '
 	git update-ref PSEUDOREF $C $B &&
-	test $C = $(cat .git/PSEUDOREF)
+	test $C = $(git rev-parse PSEUDOREF)
 '
 
 test_expect_success 'do not overwrite pseudoref with wrong old value' '
 	test_must_fail git update-ref PSEUDOREF $D $E 2>err &&
-	test $C = $(cat .git/PSEUDOREF) &&
+	test $C = $(git rev-parse PSEUDOREF) &&
 	test_i18ngrep "unexpected object ID" err
 '
 
 test_expect_success 'delete pseudoref' '
 	git update-ref -d PSEUDOREF &&
-	test_path_is_missing .git/PSEUDOREF
+	test_must_fail git rev-parse PSEUDOREF
 '
 
 test_expect_success 'do not delete pseudoref with wrong old value' '
 	git update-ref PSEUDOREF $A &&
 	test_must_fail git update-ref -d PSEUDOREF $B 2>err &&
-	test $A = $(cat .git/PSEUDOREF) &&
+	test $A = $(git rev-parse PSEUDOREF) &&
 	test_i18ngrep "unexpected object ID" err
 '
 
 test_expect_success 'delete pseudoref with correct old value' '
 	git update-ref -d PSEUDOREF $A &&
-	test_path_is_missing .git/PSEUDOREF
+	test_must_fail git rev-parse PSEUDOREF
 '
 
 test_expect_success 'create pseudoref with old OID zero' '
 	git update-ref PSEUDOREF $A $Z &&
-	test $A = $(cat .git/PSEUDOREF)
+	test $A = $(git rev-parse PSEUDOREF)
 '
 
 test_expect_success 'do not overwrite pseudoref with old OID zero' '
 	test_when_finished git update-ref -d PSEUDOREF &&
 	test_must_fail git update-ref PSEUDOREF $B $Z 2>err &&
-	test $A = $(cat .git/PSEUDOREF) &&
+	test $A = $(git rev-parse PSEUDOREF) &&
 	test_i18ngrep "already exists" err
 '
 
-- 
gitgitgadget


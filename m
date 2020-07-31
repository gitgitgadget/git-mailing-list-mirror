Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1778DC433E1
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB549208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSnrtaSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbgGaP11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbgGaP1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9E9C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id 88so28341039wrh.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4tPbBuOlUBUJNGrzExajIWDAcijCiaD6SsrE7Y63AMM=;
        b=uSnrtaSoZ6QQygIbVOZG+KYx+ukFnamMf7dAtv5zQEe6O3uiUbr7TkJTpLv3l/2VG1
         WeUOrIVRSKQCNyehI1SmSJ6mkql/Wg0/W0y6j80Ha3aC4FoSXyPcpVJm/oFeTTb9BEC8
         7ia8vT2h9zkk2fO5NfR5h6Vg+EgS/qjhK09IkQOowg5kH+/cgCAbBUQs9tl7s3tBnsnM
         maijtU2140gEjcflF3dUkgmUx20r9Vu1npQNl2TLkemdJAzcz3THc7bvc2OW7lPNRAO9
         rf64851B2FtiWaFscgC5rjYwlShhtJfk2qGQtj3W/3ZSKA4Av2+0pC/wpBUSOhhzbFSN
         +14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4tPbBuOlUBUJNGrzExajIWDAcijCiaD6SsrE7Y63AMM=;
        b=L5fdG1KC6+FkICZ9e7K6gC2HyX2RZvD4/ZPYZFvmk8zwOKrli/pTk2+SG5mHibGMj7
         0t2TNaEZHPR/pfWyU04t+Dtjih8HZgHHOMJkvjy/s+7zxTaDfJ/lwlZ5kctZ0KwsSbMi
         Y0OE4WHjKes22llqOw1bGRcVgvbt5L5xSu414XaX2YERxMLSKP/Kxt6eoHydKb9OLZs2
         buY6eYF/+H2B/SVjgezdLE1ZOJDw22fQV9BCUAGSHFqnh42+sH3tbU7Z7aJ1O4T6mhGg
         mAUCe7zgZoTJF8wN+jzxWqfSQ9z2sp2mWoZssFxGEObUvuxHYf/VI0ae3oZzcIPLTzht
         kbkQ==
X-Gm-Message-State: AOAM530OUxC9adFS8D8lssMp4H2J/FN0JC2EFAsm1NqT+0tkJcML8zEe
        UxzwUApScSzNQqz89WrdtiWH7s9P
X-Google-Smtp-Source: ABdhPJzv3fGugDuczt9GZeuskLMzQQWG3QU3w22HnEeI/cQIQOZOHLQxnYyJqTM0IslP8KeoNJoJiQ==
X-Received: by 2002:adf:9ed4:: with SMTP id b20mr4012487wrf.206.1596209242725;
        Fri, 31 Jul 2020 08:27:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm12939845wmb.11.2020.07.31.08.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:22 -0700 (PDT)
Message-Id: <716cb30c1b8074ab23e25dff5dce216925728ec0.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:26:59 +0000
Subject: [PATCH v20 03/21] t1400: use git rev-parse for testing PSEUDOREF
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


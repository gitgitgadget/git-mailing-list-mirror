Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B55C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BB2C60F6F
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbhIMPq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245476AbhIMPqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:46:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA18BC0A8893
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g16so15320934wrb.3
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V98N4KFFTGnu5SYXwIpcKyAHtNwzXMX0/pNnBaCO1p8=;
        b=CgAQgtIhgQDtOPX2qa0PQrbRIS1xw4mDewbUdhqw1JvqRj8bmJ/b4O15bjf3LKNBwt
         aQ3KPIySZMmefA2u+ZqZ60wFYb9IGtvCR33CEWk7dk+Kgnqo5HSXx+NroS4vNgykUAaI
         F9IIDc8iSu2ZrNXmvRxF28gs2Dy0sdl/Ku9O7b4LDUqp7tuPgKS581DvMWCZz3I1KQdA
         5J7HHalEasG6ZTZs5BZ9nylR0UqiRaSdPEAtLe4LY2/YZqcjxS0FsienTTmS/mypPhHV
         mAS+pKhDUGgdVpY2tPd7fRnf01GoJFu3CfCvfIuGYBzcZq7p+/N6p+NvWamOHXwTw5m4
         Jh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V98N4KFFTGnu5SYXwIpcKyAHtNwzXMX0/pNnBaCO1p8=;
        b=s42O6eZUmYALkxBYuDsC5hMqiZb2HlbBsB5ma5jDjx5ezSj4EIdrhCaXixPFIYVIh0
         SQBYUGX12U9GJMCqJBxGBMkudPAR53S6i5RNSlQJ36M4j9SnQfN+uBT9GPcsVCa8IKX0
         ezxT++bWY2QkU3XTErs9FHyliHbq+CK36ySjw0lxd3l9d0OvJi6jcNflKKHft6hAJ1Pl
         j46SZ6/dT5vnaarT0bMX+Blw7AX1aCecYS5OGx/AyzuV5wy3Tg8pPd6L6biRiwrbqRnY
         6qHMQJb/Mt2bOXYJANjbifcbmb5RjLs3lNEG/7z3UmmVDdexAaxRJ7RM735MktQMFtYk
         5fRQ==
X-Gm-Message-State: AOAM533WLsfoFK8i0P7JNtDJ+kP7EePLcASEwwsvtV1Y8l+xgEWnCGBv
        K1tEPHWyrnCeuGbRJylVEPTzbMhGHs4=
X-Google-Smtp-Source: ABdhPJwiMAijIwUx5tAUYloBYJw+cyjLrzwvfgnCPcgpDunKSurML8bMQd0ZS5FzltngUdGL6k4dTQ==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr13022518wrr.278.1631546366583;
        Mon, 13 Sep 2021 08:19:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm7560808wrr.69.2021.09.13.08.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 08:19:26 -0700 (PDT)
Message-Id: <38eee11baf580adbef406cd776551dda012c8b4b.1631546362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
        <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 15:19:15 +0000
Subject: [PATCH v2 04/11] t3407: rename a variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

$dotest holds the name of the rebase state directory and was named
after the state directory used at the time the test was added. As we
no longer use that name rename the variable to reflect its purpose.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 39076ac9462..2c70230a4eb 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -21,35 +21,35 @@ test_expect_success setup '
 
 testrebase() {
 	type=$1
-	dotest=$2
+	state_dir=$2
 
 	test_expect_success "rebase$type --abort" '
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
-		test_path_is_dir "$dotest" &&
+		test_path_is_dir "$state_dir" &&
 		git rebase --abort &&
 		test_cmp_rev to-rebase pre-rebase &&
-		test ! -d "$dotest"
+		test ! -d "$state_dir"
 	'
 
 	test_expect_success "rebase$type --abort after --skip" '
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
-		test_path_is_dir "$dotest" &&
+		test_path_is_dir "$state_dir" &&
 		test_must_fail git rebase --skip &&
 		test_cmp_rev HEAD main &&
 		git rebase --abort &&
 		test_cmp_rev to-rebase pre-rebase &&
-		test ! -d "$dotest"
+		test ! -d "$state_dir"
 	'
 
 	test_expect_success "rebase$type --abort after --continue" '
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
-		test_path_is_dir "$dotest" &&
+		test_path_is_dir "$state_dir" &&
 		echo c > a &&
 		echo d >> a &&
 		git add a &&
@@ -57,7 +57,7 @@ testrebase() {
 		test_cmp_rev ! HEAD main &&
 		git rebase --abort &&
 		test_cmp_rev to-rebase pre-rebase &&
-		test ! -d "$dotest"
+		test ! -d "$state_dir"
 	'
 
 	test_expect_success "rebase$type --abort does not update reflog" '
-- 
gitgitgadget


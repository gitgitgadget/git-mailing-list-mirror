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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36256C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE6860231
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhEaRmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhEaRk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ECFC00874E
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f2so475173wri.11
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Wf83JeVg+o2I+1ijj5sYIbouGdt/6TlF7eLkwUj7+dM=;
        b=rPWPbxpT6NIyUf7pxlv5qHyirvCsOF/ylVF68DxikttaGtRwVoHpujyG71MRb/rzZ3
         cCue1s/LF/RDpFZJ0iH5HX6H0UagJ9SKrHCUuIEbXBVa2OkdfAHMBZlpLdHdmsHym08r
         8Za3zHLvOWJY4MmByv8ngs3nXwMcfm+S5sHbqq4RpiOuypsfDKgN2ENvF1VQZcOZx8Cy
         wcOxpnTG9iLiTN7yBaO+j1N19HIkK0w91/9Ej8x3mxGTm/wC18Ek/SsKslIlTDEfjLx/
         tteqnxyzu2jY/YAMRFAqtKBQtnymobk/y/sljuuL34Rkb7YYN9SoAwZp1R2tm2J5mdqW
         q+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Wf83JeVg+o2I+1ijj5sYIbouGdt/6TlF7eLkwUj7+dM=;
        b=gBijGPH6wRG7/tV56Hx21d82DnR3mt4yrjSfyLFGNPxyaLKsvZd0GllG/lcivRSIeP
         C77l25S96lyHDVtLMhcgtw59zSKIDnj8PgAlhtJl6+BUhvXsANi8kQ0+FW//J9DT2854
         ondq5WDBskONJG81WwjDtw123AI2dC9vjNFjV+iyFzqAcfMoRicUl9DxcDz804Mu/gtL
         ZTM+HqcbQOkg4RjurPsIRzI7vKP1JwXHAMJ5mhbQLCwHHaYv4bPie/kGL7X2A6sV5iGG
         u6otfYi74mhtSrUcmN4j03OXMcN0SKGbq+MgQw8oAovbV6YnS4OQFDRybvHVPZM3NyyO
         kWOw==
X-Gm-Message-State: AOAM5312fUCEdMMBCtdOk9Gaar/d4QhaDxWnidWyPAH3pTMTudsgSd6+
        nl55RnWu+Nn5/oxHKptwbDcCbRebh8o=
X-Google-Smtp-Source: ABdhPJwn9BlQHmGz3cj3cUk8pB86e16+DzZ5T13HU5b98GZ0bhp8oXWOOSb17NfutN13M1fA7qTLjA==
X-Received: by 2002:a5d:4346:: with SMTP id u6mr23123174wrr.304.1622480206126;
        Mon, 31 May 2021 09:56:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm278408wrs.7.2021.05.31.09.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:45 -0700 (PDT)
Message-Id: <9ede1b73d5238d62faea395f1154af9e02e11b4c.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:28 +0000
Subject: [PATCH v3 13/22] t5304: use "reflog expire --all" to clear the reflog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This test checks that unreachable objects are really removed. For the test to
work, it has to ensure that no reflog retain any reachable objects.

Previously, it did this by manipulating the file system to remove reflog in the
first test, and relying on git not updating the reflog if the relevant logfile
doesn't exist in follow-up tests.

Now, explicitly clear the reflog using 'reflog expire'. This reduces the
dependency between test functions. It also is more amenable to use with
reftable, which has no concept of (non)-existence of a reflog

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5304-prune.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 15d56d3d8791..7cabb85ca6e1 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -81,12 +81,12 @@ test_expect_success 'prune: prune nonsense parameters' '
 
 test_expect_success 'prune: prune unreachable heads' '
 	git config core.logAllRefUpdates false &&
-	mv .git/logs .git/logs.old &&
-	: > file2 &&
+	>file2 &&
 	git add file2 &&
 	git commit -m temporary &&
 	tmp_head=$(git rev-list -1 HEAD) &&
 	git reset HEAD^ &&
+	git reflog expire --all &&
 	git prune &&
 	test_must_fail git reset $tmp_head --
 '
@@ -94,9 +94,7 @@ test_expect_success 'prune: prune unreachable heads' '
 test_expect_success 'prune: do not prune detached HEAD with no reflog' '
 	git checkout --detach --quiet &&
 	git commit --allow-empty -m "detached commit" &&
-	# verify that there is no reflogs
-	# (should be removed and disabled by previous test)
-	test_path_is_missing .git/logs &&
+	git reflog expire --all &&
 	git prune -n >prune_actual &&
 	test_must_be_empty prune_actual
 '
@@ -104,6 +102,7 @@ test_expect_success 'prune: do not prune detached HEAD with no reflog' '
 test_expect_success 'prune: prune former HEAD after checking out branch' '
 	head_oid=$(git rev-parse HEAD) &&
 	git checkout --quiet main &&
+	git reflog expire --all &&
 	git prune -v >prune_actual &&
 	grep "$head_oid" prune_actual
 '
-- 
gitgitgadget


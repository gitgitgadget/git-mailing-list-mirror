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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA72C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9C161108
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhEaRlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhEaRkp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AE2C068EFD
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f17so5164041wmf.2
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fd8GejOq01K6AoXMkukSoNdf1cFk1ikKhFJh07/m1iA=;
        b=eWytrichn1mlzKYM7LRGfAmQ393pCPjyTe+FncLdBzAbtQbH/l6e4r3kInf3QUhaZX
         bYAmsu+u0gBo3HWxoamO4lQs6QmnRiQDcuOXWEfc6oFyXYUyEVetCJxwO3RKzAlWU8yz
         4wuRrRbG2m1BP8iPooDZynYFE7SkwMT1AtWJ+X44Cge1UpKOxb/EV96vSzQCsPHOVGne
         VGctUNFXaTrYMUuROhAAxjr161n9iYCaKLoyS8oru8ybKWmDRLYZir02lKCnZ8fhsEBY
         OLFlEmG9ny5RXsLEDq0CIcVbZ99k7gosZYce9kxiZ2ttAUBkjrt4Yv5+Ex0fFndHsPjv
         GVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fd8GejOq01K6AoXMkukSoNdf1cFk1ikKhFJh07/m1iA=;
        b=kWftetMUOv3A7LAMY5cBRhPD7JQVBL2dwBYf6WhAhyLJM7H9DUSniNuZs1MMnwNYQS
         r6U8vhjzxm5w6K44KcbBdFi8l7BvrkrqemflnlM4cjapqKf+nUTV1zFsfKSCAoDRX9Il
         RzsKFSOAenjJmhtenLgl84qNNwqqGW4xSbnb/CniDyqtGCk1th5GG4oHb7cXXMWMUHPL
         mUDAyDHHm+nVgkA9H3DuTbDFjST7cckkRP5Uxw3H1gW4Zy4wP3HF4TRxAlrS7ydO6ffC
         XH1KzR++Yzd6EZ1I3cAh74LWOlnNQb1SZWqCbfapAP8Ao+5kuMdFPpSUKGXkvGP2Q1rj
         TWiw==
X-Gm-Message-State: AOAM533kySe5ER5j+wi4gHl4qkz15G0UkTSrUKu5GUgZ4K4iSGU1+LDx
        /MIXXrSolNNuk1l96U3uRQ1IpcFQo/M=
X-Google-Smtp-Source: ABdhPJyJeAoOo/jcdgVYiGOAyBH+JoTHgj3zCwDM6S4da0QXNd/8TS6FsBO6i1K9WgA5PBMJs7j+Qw==
X-Received: by 2002:a05:600c:47d7:: with SMTP id l23mr6883733wmo.49.1622480199870;
        Mon, 31 May 2021 09:56:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm256075wrn.38.2021.05.31.09.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:39 -0700 (PDT)
Message-Id: <6d875c6d757991c73a578933b65a569cb937546e.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:16 +0000
Subject: [PATCH v3 01/22] t4202: split testcase for invalid HEAD symref and
 HEAD hash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

Reftable will prohibit invalid hashes at the storage level, but
git-symbolic-ref can still create branches ending in ".lock".

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t4202-log.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 350cfa35936a..327991fcea49 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1834,14 +1834,18 @@ test_expect_success 'log --graph --no-walk is forbidden' '
 	test_must_fail git log --graph --no-walk
 '
 
-test_expect_success 'log diagnoses bogus HEAD' '
+test_expect_success 'log diagnoses bogus HEAD hash' '
 	git init empty &&
+	test_when_finished "rm -rf empty" &&
 	test_must_fail git -C empty log 2>stderr &&
 	test_i18ngrep does.not.have.any.commits stderr &&
 	echo 1234abcd >empty/.git/refs/heads/main &&
 	test_must_fail git -C empty log 2>stderr &&
-	test_i18ngrep broken stderr &&
-	echo "ref: refs/heads/invalid.lock" >empty/.git/HEAD &&
+	test_i18ngrep broken stderr'
+
+test_expect_success 'log diagnoses bogus HEAD symref' '
+	git init empty &&
+	git --git-dir empty/.git symbolic-ref HEAD refs/heads/invalid.lock &&
 	test_must_fail git -C empty log 2>stderr &&
 	test_i18ngrep broken stderr &&
 	test_must_fail git -C empty log --default totally-bogus 2>stderr &&
-- 
gitgitgadget


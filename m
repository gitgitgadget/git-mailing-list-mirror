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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D08EC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1000260231
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhEaRlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbhEaRkq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F316DC008741
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:42 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so327351wmh.4
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=cUsN+j76mzKamDBijjtwkqu2z92gPYbkH8XM3uMWhgE=;
        b=CJUp28VKuCw15OlChq0ETqe7//PoODpwbLh6ph9D3SG8tsseHIzjT1OcrfireOQC0G
         qb/3iEV7hoV5CAPgoDzKgTPa0emrYuMvWAzqWelHlVPD1RpAqtNwS9cwP/Gdjl4yx72u
         aNqrVZ+2AJ0+9CNSxndvQ6oO8/fetP2pU2o1C1eV4VrfoB3I0sbO+2K1vFfgNQKV170t
         rkFWgUY1cXFPIplEqJIG88PAXmRQf1TnTJmZ3o72MYLqOH72qwI0MvhNpmsEoM+zXiFQ
         BVrT4C6voCrElocBHJ3QUj48sdjli91VWAkJkVT59TkpqajdlrIv34ukagnkg0Rgr28h
         fTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=cUsN+j76mzKamDBijjtwkqu2z92gPYbkH8XM3uMWhgE=;
        b=n0WvejUl/2nLZ5JFGwfLEaOCLkV7PVEQrIHJXDKWWfRMEyw2UgoTKuJfXuwFIm/qxh
         9y+BaZnPurR38yZWsez97lVI1ReQuX5xxAvRpohRJqAcqV2aw/VzHy+eyPUYTFeJ5F+Q
         1mvfdJe4Cq6yrgzopybjapDKKhVaR9rkbOtr5Rk9St5m7r5lmXz+O2W1lmF2w/trnnB3
         ylWR93q4brjUyIHUCZRy//exl6DMwLuwVRe0uzCXNM/SO0XSRQvNgVu34NA8hjCnNhLs
         xqfdOa/n4I+S65BrMWTb72Dv5vbmBAcCq0DpUdzBPeoaOTomshBJMlzhcpFw6cNiHZdB
         twhQ==
X-Gm-Message-State: AOAM532g58fo3TU5VmKBKwIDbeXHgnx2o50gUdO1oy+Q9jdZPA5zgmkB
        vCTHLWj83YvH1g7/Klqb3bmgb5rKcWE=
X-Google-Smtp-Source: ABdhPJwln284+h6PT33C8eaGrepNcf9PGXbZ+8ujVegH+/A01322d5YCoD5b5uw/sSdxPg17M28DMg==
X-Received: by 2002:a05:600c:35cb:: with SMTP id r11mr62017wmq.152.1622480201664;
        Mon, 31 May 2021 09:56:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6sm16085591wma.4.2021.05.31.09.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:41 -0700 (PDT)
Message-Id: <c898982255c19639d77c910c84557538bd104093.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:19 +0000
Subject: [PATCH v3 04/22] t5601: read HEAD using rev-parse
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5601-clone.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index c0688467e7c0..83c24fc97a7b 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -305,7 +305,8 @@ test_expect_success 'clone from original with relative alternate' '
 test_expect_success 'clone checking out a tag' '
 	git clone --branch=some-tag src dst.tag &&
 	GIT_DIR=src/.git git rev-parse some-tag >expected &&
-	test_cmp expected dst.tag/.git/HEAD &&
+	GIT_DIR=dst.tag/.git git rev-parse HEAD >actual &&
+	test_cmp expected actual &&
 	GIT_DIR=dst.tag/.git git config remote.origin.fetch >fetch.actual &&
 	echo "+refs/heads/*:refs/remotes/origin/*" >fetch.expected &&
 	test_cmp fetch.expected fetch.actual
-- 
gitgitgadget


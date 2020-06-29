Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB20C433E3
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE735206A1
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mphkpHeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbgF2VOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729561AbgF2S5C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAE0C031C41
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so17627837wru.6
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mj5ZbJ12LR3v8Yt4MmtqwCsvAWZFVJ2iC7ETEQzbIiw=;
        b=mphkpHeU0VNnxjZ3MMaB/IGTOlr2gicWVmSTjMCy4DbFADFV2xhCcsmUQrjFKAi4DP
         8a30fOO+AwJlKFwi+98vRY+Uj/S3nLj5000u54gJ0PJIm4kdG38Qyf0u1g5llV6IBoIq
         62Agi8M4deOaBwBRKkNuJLYPTUYrzM+WhgaEVqGvSxxsZQNDwB2fAq6A2Is4YqoR3pEA
         5oIjBlZvDpCBBnAirSyj8yavbFly5xxE8ghAXC+wcbyCFT4lsZswjcZYq6per7YUhx7e
         w68HYtahgLFG82w8N/OYJbtH0tp9BMfMMFeRnxXgZLy0FLTY8T7UNIUKBsK3fef1Go+/
         LV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mj5ZbJ12LR3v8Yt4MmtqwCsvAWZFVJ2iC7ETEQzbIiw=;
        b=sFhNh2FEzW5ws6vJ/DJ8bRvHUnaRMje9TsVCBukoGLbgLyqEC3S+dXIDJqBCrCIe/A
         ffu90bDqVoTw+K+qHQwun+hc3zpPWVPJplNno+/xCp2wgxUkoyNVz3LM2kLfDORj/PGv
         irZlbhJ7g9mr78NS4Hdm758Q4tkDx1pLQ0CZ6qSzf499dAixJjmXyxO+hf521Nb9Fal9
         L7pY47Ld76h1JeWO6pBfFRKqNGdQLqnO/ehra5pxrMQjPSg9zdwXxufgoWmXC/UglelM
         uO5TMQdES1sKrE323LE/1786pOJXQyVgodqLplEcjFV3NoG3gv12KY17wHbTzaaevAnF
         3YVQ==
X-Gm-Message-State: AOAM531dSaUvvRPQL8gLyPILCy+hVbwtdUKQZtjt7jAPTEF4n5/ztlwR
        1QmxNswZ7SL40EOOcsMeapcW1zSpa9I=
X-Google-Smtp-Source: ABdhPJxPeRTnlycuQqAURrZPQb71Mzmwe+smgqPvheOumBEdVSOi3E0Awg1rlu/HaasTmbhp/ckn4g==
X-Received: by 2002:a5d:4611:: with SMTP id t17mr17407948wrq.243.1593457021203;
        Mon, 29 Jun 2020 11:57:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r3sm786486wrg.70.2020.06.29.11.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:57:00 -0700 (PDT)
Message-Id: <596c316da4fe09a05a864472b22fe411ade0d55f.1593457018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 18:56:39 +0000
Subject: [PATCH v19 01/20] lib-t6000.sh: write tag using git-update-ref
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/lib-t6000.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
index b0ed4767e3..fba6778ca3 100644
--- a/t/lib-t6000.sh
+++ b/t/lib-t6000.sh
@@ -1,7 +1,5 @@
 : included from 6002 and others
 
-mkdir -p .git/refs/tags
-
 >sed.script
 
 # Answer the sha1 has associated with the tag. The tag must exist under refs/tags
@@ -26,7 +24,8 @@ save_tag () {
 	_tag=$1
 	test -n "$_tag" || error "usage: save_tag tag commit-args ..."
 	shift 1
-	"$@" >".git/refs/tags/$_tag"
+
+	git update-ref "refs/tags/$_tag" $("$@")
 
 	echo "s/$(tag $_tag)/$_tag/g" >sed.script.tmp
 	cat sed.script >>sed.script.tmp
-- 
gitgitgadget


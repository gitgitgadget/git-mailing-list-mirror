Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FCCC433E9
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F41022A85
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbhAPRGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbhAPQaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 11:30:09 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F6AC06134F
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:10 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 7so4991384wrz.0
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dCv8Vm3E5bnMX9AUxXBz0tqO2Ex0WNF6fvpf+abNb3w=;
        b=DnR8xmPsYHK8AMgwUOqsu2T4CcR6w44JKmSJVU3lfu+pauJN7y8VzSPnkS05jgvHf6
         +1mHZ+v3l8lX29CXF54LwCFV0MpO+QuFLQLaFMiFbunRk8ryE2CUQvAfJK9HLLTDglei
         2B5mjDLk/L+HgaBoQfXdeDj2i3iS2ZUz5eQQD9mrnpiujrW7yE5a4a6Sq0xQsTnlV2s6
         VNUqbXGCwV+NTVUk1b6Gq9BWNfUBxtZuG9WfvmZnDWYHWpuap+o29Ko+r3jrjOn4WUjI
         xqSSR4sHILOt6e0/9w/cy8N0SAvwGF9ah0bUBNayeZe4nmcfhtIWXTytPu1krGXWOxlo
         4g6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCv8Vm3E5bnMX9AUxXBz0tqO2Ex0WNF6fvpf+abNb3w=;
        b=YBH0Jppk+89n9Z6FJq8yuobCuZRx2wQ0GgSS3O38/AMf9mhgsWB+/tR84nEnLq+OO8
         ZDcDz5/83H0q09e4XgEwIqbaIbBpGMKDEmp8UC9mFzV0zX/qbDKvyQz0roe6ES6XR8Mj
         ExcCGlbGiW3yNR92+kcXiJHSMVfJwmV/mwR5cPuNczlzuLi6RcsujGORwMFpqMIoJ2Ie
         YU54HTrkW0RBL/TrqGyCksUwssHJ/SucMbN6C7knwmbnXPfNi09Btat6q7RpbDUsz0Bx
         QgNEsGB/1eSTUnIRfFb8F2XHzSBR493qAhZUKXJFcXCexTBETpperh5fc5N/pixm/Ckf
         R9Gw==
X-Gm-Message-State: AOAM532Kj75bzy8q1VrivLCE7BsAiWR4QnG4SVgJMGR4/0ZZ9gDm5YmO
        sO63mdIf5QMSIAkfLOmwK2piIGSHZWL0mg==
X-Google-Smtp-Source: ABdhPJzk1+oCFZkXSDjXkKJJFgCs/xj/KmvKIfI3s6T1nK7kKOWBYivrFq6x4iLmXQuoHq4ubcJTvQ==
X-Received: by 2002:a05:6000:c9:: with SMTP id q9mr17882106wrx.259.1610811369271;
        Sat, 16 Jan 2021 07:36:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm20008855wra.53.2021.01.16.07.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 07:36:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/11] archive tests: use a cheaper "zipinfo -h" invocation to get header
Date:   Sat, 16 Jan 2021 16:35:52 +0100
Message-Id: <20210116153554.12604-10-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210114233515.31298-1-avarab@gmail.com>
References: <20210114233515.31298-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an invocation of zipinfo added in 19ee29401d (t5004: test ZIP
archives with many entries, 2015-08-22) to simply ask zipinfo for the
header info, rather than spewing out info about the entire archive and
race to kill it with SIGPIPE due to the downstream "head -2".

I ran across this because I'm adding a "set -o pipefail" test
mode. This won't be needed for the version of the mode that I'm
introducing (which currently relies on a patch to GNU bash), but I
think this is a good idea anyway.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5004-archive-corner-cases.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 3e7b23cb32..2d32d0ed12 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -153,7 +153,8 @@ test_expect_success ZIPINFO 'zip archive with many entries' '
 
 	# check the number of entries in the ZIP file directory
 	expr 65536 + 256 >expect &&
-	"$ZIPINFO" many.zip | head -2 | sed -n "2s/.* //p" >actual &&
+	"$ZIPINFO" -h many.zip >zipinfo &&
+	sed -n "2s/.* //p" <zipinfo >actual &&
 	test_cmp expect actual
 '
 
-- 
2.29.2.222.g5d2a92d10f8


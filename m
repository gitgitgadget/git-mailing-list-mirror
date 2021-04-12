Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305DEC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0398561241
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbhDLLJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbhDLLJk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:09:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD7FC06138F
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:22 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id w186so2029462wmg.3
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=swSie5ck3VhtKLBfrJHlPXMiVBO9s/osIov1znO1B6g=;
        b=d+QGOkxgSimREhMqVkaweQ1YUodHHlWKIAIR61lMOFfX8mfmwBBCCydHnItLGP8dzS
         uhcNTvP+JS4qBVWUanMMrDk9kIkjNBQEFpE45447vU1bx08cLzgEQbJC35G954z7B56O
         pDQcPsIPLSm1DVGl8S0e0u3//8FPIbCu4/P0zv9i++U4MFWYbRgZ4P59SIeuT3N/s4UL
         v7pOnkuAOB3K8907LN3azn1W306TXhTyiEJ3S5PY+aPd+d+yPiJCtt2oBrGdyOVmZoZr
         QrWLiqc5Abc0A8b6j690rqbqTq0sBCpZDE1/4GXlU5lp3JiFQ/IY4T8f0SHOV+uPAb/j
         r1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=swSie5ck3VhtKLBfrJHlPXMiVBO9s/osIov1znO1B6g=;
        b=V2SaKxwD6XsZNKjbieERog7ugRnRTRBp++jmKE4WfeyObhcc2Cnh0SzQcvSUFZKgJN
         yXuJZhU/i2BiWCCKZAFiWXQbzqBSL/WPksA+6G2AkGeQjEoUZtfUZ7Tz090sgUNqkPKO
         /vZmHpBwGRYACtBNV0U039iBix+3iZc6Q+/ppMN16EzSFfMSIPqqWxpNDXJ8vyln2G5u
         BbBhZsTlCE3AqLTZ/fkn3JchEpzayspLda4N5evbePZ0iCOQH3i4xm5nqZAi7VmLPCox
         sEoA5kTGzIV52LFpZK7jQNAxZ9v/3bnrgRMVsIp1D3h+cXrPHmDk6VNqAQLhraq7EtXx
         Y99Q==
X-Gm-Message-State: AOAM533qVFUZ4dFVcUYCzKmLUJEKpi4lLdYE3Rg9uDLgup+L5Jf1+QdA
        bRtYjqrpQKxU9Mwsg5+sMtuHyl2pi5BgIA==
X-Google-Smtp-Source: ABdhPJy/HrceZWuNvZ0ZiKD2Y57uQPcbikCw6TyhEovIGYvV/0P7+snUh6aB/M4jt4VHhU9FA2f7zA==
X-Received: by 2002:a1c:2587:: with SMTP id l129mr25944124wml.135.1618225761429;
        Mon, 12 Apr 2021 04:09:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm18158744wrh.91.2021.04.12.04.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:09:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/16] test-lib-functions: use "return 1" instead of "false"
Date:   Mon, 12 Apr 2021 13:09:03 +0200
Message-Id: <patch-14.16-b6e9d971b40-20210412T110456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a few functions that relied on a "false" being the last
statement in the function to use an explicit "return 1" like the other
functions in this file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2518a9b8274..c46bf0ff09c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -763,7 +763,7 @@ test_path_is_file () {
 	if ! test -f "$1"
 	then
 		echo "File $1 doesn't exist"
-		false
+		return 1
 	fi
 }
 
@@ -772,7 +772,7 @@ test_path_is_dir () {
 	if ! test -d "$1"
 	then
 		echo "Directory $1 doesn't exist"
-		false
+		return 1
 	fi
 }
 
@@ -781,7 +781,7 @@ test_path_exists () {
 	if ! test -e "$1"
 	then
 		echo "Path $1 doesn't exist"
-		false
+		return 1
 	fi
 }
 
@@ -803,7 +803,7 @@ test_file_not_empty () {
 	if ! test -s "$1"
 	then
 		echo "'$1' is not a non-empty file."
-		false
+		return 1
 	fi
 }
 
-- 
2.31.1.634.gb41287a30b0


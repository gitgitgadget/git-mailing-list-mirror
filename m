Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7977C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 11:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245481AbiCHLfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 06:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiCHLfA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 06:35:00 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD5C3D1C5
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 03:34:03 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id h196so867313qke.12
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 03:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AtgL04H5mAdbbAx+dZ6h8mPak3HKoqWzRwEiZnt/ZaE=;
        b=YyXlDNhou5Ryzk7DyjV/HLZFqZcCBtbwmaix/OmaHOvkEGeYPpDP4ceUeMi7K3gxun
         XO+5lcDauJtIusHDFSRM3N4GR8SIw4Kh76IduuPbK+OmW3idbLHI1htKuzkGXFOlo07Y
         DMtHvKcJkr7KsLobJB6KkwPnxAg5bLAropg7Laz677wHGSdOxj6xlTUN3cw4cntAs+sb
         wo7QWJynndnet+l5SQbZuTDmcrNljMuXwND3bF8Jx4IcEnXLhSMxb3Qf/za4mmQCSHyV
         CiJbtGtjJ6dNYfQJMKJsJtfVpLZNJNqDSt90b1+ntmEdZ1Y98w55KZM2Ecf5hlpZSOSs
         fD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AtgL04H5mAdbbAx+dZ6h8mPak3HKoqWzRwEiZnt/ZaE=;
        b=DMS3o4653wuDRk79ELIGg1Ra0PqhCLLgUikyVRd4uZslLCZSdtG6i19um4cqv46cxe
         86AMxa2C1HhilVzW2B1uKCjK1/wWHZe4l7sQ1YshKheoPKATxnG3OADofRN7chT8Q7gB
         V3LwJQtWSrlvLS7R0csXMsayoTZhQNad5uBJ0kOfATZWzxPSufqfi3E136UEIlqBku4M
         zRNpJ3m7JjEG1BqPXI57JlYyjXkj/PswGWw7RnARmF63c31orTGQWzYmv7978gmPcjfE
         lWwqapBh4pXThe/eNn0GuLuhqqR77N/ZQD1+5bas5Ba6ibE1k+j+e4pDCfJjFxx3dead
         yCmA==
X-Gm-Message-State: AOAM5309VJ7iCJdAzUvKqv8nQMzT103yigEvDyUhEyzVbbVdw9bxcSLA
        xqHY/NQCxmMqO631QAVrm2jXUNzJis4=
X-Google-Smtp-Source: ABdhPJxAmvclN92LxSne6OHk0YfMrIvIrb0ernfv7CGy/csSXTFs5Bf9zGzmmg+hpjyHttJMl60x9w==
X-Received: by 2002:a37:6c43:0:b0:46d:cca4:ad8f with SMTP id h64-20020a376c43000000b0046dcca4ad8fmr9773224qkc.107.1646739242438;
        Tue, 08 Mar 2022 03:34:02 -0800 (PST)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id a6-20020ae9e806000000b0067ba5a8a2a7sm1480305qkg.134.2022.03.08.03.34.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Mar 2022 03:34:02 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitter.spiros@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] test-lib.sh: use awk instead of expr for a POSIX non integer check
Date:   Tue,  8 Mar 2022 03:33:05 -0800
Message-Id: <20220308113305.39395-1-carenas@gmail.com>
X-Mailer: git-send-email 2.35.1.505.g27486cd1b2d
In-Reply-To: <20220304133702.26706-1-gitter.spiros@gmail.com>
References: <20220304133702.26706-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Restrict the glibc version to a single version number and compare it
arithmetically against the base glibc version to avoid accidentally
matching against "2.3" and better supporting versions like "2.34.9000"

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/test-lib.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8e59c58e7e7..f624f87eb81 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -518,9 +518,9 @@ else
 	setup_malloc_check () {
 		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
 		export MALLOC_CHECK_ MALLOC_PERTURB_
-		if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
-		   _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
-		   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
+		local _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null)
+		if echo "$_GLIBC_VERSION" | cut -d. -f1-2 |
+			awk '{ if ($2 - 2.34 < 0) exit 1 }'
 		then
 			g=
 			LD_PRELOAD="libc_malloc_debug.so.0"
-- 
2.35.1.505.g27486cd1b2d


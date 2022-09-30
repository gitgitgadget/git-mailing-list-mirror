Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EAFC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiI3LgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiI3Lfb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:35:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A74F11F7EA
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u10so6258063wrq.2
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iregKvatRXiEpm11j7H3msTugMzyvHx4kItE3juNj3Q=;
        b=OCeWNtJg+fRg4J6E7vmmqDdbhD498NHgnOlyX9tn9zqdrRlhh3snAXS/tQazppGB6j
         8XtqLuomIJVgxxhxC2H00KJh//ehXhx681onnPu8b5b8/ybMc5lRrkUdctEV7bitf8Kb
         MwkvfjdxpUvPLf7HwJs3mMKuAkHz0kPy6QpnuhOA12ioejVIW2R4SjuhTvt05HWOgIje
         W/iJEUi+8iLWWMvljwPMDNYD79g2WGY+ccJaVYqJZvJwaLwF3Sazc/4UVA0R3iBMQqi8
         gL7P4nvC1wO1SIETVaNv5hd99xuHtq6bnZkRPdCqkdIsV/QveUSoAoEbVnFWtNMPyAKO
         HBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iregKvatRXiEpm11j7H3msTugMzyvHx4kItE3juNj3Q=;
        b=A2od+2IcdZ/D5sLTs/XYQAIUDkhT4j1Eq960fU9U3yBE2WgfPCr8ZLFEA7WAv06LjI
         8USzB6jI8AB6cvIbybeTvO+leG/CsfYeC9GaUrSxJAvzohYL7/uvOJHF694XfWwZ4KT7
         IQAzolE2fbrODpKXsDRxzEDoywMcWWSJNNhnuExaD3jIY9CCpUCfcMikkeIsI4Hjhcz5
         F0ElpsaISCeOitXFkdSxNXAwOyDxTA1sX148tSXwzmho4vKmsnu8RUCtaqVogVibQ3Zd
         Vg87mqs4XZ2LattSz/QRYCOk6FuUFARS9R+s30xctQml0+K00rNPf89JCqlYoFKTkqQT
         8lpg==
X-Gm-Message-State: ACrzQf3x503URaLDGpV1vXqYVEawvOL2WvLVdKGtde/qcRoR5mxC/5hb
        ei1GelStQ0CUuh3k1PY0kncBvmDh7+vsmw==
X-Google-Smtp-Source: AMsMyM6Y9hdJYWhNseD5K844qoBnm6BXl+U1D9P5rWzVezZKLm7+vrOEPzfn/mOLx3RI7vB6KKrc1w==
X-Received: by 2002:a05:6000:184d:b0:22a:7428:3ae8 with SMTP id c13-20020a056000184d00b0022a74283ae8mr5135540wri.441.1664537296953;
        Fri, 30 Sep 2022 04:28:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm1760799wrc.62.2022.09.30.04.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:28:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/15] hook tests: fix redirection logic error in 96e7225b310
Date:   Fri, 30 Sep 2022 13:27:58 +0200
Message-Id: <patch-01.15-2e213e70038-20220930T111343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests added in 96e7225b310 (hook: add 'run' subcommand,
2021-12-22) were redirecting to "actual" both in the body of the hook
itself and in the testing code below.

The net result was that the "2>>actual" redirection later in the test
wasn't doing anything. Let's have those redirection do what it looks
like they're doing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1800-hook.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 43fcb7c0bfc..2ef3579fa7c 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -95,7 +95,7 @@ test_expect_success 'git hook run -- out-of-repo runs excluded' '
 test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
 	mkdir my-hooks &&
 	write_script my-hooks/test-hook <<-\EOF &&
-	echo Hook ran $1 >>actual
+	echo Hook ran $1
 	EOF
 
 	cat >expect <<-\EOF &&
-- 
2.38.0.rc2.935.g6b421ae1592


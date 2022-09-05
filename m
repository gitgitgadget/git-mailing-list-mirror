Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A90ECAAA1
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbiIEI1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237626AbiIEI1U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58D913D5D
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n17so10294317wrm.4
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ogQ1TKi+z4KwhBjfbAmZpy1CFOEn5HJ82wqB5gyIBfw=;
        b=VsgAutpXsC+FjHj0+7MSGfJPTHy4yh+G5ttt3nMcZM99Y+2RAQzPRV0CwCJzREInTQ
         D9mxOggbcwXxTG9gQBztevAXdrjs3abNyxET+x8zFbysYiVwyUUmHlWyVk39xEbiId3R
         V+UYnAt/NgbcstfvmsAuvPLUU7wCFJ/pDosyrHuppDehEvliehUBfU83xCeFT+7jj9vw
         0wmCechvc36AeIApWaQWJHQGiaJEX7NeVL6etwtS3AlM42KyVInBNIDx/LCoV7M42Prt
         8SDHs2WLRoHplALAQfUrabO3/+0ECJb183Vdl9Hi5MVcbqmVBVx0zRol2sVYFycXPCiu
         zLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ogQ1TKi+z4KwhBjfbAmZpy1CFOEn5HJ82wqB5gyIBfw=;
        b=GdQka5xU+3Mt0gT55v8EcplFx23lbTlsZx0y0XKe9p1z9QQ+rHU+Vw0nshMjRR+heH
         t2ajnsiy3KgiOJ0DbQ8O9VAdF9/A0zBTVhVDCf8cemfM//fyHPBT4JfSkD+3Gl7ISoy4
         DHMzOL0rQQ1dbL2Y5gFFm922F2F1i6Sqc1s3EzLmjNdVtDFBC8s+WJNlwlWAeMMCnYK+
         Az0OQtBzYfJlOQEAF3NiJSw9faNxFokwNeiKoJb/xNmPaa9Pnyng7O/ElJuYAVMsOTA/
         /pqUlki5tQvaku27WpXPnrdYR3ATkp7AiXfnw0itNzCDZwPVs4UHO6qPs57vO6W7kYmJ
         v85A==
X-Gm-Message-State: ACgBeo07/GRR0yEfKZp/RNpK4VM9g5/8Ma0ul+sOWk0pvtK0JOF8QpGu
        IflJeLhlDjvhXkKQC0nCjo9kEWxPC5uVpw==
X-Google-Smtp-Source: AA6agR6NbiHZ7lqjKaipEowe8eRSExofBBDOcCRhGgD+YaVnB1o3J/aOGMR/fIAUQ41otoKgaRxDWQ==
X-Received: by 2002:a05:6000:381:b0:221:7540:b1ee with SMTP id u1-20020a056000038100b002217540b1eemr22985295wrf.307.1662366427003;
        Mon, 05 Sep 2022 01:27:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/34] t/helper/test-proc-receive.c: use "<options>", not "<options>..."
Date:   Mon,  5 Sep 2022 10:26:27 +0200
Message-Id: <patch-16.34-1adbe9b7d12-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As in a preceding commit use "<options>", not "<options>...", in this
case there is no *.txt version, but let's fix this one too while we're
at it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-proc-receive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index cc08506cf0b..a4b305f4947 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -6,7 +6,7 @@
 #include "test-tool.h"
 
 static const char *proc_receive_usage[] = {
-	"test-tool proc-receive [<options>...]",
+	"test-tool proc-receive [<options>]",
 	NULL
 };
 
-- 
2.37.3.1425.g73df845bcb2


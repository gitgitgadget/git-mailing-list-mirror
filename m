Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539B6C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiI1Ikf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiI1Ijz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7476170C
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:53 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m4so4292745wrr.5
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WUO2DGBrvt2ju4p5utb/ICOsmXSOtNQg7to3IlnhnyU=;
        b=KtPAtyT42xqjY2wbkDCijZCB1ndF0UBxcd6Lt4YfGBUsHFD2RtZsrNi3BvS1HB6TJj
         VOIHOOcHovX/DtMbYdswnQBn5mttPyXmHL82AQimli1RwjSCoKd0ZpJ59O1sa3r85a5Y
         +fim8FcZ704Nk1Zoy4uypuhwiwdqb5JAfjPL83U6SDctAzupIKF006R+LCFwUPHvv1zQ
         f8D9WJbHpyu9mvfNBTcZTs8WS+dKYxi2XwN1O752/FVI1KtMgH9QGCO02jIGrlIv0Dy9
         te6h1OmYRfS2Zg720C6s27l1kZf39OH5hl7m/S4JWfxy64G9eZFs7stQj+Th+V4W2AaU
         3+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WUO2DGBrvt2ju4p5utb/ICOsmXSOtNQg7to3IlnhnyU=;
        b=OC5b3Eqhtp3uvYv8Byx8abUyYIuc3eyoeB9u4clX6Mdc/NQMmD/ZypswX/jsMZN1CG
         raQbqNzcTYuNfrwjlHyvBVLUP2v0+riw2N850s4fR6+bpgt/UBrca+I3PguxAkVTQO0G
         rmi8Wu4tFPA04z1lLo3BK9r2+qj2ysetq2Vy7dgbLAOduDbg0p0QuviBP4mQ0VD8v+S7
         3UMTlpWSRfs4yAtbdhlrNVRpKcPjXSdg0zV38sM+bjgX3ZiE15LOQLxF7cgEDJO+MKrv
         zSh1sADcWlt14rTcYAFw+s8+QUrYhWG8FdprApl1lp/IZl7njYmg+10CuGhiouVsaT4C
         0fxg==
X-Gm-Message-State: ACrzQf2+JgWgMasXOaRPsrO1MA0o21hr2rUZdY8FXzWhfnY4uT2ZwEn2
        rXQGUMPlkKgphlkzoyci04XtSSYFlMO6rA==
X-Google-Smtp-Source: AMsMyM6lG/Ds77yFRyDR0Fu6f/xhYmKicdIiI44p/bQqMkz5eo13eSpWoT+X0LOd00EuJp+3RcHeJw==
X-Received: by 2002:a05:6000:1d8b:b0:22a:c046:946d with SMTP id bk11-20020a0560001d8b00b0022ac046946dmr19810068wrb.249.1664354392802;
        Wed, 28 Sep 2022 01:39:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:52 -0700 (PDT)
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
Subject: [PATCH v2 16/35] t/helper/test-proc-receive.c: use "<options>", not "<options>..."
Date:   Wed, 28 Sep 2022 10:39:11 +0200
Message-Id: <patch-v2-16.35-8cc40e09124-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
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
2.38.0.rc1.925.gb61c5ccd7da


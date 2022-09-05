Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A66ECAAD3
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 18:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiIESuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 14:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiIESuS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 14:50:18 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208BA27144
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 11:50:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id nc14so18681051ejc.4
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=gGufFw9ORLKrHuLHAK1W9skwHA6cPxS+PgUQE22kywk=;
        b=F0+F+CIfzMDGdqFynFyawAw6z4ZzX/1kRwgic3p/0yInoceLmkKu2N3jCl4Z1eZZMn
         +YV8ROtcsrrrt9L3ky1mZDy/komgDy9PheCoVdTmn7hdTJv8tmP6fzkEFq4Fs4MZigNL
         eoFB2JRJ4pz4q+8S7xuc4V0YaO4qP1/Vk8BAciLH7C8WfMMOh56WHuVCSi7MkRJO1Z6Y
         o2iiulrb1I0la72iMzUIwxt54JzniJcSSzn68PQ2FGbR4/QCCWYiIFwWIGbiwlwFvTwh
         uOBopBqFfBgXOfyA2pTKbnwcWixZLmCfde+cgOp56NhthkRXRkAsem86saosbWraxAug
         1rUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gGufFw9ORLKrHuLHAK1W9skwHA6cPxS+PgUQE22kywk=;
        b=12Am0NSkovUw8hyR8UlPU38VahOh0fN43iw3Hb7HI6C2Qaq3LjoiQNnhOOv8+qq6kV
         WceUS5IQ8JB+nhLn6BN+U4i1S+2m5EZxGUAik7EObS+JJi5XkY+s2gIzL0sj8hpa3/hZ
         vm8Kzq7We/J/QMgToAuqlHnYpLbyhbSh8zCIeN3fYNZ3kaATvjBKZfl37Eh1XvFH4P/v
         kx2+8U2GTUOKitzJvT6IKFChIpuy6olSKXTtD5BeKhgoxJcx+Spfs/BO20GtdtugZrHg
         b0/6lhnisaLYAXS67VmbE8E+kKMMgIszmih/3jGw+yOHBDfdsj1ESTnJjR8VDd200NGp
         4Khg==
X-Gm-Message-State: ACgBeo1ubyu1ZxAmPCQGGxqMKrZEhiPlh6juvT41ViZ3nKRNr0LhGBCo
        NTtiCZimbao02i+Eh4djy2EGgLQszuc=
X-Google-Smtp-Source: AA6agR5bw6qenGw4kMA625lg528Cr2HhFtzeJS8UhAcPLapo9WVaeZFM1pdDDg2KoUrEv5Jvfj4q3w==
X-Received: by 2002:a17:907:6e18:b0:73d:63d9:945f with SMTP id sd24-20020a1709076e1800b0073d63d9945fmr36849522ejc.12.1662403812397;
        Mon, 05 Sep 2022 11:50:12 -0700 (PDT)
Received: from localhost (62-165-236-110.pool.digikabel.hu. [62.165.236.110])
        by smtp.gmail.com with ESMTPSA id b7-20020a05640202c700b0044e91d8ccd2sm1964567edx.50.2022.09.05.11.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 11:50:12 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/5] t0040-parse-options: remove leftover debugging
Date:   Mon,  5 Sep 2022 20:50:03 +0200
Message-Id: <20220905185007.9042-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.3.989.g4c3dfb3304
In-Reply-To: <20220905185007.9042-1-szeder.dev@gmail.com>
References: <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220905185007.9042-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t0040-parse-options.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index b19b8d3486..5cc62306e3 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -500,7 +500,6 @@ test_expect_success 'KEEP_UNKNOWN_OPT works' '
 
 test_expect_success 'NO_INTERNAL_HELP works for -h' '
 	test_expect_code 129 test-tool parse-options-flags --no-internal-help cmd -h 2>err &&
-	cat err &&
 	grep "^error: unknown switch \`h$SQ" err &&
 	grep "^usage: " err
 '
@@ -509,7 +508,6 @@ for help_opt in help help-all
 do
 	test_expect_success "NO_INTERNAL_HELP works for --$help_opt" "
 		test_expect_code 129 test-tool parse-options-flags --no-internal-help cmd --$help_opt 2>err &&
-		cat err &&
 		grep '^error: unknown option \`'$help_opt\' err &&
 		grep '^usage: ' err
 	"
-- 
2.37.3.989.g4c3dfb3304


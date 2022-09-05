Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F0BECAAD3
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 18:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiIESuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 14:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiIESuS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 14:50:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6A22715C
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 11:50:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kk26so18646997ejc.11
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iTDul9hY7q0ttDUoDwJ1eN9GNiXREVuYiuBFfrgXw6E=;
        b=Z0XYWhZY4szyLwbjpBYcAb9vI1Kg3maav8NiQPBV6Y/3D2sYNkba1dlroqqn4YWFZT
         Bd3YSSlr1fagG0J2Dae4VVemALhTKxGb9aSQSz0UXZVrOspXbgSBp/3vlCJB3v9LEDUR
         WjDg36NKbSOqz+MW/ddP34Ea5K5tlTRFHtC6jaXaSustmja5aDQGjYo4o6geagjlzgOe
         DSEJr/OvR4tr7gI3aVisPaSAF2iklyTcZHZ8Q5mZhY9j9w/4dMxAPXjXfA6Xc79rrS7P
         4vz4TeaWPm8b+fkqvPTULPobb0Frnr/MWbu2pDhVyWaWDUspg98yRBcCeTfc4Nl0Sbn4
         Y4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iTDul9hY7q0ttDUoDwJ1eN9GNiXREVuYiuBFfrgXw6E=;
        b=Ylf3KOVODHR9qFD0fm7iivDm2HtbH4SHaZDCby757sP6xex1VKi1Tb61LKFcfa5owp
         3Y02bYNhS+SYwg280I0PbGiWr5+n7r1itC2MCUNFetCOIqNY2Wm4stuBnDos4GVWoBFy
         wFYKGj7E6MQIQ6Q14uVHDPRYWIXpFJFJzyhL7gU0w1JTcsNaks6Occ+DboKDCjin3tUA
         fuFibMirNjglglp4bUXc35am7BqRoOHWtVIbj0kwxHASKN1a61K6z6dXqn6f+DdgB/08
         Vj8WZnfBKJ6OiHawoY8guy1IQE6q8STmeI2zd7XNKZGnDzkba8PIUqqEXNEtc1PzPTqB
         dtcg==
X-Gm-Message-State: ACgBeo1Wwl064ABKnRGr/Y/h2M0SKHDtx8cHk0ZQTZ8JEkE2ppvsvPOn
        u5+LxCvPMM5xOpMb1e8Kue5dXB/kN6o=
X-Google-Smtp-Source: AA6agR5FWb4L/17Og4lAFE9qnNxKp5LctBZ8naHpCmAZsw0KBQR7FvWHHIAF2I6HrfSpUEbJgeY8rw==
X-Received: by 2002:a17:906:eecb:b0:73c:5bcb:8eb3 with SMTP id wu11-20020a170906eecb00b0073c5bcb8eb3mr36870498ejb.284.1662403815575;
        Mon, 05 Sep 2022 11:50:15 -0700 (PDT)
Received: from localhost (62-165-236-110.pool.digikabel.hu. [62.165.236.110])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906300a00b00738795e7d9bsm5357069ejz.2.2022.09.05.11.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 11:50:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/5] test-parse-options.c: fix style of comparison with zero
Date:   Mon,  5 Sep 2022 20:50:05 +0200
Message-Id: <20220905185007.9042-4-szeder.dev@gmail.com>
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

The preferred style is '!argc' instead of 'argc == 0'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/helper/test-parse-options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 9fe8ce66cb..506835521a 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -255,7 +255,7 @@ int cmd__parse_options_flags(int argc, const char **argv)
 	argc = parse_options(argc, argv, NULL, test_flag_options, usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (argc == 0 || strcmp(argv[0], "cmd")) {
+	if (!argc || strcmp(argv[0], "cmd")) {
 		error("'cmd' is mandatory");
 		usage_with_options(usage, test_flag_options);
 	}
@@ -313,7 +313,7 @@ int cmd__parse_subcommand(int argc, const char **argv)
 	argc = parse_options(argc, argv, NULL, test_flag_options, usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (argc == 0 || strcmp(argv[0], "cmd")) {
+	if (!argc || strcmp(argv[0], "cmd")) {
 		error("'cmd' is mandatory");
 		usage_with_options(usage, test_flag_options);
 	}
-- 
2.37.3.989.g4c3dfb3304


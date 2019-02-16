Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 014AC1F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfBPLej (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:34:39 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43778 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfBPLei (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:34:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so6073413pgk.10
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mx3YU67jcYE6ZV/aAOaTSKW9TuP6stK+x1JgVNbadUU=;
        b=CrlVE+y/moSvhJZUimyJ8fsV05ArFMuW8elkD8D4PETvv1be8bEANhgLvZDmr/MvJn
         Bn6IBTX2ic3RkI/p3zaW13MaiRHyqHEwBjOYkNlEyWicyPqiv6hLPHuO0faMLRGzG5Rw
         DM19lepdLp3Ur+/ZNJeF3npSAuMTe/PrOv9ofaAYdjGPS9k5vG4QgBkyTrMesWG19XNV
         kH4z61VzCcYpTuj/CW3YPe+3hEX6+KSyx6SLtA+pYxFDa2LTV5LCX5jYJJD6dME48Pzh
         iaz47upuVQDU4XHVLaFItnC0+tj+3dHsBJ9r48sV/LncGeOFZvIsZwQd4gEzTOtEIfuD
         FL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mx3YU67jcYE6ZV/aAOaTSKW9TuP6stK+x1JgVNbadUU=;
        b=fItg5IPPV8w7Q+QJImX4QUG76QE8Cmils90q1NQuplp4PmA7j7IDJupKZ2F7GHdT02
         FyoXUfoXLP5imTj8PBjF40kovNJIyBK23NzC/eqMbAi2rQA8Nq3Pz4d9UJgSoeLvTvb6
         MZgwDbRAN20lM0sI94wzqspOZwVXcAqYr+zFH8GYDqxJfKYTKKm/8tMRhUBd94g4m2ak
         VPC4IrLUvaIROtbiBL8rtvhlGENOAAydrVO7SXfxb7ATPrTFUnXhnuU4MZyVZ0jSUqt/
         St+lbvfcnpu3b7OLp63aAATf3xFV5dMSiy3iKEd2fvHQW2C5L3vzimDjJOBkpdgBoMc5
         hAPQ==
X-Gm-Message-State: AHQUAuY+zr4KzlWdL2bDSkJxvQSULKrE6OtMApEksbfsJIIRTFjgYXKt
        mEJAghddFWxnmOoCFYXFM4E=
X-Google-Smtp-Source: AHgI3Ibd95viql6BEeTbH0uHCniADrQQp81AlSFoaub7V5FiinwpO2dxkzEP+uv09Oc+rXZIEMR8aw==
X-Received: by 2002:a62:4188:: with SMTP id g8mr14853247pfd.205.1550316877850;
        Sat, 16 Feb 2019 03:34:37 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id f12sm9539981pgo.13.2019.02.16.03.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:34:37 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:34:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 06/21] diff-parseopt: convert --patch-with-stat
Date:   Sat, 16 Feb 2019 18:33:31 +0700
Message-Id: <20190216113346.25000-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190216113346.25000-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
 <20190216113346.25000-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 0276f25200..b9811aefef 100644
--- a/diff.c
+++ b/diff.c
@@ -4921,6 +4921,10 @@ static void prep_parse_options(struct diff_options *options)
 			  N_("synonym for '-p --raw'"),
 			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
 			  DIFF_FORMAT_NO_OUTPUT),
+		OPT_BITOP(0, "patch-with-stat", &options->output_format,
+			  N_("synonym for '-p --stat'"),
+			  DIFF_FORMAT_PATCH | DIFF_FORMAT_DIFFSTAT,
+			  DIFF_FORMAT_NO_OUTPUT),
 		OPT_BIT_F(0, "numstat", &options->output_format,
 			  N_("machine friendly --stat"),
 			  DIFF_FORMAT_NUMSTAT, PARSE_OPT_NONEG),
@@ -4973,10 +4977,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--patch-with-stat")) {
-		enable_patch_output(&options->output_format);
-		options->output_format |= DIFF_FORMAT_DIFFSTAT;
-	} else if (!strcmp(arg, "--name-only"))
+	if (!strcmp(arg, "--name-only"))
 		options->output_format |= DIFF_FORMAT_NAME;
 	else if (!strcmp(arg, "--name-status"))
 		options->output_format |= DIFF_FORMAT_NAME_STATUS;
-- 
2.21.0.rc0.328.g0e39304f8d


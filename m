Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D6231F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfBPLhl (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:37:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46118 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLhk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:37:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so6065365pgp.13
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mx3YU67jcYE6ZV/aAOaTSKW9TuP6stK+x1JgVNbadUU=;
        b=QViyXfcS9ph+anGAgvTMHNs8H83oxUGwNWWEMpGpfA/M8fWvEgXb0WAT0bFWFJUQjO
         A3MCoaOO6qg13CTEo3Zwz1SOYppOmdKm0vMaNTaYNbjaKt9Z7nl1p3i7VuvKNksfWknY
         JArRkEDWHxEUahuz0vcS31xcBWWuMtj33O9g2johe2aKGOuLCUf4S8qMVBvHR1pYK2Zl
         P22KGEdtxFvWqW44K5F1luc9ismpIaJo/Nub5n9+meBIPcvaNu8oJWAE+UGGluVjACES
         aoZsPLpBUFHDVIZfuJU4Xl0ly97g9aZI6QCQrEnYZ1tcA5S+jE+v9cqUGG7Q65+YS0HA
         dokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mx3YU67jcYE6ZV/aAOaTSKW9TuP6stK+x1JgVNbadUU=;
        b=h1hhK9F7mh8Q3ZUm/J6Xar1Tue7o1dl9/A9lJqPmeFSt/XIiaiwgFRWeVa/KA5wFB1
         zluuQAAAoL1m9RcsE4JQiDLk+HIq4TwbGNOMeVR/9eTQdRwuo72BmrILrpQGugvMBEJW
         TDeql5pFkK4Keq+xrh/TybH1gJQTkXdSHePFHS8rANMCtEVRPbnEQ+Im+lznmye3xEOJ
         82Wmr9w0XcoJhkyGb6agQSz+vuX9LZ112xwjrSt20vAqqTSTKn096/ojU/4jP3sOUuQp
         K6ZwtxfSFgsv12upadqlE5Hqdaxs6DS9YWZf9d7LoCTstvhhSXNT79u4m7JzaRGrLfvy
         hnaQ==
X-Gm-Message-State: AHQUAubPbNhM1UYR0MseUonC7WbnmNgXLuwKJjVsGwoaPuiqQa/y7Oqg
        WaTr6AaT+8wz0EVcvU01D7s=
X-Google-Smtp-Source: AHgI3IbfPe3WzhQjUaQncmAkxtA/DmoUcdniGptFWGpfa5NEMAis3ezDDaKakHDNc+2mASmZ0sOeDw==
X-Received: by 2002:a63:4005:: with SMTP id n5mr9507173pga.86.1550317059818;
        Sat, 16 Feb 2019 03:37:39 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id d16sm9424314pgj.21.2019.02.16.03.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:37:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:37:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 06/21] diff-parseopt: convert --patch-with-stat
Date:   Sat, 16 Feb 2019 18:36:40 +0700
Message-Id: <20190216113655.25728-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190216113655.25728-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
 <20190216113655.25728-1-pclouds@gmail.com>
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


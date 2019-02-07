Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4DF1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfBGKdz (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:33:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38180 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfBGKdy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:33:54 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so4310203pgc.5
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ocb+kuLT07Kohk5lmbSpXj0JAcesvUe1gCKS1iRU19w=;
        b=nF9hyoNqfDjsr0m3EkAVThGBS4XMHlRT9cOlg1dtgWK6XF+doBhFQ7lufBZoWjUDlq
         xEJveZDh/YPQkywFIn9x0/I1YLcOpoP7BYFaAkJEqZbPaUOifohTpmDmLmtk4+Z+4y8Z
         SQ3PY+UzhwzPVMSi0hGDo1E86fHHJ0ri5jTONzlUove3oq/J3Lu7Lcanwp90IPNYU5uu
         cBj1NJkCEE4SG8TEFyHBL5H/l0bXoun9OG94Y/Nc49O93+wj40HwqTvfPBZ8+e0Y6xSY
         DUgVma3NCl1fs4/TBv62Ycf4tdkmZ0rc34EakW5Neo6yK1H7sZWv53guXmixv1NV1tTE
         CVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ocb+kuLT07Kohk5lmbSpXj0JAcesvUe1gCKS1iRU19w=;
        b=MWQPwwQtmIiof4TqhdPhENOH+AFp4ZezorQm6HaJg4Q+f99EkvPRtnXo059juvwduM
         CB2hduCJ5E7IQIXbgokNuJTJfhzD7ONqRF4tTDF9NtIoG87k8PTnnZ4vYG/MB3lCFZrh
         RJvFbLwJZXpG7ntWBK7TnHjmaGxFFHVc0nTicslOYtCx2acWiJK7VCZxC86VH38FnQbM
         kKEiv7LUIKRBMqx7hnSv4oOzWW2+447yZ2h81Gm2TBQ4j240dMeA37OFPf7Mjq3rwOGC
         P3lB2dsU/r4+thmxDYAv1YXukchTQGLNoIXy/PQqRynw9sCFHOl6Z+ChdszCXxISgrFK
         RZCA==
X-Gm-Message-State: AHQUAubvX3hpwvFBHK4VqLojczYw2qPjah/LYBaQxKv1BjNVEt4xEpLH
        1O6IF48DasRtSp8fOLUWOAZJlvId
X-Google-Smtp-Source: AHgI3IYdBH8tvhkXrEnjCxQ0lMKdfhior8WNnwCQzQYMCDNivcB7te9Xa4WN2NHQrjgzGsNshiTCJg==
X-Received: by 2002:aa7:849a:: with SMTP id u26mr7521685pfn.157.1549535634131;
        Thu, 07 Feb 2019 02:33:54 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id p2sm11958697pfb.28.2019.02.07.02.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:33:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:33:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/21] diff.c: convert --numstat and --shortstat
Date:   Thu,  7 Feb 2019 17:33:07 +0700
Message-Id: <20190207103326.10693-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 12e333c67f..419b6ac4ae 100644
--- a/diff.c
+++ b/diff.c
@@ -4905,6 +4905,12 @@ static void prep_parse_options(struct diff_options *options)
 			  N_("synonym for '-p --raw'"),
 			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
 			  DIFF_FORMAT_NO_OUTPUT),
+		OPT_BIT_F(0, "numstat", &options->output_format,
+			  N_("machine friendly --stat"),
+			  DIFF_FORMAT_NUMSTAT, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "shortstat", &options->output_format,
+			  N_("output only the last line of --stat"),
+			  DIFF_FORMAT_SHORTSTAT, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4933,11 +4939,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--numstat"))
-		options->output_format |= DIFF_FORMAT_NUMSTAT;
-	else if (!strcmp(arg, "--shortstat"))
-		options->output_format |= DIFF_FORMAT_SHORTSTAT;
-	else if (skip_prefix(arg, "-X", &arg) ||
+	if (skip_prefix(arg, "-X", &arg) ||
 		 skip_to_optional_arg(arg, "--dirstat", &arg))
 		return parse_dirstat_opt(options, arg);
 	else if (!strcmp(arg, "--cumulative"))
-- 
2.20.1.682.gd5861c6d90


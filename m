Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C7611F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfAQNJC (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:09:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35879 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQNJC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:09:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so4818434pfc.3
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kv/wwG3B++/lm993hUPIAS/SHt0+RAyoqJV3mJmUpW0=;
        b=LO7CPB0kZY/DKKjHsTup6UBOx0GW5MbMIZdmkDmGtUoNN0gs2muWGx5UN+iDYxiHVJ
         QHniAIZ54/40Zu13h659OmZOmdN0dSXOQrMRX7AfppCIMIeaL8OdMcwJTXgR9tIlOHuk
         aVCNnw5yQJ06Chp5/+W3RY4z34SvCz0QURIgkNMhAiuIcChta42s9VIVDQaOHpLzgnKE
         Y5eTh1zqQuI0UdyROrKxIPAgWJvSUvEiOtRO0h+irefNAEk+WQrWWUtBJ6d6HCrkLXxr
         lqzB2+FAhaWutnIAQqWdifyaBd+X2gCww9E+i8jektkkVcY78Wkr+tIZ2i2Jlc2ApdZL
         h7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kv/wwG3B++/lm993hUPIAS/SHt0+RAyoqJV3mJmUpW0=;
        b=E5+oYIUc286+PdGrLvg3pnXQX9/MdOAb/oxkxn0pNgcubWksi3W+ROqJ2rD4/E7T78
         vlAXdN5ZVRAsd3RnQMZ+DjxK+Eklu4pVMUgi1Ym3cSWMleIol1+Uw7Gi3UnyqqYCOjU0
         zm7ZEIsKgTdD6xt/1HN8YzHF5ImkdL+0FR3FDi0vy7DzOIafIK4RpG5/cqm/4OsnvSpp
         Oks1XngD/Gn25mVAulDByIcU7mAEeGKhda5Ejlo9FbUHz7agrr9vKU0vzod4odTJD3/a
         2KIdOutGx5ls9Had+TRHOB449eUACvfkjwoKabMwzCI0MF/3d/Wots7Wq4k1nH8Anonz
         8uNA==
X-Gm-Message-State: AJcUukcksADEKFbfgBMjZL4buFY9jpLFIwQaj9bRBispYJD0soQEo+5a
        P1TTAe2UxwovsfBFducJDAcPWz8V
X-Google-Smtp-Source: ALg8bN6v1FDjcQiqdY7TnbkhDt/7Jl57f4h3XPrvk5nGV26Zg9nB06QECltsc6xdy2+kxoaFN5myhQ==
X-Received: by 2002:a62:1484:: with SMTP id 126mr14670649pfu.257.1547730541448;
        Thu, 17 Jan 2019 05:09:01 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id w128sm2665043pfw.79.2019.01.17.05.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:09:00 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:08:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 30/76] diff.c: convert -D|--irreversible-delete
Date:   Thu, 17 Jan 2019 20:05:29 +0700
Message-Id: <20190117130615.18732-31-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 6397d7a606..e12b7ae101 100644
--- a/diff.c
+++ b/diff.c
@@ -5064,6 +5064,9 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("detect renames"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_find_renames),
+		OPT_SET_INT_F('D', "irreversible-delete", &options->irreversible_delete,
+			      N_("omit the preimage for deletes"),
+			      1, PARSE_OPT_NONEG),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5098,10 +5101,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* renames options */
-	if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
-		options->irreversible_delete = 1;
-	}
-	else if (starts_with(arg, "-C") ||
+	if (starts_with(arg, "-C") ||
 		 skip_to_optional_arg(arg, "--find-copies", NULL)) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
 			options->flags.find_copies_harder = 1;
-- 
2.20.0.482.g66447595a7


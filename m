Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C69BD1F404
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbeHZNp2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:28 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:43570 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeHZNp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:27 -0400
Received: by mail-lf1-f54.google.com with SMTP id h64-v6so8220488lfi.10
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OCHO1Mbm6XXhoAeo7cGOonXxLrOWJeQM0VzBOeAzNYg=;
        b=Ij02Pj4zE/LVriHX1eGXl/SgPe1XCmmiHbwrr6epIfe+yVx4RVKZSe/W9w/zdHRKuA
         7WKOX23aZWgPbPKTWFPaITiBwRdA1F/RSeLpKypG+sLRWEaf67X1qDzBic0Djgik0QXC
         Lv3KuyqQcK3a3uQHdEkPwbURhgaAvkAxQgINeSMdlI6hT4Q05ZtDLGRNAO3vWevGq06H
         eaxjC8OY2Qi5n+6LCVbBPVBhuQUZozx0zLu8eUCFhp/2yNOkyZhqvcB2ZoyKHIzW9o6n
         gSZfrUF+mI1e0V1a9OmPfqs7dChnjb8y3beP1WcHUt2yl4By1BIs+D4Ot3FeMLo7IP5E
         QEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OCHO1Mbm6XXhoAeo7cGOonXxLrOWJeQM0VzBOeAzNYg=;
        b=pzOKkG6nBsKJG7N8NGk12VsejwThZFJ9R++17uNYy/hkMta5X0wrDhlSwT5+qjvyQq
         OMsehjS4ij3s7MRyqJ5cgRMP09NBQfDXzXQgFUZxfRJUSHCx/3ScDGth6O24Vd+QI9Ow
         YGiV2c+KUCH0XanN5EMT+HNqMiCGzWJ0oBtVdfoxNP9fgbUPn6znA4ezCRpFuxHTgE1C
         aJz6/4Bc5fnXbmpJayLQ9JOEsApeZ3NHkE8x2nrjCaMQNaNcdTDk6/T11tNQr5HDpHLI
         pdOeYTgUqIynkDF1fq1YLh/BP41DtViDLwBfjJaJH6lGh26A1o5dYNSwooeNH7sXlnS2
         MCtA==
X-Gm-Message-State: APzg51BSXDgfsuTqeIisxi/aqffggy2KERBJrBxD4VkU+NVDTC374+M7
        PPTsTZLY/jgUC5ejcnie5lBPPbpO
X-Google-Smtp-Source: ANB0VdbPDBHK3hhrsYjo9AcC7h+4XlentlJHH8U1ceDmpB7c72aaD7MauwhC0yaahENJJbvq0OpY/w==
X-Received: by 2002:a19:8f10:: with SMTP id r16-v6mr5979435lfd.1.1535277800636;
        Sun, 26 Aug 2018 03:03:20 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:20 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/21] combine-diff.c: remove implicit dependency on the_index
Date:   Sun, 26 Aug 2018 12:02:56 +0200
Message-Id: <20180826100314.5137-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 combine-diff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index de7695e728..4fa7707b57 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1054,7 +1054,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;
 
-				if (convert_to_git(&the_index, elem->path, result, len, &buf, global_conv_flags_eol)) {
+				if (convert_to_git(rev->diffopt.repo->index,
+						   elem->path, result, len, &buf, global_conv_flags_eol)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
 					result_size = len;
-- 
2.19.0.rc0.337.ge906d732e7


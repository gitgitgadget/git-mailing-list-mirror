Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 616E91F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfAQNHy (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:07:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38136 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNHy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:07:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so4730775plb.5
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1VZsnXVXT0Nfxja3UHYFwgfHjkg47utayE+uYO35zjM=;
        b=GBitR2sDqCWoaQ6omys53fmPnjpU4ywFomDUK9Bu08NjZRLYjjQQ9NP5/S1sSl3Nu7
         zNv4/gMf8fjTRQtaHr5jYz6hEeo/oi0KwO2EVuNtL6e8jzwtt/Qe+hDt6mTj7kuvEYFi
         og34ztDJCKVqqPoqmglGF9bGUOo0N+jQHXvqM5qQh0M0ICgo4A29N1S0+04/d+s96F6f
         II+ZdvxKOsx2dParCVz19VRKMHLz8XAWnPUTDe1Y5qO8jzCy4IwgxhSP79qAo9hfKlp9
         NxawdzSgI6tohYJI8XHUIJLgF0iSg/sqC2a3y2+VfYRw+kCzXnViS+ahP69fczKR9TSx
         HGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VZsnXVXT0Nfxja3UHYFwgfHjkg47utayE+uYO35zjM=;
        b=bgn3vT0Dey07Bp3OUgi+uby4QoJaFbPCT6LnwdpdIwUKCM4FACkOPVUragPC66I3Kb
         JpYMh6OaxSvVYp6fbaryZ/1dfhHCDlBP3RZ6mMQmpHX5OLzDE8wZ1Y+MRno5x82jiehl
         H+izVV2d6N2YedZMrU85Rmfr9XhVT+eaiIZMVstaYiDMH4whx4b2TwRRE5rq4nhfn8Ty
         neyb7evIjlapFmTDXgoF8Noe67rBBUL2g9yjsShaHKKpX2FjLkifoNRULncPi0c5xyHx
         nXUjsZSDhPzOzXYnmmOXHZDpdZ1dy5u/DYZwpB7wVkswxO4HnHzIVhYrRUpiHwJYukvj
         xJXQ==
X-Gm-Message-State: AJcUukfgJ5EGD3oL+WjLjY8hbjBYHQqkTry56Fna9NBDQrjnRq+B0g7g
        IPpPEMatCiB8Cb+AK87M6EF1hAXr
X-Google-Smtp-Source: ALg8bN7/pUHgy7uJA8RVqV/A152t+ymULiropn2KhfW+EW4Bf/Zyk2TWfio/UZpNs9186sxXLPDaeA==
X-Received: by 2002:a17:902:7296:: with SMTP id d22mr15162063pll.265.1547730473400;
        Thu, 17 Jan 2019 05:07:53 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id c13sm3965187pfe.93.2019.01.17.05.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:07:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:07:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/76] diff.c: convert --patch-with-raw
Date:   Thu, 17 Jan 2019 20:05:15 +0700
Message-Id: <20190117130615.18732-17-pclouds@gmail.com>
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
 diff.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 2ebe9b23c5..07796d2b3c 100644
--- a/diff.c
+++ b/diff.c
@@ -4899,6 +4899,10 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "raw", &options->output_format,
 			  N_("generate the diff in raw format"),
 			  DIFF_FORMAT_RAW, PARSE_OPT_NONEG),
+		OPT_BITOP(0, "patch-with-raw", &options->output_format,
+			  N_("synonym for '-p --raw'"),
+			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
+			  DIFF_FORMAT_NO_OUTPUT),
 		OPT_END()
 	};
 
@@ -4927,10 +4931,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--patch-with-raw")) {
-		enable_patch_output(&options->output_format);
-		options->output_format |= DIFF_FORMAT_RAW;
-	} else if (!strcmp(arg, "--numstat"))
+	if (!strcmp(arg, "--numstat"))
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
 	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
-- 
2.20.0.482.g66447595a7


Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794AEC433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C102177B
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyV5/yjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgH0RpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgH0RpO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 13:45:14 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2A6C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 10:45:14 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so4080208pfh.3
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMV5QKFhnPr4rnfdTmWVCktqKgOz003QeE55g4bMuiI=;
        b=PyV5/yjEZGD14XCevc/7KQJACoatwoWNux8bC1xEe1kj/oRzYs+0p24POGq93MMdLW
         +Gz3HKISvz/0f/Os387ZDyXTJGP9q72jZfTv/6DyZ7cYdTy6Y9pasyE8T1yGfgrOlTBJ
         4sVK3Ompzg35TfXgmh8iTUnbZ+vwNyVjAQqXVdu3B3tmgUmrBNVDepsURXvm4nw6NR9X
         sGZxlYK/wlf77ailauG4JU+5MjAk69I+gs8SOkBRYT3tTyzhli3vfAStbTEi8tQ8Hlyl
         hrvRZhCGRonl3e5AFqYWHWy9HTElQoY3jupQCdCIxPeeDg9A42A4D3oogrt2+0pAGkWB
         czdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMV5QKFhnPr4rnfdTmWVCktqKgOz003QeE55g4bMuiI=;
        b=ctTRdhBykt1e4Z47CZ3xdVKRF6XquA5R2MOsLUOLLWBYwnOs4tx9xHstKbEZUtpLPU
         QXuTpLSy0Rn1wcsXzxmdHykb9eF2KdV3a20GMWjsjC901sT+qQcvGVKQwG+LftzC+JX2
         glj1qgJlxp85SyZTD1GuV5Yfehz+cqte0QcELnhopj7NeNkz8YltvQyLDC8rO5/q52zj
         DOGxYSzsFg/Iz8NmbyYKnQ1wjTxEvUAygDBNV5n/Qtdx8p/mVfACKfC5ebYoUEi5RUwp
         e9wb7uUf27puli9o6vnte1diAUFRNyl6MQgkiMxPuwje+7o7Eddp2cXqZUKUne5ro9pV
         1Lvg==
X-Gm-Message-State: AOAM533c+d+MA8ge71UmIVcFbImpHK1WJD+hpXXMzpb91Ca/jPc/VqSo
        KyJ9cF6m7wlu+f15Hu56O47rq7+BO7QzJg==
X-Google-Smtp-Source: ABdhPJwwlinIZujTtdgUPTrLbVBrKjhVd4XUXdFp4CvR5T0+inXEVMXVMXtp3cCSTjr0fBNaPA3k/Q==
X-Received: by 2002:a62:63c6:: with SMTP id x189mr16878632pfb.216.1598550313164;
        Thu, 27 Aug 2020 10:45:13 -0700 (PDT)
Received: from konoha.iballbatonwifi.com ([103.84.62.195])
        by smtp.gmail.com with ESMTPSA id i20sm940847pfq.204.2020.08.27.10.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 10:45:12 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     kaartic.sivaraam@gmail.com, christian.couder@gmail.com,
        gitster@pobox.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, peff@peff.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/3] submodule: eliminate unused parameters from print_submodule_summary()
Date:   Thu, 27 Aug 2020 23:14:59 +0530
Message-Id: <20200827174501.7103-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827174501.7103-1-shouryashukla.oo@gmail.com>
References: <20200827174501.7103-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eliminate the parameters 'missing_{src,dst}' from the
'print_submodule_summary()' function call since they are not used
anywhere in the function.

Reported-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 builtin/submodule--helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 63ea39025d..b83f840251 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -982,7 +982,6 @@ static char* verify_submodule_committish(const char *sm_path,
 static void print_submodule_summary(struct summary_cb *info, char* errmsg,
 				    int total_commits, const char *displaypath,
 				    const char *src_abbrev, const char *dst_abbrev,
-				    int missing_src, int missing_dst,
 				    struct module_cb *p)
 {
 	if (p->status == 'T') {
@@ -1154,8 +1153,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 
 	print_submodule_summary(info, errmsg, total_commits,
 				displaypath, src_abbrev,
-				dst_abbrev, missing_src,
-				missing_dst, p);
+				dst_abbrev, p);
 
 	free(displaypath);
 	free(src_abbrev);
-- 
2.28.0


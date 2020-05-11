Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEBAC47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063B4206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLIMS81P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbgEKL40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 07:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729319AbgEKL4Y (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 07:56:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B028C05BD0A
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so4677317wru.0
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=35ZUm74A7NtqM8sZEopnVoZ7DH1TKQD8huiWnIPF4N0=;
        b=NLIMS81PDCSupjtDs+zivo8IfGAPQ+9auVGT+v75dJPEGZL3zKlqO+ruI3mqSrX8Ck
         JpzDws1B13nGZa2zX0FJlE75IdzcNYOacQbovGuCaihIVIZvtKIl6KiFj3/0YRqCJRh/
         0SRar8FZNdyAPmhM4OODReexrxpqPyfnwVBmpCGefe2VIYI05ScHlRTGcutKxd7QG/yq
         /COh6QgK7ZANKGUYJ0DWQ6ySGvkebwtot4Vfy7F2TQX55U7OslAqR1HkDiUOqqajzzbM
         wzv8SO6C3uymOklpjpXnXls4AMZMG8CB5Usgbo6+T5ShSB962ZoWEpC766aktTkYzCA3
         s8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=35ZUm74A7NtqM8sZEopnVoZ7DH1TKQD8huiWnIPF4N0=;
        b=BeQYwpZcB+IWX29vw6bgt5q71uHOaKErIYLZ0FbEeiQwvGWLOfR6i/d+KSW2PkilgC
         PQ5ltL+AUvW28Nh4U9eF8O1uFUuXEtJDGSJBIB/6+egl0MeTFjbqW6WpWGBoRAd2bY/o
         aaoI0/T/6oyFUiwOo94tmcjj9NE4tHNelDP05hbGni9Az/LtnfiHPASrpW9KHwulfSeQ
         FwVEWTI1ka86GYJ9xUvnBPMykCPmEEwQLZjbvt6S9g4aJW+N/F/Z+vxiQ3dU1t7Mnb6i
         tXlAoCkPO1AhWpssAj39z9bLO61YRvI3zorJT0/HRQP8CV/craMX8OGNbqst/a4adVdA
         WMDg==
X-Gm-Message-State: AGi0PuaZsiZiz63Tj7+yo16zRSwa7Bauj06IHcmaGkzamQULp3CJQjNW
        YbdcWDIB5pdjzu20cZa6TIb86pJw
X-Google-Smtp-Source: APiQypK8ph7Sq+1mBABzzGea39H413+jph1qjGqWAPQMvJ8M1yo4xPrPtTDtFuwkKe77r/HR/ZlVww==
X-Received: by 2002:adf:face:: with SMTP id a14mr18327294wrs.397.1589198182954;
        Mon, 11 May 2020 04:56:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u74sm26820124wmu.13.2020.05.11.04.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:56:22 -0700 (PDT)
Message-Id: <572d0508fe0364119d83c08e01a66153810958e9.1589198180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
        <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 11:56:09 +0000
Subject: [PATCH v2 02/12] test-bloom: fix usage typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, garimasigit@gmail.com,
        szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-bloom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 77eb27adac7..00c1d44a561 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -44,7 +44,7 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
 }
 
 static const char *bloom_usage = "\n"
-"  test-tool bloom get_murmer3 <string>\n"
+"  test-tool bloom get_murmur3 <string>\n"
 "  test-tool bloom generate_filter <string> [<string>...]\n"
 "  test-tool get_filter_for_commit <commit-hex>\n";
 
-- 
gitgitgadget


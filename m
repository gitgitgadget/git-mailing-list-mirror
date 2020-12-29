Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF56C4332B
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2F8221F8
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgL2UGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 15:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgL2UGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 15:06:23 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E86AC061798
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q18so15655722wrn.1
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XL0RdMhJCBZ0gxMDc9iKNk8Af4u8BEydSMvvnNYLvbo=;
        b=n1e2OIexEXXAsoq04mAIPFhiIhGVLQ9MFkA4YCkEp6uk29X85xHEb/F7UELDnlrDc0
         Ow9eUuxKzucImD+dFVvkTvl+nmrNfSSFmjTQpqud5czIpZ6yjicWFAGGuj77cZxmPX26
         RSCRmRefysS9lhmvDhb8tHXsFiNA7dOO1nWM0/l/Cwwddhs3t/S3ANSxw3GSnhXwvsNo
         JMHCgvz5PU5Zvb8C8YFdtooFRTipuGuSYwWApmn2yu/B3unkhDAXvcx2QpfRcGyrbLj1
         OU1464ZppQyiNDXb8ajkUY4JGRKBSfxzZhrTr7mS9VvcKLSBxpOyMcBUbxP7CE8VwS0g
         JQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XL0RdMhJCBZ0gxMDc9iKNk8Af4u8BEydSMvvnNYLvbo=;
        b=eeowYa0YNVO6mA9JEeUnZNoPkAfCpjkD+SbxQu/TE5nYtTPoKzj8RSi6D5xD/0NIOo
         PuqM61rOb1tUx8LvTDM6bGY+mpY8x+GOnTs0+CigKX1gfQgcjaHBYIuT7MJDqelQ/th+
         I4WJLhiFVqH6sxe4GdOxuPlmQ3JLfjcn1byDgML3A4rELlT5L8xcKAZjz1/TlN0mwYAu
         V03HV2wqZAGguGdh4JFYxs5OBTD000/epJG12EBAaKic1SYN+NWRP1sCKPCQ91N5RGdZ
         8u2dtcD9Y8NxUNdd+31YV/Lz6Lnpij7hWnH9nfOXyJ7WrKK9nW1yqfwTn9MNkukuBU+o
         ZZiw==
X-Gm-Message-State: AOAM531JPxqyW/hHOecBKIAAtx/ozJIA96KMyzuxsYXZYoEiNP8RLQ+s
        23dTd3frbWrPYUlECZ8CQNkWzsrZypY=
X-Google-Smtp-Source: ABdhPJwDvaraAy3FXLY7SZgksNg1ZunomljQEWwaNvSUYlHsLjeOcNfW5qpIS1Yg90eP6m/1YwCg8A==
X-Received: by 2002:a05:6000:185:: with SMTP id p5mr56917833wrx.403.1609272332770;
        Tue, 29 Dec 2020 12:05:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm70755596wre.54.2020.12.29.12.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 12:05:32 -0800 (PST)
Message-Id: <7214fa73fdd13418744903f6c769fdb77c9512ce.1609272328.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
References: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
        <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Dec 2020 20:05:22 +0000
Subject: [PATCH v3 3/9] diffcore-rename: simplify limit check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

diffcore-rename had two different checks of the form

    if ((a < limit || b < limit) &&
        a * b <= limit * limit)

This can be simplified to

    if (st_mult(a, b) <= st_mult(limit, limit))

which makes it clearer how we are checking for overflow, and makes it
much easier to parse given the drop from 8 to 4 variable appearances.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1d6675c040d..16553ab259f 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -447,12 +447,16 @@ static int too_many_rename_candidates(int num_destinations, int num_sources,
 	 * growing larger than a "rename_limit" square matrix, ie:
 	 *
 	 *    num_destinations * num_sources > rename_limit * rename_limit
+	 *
+	 * We use st_mult() to check overflow conditions; in the
+	 * exceptional circumstance that size_t isn't large enough to hold
+	 * the multiplication, the system won't be able to allocate enough
+	 * memory for the matrix anyway.
 	 */
 	if (rename_limit <= 0)
 		rename_limit = 32767;
-	if ((num_destinations <= rename_limit || num_sources <= rename_limit) &&
-	    ((uint64_t)num_destinations * (uint64_t)num_sources
-	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
+	if (st_mult(num_destinations, num_sources)
+	    <= st_mult(rename_limit, rename_limit))
 		return 0;
 
 	options->needed_rename_limit =
@@ -468,9 +472,8 @@ static int too_many_rename_candidates(int num_destinations, int num_sources,
 			continue;
 		limited_sources++;
 	}
-	if ((num_destinations <= rename_limit || limited_sources <= rename_limit) &&
-	    ((uint64_t)num_destinations * (uint64_t)limited_sources
-	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
+	if (st_mult(num_destinations, limited_sources)
+	    <= st_mult(rename_limit, rename_limit))
 		return 2;
 	return 1;
 }
-- 
gitgitgadget


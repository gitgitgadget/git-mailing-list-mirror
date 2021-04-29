Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAC9C43460
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A57061139
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240776AbhD2PdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 11:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhD2PdE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 11:33:04 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16F7C06138F
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f15-20020a05600c4e8fb029013f5599b8a9so9589073wmq.1
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Lm9JjOMNB4wRimMlTSPoIP4OSRo8G8j2bkNCx3qnccQ=;
        b=LafRQlKSg0o8YzPwsuxOf/Rsf23bt5HWVDzsNDqCTpdlj5El2Aga5xLBS73QQ2YpJG
         opn74UDzbViRuLj/PrD6+RyuxsjTfLLFN+D57NGfWGYwhrmXHZn7aWpcu1aPRSXdEao6
         YhWRxLDPLXVd8t0L8DB+2e/0CZI+3tv3T7Cw2wfEjfbI4IwF1H1qrKwxvP2jCGjYL+LJ
         ZHrgyUfW9O/sxOwPaV3mnFRCry/+t6hnJ77r/j+1VPNkeB0XDGbGOCsko2eTLvSfgy79
         YXrqvgQz4NT10ZbJUleOGytP8Zjq9sdsVVUza1pv2BXgHvuRjjVDG3x0i1cFOrQlDBaj
         R/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Lm9JjOMNB4wRimMlTSPoIP4OSRo8G8j2bkNCx3qnccQ=;
        b=Cg4D0tC/wwUuc4cmRJ9xjQtUW/tGsDztD1evbJ1TrJKXRR7PURQjvafRBnIiq40zJC
         w1BNzowalxt8vgykDC2Ks6086xSm5PKX6uNjs8TWQz1mzNpuF+3/HOo1r9Zn44WjybaQ
         3N3+UNtM0vZfcZ8HiChqr8TVx9lC9+frKVc3yfBSNB1GTY+xUZZI+e+isnPD1TbEA6t3
         tnJo+quPghYHZ7Sa5tGGkXYDRFiv9K39/CUsRiy16bhLdOU/MC+Gk5wzClPEs2zYncdy
         x6tY1FYzSP2CSbs9zV2f9W0xBp4z5i21OqPcTLun12LH7AEVJG2rX124UWlEEIi9COda
         wDnA==
X-Gm-Message-State: AOAM530irtMEZ7Hs0+x1MlKNt6W5sxVSjGOPqUkUgO9fOMK5FE9zsV1f
        sKAhWAu7nKsLU3hTUoVcn48zaO8JXmY=
X-Google-Smtp-Source: ABdhPJxabhGejax3rDIjDpK7X79bi3VThfJXvxFDHp5+D5f78xfyZgpUwrDnCvSw+r4lVPmbC03nhg==
X-Received: by 2002:a1c:f708:: with SMTP id v8mr11316824wmh.133.1619710334502;
        Thu, 29 Apr 2021 08:32:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b20sm466669wmj.3.2021.04.29.08.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:32:14 -0700 (PDT)
Message-Id: <95d64d73353d8689e3928b8c9444490d0cdebfc9.1619710329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Apr 2021 15:32:07 +0000
Subject: [PATCH 7/8] refs: stop setting EINVAL and ELOOP in symref resolution
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The only caller of refs_resolve_ref_unsafe_with_errno() is in
refs/files-backend.c, and it only cares about EISDIR and ENOTDIR.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/refs.c b/refs.c
index 6e746cb01f24..597e4d1f18f9 100644
--- a/refs.c
+++ b/refs.c
@@ -1706,7 +1706,6 @@ static const char *refs_resolve_ref_unsafe_errno(struct ref_store *refs,
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 		    !refname_is_safe(refname)) {
-			errno = EINVAL;
 			return NULL;
 		}
 
@@ -1766,7 +1765,6 @@ static const char *refs_resolve_ref_unsafe_errno(struct ref_store *refs,
 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 			    !refname_is_safe(refname)) {
-				errno = EINVAL;
 				return NULL;
 			}
 
@@ -1774,7 +1772,6 @@ static const char *refs_resolve_ref_unsafe_errno(struct ref_store *refs,
 		}
 	}
 
-	errno = ELOOP;
 	return NULL;
 }
 
-- 
gitgitgadget


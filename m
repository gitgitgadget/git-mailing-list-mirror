Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A583C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 09:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346873AbiEZJVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 05:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346862AbiEZJVK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 05:21:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC7C6E5A
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:21:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h126-20020a1c2184000000b003975cedb52bso365102wmh.1
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mQjFVcDZ94ElWk9ixXd7rydvtuPllHtUtjDwap2kGlY=;
        b=oYF5aYh0NR5QQTD+6anO19hv0s/5PCoHMgB412PwnWquuApLDgsTmfwN086rhJ7DZi
         Ndkcr/HHe1hxYyyK963ANm9C6WkQGRWUtcaXm5R/pRgLLgsSooCFaNvRQ1aBeGseIYhU
         gDNpBIomq0X1FP3vvcGKakVEO4XHT033YQlVvSrnjKmb8g0/DZThIvOnA/uBKBdSOnYD
         DM1qsOr8DV5IknbV2e9HHthlq1+Nju+Nhd2TXSaBWEwiWtf7kjgo961KYRGAa7IKU1ws
         GAezV8JzrB81Pp+PEyGyIFQLwGK+mOs2Jki785JyqyW00qdq+KWStAVqkpI8wqsi5z33
         6aLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mQjFVcDZ94ElWk9ixXd7rydvtuPllHtUtjDwap2kGlY=;
        b=Bn/msroqkYsiQOJ+/ei6G/RZ/vkOjk6dZggPHH3HXNqqALm1j4eaB+LJ/L8Pgf3voD
         3duT3CE/d3j2cNl/5TYRgPMSnZNeqg5R3hUoS7qGFRew8W1h0LtyLBBu6M2L0TEeaC8m
         ebLz/r5ynicIL0soQulGPcdeaTXPCEvTvIaDFtBwVONC/8JzcDfui9954ea+mVp0FUpo
         yvhhRL08ADNCdi3wvOeLj74E4SmWqR260QfyRdwaXc5HCHFWWi1to+5BcD7dMqVNgvfv
         fQP61RaED7JQ9KPIig3FXD7kTp/I1WVCwwwxPFqwRh7COdmej3+SicqifMr78Kma1y+e
         B6OA==
X-Gm-Message-State: AOAM533kUOkJxLQ6hy78J/6YK38CjfYK9KkO6+IYhHQYOzlQlOK59PjV
        RTrzJqe6pUvjr+y983NmHmqdPj32Oc0=
X-Google-Smtp-Source: ABdhPJyC20tAYBhxKjWzpFMrjasaxwUOe7MH6caz4d+zvw8LrhyEcjkTqgkq9W7XoefSmbVHi3+ZWg==
X-Received: by 2002:a05:600c:1c9f:b0:397:7ac4:b29c with SMTP id k31-20020a05600c1c9f00b003977ac4b29cmr1360606wms.155.1653556867367;
        Thu, 26 May 2022 02:21:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9-20020a1c4d09000000b003942a244f2bsm4099539wmh.4.2022.05.26.02.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 02:21:06 -0700 (PDT)
Message-Id: <0a4c81d8cafdc048fa89c24fcfa4e2715a17d176.1653556865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 09:21:03 +0000
Subject: [PATCH 1/3] rebase.c: state preserve-merges has been removed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.email>

Since feebd2d256 (rebase: hide --preserve-merges option, 2019-10-18)
this option is now removed as stated in the subsequent release notes.

Fix the option tip.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7ab50cda2ad..6ce7e98a6f1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1110,7 +1110,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			parse_opt_interactive),
 		OPT_SET_INT_F('p', "preserve-merges", &preserve_merges_selected,
-			      N_("(DEPRECATED) try to recreate merges instead of "
+			      N_("(REMOVED) try to recreate merges instead of "
 				 "ignoring them"),
 			      1, PARSE_OPT_HIDDEN),
 		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
-- 
gitgitgadget


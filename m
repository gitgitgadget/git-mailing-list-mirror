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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBA5C4708A
	for <git@archiver.kernel.org>; Thu, 27 May 2021 08:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0199613C9
	for <git@archiver.kernel.org>; Thu, 27 May 2021 08:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhE0Ii7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 04:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbhE0Ii7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 04:38:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730F4C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 01:37:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so1996573wmf.1
        for <git@vger.kernel.org>; Thu, 27 May 2021 01:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wMVXDPLGBMLYT6OBJ2rWFehw8Rz0HAUKh3+HU5yscHk=;
        b=UCCXTtg4efnLjuLVuZBrq7xE/lJecqI2uNqSJFHcJAGoxim2UJirYPJUvKZS6i2YWe
         aNR/OuSz9Qw3LQh+LvhTJQt7ELp0ZE4rF7GoymCBwJrjTBO02Ttnuhoma8nNe1eIlSNd
         OkAf7MrtHwNw9J2J1K0qK/514WuQTpMulqfg0Su8acpww+8Pvefa9kA64AtwICb89s0P
         w3rPH0gTO2nDnq/Al+MpW4sQjW3l/CAJEmyzDFEsL2cCiGJJaYndwFWel0cGXfEgZDA8
         HEsn/uwakQq3xt6e4pIyJNHDyhyU18RI/tIb2gD0XHfgZ11J6LCtEeYo/rmP661m39f0
         92hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wMVXDPLGBMLYT6OBJ2rWFehw8Rz0HAUKh3+HU5yscHk=;
        b=eveJMKg99SNE6CvKMZxNSvLHDtG42kLkzJ88nlSFF+X7X3uneUNSksEo6RyyhswRNH
         2qqU481S1zr9RAOxI4FYz044t3xHU0pUuVZJCbOhvnY3dbAr5exfv/Yx+YJ4Jl/2jSmr
         8N3lRFBezjcITlHtB7RSH86UHLziG6Sp7qOXIs7rWTu147gfEYXTGg/wcvILHc4cQKGN
         jPprDVS1MpePDb+VM4fkq55VpShEiwfiY8dzXXh9PF6PIjTLM2F51opCmgVItPtNSJnu
         CO1wRhmvuijfxjzf7asms9exCOgumNcog9DDNUVCgp+RnEk9Jp+6x1di8eQ78KKml4z0
         dcqw==
X-Gm-Message-State: AOAM532y52jT3nlK2qEZKmDAnZc4Coe7KxIX5KeJSwlB9xjNicMuxQsm
        C/90Aq6FglGFh20/L9KtEW7Ws1iokFQ=
X-Google-Smtp-Source: ABdhPJzpFVxcAh+ICyuLJ6dhjOv0SBNeUAoj0zLGP3BcrvDvCc5puKTm/yLDhWLkC0l7RfKx8pZDvw==
X-Received: by 2002:a05:600c:4ca7:: with SMTP id g39mr2287374wmp.1.1622104645159;
        Thu, 27 May 2021 01:37:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16sm2053906wrs.52.2021.05.27.01.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 01:37:24 -0700 (PDT)
Message-Id: <7212816c8d4734b33a874835e53d9e13b3198971.1622104642.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.git.1622104642.gitgitgadget@gmail.com>
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 May 2021 08:37:18 +0000
Subject: [PATCH 2/5] diffcore-rename: avoid unnecessary strdup'ing in
 break_idx
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The keys of break_idx are strings from the diff_filepairs of
diff_queued_diff.  break_idx is only used in location_rename_dst(), and
that usage is always before any free'ing of the pairs (and thus the
strings in the pairs).  As such, there is no need to strdup these keys;
we can just reuse the existing strings as-is.

The merge logic doesn't make use of break detection, so this does not
affect the performance of any of my testcases.  It was just a minor
unrelated optimization noted in passing while looking at the code.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3375e24659ea..e333a6d64791 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -54,7 +54,7 @@ static void register_rename_src(struct diff_filepair *p)
 	if (p->broken_pair) {
 		if (!break_idx) {
 			break_idx = xmalloc(sizeof(*break_idx));
-			strintmap_init(break_idx, -1);
+			strintmap_init_with_options(break_idx, -1, NULL, 0);
 		}
 		strintmap_set(break_idx, p->one->path, rename_dst_nr);
 	}
-- 
gitgitgadget


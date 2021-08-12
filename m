Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADFCC432BE
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 13:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103936108C
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 13:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbhHLNmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 09:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbhHLNmi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 09:42:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A500C0613D9
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 06:42:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o1-20020a05600c5101b02902e676fe1f04so5852547wms.1
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 06:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8X9JG+gZ88O7dODPBjt1S2SFifYLsVLW5jYDfCOliRU=;
        b=BdN0dIT3Om2xor7BE9WWP6d5XjFxzFcLyDXHakTxj1y8EyUtIr+04ezYp7qlpbI0EF
         68+yR54mnspTKJomq+/qF47aU1NbH03O+zzGGASdwMshvaVZyGE20lG+7r6JzuBAP3eK
         ayBgW4oRcqWTb1y5rT2NUr7cppgI7lCVKyPd0tKua4s+TW9ZlFYcgE2sjd7uxcBQ89mt
         P5tR/JOxsghDl4hkhGZE2Z9MR7TCTGvMU31Iz3r7HiyLHGaSVMrN+jEfxriSZMYmaI+A
         n0KtthoTksLf9hjQumx0tijHQ6XrQxXwZxWUkoSBoDh7sFu3r3RYjBStLI8AEN5mKBac
         OdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8X9JG+gZ88O7dODPBjt1S2SFifYLsVLW5jYDfCOliRU=;
        b=asj93PZ76ZiFOO+8vmxvsAiRMfA39ZE6YyK1vPKnML4JJJs7AEeEQD0qcNrxu/bf+I
         2eNr8i/rjcPTAiXnzZpCBIt5Laxvjx6CckNirSBD2+j4L6UHpXdnln/MYph80Qq+u027
         HR7bU4Upuj1f2Bxy8bsBsnD938hjBC3itbVaExNSbuCCtq5Vf0RPkN+JeMzOX1xgSdod
         D2fYdIx2bGJ3MNOEu/lbaUGjaNIIsKvMKevrzqigZ7S8hxBlkJCeaMe68bTXDqnwYMoV
         BSsLg/DrnOJ9dqOtbjj3rs3hryCAsoOpETaK9hjpFzFIFLUa/hgHf8qtrXXDXz843Rnx
         PEhQ==
X-Gm-Message-State: AOAM532B+30kE9fL+sIJaBbwiyiyGl+urFBAAqiGVwOrSCqL+95mHi5f
        fp1ST2MNt4bD9lT/6Kd5tj2tJu2G4iM=
X-Google-Smtp-Source: ABdhPJyoAAmITIYk26G36IG0sdZBBX1F7S9LhTVdhhP8WZtJ7cM5aJIjpM27dFLbxw8TrXjStuSCUw==
X-Received: by 2002:a05:600c:218b:: with SMTP id e11mr15747062wme.185.1628775731857;
        Thu, 12 Aug 2021 06:42:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q17sm2855602wrr.91.2021.08.12.06.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 06:42:11 -0700 (PDT)
Message-Id: <8755dfa9d0415c3addbae7acf56e354f55a667ff.1628775729.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1013.v2.git.1628775729.gitgitgadget@gmail.com>
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
        <pull.1013.v2.git.1628775729.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Aug 2021 13:42:07 +0000
Subject: [PATCH v2 1/3] t3403: fix commit authorship
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Setting GIT_AUTHOR_* when committing with --amend will only change the
author if we also pass --reset-author.  This commit is used in some
tests that ensure the author ident does not change when rebasing.
Creating this commit without changing the authorship meant that the
test would not catch regressions that caused rebase to discard the
original authorship information.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3403-rebase-skip.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index e26762d0b29..6365c5af2f7 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -36,7 +36,8 @@ test_expect_success setup '
 	test_tick &&
 	GIT_AUTHOR_NAME="Another Author" \
 		GIT_AUTHOR_EMAIL="another.author@example.com" \
-		git commit --amend --no-edit -m amended-goodbye &&
+		git commit --amend --no-edit -m amended-goodbye \
+			--reset-author &&
 	test_tick &&
 	git tag amended-goodbye &&
 
-- 
gitgitgadget


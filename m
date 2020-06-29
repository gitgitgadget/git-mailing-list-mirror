Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAA1C433E4
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB035206F1
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6yEbu9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbgF2VOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbgF2S5D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9CAC031C42
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so17583060wrj.13
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6rkMjcy9NJU9ZIgbgl1YRLSMVdS03FMU3SmL7fuVvRo=;
        b=I6yEbu9wgXYZr3vHURnyop4OKE5AiOs0s+Dk4OQU8YGrPa/hKrZcleVa7ZGlRQe/MY
         c7sMGJm5QguKSftgfZjC5l3trfTN74RpACRF3WcRIKrLt1We7D6ARRQfkaUivpedP8CD
         8r5WdvMgi6CfC1xPXHlPri+HcBVmRuvdqvulIq9eXib5JYw44WxYV4Kl0ZG8etwBVlac
         JJCZxFI9qAB1OUpou956gmut8VVrBXvmOtzOEeyd2irM6TOCZDpA5RdXloRbcamZ9W+R
         LL0GViRHDB9PqVjJNhs60xax2UUtcVnmfFXDBbw4N2HwfJYaUD2m4j9tjoy2XosK51t6
         sXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6rkMjcy9NJU9ZIgbgl1YRLSMVdS03FMU3SmL7fuVvRo=;
        b=Az4nJHynsZ15zV7JYMeIKLwLGmB4JUQwFA95l1yOrzpBRvXd584zUEaM+rxjlWzEZ1
         IA6FzIfC+r90rXrMqNYd6tOkIZKoN7z+8kN+ScaXn020c67kM6fIXjYdQ1JogDTSeSa1
         ghhvALv4eYh3qMBVSKAuGuctCMlRskF63xJioVyqvIsh8Wbo546Zf1b8Z2OGap7pu3GN
         N5QH/pW2IwGcNk8WT83i7AzqvmakjM8NxUL+PjJJBDlruB5qIxpsqBGWXOjRk8mFxToN
         HcRojiemmdxKAI2ompyVKVXyfZ3+VRNdXdEiToXlxgVFf7DUMaZc5m9YgOMHEWB/aNgB
         wrXQ==
X-Gm-Message-State: AOAM533wk1fEIdJINxFG7WEm+LuN7R/gcRL+YsIT6VBSKp1FbQPjmT1M
        19C8NBV1tWseU+DV5JdBxrg6zWqZCPU=
X-Google-Smtp-Source: ABdhPJw7/8g6UVZZP2J7kJASDiUxyffYERg/d6+Zahh/53eGYXu3+15p+94LDMx1kXt99eKUSMc5bA==
X-Received: by 2002:a5d:424f:: with SMTP id s15mr8303842wrr.342.1593457021938;
        Mon, 29 Jun 2020 11:57:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k14sm684569wrn.76.2020.06.29.11.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:57:01 -0700 (PDT)
Message-Id: <277da0cf7ed641a085e6f4d843aa5ac0dd56a6c4.1593457018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 18:56:40 +0000
Subject: [PATCH v19 02/20] t3432: use git-reflog to inspect the reflog for
 HEAD
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t3432-rebase-fast-forward.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 6f0452c0ea..22afeb8ccd 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -60,15 +60,16 @@ test_rebase_same_head_ () {
 		fi &&
 		oldhead=\$(git rev-parse HEAD) &&
 		test_when_finished 'git reset --hard \$oldhead' &&
-		cp .git/logs/HEAD expect &&
+		git reflog HEAD > expect &&
 		git rebase$flag $* >stdout &&
+		git reflog HEAD > actual &&
 		if test $what = work
 		then
 			old=\$(wc -l <expect) &&
-			test_line_count '-gt' \$old .git/logs/HEAD
+			test_line_count '-gt' \$old actual
 		elif test $what = noop
 		then
-			test_cmp expect .git/logs/HEAD
+			test_cmp expect actual
 		fi &&
 		newhead=\$(git rev-parse HEAD) &&
 		if test $cmp = same
-- 
gitgitgadget


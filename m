Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4B5C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F8B208DB
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIJviHhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgIQHpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgIQHoo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 03:44:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498DEC061797
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:44 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gf14so797501pjb.5
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SMDke5q4egupJlixzIzak9Wm2pEV4d5A/nAe6GhDB6g=;
        b=cIJviHhKl0ix23nB92m4WzehNntDjnTacsSwMpQAKmpM6qrn43rr+a0KsX9VUpqhEO
         2YS6sWd44dSjj5GFNVpjf5I7nuyjvwJO3Y1id3et6nRNsWHnHMNwnUn6e4LT8MjRmijy
         xsniUkoD7VuV5uxHOPaBfnDu0YGXBsQjLPyhdGUKRLDrt+l/AcIrHP+JOUfeuJmroiBr
         JZxV8WybCes8lcW79dIvtI24txd4iqk/3En6Fpln6I/fHaiBOlFOj9rVcGsU6Ycw7CMf
         kbdaxHNNz5HWdsyHpvPzRbfILu1PT3R5uqq0MwD/WXLzH9pINlNKCz07JooLMH/+lXAF
         jWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SMDke5q4egupJlixzIzak9Wm2pEV4d5A/nAe6GhDB6g=;
        b=Y/R/ZSKuFmaGyO+N9rTkURS3ecS9KNOZ96iTMiAwgjElk9tVa1vMDpVIIskOU9b7Uf
         xyDtpWgOl1sUmDupa+jKeu+LPZuHhWkyZeShHSwwtPrnbYYL0UJEuCtKm68MP0scMU6n
         Z6qwD0cNwj1LFzgnP8t7FQaiWk8TSh1P+WuBAe2UzZ6CKhiPmjDGfu4pPBHXZ4VGy30q
         lofPYNq4aZ/dL8cP5q88ZrYDr4bt2on9QWMPQoYhgzgzm4PpQ6QvNuIpxcLxBgASzrf0
         E7jHjRsZhJkFJtmA4x/iQZ7GQ0DzOwT9jx6axmqNozekHeXj7P7UgmLUgmiFppzm2gEV
         rtcA==
X-Gm-Message-State: AOAM531Ul8jj1EpxMGvZfU7/hH4mWPUndAeYZoviVzAsjTJYX9BGOZio
        nPspvRntnlnoz3c0tlzMkpWFutH7I2fpTQ==
X-Google-Smtp-Source: ABdhPJyqV4iha1cG0C91sEVinZdcUZitQ5OAskUBvsjWb4LAQ4iVbHYoYam6GgrpGVGIB8TZ0kj4sA==
X-Received: by 2002:a17:90a:ed88:: with SMTP id k8mr7130475pjy.232.1600328683386;
        Thu, 17 Sep 2020 00:44:43 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j9sm4931711pfc.175.2020.09.17.00.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:44:42 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/10] contrib/completion: complete `git diff --merge-base`
Date:   Thu, 17 Sep 2020 00:44:14 -0700
Message-Id: <42a8c9b665c63d5e8135546538db69a366cd70da.1600328336.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1600328335.git.liu.denton@gmail.com>
References: <cover.1599723087.git.liu.denton@gmail.com> <cover.1600328335.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f68c8e0646..679d1ec8a8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1692,7 +1692,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 "
 
 __git_diff_difftool_options="--cached --staged --pickaxe-all --pickaxe-regex
-			--base --ours --theirs --no-index --relative
+			--base --ours --theirs --no-index --relative --merge-base
 			$__git_diff_common_options"
 
 _git_diff ()
-- 
2.28.0.618.gf4bc123cb7


Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E969EC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC38220747
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWqQ4+kW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgFKMjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgFKMjF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:39:05 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2A1C08C5C2
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:39:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q11so6009096wrp.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WsHlJyLJoomQg4k3zSlJOxtBruLcdOGTc+0HCWHriss=;
        b=cWqQ4+kW2ASrTu54L5v0oYf8BNu1tWNURVaDn6rLSmC30m8X8+oW0xq+X1T4QeXx4u
         nu57rRZnqXzEzVWH8y5gbhrv4EgCcpVwz/2ks6fSsD44cCYMQxY8zD3sfSGrRx6/Fbcz
         cJ6LGdP0eQfjE7r+uOTgOGnetoFB+Lmc3xj+2rhT4DQFLC66nYi4fTeQJsF8xXH7RE8q
         kLs3jhaa2P3koAeSN1UX+JrTTtnjPdOKC1nSiqWYd9tWVjabSeydK+e+cFmwjtRigzP7
         h5D843J/pR+bZn80cDtHrzMoQAf3r0T7Ah/7EUex9DtTWVvDmWoqlAKtm+MMuyd72Ln+
         PBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WsHlJyLJoomQg4k3zSlJOxtBruLcdOGTc+0HCWHriss=;
        b=UsTrVvN7cL3dRe2RBSwM9sRypK/aSmrga1o8ckJAfa6eJi8Fe7J6KZI7f1y8leBQXf
         gowuo1UKS2NPM6ADG40oxMYJet9V39Y8ht81JuOvScv0jfm7r/57VCDwXAhugG6wErs5
         jI+Spusg4rNJ7yS8JiDj5XsI1/KWcpuHuBi3nKV7geBGiFBtssQ6K9hxfrvg6cDRH5z5
         H6T3/4KX1hQvC47kgDLkROqA+UVXpzYtoXmQ0fbvZMwdD7Tu7Dwmk4dLEzDoDdPlI5kx
         TImmDWjR7Hn3A2TlUWsUUJ9QrTb6MJZhPhuAScvK2P4HSsOL1NPf9b8exfqgg9JpgktA
         yuxQ==
X-Gm-Message-State: AOAM531ND+pM17m54hJ52PJ4JOJhjitcuYKxyHKoi5pFlTpPoDkRiFda
        ycBzlRfq7S8LO5SmIfffaAbgNnFV
X-Google-Smtp-Source: ABdhPJzzfMrdRmrz988a2t0Bz+8RBV0NPLAnouzPduxcBdSu63LT2hiAPbYFjQGVgzg000VVCu4dJQ==
X-Received: by 2002:a5d:4948:: with SMTP id r8mr9131153wrs.290.1591879143575;
        Thu, 11 Jun 2020 05:39:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm3934273wmm.31.2020.06.11.05.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:39:03 -0700 (PDT)
Message-Id: <a1c889e2cd11f87f72bfd6f600db30ee59c46502.1591879139.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.git.1591879139.gitgitgadget@gmail.com>
References: <pull.654.git.1591879139.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Jun 2020 12:38:59 +0000
Subject: [PATCH 3/3] difftool -d: ensure that intent-to-add files are handled
 correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In https://github.com/git-for-windows/git/issues/2677, a `git difftool
-d` problem was reported. The underlying cause was a bug in `git
diff-files --raw` that we just fixed.

Make sure that the reported `difftool` problem stays fixed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7800-difftool.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 29b92907e2a..524f30f7dc7 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -720,6 +720,14 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'add -N and difftool -d' '
+	test_when_finished git reset --hard &&
+
+	test_write_lines A B C >intent-to-add &&
+	git add -N intent-to-add &&
+	git difftool --dir-diff --extcmd ls
+'
+
 test_expect_success 'outside worktree' '
 	echo 1 >1 &&
 	echo 2 >2 &&
-- 
gitgitgadget

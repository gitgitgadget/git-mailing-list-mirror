Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55C1C433E4
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2032072E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh6InHXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbgFWMsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732614AbgFWMsL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 08:48:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC7EC061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 05:48:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f139so1657521wmf.5
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WsHlJyLJoomQg4k3zSlJOxtBruLcdOGTc+0HCWHriss=;
        b=Mh6InHXm38/2S1fMZKIDD2c0FAsBcdH6v7/cOU6d1zkbjId6hgOQ9yznhedEAWb+M3
         runIXUEdyKnkBrLJJ9ytHx44+GVnDB5WNwJbJf2IGgSgbaZsdBV9mWUGoxu8FUizkX6j
         GLdAhDokM4qnAeX63hZP8H5DWhHYFShrbadlMh1cJ778n5z6Ey22uWFF1OUeJrVq+ZdW
         A7PXAOSliSyMQ2BVIef3uJlkpC1MPmkz8OXQIGPTAEfWrVpKnIiXiJV6eD6aqkd9lAr2
         6JR64hwv2Oasc/GuYH+5gdP8Vgl9sdjS88WNOy1E6L4yQ1EU6ex+Z3DgAnD38BKRlhh6
         fK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WsHlJyLJoomQg4k3zSlJOxtBruLcdOGTc+0HCWHriss=;
        b=G2LJXhZUC2FhPOWKE9WhQo7D1KxnZr+lkT801KYQQW4dp+LH9BeNWyDXenTtnbjCSL
         whKvGm/pGXM+9+wKK4/CoQ1b8012E56bfCi+fD5lpAx7KT3DgXIR+vxwoHcc070r4nvj
         FfdS1fp388b0s27F5OfX3jipP5F25H1hMsvypxxz/1fImUG2wKxYf2ZwDs5hQez6h6WZ
         RyzknuAJe6+eUzqEK8eerGoekpRPylVSEEDkIls7kbYs0CeB+s9hLbBY7pnXFjgqL9OP
         zLmNRy1VJwuHYC542e5lJsebcDzkM+ZvMk0/uZ1RDtVJCAeWemDKAi2n8qBjxVWKEYEP
         pM1A==
X-Gm-Message-State: AOAM532poF9hmyIqSwJAHr7iDvVgarFuYpANl7vZ21VMwieZEjLyqk7W
        zVHzgcihShp+8tSOx+y2XFzxoWw9
X-Google-Smtp-Source: ABdhPJzWMcEONmhzP53XZwQLAjLGHBjUZQPjyb3EJQmwE9lO0/cP7RgNSmuqsDk9VbJ5WNstifWzSQ==
X-Received: by 2002:a1c:9ac2:: with SMTP id c185mr13383385wme.24.1592916489798;
        Tue, 23 Jun 2020 05:48:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q128sm3564916wma.38.2020.06.23.05.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 05:48:09 -0700 (PDT)
Message-Id: <d2e9f704c9e6466aa0ac826282fdf20e71235dde.1592916485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
References: <pull.654.git.1591879139.gitgitgadget@gmail.com>
        <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 12:48:05 +0000
Subject: [PATCH v2 3/3] difftool -d: ensure that intent-to-add files are
 handled correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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

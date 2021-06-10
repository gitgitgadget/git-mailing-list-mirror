Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7559BC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5315461406
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFJJPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhFJJPb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 05:15:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA35C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 02:13:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso6048572wmi.3
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 02:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eRllt0kzAQjus5nxm88N0aMaFAqksbZ6reUWMluFIAg=;
        b=muGGpSUX4z36W8PT32gKHpehq0o3Gq+SOQm4Moa0niApFkC4JSs3ebmWg5NrMG05dy
         CBrE+V9DXY+joY9TOfGSj6kgHImw0Evr3Omi/YzsbJcG1IDlkoIWLaUfDs4sn54Mv0Hb
         esRGxQ3XlL17SDR2LmeWeSJY/p3GJeTyf1WdF+fGJ1M5PWh1hoU3qaeqYACNZuAeSNpM
         aCDvbVrbgNkMQXMrFHTdCu8FOrjhWp/AkrYVtM6MhDydpyvgAvgtOeuU/QT8fgPoTf8i
         mi9pwaW9hj352PqyCTg3rQbFbr9OKhO7TtaZ6bgSyYEQpOwBX4fxvm2DKNioBct2wcov
         CVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eRllt0kzAQjus5nxm88N0aMaFAqksbZ6reUWMluFIAg=;
        b=BIjyzRO/6tM1kcnTW919w/LqwqRXOIhghYALuP0dUivojNSPcwSp7AYzDMOwPVf9Kz
         XTrcme+ucStq/6bly+R+yfam8JNcZFpAqljtZ9CNF+RSiWXolV/d6xk/6VSg73zWVJzo
         MItQD5laqkF6Waa8DNaWCgjQ6BEZtxCm+xhv4Zb6Wj1lsy09msp6q7cVWSSOF9NqcQCr
         8fvY00mud6/f6JtsqLnoSHKn2rGXNar6el8yUqrrf2gvA2dsyb92HKItT/Yvb2kj3xTf
         t2wjAZuyLacn2fDscDHNzQqUWTGgFhidOladdP8TUQGUBmWyxi5N0a6yMqwamjmP+ce0
         ZYgg==
X-Gm-Message-State: AOAM531F/oecXe8dOzh3+wFBxi/yboWsTLlwfeS5RHAx8GZWVo8dv9Yr
        g1qYw0WVI098AzEyZKghtIl1DQABdRE=
X-Google-Smtp-Source: ABdhPJweg5jYABKN004UhAXdPc/YE3h/ljGyvcHAiabX5jcAE5epyWsJUtZm+JqenfEIBjnG+NX6Qw==
X-Received: by 2002:a05:600c:3594:: with SMTP id p20mr11893423wmq.52.1623316413530;
        Thu, 10 Jun 2021 02:13:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 125sm9803165wmb.34.2021.06.10.02.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:13:33 -0700 (PDT)
Message-Id: <a91ac6c18938116c4a74e19466da456b67376fa5.1623316412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.978.git.1623316412.gitgitgadget@gmail.com>
References: <pull.978.git.1623316412.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Jun 2021 09:13:30 +0000
Subject: [PATCH 1/2] subtree: fix the GIT_EXEC_PATH sanity check to work on
 Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 22d550749361 (subtree: don't fuss with PATH, 2021-04-27), `git
subtree` was broken thoroughly on Windows.

The reason is that it assumes Unix semantics, where `PATH` is
colon-separated, and it assumes that `$GIT_EXEC_PATH:` is a verbatim
prefix of `$PATH`. Neither are true, the latter in particular because
`GIT_EXEC_PATH` is a Windows-style path, while `PATH` is a Unix-style
path list.

Let's keep the original spirit, and hack together something that
unbreaks the logic on Windows.

A more thorough fix would look at the inode of `$GIT_EXEC_PATH` and of
the first component of `$PATH`, to make sure that they are identical,
but that is even trickier to do in a portable way.

This fixes https://github.com/git-for-windows/git/issues/3260

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/subtree/git-subtree.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index b06782bc7955..6bd689a6bb92 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -5,7 +5,13 @@
 # Copyright (C) 2009 Avery Pennarun <apenwarr@gmail.com>
 #
 
-if test -z "$GIT_EXEC_PATH" || test "${PATH#"${GIT_EXEC_PATH}:"}" = "$PATH" || ! test -f "$GIT_EXEC_PATH/git-sh-setup"
+if test -z "$GIT_EXEC_PATH" || {
+	test "${PATH#"${GIT_EXEC_PATH}:"}" = "$PATH" && {
+		# On Windows, PATH might be Unix-style, GIT_EXEC_PATH not
+		! type -p cygpath >/dev/null 2>&1 ||
+		test "${PATH#$(cygpath -au "$GIT_EXEC_PATH"):}" = "$PATH"
+	}
+} || ! test -f "$GIT_EXEC_PATH/git-sh-setup"
 then
 	echo >&2 'It looks like either your git installation or your'
 	echo >&2 'git-subtree installation is broken.'
-- 
gitgitgadget


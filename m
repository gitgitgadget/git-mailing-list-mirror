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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6E0C48BCD
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A8B61403
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFJJPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhFJJPb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 05:15:31 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52060C061760
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 02:13:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s70-20020a1ca9490000b02901a589651424so4409262wme.0
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 02:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oe6MHunQth6d0psG3IVfZJ5uux1Lw/1Ik8cJtXDs+vI=;
        b=cGpJJaoZFqtIGwJd/qsF76ABAZpAjoyGgSafangeAP5oCGvmHR+D4nxaaiDeoKHpcm
         lz6Ph39ieayqSUVuD96CHsVUXwmYfZVtILmw7B6SeNsCswolWT2itMZeQmoMwo1dQaHK
         AqLwlbwCe8i8IK1QrXzk2XNzeA0iXCCUd5qbeUaUZ1t+OTek94yw5srFkszTgG9r2ytN
         MAlneQHauWwjNY8pLSj6cBJ5v11zkPRVaWEMbP2FQsskcsBW+jcssFs0SVlA5FF3vwH4
         Vw7xxbad11Jis7/YuWBdVBwlFjUBYAWSCjsdSNECmDImrmph7OU8j+wg+CASefU8bO2a
         bU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oe6MHunQth6d0psG3IVfZJ5uux1Lw/1Ik8cJtXDs+vI=;
        b=a3f/TYslV1Jlbs1nDzl3Uh2EN8bNo2HFOAVul+WtOghYXNJ/2fN1LwmE4L60Dtnghw
         tBvczhD0w987ziYiR8zp3ZB21lZFmFKZHLLode94YmzAn9U+w8Ra5zJTtPga2q1zaRij
         mygIFDEzhSH+5We9V9GXiwn85+gNJYOoY6aHhdCwB0DfmZaYBTkt8Q9qexjHPD1xRo+t
         7V43Y/uKe41dS4Y3oMaj8YnVQatLFZF0OEo5k8eXZxZr2wQVZl8bPF4WXPg4X3eAXVwe
         vkkyYaeyFduVmwZC+58Gt7vGyyJnbrOY70v+T1JDs2LpUsdvNS5k40qHpSEiIJr2iNT4
         kM5A==
X-Gm-Message-State: AOAM530MmieLwQ8DirohsKgFj6R7MfDrO5nY4yNKBfJhYn4QCcJTIh6X
        ctv5Bk/FninhnZrvKrCjE0OIFVXIG3Y=
X-Google-Smtp-Source: ABdhPJyjrDI8rsBvJpoonuMaFpWOYtqMwGKk681unjs+uvXJ5pyJncpxPBRI/o9bVYfBkWly0mXImQ==
X-Received: by 2002:a05:600c:4ec7:: with SMTP id g7mr3892267wmq.157.1623316413981;
        Thu, 10 Jun 2021 02:13:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11sm2341993wmq.4.2021.06.10.02.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:13:33 -0700 (PDT)
Message-Id: <4e1a569c9fa494fa9bb1bfde14d77ac9751d9049.1623316412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.978.git.1623316412.gitgitgadget@gmail.com>
References: <pull.978.git.1623316412.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Jun 2021 09:13:31 +0000
Subject: [PATCH 2/2] subtree: fix assumption about the directory separator
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

On Windows, both forward and backslash are valid separators. In
22d550749361 (subtree: don't fuss with PATH, 2021-04-27), however, we
added code that assumes that it can only be the forward slash.

Let's fix that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/subtree/git-subtree.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 6bd689a6bb92..d11ac56f9eb8 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -13,6 +13,8 @@ if test -z "$GIT_EXEC_PATH" || {
 	}
 } || ! test -f "$GIT_EXEC_PATH/git-sh-setup"
 then
+	base=${0##*/}
+	base=${base##*\\}
 	echo >&2 'It looks like either your git installation or your'
 	echo >&2 'git-subtree installation is broken.'
 	echo >&2
@@ -20,10 +22,10 @@ then
 	echo >&2 " - If \`git --exec-path\` does not print the correct path to"
 	echo >&2 "   your git install directory, then set the GIT_EXEC_PATH"
 	echo >&2 "   environment variable to the correct directory."
-	echo >&2 " - Make sure that your \`${0##*/}\` file is either in your"
+	echo >&2 " - Make sure that your \`$base\` file is either in your"
 	echo >&2 "   PATH or in your git exec path (\`$(git --exec-path)\`)."
-	echo >&2 " - You should run git-subtree as \`git ${0##*/git-}\`,"
-	echo >&2 "   not as \`${0##*/}\`." >&2
+	echo >&2 " - You should run git-subtree as \`git ${base#git-}\`,"
+	echo >&2 "   not as \`$base\`." >&2
 	exit 126
 fi
 
-- 
gitgitgadget

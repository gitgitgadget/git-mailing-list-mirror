Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DDDC433DF
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 10:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13232075D
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 10:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skhaWDFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgGBKvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgGBKvX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 06:51:23 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52938C08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 03:51:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l2so25898065wmf.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=xTySjkM8lTprMFqWbrgxzJqKpGIIZeFWYye+O/XjR08=;
        b=skhaWDFQU10T5+Zx46s8FdNYqK3o0N/KaziF8UhbxGn+Kfn7dwVriBWY8SQIF8Any5
         QMi9ZoiWABkEUDaGtIK2h3IL0dxt0m5/kyrPkPR+/jhG6rgoQH2L3Anx+vyeTyicj9XD
         EoMYLaUUySuMp73Cjoyr9U4OpnOl1PecNjy8ffLETH7LmYaxGTX6PKypI2j22TUPWFn6
         chrIulO0SpNRdSCnlhFsMr+IpCluWQ9Dc5duXtRyZfUBP9ehUkY8xtPvdfpI1i7e4aOJ
         PrEfdJLCQtIG0YnXTb/6hbFOYtvy2hlsnfGSo6A3tYK5QW3SIbloOgq7+4gkq0ogrunG
         knBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xTySjkM8lTprMFqWbrgxzJqKpGIIZeFWYye+O/XjR08=;
        b=UyzZy0hBFkezPGfClvAG8i7VodQ1wV17HApMJDPmFFjz10tFp1aa7CUGzN3E67VJoN
         KtVTat4/z8v/gDqNQw+PMaJO33602nZTbzLHrgPIAwe+BCS3DHaoXEJJ9SwTh9H/SVbd
         szeBJD2ndU/B19KX4aw5iN9QVwIpi2Dc33gG8nu9t3EH8d1uv9w8MjQlgCIUujedM6xV
         Y77CYVNavPEq4e0ci1+VwbJvHm4PedUVa9rZ4k1aVP8LhgCP1aBTWwCzA1VOcKZFUZVH
         GzGSOL6FkxVX/EliIrnp/l9QnmZiqMJQHUJw+vEnWDxmt7VgPMUohaQvopmtsIbZyHEI
         EMJQ==
X-Gm-Message-State: AOAM530WIZHAbg3avrSIhtIbjWR3qA8PMxNDhbDzZzgFwuq5EQYXU7j7
        2HIXRAtT/ARyP+fKLjEcP/MebB8D
X-Google-Smtp-Source: ABdhPJyBvzgmu7L+Gz24zTQ5VJgL82gWXzngCGZFQq+PW/xpphpSkUfD/0tpIfalGb98d9lS4yN7WQ==
X-Received: by 2002:a1c:2e0e:: with SMTP id u14mr30888703wmu.55.1593687081958;
        Thu, 02 Jul 2020 03:51:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm11298228wru.9.2020.07.02.03.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 03:51:21 -0700 (PDT)
Message-Id: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com>
From:   "Alexey via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Jul 2020 10:51:20 +0000
Subject: [PATCH] Fix zsh installation instructions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexey <lesha.ogonkov@gmail.com>, Alexey <lesha.ogonkov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexey <lesha.ogonkov@gmail.com>

- Fix wrong script in completion configuration. zsh wants bash completion
  path here, not path to itself.
- Add `compinit` autoload command, since whole thing didn't work
  if it is not loaded.

Signed-off-by: Alexey <lesha.ogonkov@gmail.com>
---
    Fix zsh installation instructions
    
     * Fix wrong script in completion configuration. zsh wants bash
       completion path here, not path to itself.
     * Add compinit autoload command, since whole thing didn't work if it is
       not loaded.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-814%2Fogonkov%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-814/ogonkov/patch-1-v1
Pull-Request: https://github.com/git/git/pull/814

 contrib/completion/git-completion.zsh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index ce47e86b60..107869036d 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -9,13 +9,14 @@
 #
 # If your script is somewhere else, you can configure it on your ~/.zshrc:
 #
-#  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
+#  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
 #
 # The recommended way to install this script is to make a copy of it in
 # ~/.zsh/ directory as ~/.zsh/git-completion.zsh and then add the following
 # to your ~/.zshrc file:
 #
 #  fpath=(~/.zsh $fpath)
+#  autoload -Uz compinit && compinit
 
 complete ()
 {

base-commit: a08a83db2bf27f015bec9a435f6d73e223c21c5e
-- 
gitgitgadget

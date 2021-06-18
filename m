Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988AEC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8291A611CC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbhFRS2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbhFRS2T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:19 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91450C0617A6
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:08 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso10528727otl.13
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzdc/6+iV8+pAEkY4zTWjHEen/iX0RCSOtEZhcKa1Vs=;
        b=A8zJotCZPRdydXkR03ZPQwE891O65ngyXGY1BtZaTHsqOxuBfNlyUFELUWW2dPGJCv
         j70ok0AOSUedejq7jIufKLXSzYXEGSniOPj77RkxwpPFD1/EkReph5kkVzCvBKdn2uXI
         DIawFdGjxL5E6w6c0fwY/vloHI/BCWBuX84Ax6AmNRaOHlDfeWcZcaAKKcgPYjBL1LAl
         E7NFDzDRRFmhLa6FGaLrp6IQagdJ9bBBwag0DveTZI9H524eDM325mM9mbK7Yb5QSXor
         f2iQNHVFekHvPsrGMOf/fcwhtS/wyXW2YX46cyHgfbwlizT192TiQJhRVZ7u9++28o8a
         74Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzdc/6+iV8+pAEkY4zTWjHEen/iX0RCSOtEZhcKa1Vs=;
        b=NkmmspAv3/DU0LyRBLT4UwsWwMHxxmbgWUFjnXZPljW5AF355PqWmVd7DMGkIyUXLq
         9CLjb0DgLDuHfXm16JdqSo3UuEosZ1sHCzKAFNv9U/pEGqJtcYeuqHDLwyH+LvIW40KC
         xYu0uNMqCl6oF656tnPUYQW8JO7J+79y/RrA+Xim/4JsNZgfUkADwJUWxbD2MUcxOwSI
         iqwc5XMe87U+1r95rW3mMlIhX4fY98BejKTl7KZDmRF0Sojun/7TfVHg2hCpzjs4llSH
         dqLHCmeGyAKOqiPdssewUxHLD1Rw/nUSaKKsIqJfbo7KyoWbXCF2e1T9Y02SDF/fR+Lc
         2MSw==
X-Gm-Message-State: AOAM532ys44o3u3MowZiLY9KwyBQSPVNiwi912v3I6IMYHVUfmkrg3wT
        8gw6ZDUbzDn4KwPEDNjlHPR52JfGQkYZAw==
X-Google-Smtp-Source: ABdhPJzJGXPS4NAbFtMBTxHaVYgQVC4A2MW+9PKnH6OxKVqbGLDNHm7dr/rC9gsQRtmDClnLyS32/A==
X-Received: by 2002:a05:6830:90c:: with SMTP id v12mr10135155ott.7.1624040767558;
        Fri, 18 Jun 2021 11:26:07 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w12sm1598719oor.35.2021.06.18.11.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:07 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 24/45] completion: simplify equal suffix check
Date:   Fri, 18 Jun 2021 13:24:57 -0500
Message-Id: <20210618182518.697912-25-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We know the prefix is already '--no-', there's no need to check for the
first '--'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ad67abff36..d0df695b52 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -344,7 +344,7 @@ __gitcomp ()
 			c="$c${4-}"
 			if [[ $c == "$cur_"* ]]; then
 				case $c in
-				--*=|*.) ;;
+				*=|*.) ;;
 				*) c="$c " ;;
 				esac
 				COMPREPLY[i++]="${2-}$c"
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 4dd0a4d821..1fff8437d5 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -68,7 +68,7 @@ __gitcomp ()
 			fi
 			c="$c${4-}"
 			case $c in
-			--*=|*.) ;;
+			*=|*.) ;;
 			*) c="$c " ;;
 			esac
 			array+=("$c")
-- 
2.32.0


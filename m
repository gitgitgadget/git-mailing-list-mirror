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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D454C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67036115C
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhDZQVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbhDZQUx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:20:53 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DF2C061763
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:20:09 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id m13so56924157oiw.13
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rzp4KIn25C6/1vn0IjwPISUvQBAaHVB5nSknZ59c4wg=;
        b=uke9d3IO+Gnib+/u+HNOVrKWT8qktRZLAbE3dsiFCIIy1C0f2KLZbyqBgpRPp/xR+Y
         csYfdagTo3JAsKN4dT0+L9Jkg1mxO7kz8luPw/3HHKOdQ9mPcffkPs4Jy7+6OQhCEfTb
         FMxOhtovk4RtHGykHsyZyHda39jKXx+HRSm0nX/q7cu+oXmHal/PEZJKkVXYBfDj031n
         JIDfAlm1tPsxKxekjQsUJSAv4w0FXYxmXVSIvtx8RcI5SY9b9majIIyqxUmxcUaToq2Y
         x81nqFU2gpz4kFZv3tzoxuGlNEv+SMsqNPFGGZjfuk+XrTgRiq0qqmbx7jJ4UqJ35JVl
         3hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzp4KIn25C6/1vn0IjwPISUvQBAaHVB5nSknZ59c4wg=;
        b=RQs560YI7GAj7EgKPzrSntdex5R+RT+NvQd6Y0TsS2s/P2Naw+ySSj3R6Rq0aIwro1
         yVsnmyw3+wuJVBWYpkX+pM+jkCqFgqr8M3RTEzbrp0UtNnM11D4sR3jYT6ciIlKoOaiF
         QdTY7e5DmjVtsy8IKv1BPPRglUDG+rsrKgnreGdj04apKq1C1OSCTL168ONXnHa5+eqx
         T774VuvrEEes97Hy+pf9DOuBfnVBAnfQLqp9PGZSaxwm0dD5R1oI5zUd8dypFm9q/RMs
         2f0rcGt4yb7fP9Ua1RXNa4SdYbt+HMUOLI2c6d7Ux6PMW4LmLjPxPXDpD+NSUql13PBT
         ij/g==
X-Gm-Message-State: AOAM5329vam8e6RjmDXEeJ9/bDrUbON9PAFdj2uYrdD+HlbiaqHWa842
        OJS+y2nf2se443ltW2Ua6lPkGH7Ar4BULw==
X-Google-Smtp-Source: ABdhPJwxoBv+4XGNryM/lqUVCqd7ZphPY/7mV6HZ9bAsbx09HTYZjqNta59mOQ4es3EXDS30zBzHUw==
X-Received: by 2002:a05:6808:a8c:: with SMTP id q12mr13440342oij.112.1619454009100;
        Mon, 26 Apr 2021 09:20:09 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id j11sm66347ooo.45.2021.04.26.09.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:20:08 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 37/43] completion: zsh: add correct removable suffix
Date:   Mon, 26 Apr 2021 11:14:52 -0500
Message-Id: <20210426161458.49860-38-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zsh has a nice feature that allows a suffix to be automatically removed
if followed by a space.

For example:

  git log --prety=

If a space is typed, the suffix '=' is removed.

But we have to set the correct prefix first.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 4e9699f542..43b7c1b210 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -51,7 +51,7 @@ functions[complete]="$old_complete"
 
 __gitcompadd ()
 {
-	compadd -p "${2-}" -S "${3- }" -- ${=1} && _ret=0
+	compadd -p "${2-}" -S "${3- }" -q -- ${=1} && _ret=0
 }
 
 __gitcomp ()
@@ -79,7 +79,8 @@ __gitcomp_opts ()
 
 		if [[ -z "${4+set}" ]]; then
 			case $c in
-			*=|*.) sfx="" ;;
+			*=) c="${c%=}"; sfx="=" ;;
+			*.) sfx="" ;;
 			*) sfx=" " ;;
 			esac
 		else
-- 
2.31.0


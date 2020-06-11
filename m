Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EC1C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 06:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D572072F
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 06:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJLUuVZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgFKG7m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgFKG7k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 02:59:40 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF29C08C5C1
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 23:59:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x6so4890388wrm.13
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 23:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ydblsq5391Sh2V97ZTnFfOW1gE+9Map7bAYJl97qdsM=;
        b=rJLUuVZL/VhPhqPGle82+R9UZQPb7lcz8sSZy+nOUWOVuYLREDbkLqHwf1skZj3FcJ
         xOSDZqvE8lXq5sdJYGLOYaRTHngpOiWr0nIQFRr1crzD78ChxYq/bMX7320RegsjLON6
         THKekQrVFRxGDoIopE6tADPXg+1Bc/mEba7TAZQd7imaZh0fGPHnDGMeNHtZxcl0hXlX
         kgWQtiy2RNSIhdQYLZ32VOHDP9U+79CJscz6BqzVTfoJnh3SmfZS523+pM4PuzTG6YlE
         T0K7u+pG9UDIzBagHsAzMdJ0wCArOw0mwwn/OTvvlF44YDM/6biJlNWgHY0s3W6lH03T
         RP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ydblsq5391Sh2V97ZTnFfOW1gE+9Map7bAYJl97qdsM=;
        b=AfWqir3UH9Nmtc8U4kz7KSmwL7llc8ggyg4Yg5/k6OnrHnWna18BrAJTv3uDSw9m7O
         dG9mK3oKt8rZ2rSSPO6a5ttUZvBQ24P7WtMoUZUbbjehnxXbFonDZSnI4mmqXiEpZkUh
         UigQ/zGOj84LvlG+mhSN5hwfp9wy0uBTCA1837fD4M2uhWxR7UN3x8z5/sQAr/QK0PCP
         wLoK7HkQWn+sWa3XSprS3LinHr5Dm7nUnPuIIKcYOcZI/rUB18yZeo1ZoGRO+EtgCoRY
         PBdkfSHQYKpSAy1mDzts+mUVSc/9oTBN3+mKWXagdiUZaE08n2/o8IVgnnAJZogrD+1+
         /buQ==
X-Gm-Message-State: AOAM5330+MQigKt7NhxciMO9CY/xblKfv7IkQkn9qRxfhSs1cfTdGgBj
        fT1+8ORrKweHKP8nP0thZU5FXjnW
X-Google-Smtp-Source: ABdhPJyzfwopFqHHu++bhXEotg5RLqT8mg+jdCpQ/eUneuCS4QZWCns+Q6Q6CuBEoZm9i9BqSsgrlA==
X-Received: by 2002:a05:6000:108c:: with SMTP id y12mr7559759wrw.88.1591858777265;
        Wed, 10 Jun 2020 23:59:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y14sm2648485wma.25.2020.06.10.23.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 23:59:36 -0700 (PDT)
Message-Id: <d59f877dd5cb5515f6af5ac6ce308263051b926b.1591858774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.806.git.git.1591858774.gitgitgadget@gmail.com>
References: <pull.806.git.git.1591858774.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Jun 2020 06:59:31 +0000
Subject: [PATCH 2/4] dir, clean: avoid disallowed behavior
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     bmalehorn@gmail.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

dir.h documented quite clearly that DIR_SHOW_IGNORED and
DIR_SHOW_IGNORED_TOO are mutually exclusive, with a big comment to this
effect by the definition of both enum values.  However, a command like
   git clean -fx $DIR
would set both values for dir.flags.  I _think_ it happened to work
because:
  * As dir.h points out, DIR_KEEP_UNTRACKED_CONTENTS only takes effect
    if DIR_SHOW_IGNORED_TOO is set.
  * As coded, I believe DIR_SHOW_IGNORED would just happen to take
    precedence over DIR_SHOW_IGNORED_TOO in the code as currently
    constructed.
Which is a long way of saying "we just got lucky".

Fix clean.c to avoid setting these mutually exclusive values at the same
time, and add a check to dir.c that will throw a BUG() to prevent anyone
else from making this mistake.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c | 2 +-
 dir.c           | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 4ca12bc0c0b..3ca940f83a2 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -954,7 +954,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		remove_directories = 1;
 	}
 
-	if (remove_directories)
+	if (remove_directories && !ignored_only)
 		dir.flags |= DIR_SHOW_IGNORED_TOO | DIR_KEEP_UNTRACKED_CONTENTS;
 
 	if (read_cache() < 0)
diff --git a/dir.c b/dir.c
index 6fb2f8ecdd7..a3ad9702d64 100644
--- a/dir.c
+++ b/dir.c
@@ -193,6 +193,10 @@ int fill_directory(struct dir_struct *dir,
 	const char *prefix;
 	size_t prefix_len;
 
+	unsigned exclusive_flags = DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO;
+	if ((dir->flags & exclusive_flags) == exclusive_flags)
+		BUG("DIR_SHOW_IGNORED and DIR_SHOW_IGNORED_TOO are exclusive");
+
 	/*
 	 * Calculate common prefix for the pathspec, and
 	 * use that to optimize the directory walk
-- 
gitgitgadget


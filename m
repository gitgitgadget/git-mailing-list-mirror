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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6661C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 10:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3D8613AB
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 10:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFVKtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 06:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhFVKtI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 06:49:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81E0C06175F
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 03:46:52 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id w13so5874075wmc.3
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 03:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=05uFgrb1GkfTkjVvkcz9DJ06gSQfx+NBo6TvoJAfbiM=;
        b=aXnrzBYv9QIcfnOt74MuLNv7mDy17JmtiC7MrD3rb/7qvBeo0www3lKAKdHd/HfRcX
         yIN81hu7jiCJZGX1uVcqVRL0bFORCYrO5JBsC9UyXqg5JTTrZjKIXjHYY//ePY2rXxh7
         Ah5vwn8Paitw4mMFrdN5zIkhZc7relAtV80mJmwGHIU7dQLH7fj6VaIQiA3zkkZCXqm3
         Nx65PpL7gIltD0MZjSTvPy8gTk/kP086AZXewISnqoh8LDiKgNwJBZnkvv30xbbO18JO
         dhTzwwQvuJVSTq3qpb1MD2WE/uh8QUk0yKHRlqtpIbJaFMHkbanDqLh9f3kjulPynLQq
         JntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=05uFgrb1GkfTkjVvkcz9DJ06gSQfx+NBo6TvoJAfbiM=;
        b=Wpdj91gIFVoCGqaTM0eA6fDNq9q25V8xi2QqGS0qCiNw7SgMASjDHIl594HXWE+N1A
         VyAGJMp347iwsZzRbApQYf1rOM3feZwrvLuBwi3kD9VPpVbIvWcSB+ezTRVkl/hNmHqL
         RU8jO+9G9kKWsXCKEKnTBdRcvoB4TyNBYMVTA1j4sWjquIqbog6+pH2vn8isAs/lTbgM
         xjnz3UWDUAKGWgtaNiUjHGAhAWxzciN2AVuoWkUFQj6Xxkh70DkjUVH8RpwfNRc/0R6c
         r1ojJWTURY5J7eQuSJJGVNPqMJxvHAXBD0Lhy7W43KMkjCDLI0sxgx5m2Zif4USg1wXu
         SVBA==
X-Gm-Message-State: AOAM533kyWIzTMqkkPWSBwcKlKT8Ypg1TTkvxZPkQyAhGxFcsTY6epct
        l8vZNJWWw5n88+s9VOtzhWYG7c5UMU0=
X-Google-Smtp-Source: ABdhPJxs7LeQGyzHfageikl1nzGFYAI2YeVUYWaHfUZo2MuDDbwV+1/lJiJZQPQ/hY5HApQVAirLxg==
X-Received: by 2002:a05:600c:3791:: with SMTP id o17mr3809424wmr.187.1624358811284;
        Tue, 22 Jun 2021 03:46:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g83sm2038626wma.10.2021.06.22.03.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 03:46:50 -0700 (PDT)
Message-Id: <e322e806639ec614b2550a69f3bd84c1ef16a698.1624358809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.984.git.1624358809.gitgitgadget@gmail.com>
References: <pull.984.git.1624358809.gitgitgadget@gmail.com>
From:   "Dennis Ameling via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 10:46:47 +0000
Subject: [PATCH 2/3] cmake(windows): set correct path to the system Git config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Dennis Ameling <dennis@dennisameling.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dennis Ameling <dennis@dennisameling.com>

Currently, when Git for Windows is built with CMake, the system Git config is
expected in a different location than when building via `make`: the former
expects it to be in `<runtime-prefix>/mingw64/etc/gitconfig`, the latter in
`<runtime-prefix>/etc/gitconfig`.

Because of this, things like `git clone` do not work correctly (because cURL is
no longer able to find its certificate bundle that it needs to validate HTTPS
certificates). See the full bug report and discussion here:
https://github.com/git-for-windows/git/issues/3071#issuecomment-789261386.

This commit aligns the CMake-based build by mimicking what is already done in
`config.mak.uname`.

This closes https://github.com/git-for-windows/git/issues/3071.

Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
---
 contrib/buildsystems/CMakeLists.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index a87841340e6a..bdc5ab58d038 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -204,8 +204,6 @@ list(APPEND compat_SOURCES sha1dc_git.c sha1dc/sha1.c sha1dc/ubc_check.c block-s
 
 
 add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
-			ETC_GITATTRIBUTES="etc/gitattributes"
-			ETC_GITCONFIG="etc/gitconfig"
 			GIT_EXEC_PATH="libexec/git-core"
 			GIT_LOCALE_PATH="share/locale"
 			GIT_MAN_PATH="share/man"
@@ -220,10 +218,15 @@ add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
 
 if(WIN32)
 	set(FALLBACK_RUNTIME_PREFIX /mingw64)
-	add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
+	# Move system config into top-level /etc/
+	add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}"
+		ETC_GITATTRIBUTES="../etc/gitattributes"
+		ETC_GITCONFIG="../etc/gitconfig")
 else()
 	set(FALLBACK_RUNTIME_PREFIX /home/$ENV{USER})
-	add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
+	add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}"
+		ETC_GITATTRIBUTES="etc/gitattributes"
+		ETC_GITCONFIG="etc/gitconfig")
 endif()
 
 
-- 
gitgitgadget


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1627FC433E9
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 13:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF76D239FD
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 13:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbhAUNOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 08:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731569AbhAUNK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 08:10:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7720C0613D3
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 05:09:48 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v15so1688043wrx.4
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 05:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vq3EkTAfK/UzVu7KjVNEHh8O0ZNT9WPIaD8RrQUo0sk=;
        b=Fau6QerFbL9NN2uKiHiVcpVi0SLCbB1hyUhAFOFI+tBwX5ijwz81aCFRav1NmBNIwe
         taQWGg7AEO6Nhvyp2Rn3P+oMV4xqY9+yqd00FLlhQuX3JvDvJ3IoK0hkjpvvk6sm3SNw
         MwYyxi8AyF5JOtqbhsJtY+Wej2mPZ4UbNauoWjx417ho5Tvgmm43zNgCKAaI3kVs7O90
         KXxoxK0cs1qylY3o75BF5E8zdl86TU2FM4dHbRi/rviLRSjR4CVqHkHhrXbPLgszZ/Gs
         Lf1Em8teuighmouDnh0I/YT2edaoFAxn/5K6TeyLG6Oeer9sf7DB3NZqDkjjdZCMJ+yo
         EOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vq3EkTAfK/UzVu7KjVNEHh8O0ZNT9WPIaD8RrQUo0sk=;
        b=GzXdHGfU7qO4dENJXmnp4Pe59zBNIDLQA9m4Q/Vg1l0DjnzLJlPKEOkfYShYGqnCGv
         1k1v9bde9H/D5HL/xJGHJjCWYN+80308C9RSOJhUut72c36BxJ+6tEhSY3YWM6KOjSXu
         YjefGeLJ9sqHYq4ubSPMEzzRF93xaTJA3Dz/MZ7MqbIWkAd6+TdJ+P9M4eG4MOdgBDyH
         S9Cm3rDoxqXHM8KjFcsUq2m9M122uCpAiOk2zO9mPPbzKs6AjRW2+yGDHUZcNHOtODF2
         kO9kPdXz6jcSCmRPML5gz84fe7D73G7UH/GA2kAO9OvklfqVAHsMLsIF61nDCtbRi5TD
         +6Gg==
X-Gm-Message-State: AOAM5323rhZdpfh9c9RvK7fVgqgwKOgedyl+zQPzbirwCmWcXh8ba8hd
        st8j/3pnwLkU6N792aRT//1boPz+ShE=
X-Google-Smtp-Source: ABdhPJwqzzajpJ4/9z6Q9wMbE74VlPMDXfcR93rI25y0p1yZNNiFGQOZc/xq0wiBenFGQdcMINKYFg==
X-Received: by 2002:adf:b74d:: with SMTP id n13mr13943848wre.62.1611234587282;
        Thu, 21 Jan 2021 05:09:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y14sm8734819wru.96.2021.01.21.05.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 05:09:46 -0800 (PST)
Message-Id: <pull.840.git.1611234585889.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Jan 2021 13:09:45 +0000
Subject: [PATCH] SKIP_DASHED_BUILT_INS: respect `config.mak`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `SKIP_DASHED_BUILT_INS` is specified in `config.mak`, the dashed
form of the built-ins was still generated.

By moving the `SKIP_DASHED_BUILT_INS` handling after `config.mak` was
read, this can be avoided.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    SKIP_DASHED_BUILT_INS: respect config.mak
    
    I stumbled over this the other day. I thought I had tested this a long
    time ago, but apparently it never worked in the way I want it to work.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-840%2Fdscho%2FSKIP_DASHED_BUILT_INS-and-config.mak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-840/dscho/SKIP_DASHED_BUILT_INS-and-config.mak-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/840

 Makefile | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 7b64106930a..0c7437e08c5 100644
--- a/Makefile
+++ b/Makefile
@@ -777,20 +777,6 @@ BUILT_INS += git-status$X
 BUILT_INS += git-switch$X
 BUILT_INS += git-whatchanged$X
 
-# what 'all' will build and 'install' will install in gitexecdir,
-# excluding programs for built-in commands
-ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
-ALL_COMMANDS_TO_INSTALL = $(ALL_PROGRAMS)
-ifeq (,$(SKIP_DASHED_BUILT_INS))
-ALL_COMMANDS_TO_INSTALL += $(BUILT_INS)
-else
-# git-upload-pack, git-receive-pack and git-upload-archive are special: they
-# are _expected_ to be present in the `bin/` directory in their dashed form.
-ALL_COMMANDS_TO_INSTALL += git-receive-pack$(X)
-ALL_COMMANDS_TO_INSTALL += git-upload-archive$(X)
-ALL_COMMANDS_TO_INSTALL += git-upload-pack$(X)
-endif
-
 # what 'all' will build but not install in gitexecdir
 OTHER_PROGRAMS = git$X
 
@@ -1226,6 +1212,20 @@ ifdef DEVELOPER
 include config.mak.dev
 endif
 
+# what 'all' will build and 'install' will install in gitexecdir,
+# excluding programs for built-in commands
+ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
+ALL_COMMANDS_TO_INSTALL = $(ALL_PROGRAMS)
+ifeq (,$(SKIP_DASHED_BUILT_INS))
+ALL_COMMANDS_TO_INSTALL += $(BUILT_INS)
+else
+# git-upload-pack, git-receive-pack and git-upload-archive are special: they
+# are _expected_ to be present in the `bin/` directory in their dashed form.
+ALL_COMMANDS_TO_INSTALL += git-receive-pack$(X)
+ALL_COMMANDS_TO_INSTALL += git-upload-archive$(X)
+ALL_COMMANDS_TO_INSTALL += git-upload-pack$(X)
+endif
+
 ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 

base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
-- 
gitgitgadget

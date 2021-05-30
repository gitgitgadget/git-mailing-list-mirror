Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E78BC47092
	for <git@archiver.kernel.org>; Sun, 30 May 2021 21:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B74610A0
	for <git@archiver.kernel.org>; Sun, 30 May 2021 21:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhE3VoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 17:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhE3VoY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 17:44:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040D4C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 14:42:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x8so8846911wrq.9
        for <git@vger.kernel.org>; Sun, 30 May 2021 14:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1sXvSb6t1vhf3HDq/of/givWBtqZN9GYw/0k3U+5XDc=;
        b=eaHgUNv9pfY7c4OB3RIRuzoVrnXDNkk7YqCFu5hVvo+yNgaUiMkNS2Pp/UpDsAUKfm
         CJwU57zVqNoePD7yUvJBLEzTYbjWxI13l9q0O6nsEdnKzAR8+vVT8qd64+2mB0x4fc6N
         pxRQPUqzxU654axG5iiWfRdNbmS6rHdqwujm7TWy+41CfFUh5fbBmwEmiuQRP+5YF1UK
         cKTYqJWhbLjholTq1fxwC41q4mODwFEAwedOfPEvs5j+Muid27fKbdf3xyTSEDzHAzVm
         nFz0KZwWF+RX2uDLYJLyzXMLb44PYzv8jojSa8ufpLKZIXgvVNuqhEIJmBOwryGVxgn+
         dJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1sXvSb6t1vhf3HDq/of/givWBtqZN9GYw/0k3U+5XDc=;
        b=AW3j48EqvPqdIrYPmKuGxUi5OsHTi2PbsCH7aiYMw8FyUigzPeaeM55PdtXbSnfasx
         L/QaR9J68hzWDg4s0LgiOjBP8KuKerzDxz8UWKaOTXS5QVFdt/Vr/3yBGq5pqBz3dz0e
         TXXWPdbVLVIrGbjFnX4+TATDmWwhTOU/yDWKD6/kl2KVDMsCiCxjmylOFq84U7HnfaZj
         EOQWpV9sCAbSLL/kn57vCzzUdHKWGRk0AM9YK/G2I/hvwA+iayZ6AX78snMv2cEGN6wM
         Tg3uf1h/KK9B3rnohSvQ63lS9Sj6z+cnb8t2raZDT/VQbqJfpu45jl4Os2oyc0rdF0Y8
         A4Hw==
X-Gm-Message-State: AOAM533X76H5xGuTu1hA6AIAaC8Hj+R+pKeISwDQRrZdn/J79iStloLS
        ghnMWgE3g9v9Da+RTcl7Jb1uF/y4VHE=
X-Google-Smtp-Source: ABdhPJwaRUDYyCmtSmeh9QudJKjSBTtN6TOXRgs9pix/x/D8hpVenp9/sYBkaOC48O02ZM8yui+Jsw==
X-Received: by 2002:a5d:6382:: with SMTP id p2mr1651903wru.338.1622410963518;
        Sun, 30 May 2021 14:42:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm14924971wrt.65.2021.05.30.14.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 14:42:43 -0700 (PDT)
Message-Id: <pull.964.git.1622410962551.gitgitgadget@gmail.com>
From:   "Dima Kov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 30 May 2021 21:42:42 +0000
Subject: [PATCH] refactor of git_setup_gettext method
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Dima Kov <dima.kovol@gmail.com>, Dima Kov <dima.kovol@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dima Kov <dima.kovol@gmail.com>

Use one "free" call at the end of the function,
instead of being dependent on the execution flow.

Signed-off-by: Dima Kov <dima.kovol@gmail.com>
---
    refactor of git_setup_gettext method
    
    Use one "free" call at the end of the function, instead of being
    dependent on the execution flow.
    
    Signed-off-by: Dima Kov dima.kovol@gmail.com
    
    Hi. My first PR fot Git repository. I went over the code and saw that
    maybe this part can be more clearer. Thanks.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-964%2Fdimakov%2Ffree_opt-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-964/dimakov/free_opt-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/964

 gettext.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/gettext.c b/gettext.c
index af2413b47e85..e75c7bfdb1a8 100644
--- a/gettext.c
+++ b/gettext.c
@@ -109,17 +109,14 @@ void git_setup_gettext(void)
 	if (!podir)
 		podir = p = system_path(GIT_LOCALE_PATH);
 
-	if (!is_directory(podir)) {
-		free(p);
-		return;
+	if (is_directory(podir)) {
+		bindtextdomain("git", podir);
+		setlocale(LC_MESSAGES, "");
+		setlocale(LC_TIME, "");
+		init_gettext_charset("git");
+		textdomain("git");
 	}
 
-	bindtextdomain("git", podir);
-	setlocale(LC_MESSAGES, "");
-	setlocale(LC_TIME, "");
-	init_gettext_charset("git");
-	textdomain("git");
-
 	free(p);
 }
 

base-commit: de88ac70f3a801262eb3aa087e5d9a712be0a54a
-- 
gitgitgadget

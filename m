Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665D6C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478B96108B
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbhJOJqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbhJOJqH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:46:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B50C061753
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e12so25479109wra.4
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0G66Uzp3mHCuMdixa/D6kvWiz/NaCj53nVaYvW3At4=;
        b=Lm7VQSqgWjGmHYutFM5IdQGfN5yX0whcup0KztqjKij+eYnPAub5p4jisx23NUtkDQ
         PltV3dS/o/qKZ4is7fkSNxcCZm2KURGHVIF1BGJSUyLcYcy/+o3c58wTBQsJBLZYhait
         roKD5m5C8YX2ylR5ce8iKReHDqjiTeiT2ZyL9NCuMsa6NIL3OaHLh6CXQaE9fqKYC3Yv
         IsDVz1Vp1dSz3n6LNQeI5r274WBVdXjhXUU9O2Sct/5OgUbL1Xa9lgYtm56t7ruBYDiw
         lwDaW2P8KpU97HBVDgjDUz7UnITC0x353/UC9G75uidEFTwfJHsXMKW92Qv1KuIFKjKb
         EKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0G66Uzp3mHCuMdixa/D6kvWiz/NaCj53nVaYvW3At4=;
        b=NaciVDcl0Op1HYbtkZolVGa+l/YgoCRX2oNNXk6z/mNWcmDsD8Fy7G0lvN8ZQ5L93p
         cmJqytqmRCPRn64sS1NHV4x2bjxcOhcVIQtfypNXUmXu1655rurUvnxNKUGVaxMi3jnS
         YqYGXlcjXom/lVo2Jq8QZVv8uX6rko2xdPxdyZdlWqNu1oqAoh7moi5zOKexk4AJZQDo
         hjpUxGUKscnMT5887HqkfPGQNgllUX/8jkHdBfQ2+HGRryecJuVzYGBPQdJrHeZghbyS
         lWaL6HKre/jYxoAFv9mmhxYkCZQ5vkFxpAYVJAxGpWmzE712qak6tXnzDciFP8Jg2ia2
         fLTA==
X-Gm-Message-State: AOAM5310MNYU6hMLiGy57mrMOOqualIUSsbjqHcVt9KOzPJWwxEdKsuD
        EqSvktMqZyRYfYs6U/h+U+1MkRwqPuDSmA==
X-Google-Smtp-Source: ABdhPJzddXikrcbVyMIMu8C7NN2mAwuek7+qyexIdJ1loOp0NG7tOHnJ4V9mFuii1dK9X+RMb8XuMA==
X-Received: by 2002:adf:a502:: with SMTP id i2mr12597441wrb.311.1634291035952;
        Fri, 15 Oct 2021 02:43:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4sm5963648wrz.58.2021.10.15.02.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:43:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/13] run-command: remove old run_hook_{le,ve}() hook API
Date:   Fri, 15 Oct 2021 11:43:41 +0200
Message-Id: <patch-v2-13.13-289d5a2d849-20211015T093918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

The new hook.h library has replaced all run-command.h hook-related
functionality. So let's delete this dead code.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 32 --------------------------------
 run-command.h | 16 ----------------
 2 files changed, 48 deletions(-)

diff --git a/run-command.c b/run-command.c
index d92e670c8ed..8a21ff525f3 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1323,38 +1323,6 @@ int async_with_fork(void)
 #endif
 }
 
-static int run_hook_ve(const char *const *env, const char *name, va_list args)
-{
-	struct child_process hook = CHILD_PROCESS_INIT;
-	const char *p;
-
-	p = find_hook(name);
-	if (!p)
-		return 0;
-
-	strvec_push(&hook.args, p);
-	while ((p = va_arg(args, const char *)))
-		strvec_push(&hook.args, p);
-	hook.env = env;
-	hook.no_stdin = 1;
-	hook.stdout_to_stderr = 1;
-	hook.trace2_hook_name = name;
-
-	return run_command(&hook);
-}
-
-int run_hook_le(const char *const *env, const char *name, ...)
-{
-	va_list args;
-	int ret;
-
-	va_start(args, name);
-	ret = run_hook_ve(env, name, args);
-	va_end(args);
-
-	return ret;
-}
-
 struct io_pump {
 	/* initialized by caller */
 	int fd;
diff --git a/run-command.h b/run-command.h
index 3fa7454cf8a..59e1fbff64c 100644
--- a/run-command.h
+++ b/run-command.h
@@ -224,22 +224,6 @@ int finish_command_in_signal(struct child_process *);
  */
 int run_command(struct child_process *);
 
-/**
- * Run a hook.
- * The first argument is a pathname to an index file, or NULL
- * if the hook uses the default index file or no index is needed.
- * The second argument is the name of the hook.
- * The further arguments correspond to the hook arguments.
- * The last argument has to be NULL to terminate the arguments list.
- * If the hook does not exist or is not executable, the return
- * value will be zero.
- * If it is executable, the hook will be executed and the exit
- * status of the hook is returned.
- * On execution, .stdout_to_stderr and .no_stdin will be set.
- */
-LAST_ARG_MUST_BE_NULL
-int run_hook_le(const char *const *env, const char *name, ...);
-
 /*
  * Trigger an auto-gc
  */
-- 
2.33.1.1338.g20da966911a


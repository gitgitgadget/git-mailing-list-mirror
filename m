Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAA9C4332F
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3CE36115A
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhJSXXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhJSXXt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 19:23:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19A3C061746
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:35 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y74-20020a1c7d4d000000b00322f53b9bbfso6277691wmc.3
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0aPNBwCfdoAMegksN9nv71N+iTYj+/aoXVRkwOys1g=;
        b=MdLH+qipM3esgrwiPBtQPrARJVlh4C03YmaoU5hOTqxMCJt18inDvpH8ZmuXx1GeWW
         l20R+3uXwrA7UUEIdjLx1xU8s3PVv9a6pQ9Atf6kho7GShl9SE+Bud6w7dWps6cSaabB
         763hOI7cvljPeiUIMNt66JpZIuen0uJsm68BSXy7xi2jidpgNCHt48FS2htEW4tpI50B
         je+o1aXWuGzxoNgZlLHt7Rv8SzZYIq3p+BcBnJQHtNG7Uma/R15hfkGvFYs7hEcxqdT3
         whJVJj3WEgi5JBBOokDfMYVdplof531ac2YdR3x3Aco7qiqwio9FAkXfWhYRM8nmruJd
         JJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0aPNBwCfdoAMegksN9nv71N+iTYj+/aoXVRkwOys1g=;
        b=OKG5YaSY8EUup7kSwAow9mo6MxVxFES2UMpTFV1JzKMqfzkur4KdZ+lD9gCBKAI6xy
         XFqx3xZm/MlBT3+dCeU6CyG86hlOIaNruA0ud4DoZKTRu7U7vKa9gFoCce6wt6FqlQE9
         DKN9WxIj91mVERnPVOJoRld3YVvNB7tCL5e8Ax/oGExS30KtT4TSmvsnzxNKVyUH5q/f
         /L/Rjjpvy9jOl0ufqJyfR4LihWU6GkqFPKlJp/cdOxTzMbXN0jLDuQa3OubmemqpDYXN
         bQ8q5jru2wBKgz7h5aADLKvhjH4lU2G+w2qzozwQSzLclE5BpclQBs6niPlbgwm7ezXu
         fePA==
X-Gm-Message-State: AOAM533DEh6CXQOg5Mtb2OnZzqY7E1X+NlxA8xdB1yroBdOXx1BmLPzl
        Of6VDE/fxOBgwNaDjfP4k32jJrFfXp7XEw==
X-Google-Smtp-Source: ABdhPJwV2sNRURda1nshbmn1pKMsgH29MLdPD+8g7PRtb9w4De8qtMHH/ZLneFJbV6ThefRRRnoPBQ==
X-Received: by 2002:adf:8b1a:: with SMTP id n26mr47345443wra.182.1634685693968;
        Tue, 19 Oct 2021 16:21:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g25sm304644wrc.88.2021.10.19.16.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:21:33 -0700 (PDT)
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
Subject: [PATCH v3 06/13] merge: convert post-merge to use hook.h
Date:   Wed, 20 Oct 2021 01:20:44 +0200
Message-Id: <patch-v3-06.13-7a9fd8627cd-20211019T231647Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Teach post-merge to use the hook.h library instead of the
run-command.h library to run hooks.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index cc4a910c69b..c48b875b82b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -448,6 +448,7 @@ static void finish(struct commit *head_commit,
 		   const struct object_id *new_head, const char *msg)
 {
 	struct strbuf reflog_message = STRBUF_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	const struct object_id *head = &head_commit->object.oid;
 
 	if (!msg)
@@ -488,7 +489,8 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
-	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
+	strvec_push(&opt.args, squash ? "1" : "0");
+	run_hooks_oneshot("post-merge", &opt);
 
 	apply_autostash(git_path_merge_autostash(the_repository));
 	strbuf_release(&reflog_message);
-- 
2.33.1.1338.g20da966911a


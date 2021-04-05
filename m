Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807C6C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 13:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A941611BE
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 13:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbhDENE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 09:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhDENE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 09:04:26 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4098DC061788
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 06:04:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i18so7412722wrm.5
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RxYhwUVO73QD53gXj34Ia2LkRQxnBglVimbVxWy9/Ic=;
        b=WnRZkYf/pXmiStz/coRa+0Jnq814xR3uU5OKWhqM7osohLVB0awP1gYNGMerw3hZ7x
         aK6xJMBAtA3F7FSNMtrJSbOhk3eTmrrjbdpxrz9Qyv6Y1xhnHdvBiejAFwCBHoS5+POf
         zKgHQEo6Ll0/rZgaM8jGxdaYS7M1qJT6P9aqwrHE7Z/uFXDV0MUNkU7LVIEWufO+x7+w
         3b1SV4gGAKK6lymnbLS0L/RUW20QTsix7k8LBltCH3qgjJOCW2Ayr0Br91ybmwiogmip
         uPeB5aMCYpYF9+gKvmsKzLk6s6kAY6GkdJXItBrpEwkM2rFcDSbWpH5TYRnik0tahZ+j
         XcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RxYhwUVO73QD53gXj34Ia2LkRQxnBglVimbVxWy9/Ic=;
        b=RAPAg5cywsSMMsoJiFZPqFpdyT9GS2Xof7CH1xR/EcijI43uxRxm5XPozJXyTzMrrP
         0Q653guDac93IL8CATUvFXA+OAfw0cBA4FKyGO7qnA6rekj1einVg23wFPuDJkGshMTW
         ZNW2pHpumyDzhG3UUz4E3Txvk6xsM68mqmY48iO/xX7IwdeMp73zFywbBTwcls9p52fl
         Y/Htwd4zRONr3IAt7WNEQwygAzaGUYHx8FJGkC3vMIzEVKqKUWQMLxAnfzd2USgFZEIy
         2NXOuEi5bvfBzkjgWAuPgnQT/lGoTKAXdK44DxoRyfgHcQMSGo1yM6lyNQDE3+9loCgK
         id1g==
X-Gm-Message-State: AOAM533/FQj/SG6GTft639Mh89lVvD78DoiIIAUNRslwgM2MGp9MWIU4
        bW9NolXTgT5U2DnfwqQ683e5RUECsi0=
X-Google-Smtp-Source: ABdhPJxZ5VbLUdRe8JvC414Rk8Iu+rxgyp0+MrWVjZB/X+Z4Jf7CFR09YAWsEyHrrsryZXX3yjZMRg==
X-Received: by 2002:adf:ee0a:: with SMTP id y10mr27968796wrn.177.1617627858757;
        Mon, 05 Apr 2021 06:04:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1sm23320033wmq.29.2021.04.05.06.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 06:04:18 -0700 (PDT)
Message-Id: <3a94ff80657cd8e0142c1007be4f183c6a18587e.1617627856.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.git.1617627856.gitgitgadget@gmail.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Apr 2021 13:04:11 +0000
Subject: [PATCH 1/5] maintenance: simplify prefetch logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous logic filled a string list with the names of each remote,
but instead we could simply run the appropriate 'git fetch' data
directly in the remote iterator. Do this for reduced code size, but also
becuase it sets up an upcoming change to use the remote's refspec. This
data is accessible from the 'struct remote' data that is now accessible
in fetch_remote().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index ef7226d7bca4..fa8128de9ae1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -873,55 +873,38 @@ static int maintenance_task_commit_graph(struct maintenance_run_opts *opts)
 	return 0;
 }
 
-static int fetch_remote(const char *remote, struct maintenance_run_opts *opts)
+static int fetch_remote(struct remote *remote, void *cbdata)
 {
+	struct maintenance_run_opts *opts = cbdata;
 	struct child_process child = CHILD_PROCESS_INIT;
 
 	child.git_cmd = 1;
-	strvec_pushl(&child.args, "fetch", remote, "--prune", "--no-tags",
+	strvec_pushl(&child.args, "fetch", remote->name, "--prune", "--no-tags",
 		     "--no-write-fetch-head", "--recurse-submodules=no",
 		     "--refmap=", NULL);
 
 	if (opts->quiet)
 		strvec_push(&child.args, "--quiet");
 
-	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote);
+	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote->name);
 
 	return !!run_command(&child);
 }
 
-static int append_remote(struct remote *remote, void *cbdata)
-{
-	struct string_list *remotes = (struct string_list *)cbdata;
-
-	string_list_append(remotes, remote->name);
-	return 0;
-}
-
 static int maintenance_task_prefetch(struct maintenance_run_opts *opts)
 {
-	int result = 0;
-	struct string_list_item *item;
-	struct string_list remotes = STRING_LIST_INIT_DUP;
-
 	git_config_set_multivar_gently("log.excludedecoration",
 					"refs/prefetch/",
 					"refs/prefetch/",
 					CONFIG_FLAGS_FIXED_VALUE |
 					CONFIG_FLAGS_MULTI_REPLACE);
 
-	if (for_each_remote(append_remote, &remotes)) {
-		error(_("failed to fill remotes"));
-		result = 1;
-		goto cleanup;
+	if (for_each_remote(fetch_remote, opts)) {
+		error(_("failed to prefetch remotes"));
+		return 1;
 	}
 
-	for_each_string_list_item(item, &remotes)
-		result |= fetch_remote(item->string, opts);
-
-cleanup:
-	string_list_clear(&remotes, 0);
-	return result;
+	return 0;
 }
 
 static int maintenance_task_gc(struct maintenance_run_opts *opts)
-- 
gitgitgadget


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF22C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 960B5613BD
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbhDFSsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 14:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbhDFSsC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 14:48:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34ABC06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 11:47:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b9so7417211wrs.1
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 11:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Llo0Of7xrxXb6L4qe3wjXKvb7OepjL9FntDDDajZ5Mw=;
        b=DMyp7iRDR6qii+ndDYKda85Lrw1I11PqvwyMBEIbUV6Q0vueUN42ry5CdZEDy6AYN6
         R01gm+CbZgiXGDrfvgvSVfH1+LetRPQX06MY7ja/ka9FCS7lUnEHNce/81zeq32ad60p
         fAqW9CPSF8/mfVZZbBwRlXtlBugYkGXD/qwYb2zSwLKdm/Cnqk/CiwL1MtBzT3VAziDe
         q+VCiPosmdDoLNwO5oXeGTduGR2UDr9jMDsx+ldWIyi2akk5Z5VtyJWIj5mfyefavX2Z
         Gt7c/ydfzUnEg/SkuFN1b4VNCtvbnZ4CUY58Q4Y6a11pgV47fepV/vFz3YC0lR1lWBOz
         OjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Llo0Of7xrxXb6L4qe3wjXKvb7OepjL9FntDDDajZ5Mw=;
        b=ea9AVDGQ+QisottLuOMCW4WTsDSHW7Jbh8Bz6wDdpmTOuoMVWhv1MU/oBoGa38ujqR
         BodFwghl/c/JkjmeUDxydSKTL5wTQLvZDcOYkxpHCZL6NGIeHnUnetX+2F9+XT4WCFHb
         57tqzuUD/kZI1rpsPfewlIAq0pw/zugOVuPC34vPjk2KAeee2GEjcbhVFabQ1yfYAjEb
         qJTlGOY4NSjSRPpqfFnBlphPgJSPJzDxR3+8hhtDuYwAjbjhTGPb8Gkyl6TVRytsgwWO
         x3Cq5V4hEjbnhGjriPZDxCgO/2tkFA6HKJt8apkJrmjNj7zB6iLUS4NMxvH073ZUe1x1
         Li7Q==
X-Gm-Message-State: AOAM530H7K5qyF5lbLKT0g2smc6ZWcHItLYv2B8tmjnTlCFHLHZtH2iN
        ihTJKwB4b4EnnK9gxDBBeDezy17buIs=
X-Google-Smtp-Source: ABdhPJwp9Ga7oNmi7zd/9E17vzxh9jH1+lBGS+vmBw7Iqmld3bvvb9PuDjZFHVlrfdwVcCxbQYAjPA==
X-Received: by 2002:adf:f8c2:: with SMTP id f2mr5089623wrq.194.1617734872603;
        Tue, 06 Apr 2021 11:47:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o24sm3718380wmr.26.2021.04.06.11.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 11:47:52 -0700 (PDT)
Message-Id: <5aa0cb06c3f2e31a51bb6747fa84de69c0c1212f.1617734870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
        <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Apr 2021 18:47:46 +0000
Subject: [PATCH v2 1/5] maintenance: simplify prefetch logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous logic filled a string list with the names of each remote,
but instead we could simply run the appropriate 'git fetch' data
directly in the remote iterator. Do this for reduced code size, but also
because it sets up an upcoming change to use the remote's refspec. This
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


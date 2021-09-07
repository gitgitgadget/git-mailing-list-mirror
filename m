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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC15C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD8761102
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245316AbhIGMBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245337AbhIGMBI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:01:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D85C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:00:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q21so5672176plq.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAnrAMniDhwa/wJ6ftznhYiIsAwrAhEMX9gKAv8H5R4=;
        b=ndOX0H/whyeBKWVHsBfHPhHZsi9nWGvdxpKq5/01g9Y8pzEr3CQV50hvvDgFfnAYHV
         HyrMZnlVkhINbZ/hngyNdisBSWToGRGv3TkND9jOXtEPT5DHuU7Gg4kgk6XGUW9MiNYX
         /0RH53uS4elierwFXu5nxLdOCwIZPBChczMKlbZ4H14838Dtsj5SNiZ7JFWfPI1LfgWg
         R1CsQtEyk+SYwL/K9yqzyAcJMN7WVxAW2vUHnzRr0kGNUhHdBtRNhu9GtmVRcphd5hFn
         iG8NgHMnbOBmX63h8SOCjeczYIipk7WaAwKYsHInwgIIT7SjawLfhRAjplvNWboBl2mC
         unGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAnrAMniDhwa/wJ6ftznhYiIsAwrAhEMX9gKAv8H5R4=;
        b=sLttG6XIzJEeJqMWuOyJWWmf2S8pjZaDXF9MBOjT+ADm7ewVbx8GgAQBRpBBr/inLR
         poq+iCDWt3uXxPNphLKXs+yYpXhBcx2r6L6hrVRB9IDzYuKnmLf0aqQJn7Txa7NM3rp7
         THtqFJsgLttdcsxmHp0EJCC7AS5z6c6AhGBuHO9agP7hXyVsbKhWw7ViNAQuQgJfyQ9B
         +665+xQdO4/19Ia7kzIUIX/GdJWLpLHANCj+/kv6CEs2kQkE0bKdGPlJ0vG17NF8S2mL
         yt26lf6MAX9X63AG/hBagFb2jsgFHUZKQx0hvCtpXkffP6qDlMd7tBeaQm0g/59RvIuT
         BVoQ==
X-Gm-Message-State: AOAM5302145VUPxSGFaQLMMPS7rNs5uf1R50RhS2g5M9XvtfpwmZHj2i
        AHSbg6qdI+T1xO4wGMzEQZwtT6Y4/Q8=
X-Google-Smtp-Source: ABdhPJxxBP+/Xv0xhUucEtszt2BRBcLkWCFWXW7+mE1+rG6czBEi4Rf2u96kMgPZ/cH04q4ypW8/ug==
X-Received: by 2002:a17:90a:4894:: with SMTP id b20mr4117493pjh.13.1631016002156;
        Tue, 07 Sep 2021 05:00:02 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id a142sm11248150pfd.172.2021.09.07.04.59.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 05:00:01 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, emilyshaffer@google.com,
        gitster@pobox.com, jrnieder@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com, avarab@gmail.com,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: [PATCH 03/13] submodule--helper: introduce get_default_remote_submodule()
Date:   Tue,  7 Sep 2021 17:29:22 +0530
Message-Id: <20210907115932.36068-4-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210907115932.36068-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before 8ef1d2b549 (submodule--helper: get remote names from any
repository, 2021-07-20), it was not possible to directly retrieve a
submodule's remote name within the same process, because
`get_default_remote()` used only knew about the current repository.

Now that we have `repo_get_default_remote()`, we no longer have to start
a subprocess that called `submodule--helper get-default-remote` from
within the submodule directory.

Let's make a function called `get_default_remote_submodule()` which
takes a submodule path, and returns the default remote for that
submodule, all within the same process.

We can now use this function to save an unnecessary subprocess spawn in
`sync_submodule()`, and also in the next patch, which will require this
functionality.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1a65de4fa4..f6c4fc349b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -54,6 +54,19 @@ static char *repo_get_default_remote(struct repository *repo, const char *refnam
 	return ret;
 }
 
+static char *get_default_remote_submodule(const char *module_path)
+{
+	const char *refname;
+	const struct submodule *sub;
+	struct repository subrepo;
+
+	refname = refs_resolve_ref_unsafe(get_submodule_ref_store(module_path),
+					  "HEAD", 0, NULL, NULL);
+	sub = submodule_from_path(the_repository, null_oid(), module_path);
+	repo_submodule_init(&subrepo, the_repository, sub);
+	return repo_get_default_remote(&subrepo, refname);
+}
+
 static char *get_default_remote(void)
 {
 	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
@@ -1374,7 +1387,6 @@ static void sync_submodule(const char *path, const char *prefix,
 	char *remote_key = NULL;
 	char *sub_origin_url, *super_config_url, *displaypath;
 	struct strbuf sb = STRBUF_INIT;
-	struct child_process cp = CHILD_PROCESS_INIT;
 	char *sub_config_path = NULL;
 
 	if (!is_submodule_active(the_repository, path))
@@ -1423,14 +1435,9 @@ static void sync_submodule(const char *path, const char *prefix,
 	if (!is_submodule_populated_gently(path, NULL))
 		goto cleanup;
 
-	prepare_submodule_repo_env(&cp.env_array);
-	cp.git_cmd = 1;
-	cp.dir = path;
-	strvec_pushl(&cp.args, "submodule--helper",
-		     "print-default-remote", NULL);
-
 	strbuf_reset(&sb);
-	if (capture_command(&cp, &sb, 0))
+	strbuf_addstr(&sb, get_default_remote_submodule(path));
+	if (!sb.buf)
 		die(_("failed to get the default remote for submodule '%s'"),
 		      path);
 
-- 
2.32.0


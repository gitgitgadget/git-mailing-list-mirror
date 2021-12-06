Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B29C433FE
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 22:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355557AbhLFWIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 17:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353284AbhLFWIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 17:08:39 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6E1C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 14:05:10 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d24so25474930wra.0
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 14:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TuvXcB7Fb5uEg0xHM1CNJzb1NQXxlBGI3DvFwCwQ0VQ=;
        b=nAlmAgX/RcyUAPzoPgbhrCM7YUhJf2C7uSEW2VOKSkgZv1nQRllEmNPsoGGClO7WFm
         5LkJy2m4byGpIiySIjWTwBiVtdw3lPWdxrleJFbOLTn+rNMSj7JLKW1cFchKGskwKIzb
         Fyc/VcJ1iImuOGAFlhBEJ8+PLqen6aIC9DobXcZ2NCoElENd35VR+0tCs3D9OnijfE+O
         YA5tY6P7Xkwha34GW/NEqG5Z0LhIzkp8gu0aFXVXmXPUXs2hNTK0m2SNgJ2erQwS/dFP
         G9RMScE97zQN9NuMtUYKx1jjmh7FUS2YHjSMPEi06mMrF9PbvmUZo4eAohBK930C3bsg
         Kd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TuvXcB7Fb5uEg0xHM1CNJzb1NQXxlBGI3DvFwCwQ0VQ=;
        b=BnhTpWrlZcZ2qqO4g+wTH4jPRr+fogZKMLtIU8/JRb3tZKzUsHHmp/sZUiEzQySzl1
         pNy01h21dzw3aIfhSmjZ1NPBEGG82yGl1nE/75/BN4QTX+lSaqhmrMKGZZv2TnOPkS6r
         vA0GmOMQzfayXrXimxZn8OfoB5sEPO3Do3IVgUBUlF1tYlJPDmMjN+CCgD+UTjRCSxZ6
         WASf+Vd4YxnDvM1bytdRSGalM2IGLMaz2sRAGDVvwKu5H957hLArvotRceTaDkrt5rMA
         FnYDeWVHMXZ10CbEGTyoc79dPvBEYJBw5rQbVbIMq3iq3Tcs0jBKUgQi1AHutk05EGRk
         vayg==
X-Gm-Message-State: AOAM530wi9UXEbCqfPyVr+BhnYB+QoSS68aEyIOrrwxW89AVDVbtpXK2
        Dnm33WGss6ui0K74Gd4U0iFLNWCiEc4=
X-Google-Smtp-Source: ABdhPJysY6WL9Z9rRMUQd42pRf47/5DXv6eHQ6sgoWc6kqya2AtuOlpLAoik3B/S/5Qky41mSr1fiA==
X-Received: by 2002:adf:a145:: with SMTP id r5mr44336765wrr.462.1638828308625;
        Mon, 06 Dec 2021 14:05:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e12sm15986938wrq.20.2021.12.06.14.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 14:05:07 -0800 (PST)
Message-Id: <4e44121c2d7bced65e25eb7ec5156290132bec94.1638828305.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1091.v3.git.1638828305.gitgitgadget@gmail.com>
References: <pull.1091.v2.git.1638750965.gitgitgadget@gmail.com>
        <pull.1091.v3.git.1638828305.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 22:05:05 +0000
Subject: [PATCH v3 2/2] tmp-objdir: disable ref updates when replacing the
 primary odb
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

When creating a subprocess with a temporary ODB, we set the
GIT_QUARANTINE_ENVIRONMENT env var to tell child Git processes not
to update refs, since the tmp-objdir may go away.

Introduce a similar mechanism for in-process temporary ODBs when
we call tmp_objdir_replace_primary_odb. Now both mechanisms set
the disable_ref_updates flag on the odb, which is queried by
the ref_transaction_prepare function.

Peff's test case [1] was invoking ref updates via the cachetextconv
setting. That particular code silently does nothing when a ref
update is forbidden. See the call to notes_cache_put in
fill_textconv where errors are ignored.

[1] https://lore.kernel.org/git/YVOn3hDsb5pnxR53@coredump.intra.peff.net/

Reported-by: Jeff King <peff@peff.net>

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 environment.c  | 4 ++++
 object-file.c  | 6 ++++++
 object-store.h | 7 +++++++
 refs.c         | 2 +-
 repository.c   | 2 ++
 repository.h   | 1 +
 6 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index fe51dfe24d4..a8b64f5194f 100644
--- a/environment.c
+++ b/environment.c
@@ -169,6 +169,10 @@ void setup_git_env(const char *git_dir)
 	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
 	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
 	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
+	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
+		args.disable_ref_updates = 1;
+	}
+
 	repo_set_gitdir(the_repository, git_dir, &args);
 	strvec_clear(&to_free);
 
diff --git a/object-file.c b/object-file.c
index 0b6a61aeaff..659ef7623ff 100644
--- a/object-file.c
+++ b/object-file.c
@@ -699,6 +699,12 @@ struct object_directory *set_temporary_primary_odb(const char *dir, int will_des
 	 */
 	new_odb = xcalloc(1, sizeof(*new_odb));
 	new_odb->path = xstrdup(dir);
+
+	/*
+	 * Disable ref updates while a temporary odb is active, since
+	 * the objects in the database may roll back.
+	 */
+	new_odb->disable_ref_updates = 1;
 	new_odb->will_destroy = will_destroy;
 	new_odb->next = the_repository->objects->odb;
 	the_repository->objects->odb = new_odb;
diff --git a/object-store.h b/object-store.h
index cb173e69392..6f89482df03 100644
--- a/object-store.h
+++ b/object-store.h
@@ -27,6 +27,13 @@ struct object_directory {
 	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
 	struct oidtree *loose_objects_cache;
 
+	/*
+	 * This is a temporary object store created by the tmp_objdir
+	 * facility. Disable ref updates since the objects in the store
+	 * might be discarded on rollback.
+	 */
+	int disable_ref_updates;
+
 	/*
 	 * This object store is ephemeral, so there is no need to fsync.
 	 */
diff --git a/refs.c b/refs.c
index d7cc0a23a3b..ac744e85f5f 100644
--- a/refs.c
+++ b/refs.c
@@ -2137,7 +2137,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 		break;
 	}
 
-	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
+	if (refs->repo->objects->odb->disable_ref_updates) {
 		strbuf_addstr(err,
 			      _("ref updates forbidden inside quarantine environment"));
 		return -1;
diff --git a/repository.c b/repository.c
index c5b90ba93ea..dce8e35ac20 100644
--- a/repository.c
+++ b/repository.c
@@ -80,6 +80,8 @@ void repo_set_gitdir(struct repository *repo,
 	expand_base_dir(&repo->objects->odb->path, o->object_dir,
 			repo->commondir, "objects");
 
+	repo->objects->odb->disable_ref_updates = o->disable_ref_updates;
+
 	free(repo->objects->alternate_db);
 	repo->objects->alternate_db = xstrdup_or_null(o->alternate_db);
 	expand_base_dir(&repo->graft_file, o->graft_file,
diff --git a/repository.h b/repository.h
index a057653981c..7c04e99ac5c 100644
--- a/repository.h
+++ b/repository.h
@@ -158,6 +158,7 @@ struct set_gitdir_args {
 	const char *graft_file;
 	const char *index_file;
 	const char *alternate_db;
+	int disable_ref_updates;
 };
 
 void repo_set_gitdir(struct repository *repo, const char *root,
-- 
gitgitgadget

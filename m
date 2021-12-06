Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A719C433FE
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 00:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbhLFAjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 19:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241692AbhLFAji (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 19:39:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29D2C061751
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 16:36:10 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q3so18855066wru.5
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 16:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aBUPWg290Pm6pLig53PzPZ68pgytiSx64oEFtcO6jpE=;
        b=d18OLtfX1itzd419OF6lpeO5lw5weeijweztlVCT4M6ePSqujpSgLMHkmoRFEjpRW2
         hhEPgWfPc2E2aOXU5ZIG6rilqYhQYKgoeO+Cc8+0XbjfyLiVLgW1lknoFrsLEVlBWkPy
         Rx5BZBphe52JQzOWpGPPnz1CwfPNbc9COmOmZNXLVoEojohjAPk2MpDkiQQY82iZjsrt
         uVeY5ITzqIGTDDNNA2Fmo4JE3rixawASjK9ZsL6js70WSJW0qZt/Dk4T5Nq6hrVYMM2L
         2DyZK/D0LIXOSp72Cw4zdM5PwqCl+A7V+uoUD50yqBDfV2GRO8SZ4EHf4oDvRIzscNE2
         SqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aBUPWg290Pm6pLig53PzPZ68pgytiSx64oEFtcO6jpE=;
        b=zFt3QE60GSKQjU6pLPXNHg2OPB/3CuSKS2RQxuoKWkOPvi9+ox/aUiFWZi7QQ4RKxa
         wL39HVuzY96kfWFGLeK1zmbFVux29FV2K0XDnBQJtsRyp+/rx0WlCNvMKnWaxPT+0JZ5
         zrVdA5CZWtztq3YFcwvd2OlZtNDeGlnhMsAz4JlbLdLfShHjZhVREjA02eENKknhaA0E
         /s8g3FHhe92k05M1aGcLvJmWXXc4HJDlZtgk9qsfmUnYtBT0CGRWAI8z/WAnv8QRV3fB
         NrqT4L06Erd1ideRdeJpc2ATDdOmH12fLA7D0rCFPsi+hv6iG+D2Q7/5e6CkcZmMnzlv
         PEMA==
X-Gm-Message-State: AOAM532SphTTopIpYVxYwu9sjOSyl+0QZgEy9zsbGybdqZWwnTvRWwGy
        Sr+H6mIyhVeGfBx7R6DIbmyYBgw7Ibs=
X-Google-Smtp-Source: ABdhPJzn9D2FFkYUOdLHFxCMufxUhPgPJ/vnfKMh3wCkVvc73kx0nYCZx1Pahvkv6CBsUcv8GTdObw==
X-Received: by 2002:a5d:6d88:: with SMTP id l8mr39086901wrs.270.1638750968992;
        Sun, 05 Dec 2021 16:36:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm9444232wrw.87.2021.12.05.16.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 16:36:08 -0800 (PST)
Message-Id: <f667cbcc47dd59d029f8712464f0551898a70b15.1638750965.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1091.v2.git.1638750965.gitgitgadget@gmail.com>
References: <pull.1091.git.1638585658.gitgitgadget@gmail.com>
        <pull.1091.v2.git.1638750965.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 00:36:05 +0000
Subject: [PATCH v2 2/2] tmp-objdir: disable ref updates when replacing the
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

Note: This change adds an assumption that the state of
the_repository is relevant for any ref transaction that might
be initiated. Unwinding this assumption should be straightforward
by saving the relevant repository to query in the transaction or
the ref_store.

Peff's test case was invoking ref updates via the cachetextconv
setting. That particular code silently does nothing when a ref
update is forbidden. See the call to notes_cache_put in
fill_textconv where errors are ignored.

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
index 342400fcaad..2701dfeeec8 100644
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
index 82cf13f1054..9ae9262c340 100644
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
+	unsigned int disable_ref_updates : 1;
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

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42C0C4332F
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 02:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384119AbhLDCo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 21:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384112AbhLDCo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 21:44:27 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B913FC061359
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 18:41:02 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso6275282wmr.4
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 18:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nIwWOzyteUPgtg6V/gbptI+dO14mDOtHt15Ldl+xrEE=;
        b=YvjE7bawO012+ypSC8WyE1cUtiMq10j2dqtjLbHk2rxLx/WQRstnHHbqZV81PDxLOV
         BYfY6VAzHXbWIh64fRX8kfUVa1c74z2keDI+Yx169XsjL0XCfjyl7dYmP0CIbRVFL0Mp
         /IDrgAcYxFdEKYB8SEBCdntPKm0MS7I+zMSZo5ecl95JrNu13BeXJXRFnctuxHKOPTrY
         23sOAs4e5lMRI6yr3sq5p0te1yodjLfDHozN0l3eorCPhqJRvSL0sYHt8sCwKTTWw5Sw
         ImuGUuvJCQaOqU/MydMAc5QQgPzA6wk/igF6e8RqRiXcpQvyanANsEbSdoGrQlq/5eJW
         6aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nIwWOzyteUPgtg6V/gbptI+dO14mDOtHt15Ldl+xrEE=;
        b=q5s2fzcrkvBcKmT5Ui+ptuFUe36iZxJ3ouiHLkw2FxwOHdVYaXgzwh7DOmpOGkNICp
         5sQylqM2m5/WT1ZvLjljWUgJXYin4X9dAnA247Fj6bmtKZwrexGMhJ3sy3SXuXQf+Eiv
         SAe8q2fgGk0VBHLvTlZFQnkdA6812o5aZosZ44Z7TEq8zqnL6UDngXBn0OCIBv4wvGs4
         VBfeCWEfEqGhDNvTQUqXQagXndbcuNAtmkucklSK6x7KrO082Kgx+rcRQqIAEDdTlkd8
         nj4OshFbFVkW2E8xwZLQwGoCupXy+nCYnak8hVNt1jLS8LVqxXA20L7HRGPQkOmXCr84
         +pxA==
X-Gm-Message-State: AOAM5337gKnGEvNs4/iyLOXA28pplTPtFaPuP5fNueCWl4VD1noaNGDu
        nYjo3GBbbxJhZKJ2I/RKIgxg3GKarTY=
X-Google-Smtp-Source: ABdhPJysw+UrEAFkK81Cvq+x1Y/UpaTMZ70xp9bK9qjjcUNsNWLsKjPFueZlSzr12T13ZhIQWuPtsQ==
X-Received: by 2002:a05:600c:3ba3:: with SMTP id n35mr20337975wms.88.1638585661192;
        Fri, 03 Dec 2021 18:41:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l21sm4191881wrb.38.2021.12.03.18.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 18:41:00 -0800 (PST)
Message-Id: <d8ae001500c788cdabf4e6918da0a7ce89a48fc6.1638585658.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1091.git.1638585658.gitgitgadget@gmail.com>
References: <pull.1091.git.1638585658.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 02:40:58 +0000
Subject: [PATCH 2/2] tmp-objdir: disable ref updates when replacing the
 primary odb
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Neeraj K. Singh" <neerajsi@microsoft.com>,
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
 object-store.h | 9 ++++++++-
 refs.c         | 2 +-
 repository.c   | 2 ++
 repository.h   | 1 +
 6 files changed, 22 insertions(+), 2 deletions(-)

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
index cb173e69392..9ae9262c340 100644
--- a/object-store.h
+++ b/object-store.h
@@ -27,10 +27,17 @@ struct object_directory {
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
-	int will_destroy;
+	unsigned int will_destroy : 1;
 
 	/*
 	 * Path to the alternative object store. If this is a relative path,
diff --git a/refs.c b/refs.c
index d7cc0a23a3b..27ec7d1fc64 100644
--- a/refs.c
+++ b/refs.c
@@ -2137,7 +2137,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 		break;
 	}
 
-	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
+	if (the_repository->objects->odb->disable_ref_updates) {
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

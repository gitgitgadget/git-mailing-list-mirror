Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SORTED_RECIPS,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 291F21F576
	for <e@80x24.org>; Mon, 26 Feb 2018 10:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbeBZKbD (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 05:31:03 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42541 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbeBZKbC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 05:31:02 -0500
Received: by mail-pf0-f193.google.com with SMTP id a16so500425pfn.9
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 02:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xkn1R4/8r2zkwAMkKIsiXq2n2jVQOfAI8NnV3Gvbnvc=;
        b=pjqAPbjxVoPmiJSLkQQrAN5XqZKfY0Za4EuNv3xuJ3EHigf8kQvuwcyMY1VCj24Cxx
         PDLoUdd+5fEVwMPVsjdRIgpsqrMbDUzon1HhlD/DV5DTIofCUuuzUoERq5eN/iL6smhU
         XWAJgxNMbXadFY6Q0P1aoeqEHfUzspHMnzgFtKSXkIyDhcNISy/ifGTS+MvKVawR1pyh
         rgbYseG8tSuNc8fGchjADsTmFQ7XdHn22/DdaszfQowYgYloVuc9M7fMCjwYU0VGZexk
         fclcytfYSetZvy0A9KI9Lnd4c8CpqNrHwTxW3evWgRMmEAuFFKSuJkb2Zop3mphwQk6e
         lLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkn1R4/8r2zkwAMkKIsiXq2n2jVQOfAI8NnV3Gvbnvc=;
        b=SIhWX4mmLDlsA042CdaN36CYUhFaVshjAcTaaJWyDc/h57GsxYAeZmOPGSaKuUAQt+
         /YMMj+JKfaCnqVtfkHhDfAZrPCDiy8Rb+pLEkUY7kR0uuuOpienaabiC6vkfpyygXxMI
         55bET2P+Dts+JHpZcPYahEbtuqKqO5gyG9cSP3Lz1nXE3YABF1u314tUNb8FQU9LKpCp
         14CMUekQISkoSgux+D0jTSwtWSifgzoSEa76cy8oScquQl71YbhTNPhZUrj+cfF9iQ3W
         vSsbZvYvw0VKiZnWMFbgi9PH1t+wTsQ4JnYEiMK3LbyrHa0VuzW7WakW+QqBTDXJE17Q
         msZA==
X-Gm-Message-State: APf1xPDRxWBauRhPM7+nOPka6P53JZRMJc9eegg2mKju6R7NOnDOhuFC
        KNlRpc+iBZ7MkmmscVnJL20=
X-Google-Smtp-Source: AH8x2269pXanQqUdJRlaPYT1Pzb3BxrsGpYBKVr8aSmGJfAwMD/TWjeT+DaUKYrUtQGAXymxA2q4wQ==
X-Received: by 10.98.133.193 with SMTP id m62mr10115753pfk.74.1519641061600;
        Mon, 26 Feb 2018 02:31:01 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id s9sm13069315pfa.166.2018.02.26.02.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2018 02:31:01 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 26 Feb 2018 17:30:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 3/4] sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
Date:   Mon, 26 Feb 2018 17:30:29 +0700
Message-Id: <20180226103030.26900-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180226103030.26900-1-pclouds@gmail.com>
References: <20180214180814.GA139458@google.com>
 <20180226103030.26900-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

getenv() is supposed to work on the main repository only. This delayed
getenv() code in sha1_file.c makes it more difficult to convert
sha1_file.c to a generic object store that could be used by both
submodule and main repositories.

Move the getenv() back in setup_git_env() where other env vars are
also fetched.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 environment.c  | 1 +
 object-store.h | 5 ++++-
 object.c       | 1 +
 repository.c   | 2 ++
 repository.h   | 1 +
 sha1_file.c    | 6 +-----
 6 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/environment.c b/environment.c
index 2905042b16..95de419de8 100644
--- a/environment.c
+++ b/environment.c
@@ -158,6 +158,7 @@ void setup_git_env(const char *git_dir)
 	args.object_dir = getenv(DB_ENVIRONMENT);
 	args.graft_file = getenv(GRAFT_ENVIRONMENT);
 	args.index_file = getenv(INDEX_ENVIRONMENT);
+	args.alternate_db = getenv(ALTERNATE_DB_ENVIRONMENT);
 	repo_set_gitdir(the_repository, git_dir, &args);
 
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
diff --git a/object-store.h b/object-store.h
index afe2f93459..9b1303549b 100644
--- a/object-store.h
+++ b/object-store.h
@@ -87,6 +87,9 @@ struct raw_object_store {
 	 */
 	char *objectdir;
 
+	/* Path to extra alternate object database if not NULL */
+	char *alternate_db;
+
 	struct packed_git *packed_git;
 	/* A most-recently-used ordered version of the packed_git list. */
 	struct list_head packed_git_mru;
@@ -109,7 +112,7 @@ struct raw_object_store {
 	unsigned packed_git_initialized : 1;
 };
 
-#define RAW_OBJECT_STORE_INIT(o) { NULL, NULL, LIST_HEAD_INIT(o.packed_git_mru), NULL, NULL, 0, 0, 0 }
+#define RAW_OBJECT_STORE_INIT(o) { NULL, NULL, NULL, LIST_HEAD_INIT(o.packed_git_mru), NULL, NULL, 0, 0, 0 }
 
 void raw_object_store_clear(struct raw_object_store *o);
 
diff --git a/object.c b/object.c
index a7c238339b..5317cfc390 100644
--- a/object.c
+++ b/object.c
@@ -464,6 +464,7 @@ static void free_alt_odbs(struct raw_object_store *o)
 void raw_object_store_clear(struct raw_object_store *o)
 {
 	FREE_AND_NULL(o->objectdir);
+	FREE_AND_NULL(o->alternate_db);
 
 	free_alt_odbs(o);
 	o->alt_odb_tail = NULL;
diff --git a/repository.c b/repository.c
index be86da82cc..19532ec5ff 100644
--- a/repository.c
+++ b/repository.c
@@ -56,6 +56,8 @@ void repo_set_gitdir(struct repository *repo,
 	repo_set_commondir(repo, o->shared_root);
 	expand_base_dir(&repo->objects.objectdir, o->object_dir,
 			repo->commondir, "objects");
+	free(repo->objects.alternate_db);
+	repo->objects.alternate_db = xstrdup_or_null(o->alternate_db);
 	expand_base_dir(&repo->graft_file, o->graft_file,
 			repo->commondir, "info/grafts");
 	expand_base_dir(&repo->index_file, o->index_file,
diff --git a/repository.h b/repository.h
index b5b5d138aa..b1da2a6384 100644
--- a/repository.h
+++ b/repository.h
@@ -94,6 +94,7 @@ struct set_gitdir_args {
 	const char *object_dir;
 	const char *graft_file;
 	const char *index_file;
+	const char *alternate_db;
 };
 
 extern void repo_set_gitdir(struct repository *repo,
diff --git a/sha1_file.c b/sha1_file.c
index dfc8deec38..ad1cd441e6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -673,15 +673,11 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 
 void prepare_alt_odb(struct repository *r)
 {
-	const char *alt;
-
 	if (r->objects.alt_odb_tail)
 		return;
 
-	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
-
 	r->objects.alt_odb_tail = &r->objects.alt_odb_list;
-	link_alt_odb_entries(r, alt, PATH_SEP, NULL, 0);
+	link_alt_odb_entries(r, r->objects.alternate_db, PATH_SEP, NULL, 0);
 
 	read_info_alternates(r, r->objects.objectdir, 0);
 }
-- 
2.16.1.435.g8f24da2e1a


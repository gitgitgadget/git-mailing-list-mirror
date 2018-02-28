Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 962E41F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeB1Bh4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:37:56 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34083 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeB1Bhy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:37:54 -0500
Received: by mail-pl0-f66.google.com with SMTP id u13-v6so555758plq.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1hc8bc4pn9wXpsW4kznDwmpPUX+91tfy+Ox8POeMNSk=;
        b=uHB2kK932v7QkSnMqnHVnAyfU00nDWT+IDTHDu2HilXGBNlVMaKavgp28slfssm7/B
         UHfQXsJ0WOPa4R62S+0o7vTY1Ukw7S2JrQ9asfuQaJy9bVa+r8yRPpOyN7YU9zNy01sb
         cyYtMAGwMuGQ8PqH+0Wbn0kYKYjdoNj4yBIc0l2a9Tb7Ddo0cZWL7kjONJhCxSBFvXRH
         WjAVinjHFoE9CD1r9c5tU9Ey9xy2oCWY4pWr+B+Pp0bYIrBrGe8D4LdgwxXtrYvANcEs
         Is1srrqsuxc9CpXFS2DQEwsDvJf20Hp9bnO0j+iMrLJJiBBCVO6eeOK0xQ6I1T1oj0pf
         gxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1hc8bc4pn9wXpsW4kznDwmpPUX+91tfy+Ox8POeMNSk=;
        b=G+InKTQZuvZC5zZPWFjz9x9xxVjSgaoj3z7vZh17dKwjdkS88NYyBP4xYzdmlcA/Sx
         InFwTEQnFmH31V9/N0v5v0+xKkOY+1BJDZXsNj3tfZDcKXtde13zHbEzglUrr58ns2/1
         kw89NWBmrrGn2V1n722kF4nvu/tIYsXJ7dPTUaT0rvb86dCTGBeZvQ6+XSpyKqiGSMNN
         kROMxIVYGpAxVJ+on38/L3A/ohwhh0JCCirn/AU80RGUDQ+fDEawQZgp2aciLH1cFYqF
         /PIhcFyKc9xAUIF/Bp5vgmOsiYbyzhaJlN+4NXXS3L+71p9MRGRoOT4L2yZ97A5r/M5l
         2znw==
X-Gm-Message-State: APf1xPC7fDPvxq4YvFXXwTTyJhCqXIKKAcHnNcH9doCnGNi1sE3EoPCo
        HUDb7vhsilxt1GOzQm5d54Y=
X-Google-Smtp-Source: AH8x226hSLXfMx1v4wrARVlDC4YQlqenlnzlmNCc4kmNJPfFYUnfNUTDMYxkW2wWbR3BVwscH7XkZA==
X-Received: by 2002:a17:902:b901:: with SMTP id bf1-v6mr16286578plb.175.1519781874267;
        Tue, 27 Feb 2018 17:37:54 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id n13sm573588pfg.45.2018.02.27.17.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 17:37:53 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sbeller@google.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 3/4] sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
Date:   Wed, 28 Feb 2018 08:37:26 +0700
Message-Id: <20180228013727.13815-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.399.g632f88eed1
In-Reply-To: <20180228013727.13815-1-pclouds@gmail.com>
References: <20180227095846.9238-1-pclouds@gmail.com>
 <20180228013727.13815-1-pclouds@gmail.com>
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
index 454e435bed..b2128c1188 100644
--- a/environment.c
+++ b/environment.c
@@ -175,6 +175,7 @@ void setup_git_env(const char *git_dir)
 	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
 	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
 	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
+	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
 	repo_set_gitdir(the_repository, git_dir, &args);
 	argv_array_clear(&to_free);
 
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
index 89e76173a3..b5306ddaa2 100644
--- a/repository.c
+++ b/repository.c
@@ -61,6 +61,8 @@ void repo_set_gitdir(struct repository *repo,
 	repo_set_commondir(repo, o->commondir);
 	expand_base_dir(&repo->objects.objectdir, o->object_dir,
 			repo->commondir, "objects");
+	free(repo->objects.alternate_db);
+	repo->objects.alternate_db = xstrdup_or_null(o->alternate_db);
 	expand_base_dir(&repo->graft_file, o->graft_file,
 			repo->commondir, "info/grafts");
 	expand_base_dir(&repo->index_file, o->index_file,
diff --git a/repository.h b/repository.h
index f917baa584..1b6afd0926 100644
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
2.16.1.399.g632f88eed1


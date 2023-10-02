Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7E9E784A6
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjJBClf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbjJBClP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:15 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C572D9
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:58 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-79f82b26abfso562693439f.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214457; x=1696819257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AF5mnlyuAtBynDxzlMk6AzIHona7RoAHcXNCm+fnaGE=;
        b=NxJPIa1sgXrvJ3wAcu7086OtmwgUkdbFRKzqV8WIEd2ZbzrPkXD2js+3jBorp2RfUy
         zl/UP43ENGKzbpBT0WXUGx/8Hg02GMsd2RqH8pMh5Ooai0eOCd/D/Jz9FI7XK8O4XTLa
         neLyMJwAxrRXAE4SooJKhRhAellkBbihkE+N+OuIRa0T0naDRDyuYZGRA6rDKGptPtwq
         v+zffUzw0yKpHKv10K7gtkK0P1Q/bXhkcnWb1dPecMZkt3ElAz2rO68wlhO1jKhAUnB/
         LXdJlBG76LBS+UyBGAKB4M/lpf3UFO41YYR8ArcP8+yJMteieuHg3fCeoa1/piSKu5uh
         W1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214457; x=1696819257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AF5mnlyuAtBynDxzlMk6AzIHona7RoAHcXNCm+fnaGE=;
        b=seRz0NBfKQy2J2nI1gmgSKA7bdbsUwFYP43f+ySK6nS6MfX3WWLd0EKixXybSa3c4X
         +z+caOOrvRymcv5JMaDlhdO8eGBdjGsVG2Zz0yzIrzij/Q2y17h/MkFwSpxr4pfub4H/
         aPQXMuLglmkYu9CkCATF2fqIvQ5qcLvTQryJP4TAKCBiwgc7DL5XKcB2yNedZ+MpGOKw
         2i/xV0eYnRuOeYgn5fLD/GxdRJAOn5rtzRJwBR7cevcB5d5VjYk5PQKyTg0tpu+PZLPU
         /xQc9kBHeL7pRYh8BSHP/CZviUghUkU6uUMINJgOdmmHf1Ev/frNAUI+Y28FAqWY/Zsh
         v1Ag==
X-Gm-Message-State: AOJu0Yz2rXYxwRQ2IlSCJHfOSVBb7HnGUkGE0j7tpnrE+nIbIwy413el
        tZjmP+a6ER04XUkyiKXZjlg=
X-Google-Smtp-Source: AGHT+IGQzZyjTlBo8/FsPg+1MHLlov9FIWJLQNeJXXEZ8rOhm+FNKnbkrE3ZkFWNObM0Jab/VY4/+A==
X-Received: by 2002:a6b:a12:0:b0:792:792e:6619 with SMTP id z18-20020a6b0a12000000b00792792e6619mr11543582ioi.2.1696214457687;
        Sun, 01 Oct 2023 19:40:57 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:57 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 21/30] repository: implement extensions.compatObjectFormat
Date:   Sun,  1 Oct 2023 21:40:25 -0500
Message-Id: <20231002024034.2611-21-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Add a configuration option to enable updating and reading from
compatibility hash maps when git accesses the reposotiry.

Call the helper function repo_set_compat_hash_algo with the value
that compatObjectFormat is set to.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 Documentation/config/extensions.txt | 12 ++++++++++++
 repository.c                        |  2 +-
 setup.c                             | 23 +++++++++++++++++++++--
 setup.h                             |  1 +
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
index bccaec7a9636..9f72e6d9f4f1 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.txt
@@ -7,6 +7,18 @@ Note that this setting should only be set by linkgit:git-init[1] or
 linkgit:git-clone[1].  Trying to change it after initialization will not
 work and will produce hard-to-diagnose issues.
 
+extensions.compatObjectFormat::
+
+	Specify a compatitbility hash algorithm to use.  The acceptable values
+	are `sha1` and `sha256`.  The value specified must be different from the
+	value of extensions.objectFormat.  This allows client level
+	interoperability between git repositories whose objectFormat matches
+	this compatObjectFormat.  In particular when fully implemented the
+	pushes and pulls from a repository in whose objectFormat matches
+	compatObjectFormat.  As well as being able to use oids encoded in
+	compatObjectFormat in addition to oids encoded with objectFormat to
+	locally specify objects.
+
 extensions.worktreeConfig::
 	If enabled, then worktrees will load config settings from the
 	`$GIT_DIR/config.worktree` file in addition to the
diff --git a/repository.c b/repository.c
index 6214f61cf4e7..9d91536b613b 100644
--- a/repository.c
+++ b/repository.c
@@ -194,7 +194,7 @@ int repo_init(struct repository *repo,
 		goto error;
 
 	repo_set_hash_algo(repo, format.hash_algo);
-	repo_set_compat_hash_algo(repo, GIT_HASH_UNKNOWN);
+	repo_set_compat_hash_algo(repo, format.compat_hash_algo);
 	repo->repository_format_worktree_config = format.worktree_config;
 
 	/* take ownership of format.partial_clone */
diff --git a/setup.c b/setup.c
index aa8bf5da5226..85259a259be3 100644
--- a/setup.c
+++ b/setup.c
@@ -590,6 +590,25 @@ static enum extension_result handle_extension(const char *var,
 				     "extensions.objectformat", value);
 		data->hash_algo = format;
 		return EXTENSION_OK;
+	} else if (!strcmp(ext, "compatobjectformat")) {
+		struct string_list_item *item;
+		int format;
+
+		if (!value)
+			return config_error_nonbool(var);
+		format = hash_algo_by_name(value);
+		if (format == GIT_HASH_UNKNOWN)
+			return error(_("invalid value for '%s': '%s'"),
+				     "extensions.compatobjectformat", value);
+		/* For now only support compatObjectFormat being specified once. */
+		for_each_string_list_item(item, &data->v1_only_extensions) {
+			if (!strcmp(item->string, "compatobjectformat"))
+				return error(_("'%s' already specified as '%s'"),
+					"extensions.compatobjectformat",
+					hash_algos[data->compat_hash_algo].name);
+		}
+		data->compat_hash_algo = format;
+		return EXTENSION_OK;
 	}
 	return EXTENSION_UNKNOWN;
 }
@@ -1565,7 +1584,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
 			repo_set_compat_hash_algo(the_repository,
-						  GIT_HASH_UNKNOWN);
+						  repo_fmt.compat_hash_algo);
 			the_repository->repository_format_worktree_config =
 				repo_fmt.worktree_config;
 			/* take ownership of repo_fmt.partial_clone */
@@ -1659,7 +1678,7 @@ void check_repository_format(struct repository_format *fmt)
 	check_repository_format_gently(get_git_dir(), fmt, NULL);
 	startup_info->have_repository = 1;
 	repo_set_hash_algo(the_repository, fmt->hash_algo);
-	repo_set_compat_hash_algo(the_repository, GIT_HASH_UNKNOWN);
+	repo_set_compat_hash_algo(the_repository, fmt->compat_hash_algo);
 	the_repository->repository_format_worktree_config =
 		fmt->worktree_config;
 	the_repository->repository_format_partial_clone =
diff --git a/setup.h b/setup.h
index 58fd2605dd26..5d678ceb8caa 100644
--- a/setup.h
+++ b/setup.h
@@ -86,6 +86,7 @@ struct repository_format {
 	int worktree_config;
 	int is_bare;
 	int hash_algo;
+	int compat_hash_algo;
 	int sparse_index;
 	char *work_tree;
 	struct string_list unknown_extensions;
-- 
2.41.0


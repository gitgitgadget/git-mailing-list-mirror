Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF54EE82CCC
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjI0T4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjI0T4c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:32 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A684DCCF
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:06 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7927f24140eso412187039f.2
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844566; x=1696449366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+XvkI2q8HdgyNZqFquNWFe2nBLsYwqJ2GxQfllpj68=;
        b=DeYK+9eeqfO/4W0llSsxtOcXmR7FajwjCl1Y1+ImUNGGt44bDrkUyOraBfsVBfXzOa
         N/vif8yA0vQHZRKP7j6yCRK8IvpJn5eQReaCZV2HY1P6CntIOLpVJxbv4tmBZpEXtPMW
         hJHqAp5QoBSIKhgzitH0BZ5gfNwmL5yHDRqJtU7CeNwsDztszbgivts4YIaSZxFz3REp
         3vkTsfG1jFR0zWXfTI8tqwynx2dP7hcG3mU04guKbV09G/AxVxm6NK2LMmwo68lZ1ZW7
         TNlH2g7MgM4nT2mtR3x60z/AkthJVrGqaiq7QeDsdoJneuYUu++jyX0ubHbF4oAwXhul
         bEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844566; x=1696449366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+XvkI2q8HdgyNZqFquNWFe2nBLsYwqJ2GxQfllpj68=;
        b=Wf7fNx/iiuS1xO255yfimzNB0wz+HS9P33+ZtS+ElMbPwXnodhaVXhucaKBcynG0wv
         oHot894ab+B3tTa3TacaQSBmSqls1df2hCALSiGjZlAHs57DA3W9Xp4lqmLLxCrqasZ/
         bG2FbE45ku6gOJhflML2mmFY5QV6QI62tlv5pN2YGzlXYUEwB80DG7x1sbBev8gV/0yq
         +SVvRT/tq2LWgQ1NXvjoUJAQ+v0rJtmsx/kbaGMgLO6Bzxf3Rqh2CeQM5pn37d0ZRkLo
         dQ9AkusmB/JkfEbtfMEWsZVlyx4Ejm9EE/VeIlH2MbJ5Cf8W7vvDegRt0oOhEhCprC4m
         Mkkw==
X-Gm-Message-State: AOJu0YxN3jv3xpkTMtbzT/fv9MhdPYmoOn20Ki9l4G4iZsjQzOAgzahn
        MI4xDKLg0Bvvu65+w9pUqlM=
X-Google-Smtp-Source: AGHT+IFCsZOxoqhIUmy9XumtBApasHB93gJFvBA0dQG+UCROekUqdIBE31zvhv20iNuIE6jpVwasgw==
X-Received: by 2002:a6b:dd07:0:b0:79f:cb49:f476 with SMTP id f7-20020a6bdd07000000b0079fcb49f476mr2480117ioc.21.1695844565977;
        Wed, 27 Sep 2023 12:56:05 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:56:05 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 21/30] repository: Implement extensions.compatObjectFormat
Date:   Wed, 27 Sep 2023 14:55:28 -0500
Message-Id: <20230927195537.1682-21-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
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
index deb5a33fe9e1..87b40472dbc5 100644
--- a/setup.c
+++ b/setup.c
@@ -598,6 +598,25 @@ static enum extension_result handle_extension(const char *var,
 		}
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
@@ -1573,7 +1592,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
 			repo_set_compat_hash_algo(the_repository,
-						  GIT_HASH_UNKNOWN);
+						  repo_fmt.compat_hash_algo);
 			the_repository->repository_format_worktree_config =
 				repo_fmt.worktree_config;
 			/* take ownership of repo_fmt.partial_clone */
@@ -1667,7 +1686,7 @@ void check_repository_format(struct repository_format *fmt)
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


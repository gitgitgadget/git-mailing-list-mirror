Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22E2B1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 18:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeJSClE (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 22:41:04 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:39767 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeJSClD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 22:41:03 -0400
Received: by mail-oi1-f201.google.com with SMTP id d23-v6so21259778oib.6
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=40tLCCS66N059thyNV0K+9T6RZVgjK1KcJeEPbkQFrc=;
        b=TQGmqJg+vnMcvNSJiEiV+qznWy18hI71ojuNZ6QjL+dpQrE6KcRJjhFtaA+DO+mwZC
         aosfJant6Oq9Yh/aN9g6IBbgeynTXKQ0eVDCFVj4hcHn7uaqEkCqXNkbnqdS4NiozsEY
         7YYK//n5eapfDcZynTOIhONK4RKYeMDZWHGspUTBoutjOQtRXoGymtYibxeM3+/muwzG
         VCQrVqjVGGPJmBZMIwMYYVfZpDQ0/C8tabTo6o0+WncpRWEC2ZiW6PkOlAC1ewlbxFDy
         onDI3Cc4xWIlq5y1/prKFSpMLL0LY6mXrsbwB+8GRiwiTamIk52thYa3FdBzjeUvVyjz
         jcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=40tLCCS66N059thyNV0K+9T6RZVgjK1KcJeEPbkQFrc=;
        b=aO8EBFQYgK4hnaOMjliodRY/Mwq6u5YifRUqee2ZE7GMeo+iAjs8vLFzJr1ScR2c4R
         OKSNhz8AGrPBPFjo3/y3x3To1Qk7szLapdDTYkQZQtvOcMOEcnMRkxqIQ9HcSFCD2BJY
         9MERxCbqCK93YiFlhuNJ54QjTdWo5+xWkpeIhmPJ8kjofoQVa9JwgR4lJz4iTV1+a/MQ
         FujmMSZk2oEeMS9NOJPiZvsdNIQHu+UVBOucd7+twgW32zae1i758X1D9dBpDgdpXP/N
         h4UHRaFu5pnxIm+fgFnpe7Nz2/ahhC/luFF+pppZNSn7Y/WixE0kxpJDTX27C63bNFFC
         97IQ==
X-Gm-Message-State: ABuFfojNWkgLbuhrNM28VZphFSHHzyZnvuL/bh1OXaXu5PLlNZLdlnDS
        Wh/YzNHKx4pvFj0dYk7ZsMjy+dB839Jm
X-Google-Smtp-Source: ACcGV62bf00xo/gGwj3kcscw9CL6RMby6MnUsK0nbUg/KlWIzO+qlAnZBDtu8UCuG2wjjszeK8jsA8h6LdW4
X-Received: by 2002:aca:d407:: with SMTP id l7-v6mr25788112oig.41.1539887925900;
 Thu, 18 Oct 2018 11:38:45 -0700 (PDT)
Date:   Thu, 18 Oct 2018 11:37:57 -0700
In-Reply-To: <20181018183758.81186-1-sbeller@google.com>
Message-Id: <20181018183758.81186-2-sbeller@google.com>
Mime-Version: 1.0
References: <CAGZ79kbpXQURMsZY15_k3rJ-dyH0i4qAGDv8umM8Hmx10ZdMMA@mail.gmail.com>
 <20181018183758.81186-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [RFC PATCH 1/2] repository: have get_the_repository() to remove
 the_repository dependency
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The struct 'the_repo' contains all data that of the main repository.
As we move more and more globals into this struct, the usual way of
accessing these is using 'the_repository', which can be used as a drop in
replacement for accessing the migrated globals.

However during the migration of globals into the repository object, it is
not clear if some code path rely on the_repository or can work on an
arbitrary repository (as we'd eventually want for submodules) due to the
excessive use of the_repository throughout the code base.

To address this, introduce a function 'get_the_repository(void)' which
will return the main repository and set the_repository to NULL when the
environment variable GIT_NO_THE_REPOSITORY is set.

This function is to be strictly used only at the beginning of builtin
command to assign it to a local repository pointer that we'll use to
pass through the code base.

By having the possibility to set the_repository to NULL, we'll get
a segfault when we try to access the_repository instead of using the
handle that we pass around.

This approach let's us have the_repository in the setup code, which
in its current form is not yet able to transition into a world where
the repository handle is passed around and only test the passing around
of the repository handle for later stage code.

Eventually in the future the setup code will produce the repository
handle and each 'cmd_foo(int argc, char **argv)' builtin would get the
repository via an additional parameter.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 repository.c | 10 ++++++++++
 repository.h | 13 ++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/repository.c b/repository.c
index 5dd1486718..aaaababb88 100644
--- a/repository.c
+++ b/repository.c
@@ -20,6 +20,16 @@ void initialize_the_repository(void)
 	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
 }
 
+struct repository *get_the_repository(void)
+{
+	struct repository *r = the_repository;
+
+	if (getenv("GIT_NO_THE_REPOSITORY"))
+		the_repository = NULL;
+
+	return r;
+}
+
 static void expand_base_dir(char **out, const char *in,
 			    const char *base_dir, const char *def_in)
 {
diff --git a/repository.h b/repository.h
index 9f16c42c1e..26f5d64f68 100644
--- a/repository.h
+++ b/repository.h
@@ -114,13 +114,24 @@ void repo_set_gitdir(struct repository *repo, const char *root,
 		     const struct set_gitdir_args *extra_args);
 void repo_set_worktree(struct repository *repo, const char *path);
 void repo_set_hash_algo(struct repository *repo, int algo);
-void initialize_the_repository(void);
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
 int repo_submodule_init(struct repository *submodule,
 			struct repository *superproject,
 			const char *path);
 void repo_clear(struct repository *repo);
 
+/*
+ * Initializes the repository 'the_repository', which is used in the transition
+ * phase of moving globals into the repository struct.
+ */
+void initialize_the_repository(void);
+
+/*
+ * To be called once; after the call use only returned repository, and do not
+ * use the_repository any more
+ */
+struct repository *get_the_repository(void);
+
 /*
  * Populates the repository's index from its index_file, an index struct will
  * be allocated if needed.
-- 
2.19.0


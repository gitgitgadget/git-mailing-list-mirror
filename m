Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EC4D20323
	for <e@80x24.org>; Fri, 17 Mar 2017 02:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbdCQCyP (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 22:54:15 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33820 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbdCQCyO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 22:54:14 -0400
Received: by mail-qt0-f195.google.com with SMTP id x35so8085822qtc.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 19:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rr7wT6QXdCK/npHpItaa+etFnBJwia06AqUfIfvSCSg=;
        b=kxaIQlaVcjQ3ApDJI1JlCiX5Bji13MAvVCpp1YCTmiuomA/Z1fYD3VsrjGSa6Kfsw7
         uZwp7ZHGfWSYElxoEmeB+i4LSfySeZmtKa4/QunEv0Uyludo2Ml2h7d20lghsn9HOkRw
         Q0rDK0bomN/Tmo0SYV9NGeTtTw6FmLx5FigeRduHRvS0NloyZUGi0rxdUZFW3z8uqXiR
         7REb6Wh7M2vAwUAzfRgx1kdRvjlqS45dfoPu8FdvQV/omjcsjDBHMmDvTJXayl6QjR8O
         g9N0f3KmmSIRyH7f8Ut5QOtryNADKhWL1ZBYk690dntHOAIBJ4pUnhGdPagqoErgfhUd
         tfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rr7wT6QXdCK/npHpItaa+etFnBJwia06AqUfIfvSCSg=;
        b=L5Y/fSAcFbviZxJh3KKr1+94a7na4KSrkJJLuhD5eGI2/nyJp6i6sBUXzFTkbIBzln
         hMdVk1vz62HoKgPPEtCd0Ny/OC6NFbt7tHW40iJT8BLzw6Zx3mgALL9pRFGQL0BGtbZu
         qRAbMocGDCI0umuVbYQ1jNOwgO2IxbubN5qL6Qb7ThYfYZ7pigkD48qH4J9A8vpPj1iQ
         2wKox6cK8rFj07/IufP20gYRP+zTtuWSkg5DlKvHJpfRQQ9zEvVadkP/qcgfCNbH6sB9
         cIw9/8RBb/yXYWTV+Sb0LxanqVv/OWNbWC06W8HQDPzi1srBlNyPKU62lajfXvMVc8U8
         Pkfg==
X-Gm-Message-State: AFeK/H3XsJOb1NLVc66q5nOxRsMld9AdNTMZ1yAGKoXMXQUoiIXlaWrVsNEnR/L/u0VTYw==
X-Received: by 10.237.38.194 with SMTP id q60mr12368426qtd.84.1489719196841;
        Thu, 16 Mar 2017 19:53:16 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-116.cit.cornell.edu. [128.84.124.116])
        by smtp.googlemail.com with ESMTPSA id r30sm5009007qtc.66.2017.03.16.19.53.16
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 19:53:16 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [GSoC][PATCH v5 1/3] path.c: add xdg_cache_home
Date:   Thu, 16 Mar 2017 22:53:13 -0400
Message-Id: <20170317025315.84548-1-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170316051827.97198-5-lehmacdj@gmail.com>
References: <20170316051827.97198-5-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have xdg_config_home to format paths relative to
XDG_CONFIG_HOME. Let's provide a similar function xdg_cache_home to do
the same for paths relative to XDG_CACHE_HOME.

Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
---
 cache.h |  7 +++++++
 path.c  | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/cache.h b/cache.h
index c95826971..66761bc56 100644
--- a/cache.h
+++ b/cache.h
@@ -1169,6 +1169,13 @@ extern int is_ntfs_dotgit(const char *name);
  */
 extern char *xdg_config_home(const char *filename);
 
+/**
+ * Return a newly allocated string with the evaluation of
+ * "$XDG_CACHE_HOME/git/$filename" if $XDG_CACHE_HOME is non-empty, otherwise
+ * "$HOME/.cache/git/$filename". Return NULL upon error.
+ */
+extern char *xdg_cache_home(const char *filename);
+
 /* object replacement */
 #define LOOKUP_REPLACE_OBJECT 1
 #define LOOKUP_UNKNOWN_OBJECT 2
diff --git a/path.c b/path.c
index efcedafba..22248436b 100644
--- a/path.c
+++ b/path.c
@@ -1272,6 +1272,21 @@ char *xdg_config_home(const char *filename)
 	return NULL;
 }
 
+char *xdg_cache_home(const char *filename)
+{
+	const char *home, *cache_home;
+
+	assert(filename);
+	cache_home = getenv("XDG_CACHE_HOME");
+	if (cache_home && *cache_home)
+		return mkpathdup("%s/git/%s", cache_home, filename);
+
+	home = getenv("HOME");
+	if (home)
+		return mkpathdup("%s/.cache/git/%s", home, filename);
+	return NULL;
+}
+
 GIT_PATH_FUNC(git_path_cherry_pick_head, "CHERRY_PICK_HEAD")
 GIT_PATH_FUNC(git_path_revert_head, "REVERT_HEAD")
 GIT_PATH_FUNC(git_path_squash_msg, "SQUASH_MSG")
-- 
2.11.0


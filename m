Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFDD420951
	for <e@80x24.org>; Fri, 17 Mar 2017 12:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751047AbdCQMg6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 08:36:58 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33553 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdCQMg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 08:36:57 -0400
Received: by mail-qt0-f193.google.com with SMTP id r45so9248770qte.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 05:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rr7wT6QXdCK/npHpItaa+etFnBJwia06AqUfIfvSCSg=;
        b=QpqZ0NlLlb7QU58vUiaUKnfH2RvcwHDYQbo11w2Hg8Cvxm2DCJkmHQ0Tixtg3ulv4s
         ZFRxkgDU/sOeePsQshLtZqqwRYePgQT+Qewb5Scw+H+LVq6Qv3wWzDGondYJJ8WB/CGa
         GrBdsVsetpF4u2mXl7ks7H3vULvRTX6Wd+/E4fX0dQ/Hj5bveDLqUH7gjxxU2er6Doxq
         PatBXRNLE+fh6X40UTwPKZTVHjhf9yLCYwEhIJWiM4TVdmSmE7tlLHkVJyf7pmydinCp
         6hZj9ccwGhQHqEZ1+cyuW6cRm8nOMMnuJnK+aajnZ1PW9CZ5PLeeW41oWgQuML6Mn+rW
         NVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rr7wT6QXdCK/npHpItaa+etFnBJwia06AqUfIfvSCSg=;
        b=oGgS5NxiC5R5HArGe0IlzGS0xOYqhXC7DdbVcv5K4iYzSJYMvT0Y3M85FjPAGdSK6a
         0L8gF8yjo2w3rzsMCHnq3jzxi2gepArT5QHUN0ln9dRX0e0I5GD05EDs8dFk0UYuKAbu
         PbXtfAVkbKrwR4Oj67Z8DrEqdw5B81u4y3rCMxzSVIYjI/84cSyK/k19nE7r5sSEQDY5
         mpQm3h/KORAmo6NOwiDV/0hzMFCakyjAw2wqbaSCQYgvfroKOueGVXKqxFuDf9id3IMJ
         L7deC0RHYO8PS5VihdI7Ybrr79I5o1ckZLOY/GpZqNO/gzJq4GpXGzvWJAKcC+4Tt95o
         T0cA==
X-Gm-Message-State: AFeK/H1XNuRjhps6ssOSaDI6aydrxG3cUChUo+lMGYY0PRRZJUkb/+KnvG7S174eW2logA==
X-Received: by 10.200.47.225 with SMTP id m30mr13104686qta.175.1489754196376;
        Fri, 17 Mar 2017 05:36:36 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-116.cit.cornell.edu. [128.84.124.116])
        by smtp.googlemail.com with ESMTPSA id h33sm5811607qtc.42.2017.03.17.05.36.35
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 05:36:35 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [GSoC][PATCH v6 1/3] path.c: add xdg_cache_home
Date:   Fri, 17 Mar 2017 08:36:32 -0400
Message-Id: <20170317123634.10863-1-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170317025315.84548-3-lehmacdj@gmail.com>
References: <20170317025315.84548-3-lehmacdj@gmail.com>
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


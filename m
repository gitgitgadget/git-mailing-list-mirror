Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2BC1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753430AbeC1R4g (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:56:36 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33552 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753320AbeC1R4b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:56:31 -0400
Received: by mail-lf0-f68.google.com with SMTP id x205-v6so4753273lfa.0
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PH4wom3YFNdUn8AyiZ8h1tvDzCh9RRwoxIHbxeYuJWw=;
        b=kO98Ib2SutLw4fOiGmQE9Iq76X0rk/a+w067cryRbILwC7g9Hgt0DZuO3pLHuurono
         RRxPSEZdMA/wFrj3VuKcrvevGKAJEKVVuIS7DPW/l6MfkGjLc6xzDWsjvj1kmgGsmlWF
         Hp/5EmEroLixqcJBvkXZbGYPSiFzTuNQKwMSnrEzs4IaUYfql9cZFCGiMSKhTXJCZbTO
         N+HuBs9FvYEHIMt/GlXk7YrfXgLr1OusRNgxwX4LM7nLmPIfzbT/KyJDuY/Tw243altO
         Ta7arbu016yAawPj1a1Vjogyoco9WR+WFW9ft2A3chafgAu8TFhUKGKAhZekPqvtx4fR
         GS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PH4wom3YFNdUn8AyiZ8h1tvDzCh9RRwoxIHbxeYuJWw=;
        b=N2MgS5TQe4MN0gHyh94ODd8HB/+OMnixsB62wLxuh0IX4EPOo23eyS+0sdeOBnZDPZ
         X2cFPFQxCcaWQqdEqYlhxxwj9F5GNGylYghj8O0PwVdaoFECwEPWHbCAq7npuqe5p9cB
         7LMlU0RA8YTXfdeuyKoQ7pCvXXq0xd5GGMX5R2hP/AfJeOBkTcjaCoy7PtkLUosZi7u6
         oQJVzCUg9T5EIuH8mf2YKabtZIXs8WSnaYqxSDsvCIV3I5iH8RD1Hcmj3a5pYoohqihb
         c86jxUP1MrZIyfnJC0o/CTChfjAoLxrJd2LKQyJceBgDfLOi00ULRB32JWMwoi9AduMg
         ++6A==
X-Gm-Message-State: AElRT7HBzlnDbwDCne2Q/PlzaQZmtbtJBC33a8ZyJHLlmDjRbpk+jS/a
        6vn3TmK/qh+224E3Mewu513ylA==
X-Google-Smtp-Source: AIpwx48dFPlDvoXNU/17J7aKrdW1BhvZKHJoD0UNUIBX++Bmcl6AFZyH1K16MpCxwHd0EVYZ70NcMw==
X-Received: by 2002:a19:4acc:: with SMTP id x195-v6mr3223274lfa.46.1522259789620;
        Wed, 28 Mar 2018 10:56:29 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s12sm706658ljj.49.2018.03.28.10.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 10:56:28 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Rafael Ascensao <rafa.almas@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 5/8] setup.c: allow other code to be notified when $CWD moves
Date:   Wed, 28 Mar 2018 19:55:34 +0200
Message-Id: <20180328175537.17450-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.439.gca064e2955
In-Reply-To: <20180328175537.17450-1-pclouds@gmail.com>
References: <20180328094733.GA1523@sigill.intra.peff.net>
 <20180328175537.17450-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Duy Nguyen <pclouds@gmail.com>

When the current directory is moved, all relative paths may become
invalid because they are still relative to the old current
directory. At this point in setup_work_tree() many objects have been
initialized and some keep relative paths in their data structure.

$GIT_DIR and $GIT_WORK_TREE for example are the two examples which are
dealt with explicitly in this code: $GIT_WORK_TREE is reset to "." and
set_git_dir() is called the second time with a new relative path.

Introduce a more generic mechanism to let all code get notified and do
the path adjustment themselves instead of pulling all path adjustment
logic in here. The $GIT_DIR and $GIT_WORK_TREE adjustments will
removed from this code in later patches.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h |  5 +++++
 setup.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 05f32c9659..895abe7e7e 100644
--- a/cache.h
+++ b/cache.h
@@ -522,6 +522,11 @@ extern void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
+typedef void (*cwd_updated_fn)(const char *old_cwd,
+			       const char *new_cwd,
+			       void *cb_data);
+void add_cwd_update_callback(cwd_updated_fn fn, void *cb_data);
+void removet_cwd_update_callback(cwd_updated_fn fn, void *cb_data);
 extern void setup_adjust_path(const char *name, char **path,
 			      const char *old_cwd,
 			      const char *new_cwd);
diff --git a/setup.c b/setup.c
index e26f44185e..e340ee2130 100644
--- a/setup.c
+++ b/setup.c
@@ -376,6 +376,24 @@ int is_inside_work_tree(void)
 	return inside_work_tree;
 }
 
+struct cwd_update_callback {
+	cwd_updated_fn fn;
+	void *cb_data;
+};
+
+static struct cwd_update_callback *cwd_callbacks;
+static int nr_cwd_callbacks;
+
+void add_cwd_update_callback(cwd_updated_fn fn, void *cb_data)
+{
+	struct cwd_update_callback *cb;
+
+	REALLOC_ARRAY(cwd_callbacks, nr_cwd_callbacks + 1);
+	cb = cwd_callbacks + nr_cwd_callbacks++;
+	cb->fn = fn;
+	cb->cb_data = cb_data;
+}
+
 void setup_adjust_path(const char *name, char **path,
 		       const char *old_cwd,
 		       const char *new_cwd)
@@ -398,8 +416,10 @@ void setup_adjust_path(const char *name, char **path,
 
 void setup_work_tree(void)
 {
-	const char *work_tree, *git_dir;
 	static int initialized = 0;
+	const char *work_tree, *git_dir;
+	struct strbuf old_cwd = STRBUF_INIT;
+	int i;
 
 	if (initialized)
 		return;
@@ -411,6 +431,7 @@ void setup_work_tree(void)
 	git_dir = get_git_dir();
 	if (!is_absolute_path(git_dir))
 		git_dir = real_path(get_git_dir());
+	strbuf_get_pwd_cwd(&old_cwd);
 	if (!work_tree || chdir(work_tree))
 		die(_("this operation must be run in a work tree"));
 
@@ -421,6 +442,10 @@ void setup_work_tree(void)
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
 		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
 
+	for (i = 0; i < nr_cwd_callbacks; i++)
+		cwd_callbacks[i].fn(old_cwd.buf, work_tree,
+				    cwd_callbacks[i].cb_data);
+	strbuf_release(&old_cwd);
 	set_git_dir(remove_leading_path(git_dir, work_tree));
 	initialized = 1;
 }
-- 
2.17.0.rc1.439.gca064e2955


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19F071F453
	for <e@80x24.org>; Thu, 21 Feb 2019 12:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfBUMUg (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 07:20:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43957 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfBUMUf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 07:20:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id m10so4441396plt.10
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 04:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ToS7UW+oNIfkBlEwaJvfDJdqZ9GvQbF7MpNkOAd+x0E=;
        b=rBGA6VMPwlTh4ct/Sd4GVbZa2Z7Qi9qXD0HnsrntiCTG/PLYx9LHewh4a+a6EsXVB5
         zUoCg1MsMSBQmNi3JAOPKE8Wstgn8oEaO/Pwl20KwmrkHwnYDeTvnXPJ3jsetZX4MMT9
         BjAN6rFXSwHiwBIagZ7GbGBxpDfr4IAaSqJrSxSSgCMgV16bwm6GX1tJqxAaJQMOJTp5
         crtuIPwWWyfrS0paPrfMiQDUXfZBgP94w6/FOFC7lp5lJcVXhlCys6B4KVjVcK1wnkzD
         MR+VRJJzJgjtywXg+MbrWUp5yKsRsgg+ptHnbPeM9GTlf7/rjQk7sjpMeiVVb+mph4pF
         3bEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ToS7UW+oNIfkBlEwaJvfDJdqZ9GvQbF7MpNkOAd+x0E=;
        b=UjrRWR64YB3eO/sgP3kFcA38e5MNmNbKw9PBnSmfrdhyozt0uWkBREE72/7P2T8bkn
         DKIDlAeUDBJZzlNpXT5H5jJksPkCMrgq5VFwLpJYSHGZrOwIoDfaUggFTZb/nGVscvnm
         8hNxwT8iefLI3QiOVVtcdsDqGXCpPAJCcFK5WpS/I0WGHhB07LTlBGAsmxVfvqgrRZQB
         PpNLhKN3bUCK9DE5ZWL/q0GMDAvS8Vc1nG+YoqTB5HYaUroHYhzHoWF1VdS6H9H8puk9
         XXAKDJx7e7On9lPkZiVU+mVGF1LED7jmqmAUzwbm81wTgANOijTTLjXw2lL2cz83RRe8
         Xfww==
X-Gm-Message-State: AHQUAuZEUpYqsAniNDcaXRDDdtKw6ks3sLWSYP+v/VDk1O6UbBkc1gWk
        iyIQ+TMTV1F8RWcm7NEKOkQ=
X-Google-Smtp-Source: AHgI3Ibf/p1AtHdP073MSeKnx6+LY+/c3oVUC2d5ZZTh9u9e7gvruwOILwyHIPKV8VV7VCIZ4XJHcA==
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr42336302pla.177.1550751634718;
        Thu, 21 Feb 2019 04:20:34 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id w4sm45097381pgk.16.2019.02.21.04.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 04:20:33 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 19:20:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, hi-angel@yandex.ru, sunshine@sunshineco.com
Subject: [PATCH v2 1/1] worktree add: sanitize worktree names
Date:   Thu, 21 Feb 2019 19:19:43 +0700
Message-Id: <20190221121943.19778-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190221121943.19778-1-pclouds@gmail.com>
References: <20190221110026.23135-1-pclouds@gmail.com>
 <20190221121943.19778-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Worktree names are based on $(basename $GIT_WORK_TREE). They aren't
significant until 3a3b9d8cde (refs: new ref types to make per-worktree
refs visible to all worktrees - 2018-10-21), where worktree name could
be part of a refname and must follow refname rules.

Update 'worktree add' code to remove special characters to follow
these rules. The code could replace chars with '-' more than
necessary, but it keeps the code simple. In the future the user will
be able to specify the worktree name by themselves if they're not
happy with this dumb character substitution.

Reported-by: Konstantin Kharlamov <hi-angel@yandex.ru>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c      | 51 ++++++++++++++++++++++++++++++++++++++++-
 t/t2025-worktree-add.sh |  7 ++++++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3f9907fcc9..53e41db229 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -262,6 +262,50 @@ static void validate_worktree_add(const char *path, const struct add_opts *opts)
 	free_worktrees(worktrees);
 }
 
+/*
+ * worktree name is part of refname and has to pass
+ * check_refname_component(). Remove unallowed characters to make it
+ * valid.
+ */
+static void sanitize_worktree_name(struct strbuf *name)
+{
+	char *orig_name = xstrdup(name->buf);
+	int i;
+
+	/*
+	 * All special chars replaced with dashes. See
+	 * check_refname_component() for reference.
+	 * Note that .lock is also turned to -lock, removing its
+	 * special status.
+	 */
+	for (i = 0; i < name->len; i++) {
+		if (strchr(":?[]\\~ \t@{}*/.", name->buf[i]))
+			name->buf[i] = '-';
+	}
+
+	/* remove consecutive dashes, leading or trailing dashes */
+	for (i = 0; i < name->len; i++) {
+		while (name->buf[i] == '-' &&
+		       (i == 0 ||
+			i == name->len - 1 ||
+			(i < name->len - 1 && name->buf[i + 1] == '-')))
+			strbuf_remove(name, i, 1);
+	}
+
+	/*
+	 * a worktree name of only special chars would be reduced to
+	 * an empty string
+	 */
+	if (name->len == 0)
+		strbuf_addstr(name, "worktree");
+
+	if (check_refname_format(name->buf, REFNAME_ALLOW_ONELEVEL))
+		BUG("worktree name '%s' (from '%s') is not a valid refname",
+		    name->buf, orig_name);
+
+	free(orig_name);
+}
+
 static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
@@ -275,6 +319,7 @@ static int add_worktree(const char *path, const char *refname,
 	struct strbuf symref = STRBUF_INIT;
 	struct commit *commit = NULL;
 	int is_branch = 0;
+	struct strbuf sb_name = STRBUF_INIT;
 
 	validate_worktree_add(path, opts);
 
@@ -290,7 +335,10 @@ static int add_worktree(const char *path, const char *refname,
 		die(_("invalid reference: %s"), refname);
 
 	name = worktree_basename(path, &len);
-	git_path_buf(&sb_repo, "worktrees/%.*s", (int)(path + len - name), name);
+	strbuf_add(&sb_name, name, path + len - name);
+	sanitize_worktree_name(&sb_name);
+	name = sb_name.buf;
+	git_path_buf(&sb_repo, "worktrees/%s", name);
 	len = sb_repo.len;
 	if (safe_create_leading_directories_const(sb_repo.buf))
 		die_errno(_("could not create leading directories of '%s'"),
@@ -415,6 +463,7 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_release(&symref);
 	strbuf_release(&sb_repo);
 	strbuf_release(&sb_git);
+	strbuf_release(&sb_name);
 	return ret;
 }
 
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 286bba35d8..71aa6ab9c1 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -570,4 +570,11 @@ test_expect_success '"add" an existing locked but missing worktree' '
 	git worktree add --force --force --detach gnoo
 '
 
+test_expect_success 'sanitize generated worktree name' '
+	git worktree add --detach ".  weird*..?.lock.lock" &&
+	test -d .git/worktrees/weird-lock-lock &&
+	git worktree add --detach .... &&
+	test -d .git/worktrees/worktree
+'
+
 test_done
-- 
2.21.0.rc1.337.gdf7f8d0522


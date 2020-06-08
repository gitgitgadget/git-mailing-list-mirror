Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F736C433E1
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B1E82067B
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqRJry9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgFHGZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgFHGZF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 02:25:05 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F353DC08C5C4
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 23:25:04 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a13so15654284ilh.3
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 23:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ajv9ZRjOU5I1TtLHtSsOg0sPmCHp4QOcLkvJb4PbdUM=;
        b=OqRJry9oVAMgKGc1DRrHS3Otuln3SeSqC+IL5ZW1g2Mw3oKb1CatimXy/KxP8IrMgz
         eX2d/LfQUR5SJmc9hfX8MdwILfZWXzgZ9rBkn3uuHT+w8EtKPovx415QDW2ULA54TMSt
         vgFdwcHfRbgfEdy/RXwCQdnXrDqNAQaq2b3mRkmdH6hBS6nIYaJ9RNwLeH890gIe+q8k
         pO2aOSG4BXm8DZusv+zOuGupDBYobuoL30NFOA4FzQB2B6bp9+IuxHMDZ81GepKsDvR2
         Djbmx3g/y62xf+4k32v7dfb1NzGfdx51uzxnSKZHhawzSd5xpqp5Ijlkm6y+TXgGZ0L+
         9/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ajv9ZRjOU5I1TtLHtSsOg0sPmCHp4QOcLkvJb4PbdUM=;
        b=Y1SeBAqgEKq3esQbSccFBso04j8gOYCsVG1SLI7ahK89iO5F/vihHy4EJfUsK5vX/J
         G9iOSxEm/SyXAtd0dRsIRHU5Sn7szleUjigggkCjtQyuzsP/CGvCx96MKEz8EWuw5esk
         8zb4eJmo4VS+iN/l19sp74uXwEVTvx3KUqFutNrDsvPdanwRrxEFo+vMP6eNTgAIS2UR
         34AugNIXg6v6Ycq1eXoYG0Y3a2O5dAa+04n+6Nn76A7tyX40+2BqeBQlddBoUMIkf7GW
         swwpPcUSaZTZ6MY9Fi68hEvBs4RkUCM9DuImrUEVn+ETjVru2BDZklrrG/vLnicAuo/S
         vHlQ==
X-Gm-Message-State: AOAM53357sEXMbuD2/I1nzlhwgcx3on0PedAsqtbHbmrDZLPwB1GUwoI
        o88ByBzWAz3wQei/uAM0f+eXrFhQou0=
X-Google-Smtp-Source: ABdhPJy1lQX7j6kSb8Ya8+fAItDXHvdlaVeUA5QQgZjh5py+ejKiqMe2pYKHyoUImotpBZ7w4mPvxQ==
X-Received: by 2002:a92:a1cc:: with SMTP id b73mr8355542ill.162.1591597503746;
        Sun, 07 Jun 2020 23:25:03 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id s73sm7477948ilk.41.2020.06.07.23.25.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 23:25:03 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jonathan=20M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 5/8] worktree: prune duplicate entries referencing same worktree path
Date:   Mon,  8 Jun 2020 02:23:53 -0400
Message-Id: <20200608062356.40264-6-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da
In-Reply-To: <20200608062356.40264-1-sunshine@sunshineco.com>
References: <20200608062356.40264-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A fundamental restriction of linked working trees is that there must
only ever be a single worktree associated with a particular path, thus
"git worktree add" explicitly disallows creation of a new worktree at
the same location as an existing registered worktree. Nevertheless,
users can still "shoot themselves in the foot" by mucking with
administrative files in .git/worktree/<id>/. Worse, "git worktree move"
is careless[1] and allows a worktree to be moved atop a registered but
missing worktree (which can happen, for instance, if the worktree is on
removable media). For instance:

    $ git clone foo.git
    $ cd foo
    $ git worktree add ../bar
    $ git worktree add ../baz
    $ rm -rf ../bar
    $ git worktree move ../baz ../bar
    $ git worktree list
    .../foo beefd00f [master]
    .../bar beefd00f [bar]
    .../bar beefd00f [baz]

Help users recover from this form of corruption by teaching "git
worktree prune" to detect when multiple worktrees are associated with
the same path.

[1]: A subsequent commit will fix "git worktree move" validation to be
     more strict.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c        | 64 ++++++++++++++++++++++++++++++---------
 t/t2401-worktree-prune.sh | 12 ++++++++
 2 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d0c046e885..2cb95f16d4 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -67,7 +67,12 @@ static void delete_worktrees_dir_if_empty(void)
 	rmdir(git_path("worktrees")); /* ignore failed removal */
 }
 
-static int should_prune_worktree(const char *id, struct strbuf *reason)
+/*
+ * Return NULL if worktree entry should be pruned (along with reason for
+ * pruning), otherwise return the path of the worktree itself. Caller is
+ * responsible for freeing return value.
+ */
+static char *worktree_disposition(const char *id, struct strbuf *reason)
 {
 	struct stat st;
 	char *path;
@@ -77,17 +82,17 @@ static int should_prune_worktree(const char *id, struct strbuf *reason)
 
 	if (!is_directory(git_path("worktrees/%s", id))) {
 		strbuf_addstr(reason, _("not a valid directory"));
-		return 1;
+		return NULL;
 	}
 	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
 		strbuf_addstr(reason, _("gitdir file does not exist"));
-		return 1;
+		return NULL;
 	}
 	fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
 	if (fd < 0) {
 		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
 			    strerror(errno));
-		return 1;
+		return NULL;
 	}
 	len = xsize_t(st.st_size);
 	path = xmallocz(len);
@@ -98,7 +103,7 @@ static int should_prune_worktree(const char *id, struct strbuf *reason)
 			    strerror(errno));
 		close(fd);
 		free(path);
-		return 1;
+		return NULL;
 	}
 	close(fd);
 
@@ -107,30 +112,29 @@ static int should_prune_worktree(const char *id, struct strbuf *reason)
 			    _("short read (expected %"PRIuMAX" bytes, read %"PRIuMAX")"),
 			    (uintmax_t)len, (uintmax_t)read_result);
 		free(path);
-		return 1;
+		return NULL;
 	}
 	while (len && (path[len - 1] == '\n' || path[len - 1] == '\r'))
 		len--;
 	if (!len) {
 		strbuf_addstr(reason, _("invalid gitdir file"));
 		free(path);
-		return 1;
+		return NULL;
 	}
 	path[len] = '\0';
 	if (!file_exists(path)) {
-		free(path);
 		if (file_exists(git_path("worktrees/%s/locked", id)))
-			return 0;
+			return path;
 		if (stat(git_path("worktrees/%s/index", id), &st) ||
 		    st.st_mtime <= expire) {
 			strbuf_addstr(reason, _("gitdir file points to non-existent location"));
-			return 1;
+			free(path);
+			return NULL;
 		} else {
-			return 0;
+			return path;
 		}
 	}
-	free(path);
-	return 0;
+	return path;
 }
 
 static void prune_worktree(const char *id, const char *reason)
@@ -141,22 +145,54 @@ static void prune_worktree(const char *id, const char *reason)
 		delete_git_dir(id);
 }
 
+static int prune_cmp(const void *a, const void *b)
+{
+	const struct string_list_item *x = a;
+	const struct string_list_item *y = b;
+	int c;
+
+	if ((c = fspathcmp(x->string, y->string)))
+	    return c;
+	/* paths same; sort by .git/worktrees/<id> */
+	return strcmp(x->util, y->util);
+}
+
+static void prune_dups(struct string_list *l)
+{
+	int i;
+
+	QSORT(l->items, l->nr, prune_cmp);
+	for (i = 1; i < l->nr; i++) {
+		if (!fspathcmp(l->items[i].string, l->items[i - 1].string))
+			prune_worktree(l->items[i].util, "duplicate entry");
+	}
+}
+
 static void prune_worktrees(void)
 {
 	struct strbuf reason = STRBUF_INIT;
+	struct string_list kept = STRING_LIST_INIT_NODUP;
 	DIR *dir = opendir(git_path("worktrees"));
 	struct dirent *d;
 	if (!dir)
 		return;
 	while ((d = readdir(dir)) != NULL) {
+		char *path;
 		if (is_dot_or_dotdot(d->d_name))
 			continue;
 		strbuf_reset(&reason);
-		if (!should_prune_worktree(d->d_name, &reason))
+		path = worktree_disposition(d->d_name, &reason);
+		if (path) {
+			string_list_append(&kept, path)->util = xstrdup(d->d_name);
 			continue;
+		}
 		prune_worktree(d->d_name, reason.buf);
 	}
 	closedir(dir);
+
+	prune_dups(&kept);
+	string_list_clear(&kept, 1);
+
 	if (!show_only)
 		delete_worktrees_dir_if_empty();
 	strbuf_release(&reason);
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index 9be8e97d66..7694f25a16 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -102,4 +102,16 @@ test_expect_success 'not prune proper checkouts' '
 	test -d .git/worktrees/nop
 '
 
+test_expect_success 'prune duplicate (linked/linked)' '
+	test_when_finished rm -fr .git/worktrees w1 w2 &&
+	git worktree add --detach w1 &&
+	git worktree add --detach w2 &&
+	sed "s/w2/w1/" .git/worktrees/w2/gitdir >.git/worktrees/w2/gitdir.new &&
+	mv .git/worktrees/w2/gitdir.new .git/worktrees/w2/gitdir &&
+	git worktree prune --verbose >actual &&
+	test_i18ngrep "duplicate entry" actual &&
+	test -d .git/worktrees/w1 &&
+	! test -d .git/worktrees/w2
+'
+
 test_done
-- 
2.27.0.290.gba653c62da


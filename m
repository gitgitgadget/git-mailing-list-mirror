Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C817920248
	for <e@80x24.org>; Tue, 26 Feb 2019 10:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfBZK7H (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 05:59:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42813 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfBZK7H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 05:59:07 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so6066629pfi.9
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 02:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkvR1LApeMXLa+es8kSfYFULlWhUm5gx0iaO3b5B1Ys=;
        b=JaXNZNykv1C6FYnBjGFsQoEDjn1a1haAP6DYTSYi9AyrELeJ/gOv4BITYOi33DWPW0
         IL+e+/uihRiacm1aW6GNawJXW1vOQ7r2LNOMiogym2kjoB5SeC7daTL8fgr7vpXA5SRh
         khTAO03mgAW4HG+Yc8mmG8R8BkrLPLoHPH0qO4cPESP5jb1DE6i8J2yq3x7R07b9Kp7z
         moabZmbpBhkdH6GXEdVetjPFKcTk6N2EL3c89G/f5aXRc81ks99MI/xrVUrWuzxzamAE
         IRyZvp7YZaZfMYqDpvbg+1RsDFbCL01EpZWjFXgJaAewU1aFU/PNDolSquWVSa+1FRFg
         G4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkvR1LApeMXLa+es8kSfYFULlWhUm5gx0iaO3b5B1Ys=;
        b=hsW3B4s6HA7I/uxxXMZfk8HIUsNxi++AS/EllmQuJQuywo5h26acZnCxt8eQ8efVY/
         bT3Lj1+hQlW/uv7HpaZ1LYZk9x3e56nM6qo+4l2lwP68Qq7db95zBQd7PZqfKoJYk5Hg
         AFJQChzmDIu5/k08JL255ah6c2utfJelX0AnkX2PTZb0NivR4TJfFjomHPKifzMNcZmL
         azZj3/kySH2XaOjA7T4lHdfsvaScVTPCSeRcByheEf5oOSPkOGuppd0kbokmjh9lafDy
         keqGeX7IuMRhLOruxpHD5MVZJ+6YN8KqTvxjMFBJFzoN+q1p7HVrbDUE8VnvHb6Le/JD
         fZRw==
X-Gm-Message-State: AHQUAuZH5FjodqUNeNj7y29qsXqTyMFnlCGydMohkTnF7W0/bgaGQsxY
        Dx/XBIxsVVx5zZ/UwIMqABY=
X-Google-Smtp-Source: AHgI3IYgGaKJhBk06dzrvIFMrbTpjeg9/rhBLBlPjEJB303yIpC66ho5O0eOd4C0wnBWMYey9MDtAA==
X-Received: by 2002:a62:6f06:: with SMTP id k6mr25164232pfc.257.1551178746531;
        Tue, 26 Feb 2019 02:59:06 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id h65sm14935280pgc.93.2019.02.26.02.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 02:59:05 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 26 Feb 2019 17:59:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, hi-angel@yandex.ru, sunshine@sunshineco.com,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 1/1] worktree add: sanitize worktree names
Date:   Tue, 26 Feb 2019 17:58:51 +0700
Message-Id: <20190226105851.32273-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190226105851.32273-1-pclouds@gmail.com>
References: <20190221121943.19778-1-pclouds@gmail.com>
 <20190226105851.32273-1-pclouds@gmail.com>
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
 builtin/worktree.c      | 37 ++++++++++++++++++++++++++++++++++++-
 refs.c                  |  6 ++++++
 refs.h                  |  1 +
 t/t2025-worktree-add.sh |  7 +++++++
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3f9907fcc9..21469eb52c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -262,6 +262,36 @@ static void validate_worktree_add(const char *path, const struct add_opts *opts)
 	free_worktrees(worktrees);
 }
 
+static void sanitize_worktree_name(struct strbuf *name)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int i;
+
+	for (i = 0; i < name->len; i++) {
+		int ch = name->buf[i];
+
+		if (char_allowed_in_refname(ch))
+			strbuf_addch(&sb, ch);
+		else if (sb.len > 0 && sb.buf[sb.len - 1] != '-')
+			strbuf_addch(&sb, '-');
+	}
+	if (sb.len > 0 && sb.buf[sb.len - 1] == '-')
+		strbuf_setlen(&sb, sb.len - 1);
+	/*
+	 * a worktree name of only special chars would be reduced to
+	 * an empty string
+	 */
+	if (sb.len == 0)
+		strbuf_addstr(&sb, "worktree");
+
+	if (check_refname_format(sb.buf, REFNAME_ALLOW_ONELEVEL))
+		BUG("worktree name '%s' (from '%s') is not a valid refname",
+		    sb.buf, name->buf);
+
+	strbuf_swap(&sb, name);
+	strbuf_release(&sb);
+}
+
 static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
@@ -275,6 +305,7 @@ static int add_worktree(const char *path, const char *refname,
 	struct strbuf symref = STRBUF_INIT;
 	struct commit *commit = NULL;
 	int is_branch = 0;
+	struct strbuf sb_name = STRBUF_INIT;
 
 	validate_worktree_add(path, opts);
 
@@ -290,7 +321,10 @@ static int add_worktree(const char *path, const char *refname,
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
@@ -415,6 +449,7 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_release(&symref);
 	strbuf_release(&sb_repo);
 	strbuf_release(&sb_git);
+	strbuf_release(&sb_name);
 	return ret;
 }
 
diff --git a/refs.c b/refs.c
index 142888a40a..f23f583db1 100644
--- a/refs.c
+++ b/refs.c
@@ -57,6 +57,12 @@ static unsigned char refname_disposition[256] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
 };
 
+int char_allowed_in_refname(int ch)
+{
+	return 0 <= ch && ch < ARRAY_SIZE(refname_disposition) &&
+		refname_disposition[ch] == 0;
+}
+
 /*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
diff --git a/refs.h b/refs.h
index 308fa1f03b..61b4073f76 100644
--- a/refs.h
+++ b/refs.h
@@ -459,6 +459,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data);
  * repeated slashes are accepted.
  */
 int check_refname_format(const char *refname, int flags);
+int char_allowed_in_refname(int ch);
 
 const char *prettify_refname(const char *refname);
 
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 286bba35d8..ea22207361 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -570,4 +570,11 @@ test_expect_success '"add" an existing locked but missing worktree' '
 	git worktree add --force --force --detach gnoo
 '
 
+test_expect_success 'sanitize generated worktree name' '
+	git worktree add --detach ".  weird*..?.lock.lock." &&
+	test -d .git/worktrees/weird-lock-lock &&
+	git worktree add --detach .... &&
+	test -d .git/worktrees/worktree
+'
+
 test_done
-- 
2.21.0.rc1.337.gdf7f8d0522


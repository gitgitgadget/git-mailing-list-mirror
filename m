Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A83A20248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfCHJ2u (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:28:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45918 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfCHJ2t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:28:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id 125so13455784pgc.12
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LbE2biPutGRs6FsPPABFKhkVUYOx6weAJTlWiZDw+L4=;
        b=ir7MD+7j2AsNxuCdcKqQndnYDTEUdS5dDrCKZyvdDZRywi+enrih41ReBCQa19iUk9
         rxTaXaqas8x2M+uIFMnaJDHZ1m7+TLV0odqqnVCz/OYGD+sAv/8Qbv6ja+jXy40GH5Mt
         quW6aZarDQawBg3+ktMYPGazL5aji9vtUuhFim08Jf268ft/BzQGu0vOW3CA2MQ8jbMU
         RyIA8zHFll6W1lZEX0s5+OTe+pWsytt7/lJAO8/kYr7Mk73DVI3PEt+ozB/KK26AGqh4
         L3iUqI1OsAVetZvOo8x8pRfD8+GkKuSmc0S8FKksggQ5ecxzj3aw7Y8losFiFh79bGeE
         qU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LbE2biPutGRs6FsPPABFKhkVUYOx6weAJTlWiZDw+L4=;
        b=IL6h7jJR5LPwS7WXVooJ/LfNCHkfdayf3D5tzZ8iJpB9eVnXwRvW7gbsRsJy7ajI8u
         VpJSE8ANRlEYkod4FANak1+5SzXEu83TA/aNWg5G9TlwR78GSjpgMowQV4GQOWQOfq7V
         5ERHzDlINTvQYmjpGnSxA+PwiAQasWQnKjiImRO0PLtX2I2ZtK2UwrrEExU/SLf2/yn1
         KXQl5/qTDBWNpaQs+tbi5jFkPcZNAdWB9Rusztu8Mxs7zorn9bRH5pG4IdkOIeBjAgXH
         yTotzsnBaIlGM4+8v23MOqZU16WBKMYEhGQqymDyai4SIr2wH7Akqpph3vWalTyoljE/
         kHSA==
X-Gm-Message-State: APjAAAXomtHlgqngv+N5J7z2Z6x/ZBfRrf2VjvQQaywr4wu4N80nVH+7
        cY7+8qnSVTh54K0MsppXA1g=
X-Google-Smtp-Source: APXvYqzfDmscMzG5S6pLIRxdXPG8zFPFvzcM8Aain4pIl/wh71IKF8mnLzJfqc1JzVbVyzL9dmBehQ==
X-Received: by 2002:a65:5142:: with SMTP id g2mr15840086pgq.149.1552037329054;
        Fri, 08 Mar 2019 01:28:49 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id m20sm24140035pfj.142.2019.03.08.01.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:28:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:28:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        hi-angel@yandex.ru, peff@peff.net, ramsay@ramsayjones.plus.com,
        sunshine@sunshineco.com
Subject: [PATCH v5 1/1] worktree add: sanitize worktree names
Date:   Fri,  8 Mar 2019 16:28:34 +0700
Message-Id: <20190308092834.12549-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308092834.12549-1-pclouds@gmail.com>
References: <20190305120834.7284-1-pclouds@gmail.com>
 <20190308092834.12549-1-pclouds@gmail.com>
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
these rules. In the future the user will be able to specify the
worktree name by themselves if they're not happy with this dumb
character substitution.

Reported-by: Konstantin Kharlamov <hi-angel@yandex.ru>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c      |  10 +++-
 refs.c                  | 103 ++++++++++++++++++++++++++++++++--------
 refs.h                  |   6 +++
 t/t2400-worktree-add.sh |   5 ++
 4 files changed, 104 insertions(+), 20 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 6cc094a453..756cf3a417 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -275,6 +275,7 @@ static int add_worktree(const char *path, const char *refname,
 	struct strbuf symref = STRBUF_INIT;
 	struct commit *commit = NULL;
 	int is_branch = 0;
+	struct strbuf sb_name = STRBUF_INIT;
 
 	validate_worktree_add(path, opts);
 
@@ -290,7 +291,13 @@ static int add_worktree(const char *path, const char *refname,
 		die(_("invalid reference: %s"), refname);
 
 	name = worktree_basename(path, &len);
-	git_path_buf(&sb_repo, "worktrees/%.*s", (int)(path + len - name), name);
+	strbuf_add(&sb, name, path + len - name);
+	sanitize_refname_component(sb.buf, &sb_name);
+	if (!sb_name.len)
+		BUG("How come '%s' becomes empty after sanitization?", sb.buf);
+	strbuf_reset(&sb);
+	name = sb_name.buf;
+	git_path_buf(&sb_repo, "worktrees/%s", name);
 	len = sb_repo.len;
 	if (safe_create_leading_directories_const(sb_repo.buf))
 		die_errno(_("could not create leading directories of '%s'"),
@@ -416,6 +423,7 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_release(&symref);
 	strbuf_release(&sb_repo);
 	strbuf_release(&sb_git);
+	strbuf_release(&sb_name);
 	return ret;
 }
 
diff --git a/refs.c b/refs.c
index 142888a40a..e9f83018f0 100644
--- a/refs.c
+++ b/refs.c
@@ -72,30 +72,57 @@ static unsigned char refname_disposition[256] = {
  * - it ends with ".lock", or
  * - it contains a "@{" portion
  */
-static int check_refname_component(const char *refname, int *flags)
+static int check_refname_component(const char *refname, int *flags,
+				   struct strbuf *sanitized)
 {
 	const char *cp;
 	char last = '\0';
+	size_t component_start;
+
+	if (sanitized)
+		component_start = sanitized->len;
 
 	for (cp = refname; ; cp++) {
 		int ch = *cp & 255;
 		unsigned char disp = refname_disposition[ch];
+
+		if (sanitized && disp != 1)
+			strbuf_addch(sanitized, ch);
+
 		switch (disp) {
 		case 1:
 			goto out;
 		case 2:
-			if (last == '.')
-				return -1; /* Refname contains "..". */
+			if (last == '.') { /* Refname contains "..". */
+				if (sanitized)
+					sanitized->len--; /* collapse ".." to single "." */
+				else
+					return -1;
+			}
 			break;
 		case 3:
-			if (last == '@')
-				return -1; /* Refname contains "@{". */
+			if (last == '@') { /* Refname contains "@{". */
+				if (sanitized)
+					sanitized->buf[sanitized->len-1] = '-';
+				else
+					return -1;
+			}
 			break;
 		case 4:
-			return -1;
+			/* forbidden char */
+			if (sanitized)
+				sanitized->buf[sanitized->len-1] = '-';
+			else
+				return -1;
+			break;
 		case 5:
-			if (!(*flags & REFNAME_REFSPEC_PATTERN))
-				return -1; /* refspec can't be a pattern */
+			if (!(*flags & REFNAME_REFSPEC_PATTERN)) {
+				/* refspec can't be a pattern */
+				if (sanitized)
+					sanitized->buf[sanitized->len-1] = '-';
+				else
+					return -1;
+			}
 
 			/*
 			 * Unset the pattern flag so that we only accept
@@ -109,26 +136,48 @@ static int check_refname_component(const char *refname, int *flags)
 out:
 	if (cp == refname)
 		return 0; /* Component has zero length. */
-	if (refname[0] == '.')
-		return -1; /* Component starts with '.'. */
+
+	if (refname[0] == '.') { /* Component starts with '.'. */
+		if (sanitized)
+			sanitized->buf[component_start] = '-';
+		else
+			return -1;
+	}
 	if (cp - refname >= LOCK_SUFFIX_LEN &&
-	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN))
-		return -1; /* Refname ends with ".lock". */
+	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN)) {
+		if (!sanitized)
+			return -1;
+		/* Refname ends with ".lock". */
+		while (strbuf_strip_suffix(sanitized, LOCK_SUFFIX)) {
+			/* try again in case we have .lock.lock */
+		}
+	}
 	return cp - refname;
 }
 
-int check_refname_format(const char *refname, int flags)
+static int check_or_sanitize_refname(const char *refname, int flags,
+				     struct strbuf *sanitized)
 {
 	int component_len, component_count = 0;
 
-	if (!strcmp(refname, "@"))
+	if (!strcmp(refname, "@")) {
 		/* Refname is a single character '@'. */
-		return -1;
+		if (sanitized)
+			strbuf_addch(sanitized, '-');
+		else
+			return -1;
+	}
 
 	while (1) {
+		if (sanitized && sanitized->len)
+			strbuf_complete(sanitized, '/');
+
 		/* We are at the start of a path component. */
-		component_len = check_refname_component(refname, &flags);
-		if (component_len <= 0)
+		component_len = check_refname_component(refname, &flags,
+							sanitized);
+		if (sanitized && component_len == 0)
+			; /* OK, omit empty component */
+		else if (component_len <= 0)
 			return -1;
 
 		component_count++;
@@ -138,13 +187,29 @@ int check_refname_format(const char *refname, int flags)
 		refname += component_len + 1;
 	}
 
-	if (refname[component_len - 1] == '.')
-		return -1; /* Refname ends with '.'. */
+	if (refname[component_len - 1] == '.') {
+		/* Refname ends with '.'. */
+		if (sanitized)
+			; /* omit ending dot */
+		else
+			return -1;
+	}
 	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
 		return -1; /* Refname has only one component. */
 	return 0;
 }
 
+int check_refname_format(const char *refname, int flags)
+{
+	return check_or_sanitize_refname(refname, flags, NULL);
+}
+
+void sanitize_refname_component(const char *refname, struct strbuf *out)
+{
+	if (check_or_sanitize_refname(refname, REFNAME_ALLOW_ONELEVEL, out))
+		BUG("sanitizing refname '%s' check returned error", refname);
+}
+
 int refname_is_safe(const char *refname)
 {
 	const char *rest;
diff --git a/refs.h b/refs.h
index 308fa1f03b..4d8c5465c3 100644
--- a/refs.h
+++ b/refs.h
@@ -460,6 +460,12 @@ int for_each_reflog(each_ref_fn fn, void *cb_data);
  */
 int check_refname_format(const char *refname, int flags);
 
+/*
+ * Apply the rules from check_refname_format, but mutate the result until it
+ * is acceptable, and place the result in "out".
+ */
+void sanitize_refname_component(const char *refname, struct strbuf *out);
+
 const char *prettify_refname(const char *refname);
 
 char *shorten_unambiguous_ref(const char *refname, int strict);
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 286bba35d8..c989dbe321 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -570,4 +570,9 @@ test_expect_success '"add" an existing locked but missing worktree' '
 	git worktree add --force --force --detach gnoo
 '
 
+test_expect_success FUNNYNAMES 'sanitize generated worktree name' '
+	git worktree add --detach ".  weird*..?.lock.lock" &&
+	test -d .git/worktrees/---weird-.-
+'
+
 test_done
-- 
2.21.0.rc1.337.gdf7f8d0522


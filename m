Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7A3C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309F72067B
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umqM+nXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgFHGZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgFHGZA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 02:25:00 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D06CC08C5C4
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 23:25:00 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id c8so17341669iob.6
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 23:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8pRSLGaGRrEW4htbLAXHZG5waVEBVHSPXOCB1NQdew=;
        b=umqM+nXwT8JPfYDrlgfBIEe+5gSupUILemlPqtbhkG0SPoPs4gD0DvWLj3e/gZmnES
         SD2rZQep5aYTV4WqLwxVyYMAZ04jyVPqD3WY4kADFEljkMDQSx4ZxHE8wsCLM3lyzp7S
         k5H3JcySJXD5ky9J8nxI6KrwRUr9wZDrkc10d7zXUTQift9j12/ZEeVRVpm5fg2slqBY
         rUOA7SEvs/b0fte9eIpc3N5wDzJ2Ce1EpDWeoxxuQ/wVOl8tiK7jzYvAcxZguI35B/gi
         ZLehIZpxC+S9sRnHu5FACbTjanLhldVZdiovQwY0d76fR40EbQ1wj7iBkKpA3s3vZKlK
         IF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=d8pRSLGaGRrEW4htbLAXHZG5waVEBVHSPXOCB1NQdew=;
        b=DXKBOi26/tN3+08dEqs7j3cUvMnnwrcC+N/QHaJ0mbULfXDLTx+wVGabyLCQvGTBHi
         3OVT/ZYmTeOqMW+rrUJPoYet++z5ohFkc4JWuQDY+WMb3AZW2AmhGGfGC6i3KzghT5Yr
         5QjRkLmf13XKYi6d3J8BZYFwuojqQZh+cpLOPqo03V7avJ1XArmVDSKZ8Ze9oVF7z0m7
         Jm6sqbVvMLaSeIFdI95kHoyttWFEpqbtkzwLdxesoCwHzugYysPn8Ub19slXRf7y0Hm2
         hU9qZ7kSDrzJf1yqPWZYhTvvNbJFHn07AwKPYIQ4ihSd8zHxXVJHhe7HwXWXDltJ0Seg
         OrVQ==
X-Gm-Message-State: AOAM533VICujw2JSGvcLdM99xHdo2EVXWC96oraOpazX5jDsAMcNbcXa
        19KLNmVgyoMSqJm7rYoILKoZVfod9N4=
X-Google-Smtp-Source: ABdhPJwPI/CQzMRvMxCevaBuybsL7MWO8TMN9SFIJRiNQLY563GtOxvbt/ohRlK9NCGQhkStnI7Pfg==
X-Received: by 2002:a02:a78e:: with SMTP id e14mr20863078jaj.9.1591597499066;
        Sun, 07 Jun 2020 23:24:59 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id s73sm7477948ilk.41.2020.06.07.23.24.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 23:24:58 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jonathan=20M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/8] worktree: factor out repeated string literal
Date:   Mon,  8 Jun 2020 02:23:49 -0400
Message-Id: <20200608062356.40264-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da
In-Reply-To: <20200608062356.40264-1-sunshine@sunshineco.com>
References: <20200608062356.40264-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For each worktree removed by "git worktree prune", it reports the reason
for the removal. All reasons share the common prefix "Removing
worktrees/%s:". As new removal reasons are added, this prefix needs to
be duplicated, which is error-prone and potentially cumbersome.
Therefore, factor out the common prefix.

Although this change seems to increase the "sentence lego quotient", it
should be reasonably safe, as the reason for removal is a distinct
clause, not strictly related to the prefix. Moreover, the "worktrees" in
"Removing worktrees/%s:" is a path literal which ought not be localized,
so by factoring it out, we can more easily avoid exposing that path
fragment to translators.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d99db35668..9b15f19fc5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -76,19 +76,19 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 	ssize_t read_result;
 
 	if (!is_directory(git_path("worktrees/%s", id))) {
-		strbuf_addf(reason, _("Removing worktrees/%s: not a valid directory"), id);
+		strbuf_addstr(reason, _("not a valid directory"));
 		return 1;
 	}
 	if (file_exists(git_path("worktrees/%s/locked", id)))
 		return 0;
 	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
-		strbuf_addf(reason, _("Removing worktrees/%s: gitdir file does not exist"), id);
+		strbuf_addstr(reason, _("gitdir file does not exist"));
 		return 1;
 	}
 	fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
 	if (fd < 0) {
-		strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir file (%s)"),
-			    id, strerror(errno));
+		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
+			    strerror(errno));
 		return 1;
 	}
 	len = xsize_t(st.st_size);
@@ -96,8 +96,8 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 
 	read_result = read_in_full(fd, path, len);
 	if (read_result < 0) {
-		strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir file (%s)"),
-			    id, strerror(errno));
+		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
+			    strerror(errno));
 		close(fd);
 		free(path);
 		return 1;
@@ -106,15 +106,15 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 
 	if (read_result != len) {
 		strbuf_addf(reason,
-			    _("Removing worktrees/%s: short read (expected %"PRIuMAX" bytes, read %"PRIuMAX")"),
-			    id, (uintmax_t)len, (uintmax_t)read_result);
+			    _("short read (expected %"PRIuMAX" bytes, read %"PRIuMAX")"),
+			    (uintmax_t)len, (uintmax_t)read_result);
 		free(path);
 		return 1;
 	}
 	while (len && (path[len - 1] == '\n' || path[len - 1] == '\r'))
 		len--;
 	if (!len) {
-		strbuf_addf(reason, _("Removing worktrees/%s: invalid gitdir file"), id);
+		strbuf_addstr(reason, _("invalid gitdir file"));
 		free(path);
 		return 1;
 	}
@@ -123,7 +123,7 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 		free(path);
 		if (stat(git_path("worktrees/%s/index", id), &st) ||
 		    st.st_mtime <= expire) {
-			strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to non-existent location"), id);
+			strbuf_addstr(reason, _("gitdir file points to non-existent location"));
 			return 1;
 		} else {
 			return 0;
@@ -147,7 +147,8 @@ static void prune_worktrees(void)
 		if (!prune_worktree(d->d_name, &reason))
 			continue;
 		if (show_only || verbose)
-			printf("%s\n", reason.buf);
+			printf_ln(_("Removing %s/%s: %s"),
+				  "worktrees", d->d_name, reason.buf);
 		if (show_only)
 			continue;
 		delete_git_dir(d->d_name);
-- 
2.27.0.290.gba653c62da


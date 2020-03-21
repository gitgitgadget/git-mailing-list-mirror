Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077F5C4332E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8B62070A
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOIxAxIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgCUJWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44048 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgCUJWe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id j4so9762342qkc.11
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0NxTigZ7S4/0pb8spV/wk3u0bSd2dMtokHnQKs1ut8=;
        b=lOIxAxIQ+d8ngedlfoc5yXI0/2hnGijDSrX/8GbUI8LvthI3g9M+BrJGo0cM5Sec75
         yVVLuDJnJPigjLMje+jde0JOg8i6ibxrGp3ZAVqkduGMYuP8td7k1l32kZgJy3hfYUsO
         RoI8NdeeBxj+2AP8v+VAXj9coI1tzqWQTJCMHYgfs9vPZcGCU4GhSMgm4hi6HkfxJ40G
         LYKag0Srz9R1huQEa8lmIvnMPg24pZ8ALzkGIIbo29vG8AbPaBr4SizUaOepeGUDJh39
         Wb7eazH2REiD0jEumaTZFVydUZ7Z5lmhiIVJBwycm4Rtvv1ZHKhzAekT+3N/ThnIocW1
         9kwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0NxTigZ7S4/0pb8spV/wk3u0bSd2dMtokHnQKs1ut8=;
        b=p5uohdQotcmV6OKiuUXd97d+1YRBbt0WLWCrKETZgvQtTzuJMp89BJfKnkjuRiOuCV
         8jZfBwZ9eGYyRrWuovV3Qt/LGhEE+kLIcZ/Y0QiBeLCJFDNeykbxMh7+1BFLqR8QjIF+
         JofJb0/Is3ZmaE+ebIPQ2RVbFRwgYTLzpx80ROo2ke0bWQ8OeBw3pBpSOFjFx+aEpPHd
         gfZ83NKOlXHxBvhrT8WEoPabMvWvdrvQO0+Pcx1Ly9wB5Lpecn3PyC+aJgI6+sjj/ojH
         5od7JunGm5r3Ttc9eEQHoNjUsdnFlhzGZdk/OpnVx3XZPh7b0gPPZ5bBbJAsD081iiC8
         GJYw==
X-Gm-Message-State: ANhLgQ2CLDmvlKo9ixyjKxaCxgmvvVhK1Fomc2uhnGRgtntdA6kGqZ1C
        ggvv8BbIi9UUfxoI247AiaPb0HoU
X-Google-Smtp-Source: ADFU+vsPE7/N+iWmUTJwsl4PFbOMDHWQPIry0amorZk0y94rWk+qMy18sl21t/iTItE0lkGxSEaKGA==
X-Received: by 2002:a37:4b86:: with SMTP id y128mr812704qka.95.1584782553332;
        Sat, 21 Mar 2020 02:22:33 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:32 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 13/19] rebase: generify create_autostash()
Date:   Sat, 21 Mar 2020 05:21:32 -0400
Message-Id: <fffc038cd6d81f50a369904a8ecc2b1b6fab0e2b.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we plan on lib-ifying create_autostash() so we need it to
be more generic. Make it more generic by making it accept a
`struct repository` argument instead of implicitly using the non-repo
functions and `the_repository`. Also, make it accept a `path` argument
so that we no longer rely have to rely on `struct rebase_options`.
Finally, make it accept a `default_reflog_action` argument so we no
longer have to rely on `DEFAULT_REFLOG_ACTION`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 037effc510..3370c8f2c4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1274,22 +1274,21 @@ static int check_exec_cmd(const char *cmd)
 	return 0;
 }
 
-static void create_autostash(struct rebase_options *options)
+static void create_autostash(struct repository *r, const char *path,
+			     const char *default_reflog_action)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct lock_file lock_file = LOCK_INIT;
 	int fd;
 
-	fd = hold_locked_index(&lock_file, 0);
-	refresh_cache(REFRESH_QUIET);
+	fd = repo_hold_locked_index(r, &lock_file, 0);
+	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (0 <= fd)
-		repo_update_index_if_able(the_repository, &lock_file);
+		repo_update_index_if_able(r, &lock_file);
 	rollback_lock_file(&lock_file);
 
-	if (has_unstaged_changes(the_repository, 1) ||
-	    has_uncommitted_changes(the_repository, 1)) {
-		const char *autostash =
-			state_dir_path("autostash", options);
+	if (has_unstaged_changes(r, 1) ||
+	    has_uncommitted_changes(r, 1)) {
 		struct child_process stash = CHILD_PROCESS_INIT;
 		struct object_id oid;
 
@@ -1307,18 +1306,18 @@ static void create_autostash(struct rebase_options *options)
 		strbuf_reset(&buf);
 		strbuf_add_unique_abbrev(&buf, &oid, DEFAULT_ABBREV);
 
-		if (safe_create_leading_directories_const(autostash))
+		if (safe_create_leading_directories_const(path))
 			die(_("Could not create directory for '%s'"),
-			    options->state_dir);
-		write_file(autostash, "%s", oid_to_hex(&oid));
+			    path);
+		write_file(path, "%s", oid_to_hex(&oid));
 		printf(_("Created autostash: %s\n"), buf.buf);
-		if (reset_head(the_repository, NULL, "reset --hard",
+		if (reset_head(r, NULL, "reset --hard",
 			       NULL, RESET_HEAD_HARD, NULL, NULL,
-			       DEFAULT_REFLOG_ACTION) < 0)
+			       default_reflog_action) < 0)
 			die(_("could not reset --hard"));
 
-		if (discard_index(the_repository->index) < 0 ||
-			repo_read_index(the_repository) < 0)
+		if (discard_index(r->index) < 0 ||
+			repo_read_index(r) < 0)
 			die(_("could not read index"));
 	}
 	strbuf_release(&buf);
@@ -1956,7 +1955,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("could not read index"));
 
 	if (options.autostash) {
-		create_autostash(&options);
+		create_autostash(the_repository, state_dir_path("autostash", &options),
+				 DEFAULT_REFLOG_ACTION);
 	}
 
 	if (require_clean_work_tree(the_repository, "rebase",
-- 
2.25.0.114.g5b0ca878e0


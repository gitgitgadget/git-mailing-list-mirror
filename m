Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D51C43331
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50072074B
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bj8hGIyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDDBMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:18 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38118 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgDDBMR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id h14so10194831qke.5
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nhhS7eH2znlOIw1OtQOPkWNOz5rVtgDAZc916pl9T5I=;
        b=Bj8hGIyvSy4hU/Uh8gGfI6aWJ/L4vKvZKf6XN2KrQOBfJ9RORGNPMmmz/KjKY1MtvF
         wBCS+rZdc924kL3bzg0C2VmFzpco3LOlO/JK9VW3xcwF0UtdGRCZWwZZ59NMn1PKBGMa
         uIwmiZcwfPvmWvxmL8RfcpEZJ8+us0HPmZfSMN/jJX7L+6yb5LXCj0S23El6v/vRUqHe
         vhJMGeQA3VmZcSW8Jhp1PJZwzEO5j/BTd3fXMW/68mkKwzlmitSfGT8MHlZHuTR+pYkv
         nf4S/vIWm+Jtsj8SGutmV2ByaRJhb0GGiY5PhIYqx+7qxQh+wG7cEU92t8jgy0/Xcp5x
         rLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nhhS7eH2znlOIw1OtQOPkWNOz5rVtgDAZc916pl9T5I=;
        b=b3EAlLS52E3bcmvRvhHY6rpxkeZS0evc6ArCyfM013Re+NHQ30TLd3S+W0TE2uUz8f
         KwOAxs02Fj8Siha6bZ+1ShLwWDHRGHwJKCCPYxyqhFW/Sx5YMTao+QSzElS3HdW3iNuy
         iNBS3Fpy0QwG7X1Sr/fo5/eENPaOziqvuNAanQbnfHpQb2SJtr8OBGjlOxuRDRZuq8Oi
         vL4xHAYTI8KkMHEqnNjLTjgxilG/GaJupTjKCAgBSrUUb4IytBxAxp1cMsq9RjMoE6mu
         ZXVLEuKPzj7JdPF0vJ19X7ZYyYGR4k5WoYFY8ldhm3xwzYEaBt55EmytXKu/ZZQuePQ+
         llBA==
X-Gm-Message-State: AGi0PubeVRSGhCC5YpWHuhU5JNzWUfpbolYhZ+ogcgY++HBxYN5orSb9
        3DaPaMBGCCjY7XG/YdIR5e2CgrmZ
X-Google-Smtp-Source: APiQypLztK8H2Cl+7kxwY0o+e1T/j1g9A+AfRCl9DIX1l/afhhAvW+/vP9BSz5RtT76PhtXQsuSDEw==
X-Received: by 2002:a05:620a:48:: with SMTP id t8mr168467qkt.21.1585962736280;
        Fri, 03 Apr 2020 18:12:16 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:15 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 16/23] rebase: generify create_autostash()
Date:   Fri,  3 Apr 2020 21:11:29 -0400
Message-Id: <9ab10d23d41a2135a02bf054269a7deb5d07604e.1585962673.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
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
index 8349f3a03a..e9b05a6cd8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1269,22 +1269,21 @@ static int check_exec_cmd(const char *cmd)
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
 
@@ -1302,18 +1301,18 @@ static void create_autostash(struct rebase_options *options)
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
@@ -1951,7 +1950,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("could not read index"));
 
 	if (options.autostash) {
-		create_autostash(&options);
+		create_autostash(the_repository, state_dir_path("autostash", &options),
+				 DEFAULT_REFLOG_ACTION);
 	}
 
 	if (require_clean_work_tree(the_repository, "rebase",
-- 
2.26.0.159.g23e2136ad0


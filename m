Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E05BC2BB86
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2A5207FF
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojImca48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgDGO2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45116 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbgDGO2i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id m67so613528qke.12
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cbePUmxJ16mQRaPfNX0o6pIqYlsrieIb5KHd0Q/gLKA=;
        b=ojImca48A1vfPdcgFOYbJ7m9YmA8fYebSF4hO1W39rm3qxRM9mMRLavVkp9nxmscLe
         UDbVoS0cikNbxOMOrFj7uF6XWLBIz6UDYNDVZPDnrvZTipmKilUItiEfmHVFkzk0p2ze
         WRKzhivkTJM6gM020TciznBolHYoMSDvJlaquOWe0pi9zS8JuzSlK592o6Pr5ur8sYLu
         Id8L5IIi6uvie4MCbzELLUkQtOyjG5g5TRW8rqH3SYzXqCbE8IBagZ0iK1fueBH1piIm
         rA0ZNvWJWcfDvqD2SzHlQd1GeSOygPbgjDKQvHcfuecGl4lWR9ANpVytQcnbGgdI9phH
         FX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cbePUmxJ16mQRaPfNX0o6pIqYlsrieIb5KHd0Q/gLKA=;
        b=Z0O3gQTJa16C660ohcij4cCc4UIdapLL/rHK9iZY4DMfeV7XLEouhOLVNqJpVlMKWp
         MJO08BiCrThl6x48gy/rM19BrV8AsLuL7Sm9VhAzAtsW2/Xz8t0FU3FcZFJY1zxxrPds
         z1plD/wzoGcpOtxFMmgwZsgViJKbCSerjea7KqpdgPiFRLB3p54T2+PMm9BBYFnBkWUG
         IdJR/7VUAI+An0CLQZGba+ygIGJ3YGVyJBxYzLuv84h29h0kT3a+jTqbrL5o0/lS7fJI
         g0Cj4DcszKDT6KzDEIGtdrOqaK+u9u8C83csrFD1KlFiUqBlGBqP1FDloMg0CWG8XtNv
         79Yg==
X-Gm-Message-State: AGi0PuZlhx+kB9glhla77zADaGcRmaL+D/AgWZxtA0/jC4G0Y6EXhnFP
        BuFE5D5e/MN3Eq2ukC+Hi0vz0naC
X-Google-Smtp-Source: APiQypIHF75adwvXw80RNQN8BaXq2V158RsAMANRqicMIyomeQ4sYCrxPxKK0YgQKNWTOZmzJB5x3A==
X-Received: by 2002:a37:6585:: with SMTP id z127mr2477976qkb.463.1586269717471;
        Tue, 07 Apr 2020 07:28:37 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:36 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 15/22] rebase: generify create_autostash()
Date:   Tue,  7 Apr 2020 10:28:02 -0400
Message-Id: <c2ed4cd39d6ec2c7ba095a5a75bf28334be476c8.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
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
index 581ad3af7b..ae345c9e57 100644
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
2.26.0.159.g23e2136ad0


Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E3DC2D0D0
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43682071A
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txwi/ngA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfLXLGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:06:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46589 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfLXLF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:05:59 -0500
Received: by mail-qt1-f194.google.com with SMTP id g1so10956518qtr.13
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95FT44X1fafYIi6ZPoieZf54Wx0KhlfDBBonSUy6A1I=;
        b=txwi/ngA+mGAhC9vOcc4rFMRiMA8Js/v4EHUq31ckVU3914hkHYYZwl2i8B2krvuTU
         RtWtLtMbZfGmDxhXssuR4t8h9H27/Y7B4Dv34VHl1aMYsgfZFrxzDPcrm1067OaWgenH
         mjkT4/jYsIULieiqNfDhYp7/MbL4sac5Uo/aJtaNwCzacyRJ35zEMIBiqZa2wYWVm8s0
         63qe1vN88jp3MAtPI7/uLi/F8R6ix/QUhvflkWtlzg8Pamuh4tdoqyE2Dj8Q0M2b//0m
         Vf2RDcQc5saJyg4Yn/JbZ6L4Sz79z6Ti1US7saQmmbZMa73dDtdbj1gZhnGhsIJA4zOt
         esuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95FT44X1fafYIi6ZPoieZf54Wx0KhlfDBBonSUy6A1I=;
        b=UEWYVrMNE9pOL1hslYTtxckDf85fKeiv4p9jfm6ojhwcoBGpZ0U8OqjLfIVqGX/BFb
         VPNQ6hN9PcS6GzSVG5XG/AA1IAesWleNZ6PM2gdMvLf2S5K8W6NyE82b90VmSxUOa3PN
         ccaq4GLbhD6mxuAXKSUUtcemqggOCFz5gVOpKN2exDBZ9OTDbsOCmFU97xX70+pPOZH/
         iNJ8vwXMhOWbw04ra021VIkHHhN5q/GBnt67BQzStYMLuk7TP98qgQEZJo4nGXUf4rXa
         0zDsvTIF6FNN9FN8Io/dTove48AaCUsHxrteKK/Z52DbPL+sqW5XFulRhLA4so/qpGpJ
         WOHA==
X-Gm-Message-State: APjAAAW24FuyGVjreZ4jic82sORdKIAwcCDjvjc/iGPsRW5svWNNSYdw
        ssmbNefp588n6ebOhKwP5S6tu+N9
X-Google-Smtp-Source: APXvYqzEnAl6H9l8Y+yUzirRR6AmPj/3cMNQ2cK/hwwsuwSmCcaxSHi2nj/QybuTgQkS9iVoRquxYg==
X-Received: by 2002:ac8:604b:: with SMTP id k11mr26869770qtm.372.1577185557972;
        Tue, 24 Dec 2019 03:05:57 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7446944qtb.43.2019.12.24.03.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:05:57 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 12/17] rebase: generify create_autostash()
Date:   Tue, 24 Dec 2019 06:05:09 -0500
Message-Id: <bba7586cba65f40ea016d892479e61f9c9d430dd.1577185374.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com> <cover.1577185374.git.liu.denton@gmail.com>
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
index b60be5c875..fea4ae754d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1232,22 +1232,21 @@ static int check_exec_cmd(const char *cmd)
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
 
@@ -1265,18 +1264,18 @@ static void create_autostash(struct rebase_options *options)
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
@@ -1881,7 +1880,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("could not read index"));
 
 	if (options.autostash) {
-		create_autostash(&options);
+		create_autostash(the_repository, state_dir_path("autostash", &options),
+				 DEFAULT_REFLOG_ACTION);
 	}
 
 	if (require_clean_work_tree(the_repository, "rebase",
-- 
2.24.1.810.g65a2f617f4


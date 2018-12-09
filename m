Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24AB120A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeLIKpO (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:14 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45985 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeLIKpM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so7055063ljd.12
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DoHPT0DUEU3Lkjl6/S6Nl7gtjoVu3Qz0JTjEBqf75ME=;
        b=KtDLNP5+5UP0ycKrWPwm4PTCe1i6YPjxfmr6Bd6ojJW6V1ONgqB18fLESz47Uq2NOO
         ZdPbkuwc7fQHGo9gfmoxUdCf4jnOe62FWv5DYBXrKFq2g0KsE39QulvOhPgqemXLpHAa
         V7/SJW1tW70KJOeXKLFPDuGe98WQGm5Hjz90niC8SDtykdoX6ZHKuFgrJpglleI5z6yk
         TMArqxne391kIEC4wwhGJB8SY1i7fBrKbfvAkmbjug6m8fJsMfQHLVic/xp3AWRYczg+
         HHarAF8gWBztK0dqe3Z3Rey4ppIHG63h+8rHDGvV6fc6FAGoJAeFfpZkzTZckWS5VXGx
         2Cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DoHPT0DUEU3Lkjl6/S6Nl7gtjoVu3Qz0JTjEBqf75ME=;
        b=s6J1aT+XGma/5LUXzbOr4g0gkxLDZ1+FeZBzROpk0xwldO3fOr8qyOVqsv0aLwWgjB
         ZcNf1RplFkPOs2SfHkTDrCx57VIgDfOOe1ndL1OLIUaBvqq6PlByoNFmb3GKL4HNtakL
         zCXZlNkut3IhUGeBJxkB8AQ6w60cl+GVrSx0iVeY2we47DJQZmJuze8Ntn3jGFAFK+ac
         OVEgOMYLH2GF5FZE509TTfPc/KPuQ+FrNrDgwLTby4xZQT7bikALuoMHxImB8r3QEbD/
         jKE70oq30M8CXYLxUQCsaTcS5hQuQ/lAIt2Xi1pbPbE0Iw3USAwn6g3uwXo4Dcohp62a
         mdig==
X-Gm-Message-State: AA+aEWZ1typ8tlKp3BlZf6KPRg/sIxD7ZB0E9gevvdEgTE04juqnOI9T
        y1DoH9HMagoW0MwUUy+zT0Su0zB8
X-Google-Smtp-Source: AFSGD/VsHx1KDBpJ3GGv49aSm6V/JG7CUJwzbMt8VrsHCGfhr4FIuAt9IelHtNYbZlGlMLLgjz81vQ==
X-Received: by 2002:a2e:5703:: with SMTP id l3-v6mr5292895ljb.106.1544352308632;
        Sun, 09 Dec 2018 02:45:08 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:08 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/24] apply: support backup log with --keep-backup
Date:   Sun,  9 Dec 2018 11:44:02 +0100
Message-Id: <20181209104419.12639-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally changes from git-apply are not worth logging because they
come from a file and can be recovered from there. This option will
mostly be used by add--interactive.pl where patches are generated
during an interactive add session and are very much worth logging.

The logging is a bit more complicated because an update is done in two
phases. The old version of all patches is removed first then the new
one added. We need to keep track of the old version in order to make a
backup.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-apply.txt |  3 +++
 apply.c                     | 38 +++++++++++++++++++++++++++++++++++--
 apply.h                     |  1 +
 t/t2080-backup-log.sh       | 25 ++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index b9aa39000f..7b0ae790db 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -250,6 +250,9 @@ When `git apply` is used as a "better GNU patch", the user can pass
 the `--unsafe-paths` option to override this safety check.  This option
 has no effect when `--index` or `--cached` is in use.
 
+--keep-backup::
+	Enable index backup log when `--cached` or `--index` is used.
+
 CONFIGURATION
 -------------
 
diff --git a/apply.c b/apply.c
index 01793d6126..716c9a658f 100644
--- a/apply.c
+++ b/apply.c
@@ -21,6 +21,7 @@
 #include "quote.h"
 #include "rerere.h"
 #include "apply.h"
+#include "backup-log.h"
 
 static void git_apply_config(void)
 {
@@ -226,6 +227,7 @@ struct patch {
 	char old_oid_prefix[GIT_MAX_HEXSZ + 1];
 	char new_oid_prefix[GIT_MAX_HEXSZ + 1];
 	struct patch *next;
+	struct object_id old_oid;
 
 	/* three-way fallback result */
 	struct object_id threeway_stage[3];
@@ -4261,6 +4263,16 @@ static void patch_stats(struct apply_state *state, struct patch *patch)
 static int remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
 {
 	if (state->update_index && !state->ita_only) {
+		if (state->backup_log) {
+			int pos = index_name_pos(state->repo->index,
+						 patch->old_name,
+						 strlen(patch->old_name));
+			if (pos >= 0)
+				oidcpy(&patch->old_oid,
+				       &state->repo->index->cache[pos]->oid);
+			else
+				oidclr(&patch->old_oid);
+		}
 		if (remove_file_from_index(state->repo->index, patch->old_name) < 0)
 			return error(_("unable to remove %s from index"), patch->old_name);
 	}
@@ -4276,7 +4288,8 @@ static int add_index_file(struct apply_state *state,
 			  const char *path,
 			  unsigned mode,
 			  void *buf,
-			  unsigned long size)
+			  unsigned long size,
+			  const struct object_id *old_oid)
 {
 	struct stat st;
 	struct cache_entry *ce;
@@ -4314,6 +4327,16 @@ static int add_index_file(struct apply_state *state,
 				       "for newly created file %s"), path);
 		}
 	}
+	if (state->backup_log) {
+		struct strbuf *sb = state->repo->index->backup_log;
+
+		if (!sb) {
+			sb = xmalloc(sizeof(*sb));
+			strbuf_init(sb, 0);
+			state->repo->index->backup_log = sb;
+		}
+		bkl_append(sb, ce->name, old_oid, &ce->oid);
+	}
 	if (add_index_entry(state->repo->index, ce, ADD_CACHE_OK_TO_ADD) < 0) {
 		discard_cache_entry(ce);
 		return error(_("unable to add cache entry for %s"), path);
@@ -4484,7 +4507,8 @@ static int create_file(struct apply_state *state, struct patch *patch)
 	if (patch->conflicted_threeway)
 		return add_conflicted_stages_file(state, patch);
 	else if (state->update_index)
-		return add_index_file(state, path, mode, buf, size);
+		return add_index_file(state, path, mode, buf, size,
+				      &patch->old_oid);
 	return 0;
 }
 
@@ -4659,6 +4683,7 @@ static int apply_patch(struct apply_state *state,
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
 	int res = 0;
+	int core_backup_log = 0;
 
 	state->patch_input_file = filename;
 	if (read_patch_file(&buf, fd) < 0)
@@ -4721,6 +4746,13 @@ static int apply_patch(struct apply_state *state,
 		goto end;
 	}
 
+	if (state->backup_log &&
+	    (!state->update_index ||
+	     repo_config_get_bool(state->repo, "core.backupLog",
+				  &core_backup_log) ||
+	     !core_backup_log))
+		state->backup_log = 0;
+
 	if (state->check || state->apply) {
 		int r = check_patch_list(state, list);
 		if (r == -128) {
@@ -4982,6 +5014,8 @@ int apply_parse_options(int argc, const char **argv,
 			N_("mark new files with `git add --intent-to-add`")),
 		OPT_BOOL(0, "cached", &state->cached,
 			N_("apply a patch without touching the working tree")),
+		OPT_BOOL(0, "keep-backup", &state->backup_log,
+			 N_("log index changes if the feature is enabled")),
 		OPT_BOOL_F(0, "unsafe-paths", &state->unsafe_paths,
 			   N_("accept a patch that touches outside the working area"),
 			   PARSE_OPT_NOCOMPLETE),
diff --git a/apply.h b/apply.h
index 5948348133..d4de2ebcb9 100644
--- a/apply.h
+++ b/apply.h
@@ -51,6 +51,7 @@ struct apply_state {
 	int check_index; /* preimage must match the indexed version */
 	int update_index; /* check_index && apply */
 	int ita_only;	  /* add intent-to-add entries to the index */
+	int backup_log;	  /* enable backup log */
 
 	/* These control cosmetic aspect of the output */
 	int diffstat; /* just show a diffstat, and don't actually apply */
diff --git a/t/t2080-backup-log.sh b/t/t2080-backup-log.sh
index b19e26a807..8d1c8c5935 100755
--- a/t/t2080-backup-log.sh
+++ b/t/t2080-backup-log.sh
@@ -63,4 +63,29 @@ test_expect_success 'partial commit writes backup log' '
 	test_cmp expected .git/index.bkl
 '
 
+test_expect_success 'apply --cached writes backup log' '
+	rm -f .git/index.bkl &&
+	git reset --hard &&
+	test_tick &&
+	echo to-be-deleted >to-be-deleted &&
+	echo to-be-modified >to-be-modified &&
+	OLD_M=$(git hash-object to-be-modified) &&
+	git add . &&
+	git commit -m first &&
+	rm to-be-deleted &&
+	echo modified >>to-be-modified &&
+	NEW_M=$(git hash-object to-be-modified) &&
+	OLD_A=$ZERO_OID &&
+	echo to-be-added >to-be-added &&
+	NEW_A=$(git hash-object to-be-added) &&
+	git add . &&
+	git commit -m second &&
+	git diff HEAD^ HEAD >patch &&
+	git reset --hard HEAD^ &&
+	git -c core.backupLog=true apply --cached --keep-backup patch &&
+	echo "$OLD_A $NEW_A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $test_tick -0700	to-be-added" >expected &&
+	echo "$OLD_M $NEW_M $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $test_tick -0700	to-be-modified" >>expected &&
+	test_cmp expected .git/index.bkl
+'
+
 test_done
-- 
2.20.0.rc2.486.g9832c05c3d


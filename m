Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 518C11F597
	for <e@80x24.org>; Sun, 29 Jul 2018 00:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbeG2CLF (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 22:11:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44263 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731752AbeG2CLF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 22:11:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so5265593pgp.11
        for <git@vger.kernel.org>; Sat, 28 Jul 2018 17:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2V4npggnB1JGWSzxeT4YSon3VdTvSjH/gf1XvKbK9l4=;
        b=aJldZyAzhmrFii5UrxiTRrYdqBv/3BdaY83sRTAHY8gcnXzpgl19vZ2bctCD14tTE0
         jqYBffN7ENIYg4pOEvbzP0ji08KKFVDxRJdtla2mJiDbH+J4EvVabw7sd1/9d3J67GCD
         DIF4Cc9hto2/6M3ApfVAQ0Jb3TP+rskoz8bI8rXExPM3djPw9WYyOm4jJEd9cbiMlvjH
         n0fV6E+IyGc9QnhoaxCqkVNjQ4c/zBzbjhPg7JlXB8h9rZ/Gqkkb8GEFVjOEdeSpnxWM
         E+FjZo5sXYpokh2KWgvU6eZc1I9MI/bkMwQWvhMauhSeI0o+h6Q6eXSDEop+fiPXp+dP
         8qEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2V4npggnB1JGWSzxeT4YSon3VdTvSjH/gf1XvKbK9l4=;
        b=D3gUp19nieelVXJQngeFUGvW/r4OX/pS3AxidCC7YMxaIJFocf9iyVBhIRvq2HmQSh
         V4ELDv9VvQk0DME3bsuf4mYlx7KsaJZdo6vyOadKZsdTX0OO1p4SPRFM0OYyc2Pb0gwB
         y19Ma1oXBavNhA7d2VgC2ziUkXO8qfNgh87OkqFkos+uOzTnqXxCB65iASf6iUPQvpuZ
         NjC++3IXnt5YKTpegm+u0EFHgzEKu7tiD3Dg+ko047iT+eD0Ccyt4gk1LSAyg7UgWLhE
         fb9LI/X3VrGhdMBToedKBgjNpV3xJlwxjsizBy2nRT/E6lSP+X4t2BXHieTszOkm57NG
         ZY4A==
X-Gm-Message-State: AOUpUlGlkhgn4ezZUQP3zDAEGpScFV5TD3NvEpvKe1YfnEBHlZO+vBbV
        oAsNeasMeiqdRif4Bnl9DFIsqxjN
X-Google-Smtp-Source: AAOMgpeonBR5uDsOZFGl9y8Mp5Nb7TuK5ZbSHSs1fzOEE0GL+uRcdKsuTPuHsDDLUsG435DMvAaM3Q==
X-Received: by 2002:a63:7a0a:: with SMTP id v10-v6mr11059746pgc.444.1532824960163;
        Sat, 28 Jul 2018 17:42:40 -0700 (PDT)
Received: from localhost.localdomain ([104.132.11.104])
        by smtp.gmail.com with ESMTPSA id a17-v6sm13034856pfg.106.2018.07.28.17.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 17:42:39 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v4 4/4] commit: fix exit code when doing a dry run
Date:   Sun, 22 Jul 2018 22:09:03 -0400
Message-Id: <20180723020903.22435-5-sxlijin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715110807.25544-1-sxlijin@gmail.com>
References: <20180715110807.25544-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In wt-status.c, the s->committable bit is set only in the call tree of
wt_longstatus_print(), and it is not always set correctly. This means
that in normal cases, if there are changes to be committed, or if there
is a merge in progress and all conflicts have been resolved, `--dry-run`
and `--long` return the correct exit code but `--short` and
`--porcelain` do not, even though all four flags imply dry run.
Moreover, if there is a merge in progress and some but not all conflicts
have been resolved, `--short` and `--porcelain` only return the correct
exit code by coincidence (because the codepaths they follow never touch
the committable bit), whereas `--dry-run` and `--long` return the wrong
exit code.

Teach wt_status_collect() to set s->committable correctly (if a merge is
in progress, committable should be set iff there are no unmerged
changes; otherwise, committable should be set iff there are changes in
the index) so that all four flags which imply dry runs return the
correct exit code in the above described situations and mark the
documenting tests as fixed.

Use the index_status field in the wt_status_change_data structs in
has_unmerged() to determine whether or not there are unmerged paths,
instead of the stagemask field, to improve readability.

Also stop setting s->committable in wt_longstatus_print_updated() and
show_merge_in_progress(), and const-ify wt_status_state in the method
signatures in those callpaths.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7501-commit.sh | 12 +++----
 wt-status.c       | 80 +++++++++++++++++++++++++++++------------------
 2 files changed, 55 insertions(+), 37 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index e49dfd0a2..6dba526e6 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -99,12 +99,12 @@ test_expect_success '--dry-run with stuff to commit returns ok' '
 	git commit -m next -a --dry-run
 '
 
-test_expect_failure '--short with stuff to commit returns ok' '
+test_expect_success '--short with stuff to commit returns ok' '
 	echo bongo bongo bongo >>file &&
 	git commit -m next -a --short
 '
 
-test_expect_failure '--porcelain with stuff to commit returns ok' '
+test_expect_success '--porcelain with stuff to commit returns ok' '
 	echo bongo bongo bongo >>file &&
 	git commit -m next -a --porcelain
 '
@@ -714,7 +714,7 @@ test_expect_success '--long with only unresolved merge conflicts' '
 	test_cmp expected actual
 '
 
-test_expect_failure '--dry-run with resolved and unresolved merge conflicts' '
+test_expect_success '--dry-run with resolved and unresolved merge conflicts' '
 	git reset --hard commit-2 &&
 	test_must_fail git merge --no-commit commit-1 &&
 	echo "resolve one merge conflict" >test-file1 &&
@@ -747,7 +747,7 @@ test_expect_success '--porcelain with resolved and unresolved merge conflicts' '
 	test_cmp expected actual
 '
 
-test_expect_failure '--long with resolved and unresolved merge conflicts' '
+test_expect_success '--long with resolved and unresolved merge conflicts' '
 	git reset --hard commit-2 &&
 	test_must_fail git merge --no-commit commit-1 &&
 	echo "resolve one merge conflict" >test-file1 &&
@@ -769,7 +769,7 @@ test_expect_success '--dry-run with only resolved merge conflicts' '
 	test_cmp expected actual
 '
 
-test_expect_failure '--short with only resolved merge conflicts' '
+test_expect_success '--short with only resolved merge conflicts' '
 	git reset --hard commit-2 &&
 	test_must_fail git merge --no-commit commit-1 &&
 	echo "resolve all merge conflicts" | tee test-file1 test-file2 &&
@@ -780,7 +780,7 @@ test_expect_failure '--short with only resolved merge conflicts' '
 	test_cmp expected actual
 '
 
-test_expect_failure '--porcelain with only resolved merge conflicts' '
+test_expect_success '--porcelain with only resolved merge conflicts' '
 	git reset --hard commit-2 &&
 	test_must_fail git merge --no-commit commit-1 &&
 	echo "resolve all merge conflicts" | tee test-file1 test-file2 &&
diff --git a/wt-status.c b/wt-status.c
index af83fae68..fc239f61c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -724,6 +724,38 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		s->untracked_in_ms = (getnanotime() - t_begin) / 1000000;
 }
 
+static int has_unmerged(const struct wt_status *s)
+{
+	int i;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d = (s->change.items[i]).util;
+		if (d->index_status == DIFF_STATUS_UNMERGED)
+			return 1;
+	}
+	return 0;
+}
+
+static void wt_status_mark_committable(
+		struct wt_status *s, const struct wt_status_state *state)
+{
+	int i;
+
+	if (state->merge_in_progress) {
+		s->committable = !has_unmerged(s);
+		return;
+	}
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d = (s->change.items[i]).util;
+
+		if (d->index_status) {
+			s->committable = 1;
+			return;
+		}
+	}
+}
+
 void wt_status_collect(struct wt_status *s, const struct wt_status_state *state)
 {
 	wt_status_collect_changes_worktree(s);
@@ -734,6 +766,8 @@ void wt_status_collect(struct wt_status *s, const struct wt_status_state *state)
 		wt_status_collect_changes_index(s);
 
 	wt_status_collect_untracked(s);
+
+	wt_status_mark_committable(s, state);
 }
 
 static void wt_longstatus_print_unmerged(const struct wt_status *s)
@@ -759,28 +793,27 @@ static void wt_longstatus_print_unmerged(const struct wt_status *s)
 
 }
 
-static void wt_longstatus_print_updated(struct wt_status *s)
+static void wt_longstatus_print_updated(const struct wt_status *s)
 {
-	int shown_header = 0;
 	int i;
 
+	if (!s->committable)
+		return;
+
+	wt_longstatus_print_cached_header(s);
+
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
 		struct string_list_item *it;
 		it = &(s->change.items[i]);
 		d = it->util;
-		if (!d->index_status ||
-		    d->index_status == DIFF_STATUS_UNMERGED)
-			continue;
-		if (!shown_header) {
-			wt_longstatus_print_cached_header(s);
-			s->committable = 1;
-			shown_header = 1;
+		if (d->index_status &&
+		    d->index_status != DIFF_STATUS_UNMERGED) {
+			wt_longstatus_print_change_data(s, WT_STATUS_UPDATED, it);
 		}
-		wt_longstatus_print_change_data(s, WT_STATUS_UPDATED, it);
 	}
-	if (shown_header)
-		wt_longstatus_print_trailer(s);
+
+	wt_longstatus_print_trailer(s);
 }
 
 /*
@@ -1064,21 +1097,7 @@ static void wt_longstatus_print_tracking(const struct wt_status *s)
 	strbuf_release(&sb);
 }
 
-static int has_unmerged(const struct wt_status *s)
-{
-	int i;
-
-	for (i = 0; i < s->change.nr; i++) {
-		struct wt_status_change_data *d;
-		d = s->change.items[i].util;
-		if (d->stagemask)
-			return 1;
-	}
-	return 0;
-}
-
-static void show_merge_in_progress(struct wt_status *s,
-				const struct wt_status_state *state,
+static void show_merge_in_progress(const struct wt_status *s,
 				const char *color)
 {
 	if (has_unmerged(s)) {
@@ -1090,7 +1109,6 @@ static void show_merge_in_progress(struct wt_status *s,
 					 _("  (use \"git merge --abort\" to abort the merge)"));
 		}
 	} else {
-		s-> committable = 1;
 		status_printf_ln(s, color,
 			_("All conflicts fixed but you are still merging."));
 		if (s->hints)
@@ -1584,12 +1602,12 @@ void wt_status_clear_state(struct wt_status_state *state)
 	free(state->detached_from);
 }
 
-static void wt_longstatus_print_state(struct wt_status *s,
+static void wt_longstatus_print_state(const struct wt_status *s,
 				      const struct wt_status_state *state)
 {
 	const char *state_color = color(WT_STATUS_HEADER, s);
 	if (state->merge_in_progress)
-		show_merge_in_progress(s, state, state_color);
+		show_merge_in_progress(s, state_color);
 	else if (state->am_in_progress)
 		show_am_in_progress(s, state, state_color);
 	else if (state->rebase_in_progress || state->rebase_interactive_in_progress)
@@ -1602,7 +1620,7 @@ static void wt_longstatus_print_state(struct wt_status *s,
 		show_bisect_in_progress(s, state, state_color);
 }
 
-static void wt_longstatus_print(struct wt_status *s, const struct wt_status_state *state)
+static void wt_longstatus_print(const struct wt_status *s, const struct wt_status_state *state)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
-- 
2.18.0


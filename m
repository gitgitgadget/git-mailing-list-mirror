Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E659E1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 16:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbfFTQiz (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 12:38:55 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:52062 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732175AbfFTQix (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 12:38:53 -0400
Received: by mail-pf1-f201.google.com with SMTP id 145so2342399pfv.18
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A3Z0cWOfQhQzlRlFoUMY3K2LatW/nPAWWeEJ0b23eQY=;
        b=iqvKlbuQeazwuHHa1lXQBSK+O2tLFdvh2wek0az7O8BbaXmlr7w2vew+mdjxmbJyNo
         33i9eqPbZRmfnZRGiyD6ywg2viKdWuxF/e90iIaExY1Mi9iO5tjRnONkuwwSQO5nK83z
         yReRDbuxseLzpymE77dtJCVngVab7umLBbed1lS1CGBIUQzgLuhoQWCOdT855AaYBU77
         P31jiT22HLSAPw/D4IPzjBKIAYpaRnNQid6rXZMfRZLmvxlpWFOgDcGvv3ycJz/Na+uW
         IQuxN4kmExm1zqticRFk6Rpm1BwOa+EukrwNiVwu2fHLwHMSs8AbmM4KpjFPzQpcQR82
         IT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A3Z0cWOfQhQzlRlFoUMY3K2LatW/nPAWWeEJ0b23eQY=;
        b=KJy8lEIk3J2yBgkMNF4KdlKVOOYSiJrXLZBv9SxcrKCEkecElgNwTRASWgXzSlxxQ0
         fzzv/NfHsEavrge+yTMadtGOMlJkcig3OYsMl4aG5hLduJPxlyrn3eY+fuRBHYPrAaR1
         TA9R46xV+W1pjfkdnHFIe1tjZl/ROTE/bGy+vGCQxqZHWQR0EaD1qNM5VqbNrlSsygAh
         gKlNXMuVF6lInJSAU3kJF2CSc6eSn2c0+AI3MDHiqa5PEbCjX2DiGvUF/dSksFdqESPo
         Ls7HT00D/Ks/Bf+Zkb3uxHHhchpSDdj4PDFfLe6HdrOtXt8W4HH/y3yQU00n95Y2gvcX
         gw0g==
X-Gm-Message-State: APjAAAUyYASYIHINEX5b6JsoDhXcugUAZTZAkvkt/w7HO25D6llm8GaC
        Z4x9M68BJZKAAYMo+3/AjqPNtAeoTqBJLVYuSi9wVBQC+v3nL3MfL50kE6SV1OTYdm97YhKjhMF
        FnJAn6comTJy0wXt2xAOhqFA/QNuqN7ZTdJuG0ly+0eBrfDZTMkFo
X-Google-Smtp-Source: APXvYqyEqA9WCRwvU5oTvrBCiCgo+k9A8Nt5bMuI+P1O/UqPZxjmWXu4Vzvb37CKoCu/9WPcjDrFNAfi
X-Received: by 2002:a63:f146:: with SMTP id o6mr13318950pgk.179.1561048731912;
 Thu, 20 Jun 2019 09:38:51 -0700 (PDT)
Date:   Thu, 20 Jun 2019 12:38:19 -0400
In-Reply-To: <20190620163820.231316-1-brho@google.com>
Message-Id: <20190620163820.231316-9-brho@google.com>
Mime-Version: 1.0
References: <20190620163820.231316-1-brho@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 8/9] blame: use the fingerprint heuristic to match ignored lines
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Michael Platings <michael@platin.gs>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit integrates the fuzzy fingerprint heuristic into
guess_line_blames().

We actually make two passes.  The first pass uses the fuzzy algorithm to
find a match within the current diff chunk.  If that fails, the second
pass searches the entire parent file for the best match.

For an example of scanning the entire parent for a match, consider:

	commit-a 30) #include <sys/header_a.h>
	commit-b 31) #include <header_b.h>
	commit-c 32) #include <header_c.h>

Then commit X alphabetizes them:

	commit-X 30) #include <header_b.h>
	commit-X 31) #include <header_c.h>
	commit-X 32) #include <sys/header_a.h>

If we just check the parent's chunk (i.e. the first pass), we'd get:

	commit-b 30) #include <header_b.h>
	commit-c 31) #include <header_c.h>
	commit-X 32) #include <sys/header_a.h>

That's because commit X actually consists of two chunks: one chunk is
removing sys/header_a.h, then some context, and the second chunk is
adding sys/header_a.h.

If we scan the entire parent file, we get:

	commit-b 30) #include <header_b.h>
	commit-c 31) #include <header_c.h>
	commit-a 32) #include <sys/header_a.h>

Signed-off-by: Barret Rhoden <brho@google.com>
---
 blame.c                       | 60 ++++++++++++++++++++++++++++++++---
 t/t8014-blame-ignore-fuzzy.sh |  3 --
 2 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/blame.c b/blame.c
index 103838546e07..f81ec9a8cf80 100644
--- a/blame.c
+++ b/blame.c
@@ -990,12 +990,19 @@ static void fill_origin_fingerprints(struct blame_origin *o, mmfile_t *file)
 		return;
 	o->num_lines = find_line_starts(&line_starts, o->file.ptr,
 					o->file.size);
-	/* TODO: Will fill in fingerprints in a future commit */
+	o->fingerprints = xcalloc(sizeof(struct fingerprint), o->num_lines);
+	get_line_fingerprints(o->fingerprints, o->file.ptr, line_starts,
+			      0, o->num_lines);
 	free(line_starts);
 }
 
 static void drop_origin_fingerprints(struct blame_origin *o)
 {
+	if (o->fingerprints) {
+		free_line_fingerprints(o->fingerprints, o->num_lines);
+		o->num_lines = 0;
+		FREE_AND_NULL(o->fingerprints);
+	}
 }
 
 /*
@@ -1573,9 +1580,34 @@ static int are_lines_adjacent(struct blame_line_tracker *first,
 	       first->s_lno + 1 == second->s_lno;
 }
 
+static int scan_parent_range(struct fingerprint *p_fps,
+			     struct fingerprint *t_fps, int t_idx,
+			     int from, int nr_lines)
+{
+	int sim, p_idx;
+	#define FINGERPRINT_FILE_THRESHOLD	10
+	int best_sim_val = FINGERPRINT_FILE_THRESHOLD;
+	int best_sim_idx = -1;
+
+	for (p_idx = from; p_idx < from + nr_lines; p_idx++) {
+		sim = fingerprint_similarity(&t_fps[t_idx], &p_fps[p_idx]);
+		if (sim < best_sim_val)
+			continue;
+		/* Break ties with the closest-to-target line number */
+		if (sim == best_sim_val && best_sim_idx != -1 &&
+		    abs(best_sim_idx - t_idx) < abs(p_idx - t_idx))
+			continue;
+		best_sim_val = sim;
+		best_sim_idx = p_idx;
+	}
+	return best_sim_idx;
+}
+
 /*
- * This cheap heuristic assigns lines in the chunk to their relative location in
- * the parent's chunk.  Any additional lines are left with the target.
+ * The first pass checks the blame entry (from the target) against the parent's
+ * diff chunk.  If that fails for a line, the second pass tries to match that
+ * line to any part of parent file.  That catches cases where a change was
+ * broken into two chunks by 'context.'
  */
 static void guess_line_blames(struct blame_origin *parent,
 			      struct blame_origin *target,
@@ -1584,11 +1616,22 @@ static void guess_line_blames(struct blame_origin *parent,
 {
 	int i, best_idx, target_idx;
 	int parent_slno = tlno + offset;
+	int *fuzzy_matches;
 
+	fuzzy_matches = fuzzy_find_matching_lines(parent, target,
+						  tlno, parent_slno, same,
+						  parent_len);
 	for (i = 0; i < same - tlno; i++) {
 		target_idx = tlno + i;
-		best_idx = target_idx + offset;
-		if (best_idx < parent_slno + parent_len) {
+		if (fuzzy_matches && fuzzy_matches[i] >= 0) {
+			best_idx = fuzzy_matches[i];
+		} else {
+			best_idx = scan_parent_range(parent->fingerprints,
+						     target->fingerprints,
+						     target_idx, 0,
+						     parent->num_lines);
+		}
+		if (best_idx >= 0) {
 			line_blames[i].is_parent = 1;
 			line_blames[i].s_lno = best_idx;
 		} else {
@@ -1596,6 +1639,7 @@ static void guess_line_blames(struct blame_origin *parent,
 			line_blames[i].s_lno = target_idx;
 		}
 	}
+	free(fuzzy_matches);
 }
 
 /*
@@ -2372,6 +2416,12 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 			if (!porigin)
 				continue;
 			pass_blame_to_parent(sb, origin, porigin, 1);
+			/*
+			 * Preemptively drop porigin so we can refresh the
+			 * fingerprints if we use the parent again, which can
+			 * occur if you ignore back-to-back commits.
+			 */
+			drop_origin_blob(porigin);
 			if (!origin->suspects)
 				goto finish;
 		}
diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
index 844396615271..6f1a94caef22 100755
--- a/t/t8014-blame-ignore-fuzzy.sh
+++ b/t/t8014-blame-ignore-fuzzy.sh
@@ -3,9 +3,6 @@
 test_description='git blame ignore fuzzy heuristic'
 . ./test-lib.sh
 
-# short circuit until blame has the fuzzy capabilities
-test_done
-
 pick_author='s/^[0-9a-f^]* *(\([^ ]*\) .*/\1/'
 
 # Each test is composed of 4 variables:
-- 
2.22.0.410.gd8fdbe21b5-goog


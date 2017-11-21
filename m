Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBC362036D
	for <e@80x24.org>; Tue, 21 Nov 2017 22:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbdKUWR2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 17:17:28 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:43357 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdKUWR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 17:17:27 -0500
Received: by mail-io0-f193.google.com with SMTP id s37so10210275ioe.10
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 14:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aEFFqQ79FaiDPRk43qrJXDFy5+O5nxPxh2uWYNE0IAw=;
        b=h8vW4NaeQkOk3smg7jlmohBIPu5buga2CRmRIsp2D5pof+IW/vz/BdqWpTmQCG/Khv
         OvG5OkAgdkZXYbe0wXb5nMz1GCzqqqiDeTZA3pbAYAbIgI+BVXuqKsQJ/+d2po6sGOXZ
         9Dkkbw7MmrStiWkA7Nn1u4FP7s4yKOALCucQ/poCfRTAfgA+r6aY3fEn0X0FD0Bhh5VU
         PGP2jRlFZ0dHpflLlLm0jupTSAjZX9Z/5ffknQcGBjkpG+i1eDGl0rSsXEMWJHXAomE/
         yrJX1hlVP2ueT0cv93loCoFWH85y95ZcoDQqRzEPjlTyghvpmUi+Vema1T8JFTmiJ1uF
         uf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aEFFqQ79FaiDPRk43qrJXDFy5+O5nxPxh2uWYNE0IAw=;
        b=n43JyLT738d7bZT62/o60O8ZwN+xiiDVtyPOkiQoEDevH0Yq4wTHq4MGz25XIyay6w
         CBpQMKGZDXkTSgYW6a+Y6kwtJctQpo5WM+Ze7dTA/G/alEecvZvCvPkIfnpWyyfGrfab
         J4QuKVy72Tq7eFx3H1SByLI/0lZzrB2h0tJuqg0a7zH2HD0IdFMRwnnlWv0wITjpIZaw
         ybklY+9kKGtdAvBfcJPW5UFCbM6y5lC7IbFXQE0np04P5lxR7+CwkyvJBzi3sZXQKw3T
         RYy+kSW4tNgUujKZVU5nZfmOkXns1tPPRRrWRSGsp+F/PDfl1TiOPX1YMcicue4pMifi
         IOsw==
X-Gm-Message-State: AJaThX5v0n4r3NNgXVuvFsp2a9Ev4kIyXpoGYrS/sfuHd8rN93TVH1c9
        n+Vzt5JchNq74+SE9gG5Rjbb9lARLP0=
X-Google-Smtp-Source: AGs4zMZwYJv+wLC0xFzU6AfE3Z+n6wMWJz5wlHI7c7S1GHnBTJyA+txVlh+DGPxIhbXZ7gqWO8Bxbw==
X-Received: by 10.107.6.142 with SMTP id f14mr21590205ioi.152.1511302646795;
        Tue, 21 Nov 2017 14:17:26 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id r4sm1146543itg.11.2017.11.21.14.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Nov 2017 14:17:26 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH] xdiff/xpatience: support anchoring a line
Date:   Tue, 21 Nov 2017 14:17:17 -0800
Message-Id: <20171121221717.155301-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.0.317.g14c63a9dc.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach the patience diff to support prohibiting a user-specified line
from appearing as a deletion or addition in the end result.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I'm sending this out to see if a change similar to this would be
welcome. It is useful to me as a reviewer (to check my own code, e.g.
when checking [1]). Probably more design needs to go into this,
including the best way to specify the "anchor" line, and the correct
behavior when the anchor is either not found or appears more than once.

Any thoughts?

[1]
https://public-inbox.org/git/20171121221256.154741-1-jonathantanmy@google.com/
---
 t/t4033-diff-patience.sh | 13 +++++++++++++
 xdiff/xpatience.c        | 29 +++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/t/t4033-diff-patience.sh b/t/t4033-diff-patience.sh
index 113304dc5..2147fd688 100755
--- a/t/t4033-diff-patience.sh
+++ b/t/t4033-diff-patience.sh
@@ -13,6 +13,19 @@ test_expect_success '--ignore-space-at-eol with a single appended character' '
 	grep "^+.*X" diff
 '
 
+test_expect_success 'anchor' '
+	printf "a\nb\nc\n" >pre &&
+	printf "c\na\nb\n" >post &&
+
+	# without anchor, c is moved
+	test_expect_code 1 git diff --no-index --patience pre post >diff &&
+	grep "^+c" diff &&
+
+	# with anchor, a is moved
+	DIFF_ANCHOR=c test_expect_code 1 git diff --no-index --patience pre post >diff &&
+	grep "^+a" diff
+'
+
 test_diff_frobnitz "patience"
 
 test_diff_unique "patience"
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index a44e77632..195a60e57 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -62,6 +62,8 @@ struct hashmap {
 		 * initially, "next" reflects only the order in file1.
 		 */
 		struct entry *next, *previous;
+
+		unsigned anchor : 1;
 	} *entries, *first, *last;
 	/* were common records found? */
 	unsigned long has_matches;
@@ -70,6 +72,14 @@ struct hashmap {
 	xpparam_t const *xpp;
 };
 
+static int is_anchor(const char *line)
+{
+	char *anchor = getenv("DIFF_ANCHOR");
+	if (!anchor)
+		return 0;
+	return !strncmp(line, anchor, strlen(anchor));
+}
+
 /* The argument "pass" is 1 for the first file, 2 for the second. */
 static void insert_record(int line, struct hashmap *map, int pass)
 {
@@ -110,6 +120,7 @@ static void insert_record(int line, struct hashmap *map, int pass)
 		return;
 	map->entries[index].line1 = line;
 	map->entries[index].hash = record->ha;
+	map->entries[index].anchor = is_anchor(map->env->xdf1.recs[line - 1]->ptr);
 	if (!map->first)
 		map->first = map->entries + index;
 	if (map->last) {
@@ -192,14 +203,28 @@ static struct entry *find_longest_common_sequence(struct hashmap *map)
 	int longest = 0, i;
 	struct entry *entry;
 
+	/*
+	 * If not -1, this entry in sequence must never be overridden. (Also,
+	 * do not override entries in sequence before this entry, since it is
+	 * useless.)
+	 */
+	int anchor_i = -1;
+
 	for (entry = map->first; entry; entry = entry->next) {
 		if (!entry->line2 || entry->line2 == NON_UNIQUE)
 			continue;
 		i = binary_search(sequence, longest, entry);
 		entry->previous = i < 0 ? NULL : sequence[i];
-		sequence[++i] = entry;
-		if (i == longest)
+		++i;
+		if (i <= anchor_i)
+			continue;
+		sequence[i] = entry;
+		if (anchor_i == -1 && entry->anchor) {
+			anchor_i = i;
+			longest = anchor_i + 1;
+		} else if (i == longest) {
 			longest++;
+		}
 	}
 
 	/* No common unique lines were found */
-- 
2.15.0.448.gf294e3d99a-goog


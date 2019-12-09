Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F263C2D0C4
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE4A207FD
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZPHPje5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfLILxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:53:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36603 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbfLILxU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 06:53:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so15885998wru.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 03:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KKap58d6zGDQ810DMkxdFRpP455mOwAiVfiW/L45Ahs=;
        b=fZPHPje5FchM2gf4Qhnuuu73MW3AWU1wFBUF7C40DwDsd7jeAM7i0Y+qLObPlm6aK3
         iecXBJF/pIGKu0DBW30OEFcBIpdc/KZJRDiWjyXbO9OpvgSVRnuXL4B0Rihgg6/J3lXZ
         quv67R2PRlMUKQ64FJA5ZBVyb0dHA6S7cjSa9/2cA/32aodzZm1mMXF9KVb+PCB1QTzw
         mYsqqBdSymUhrniEaGLj2bWWbuDLYvxN+ikgUtku8auTPIlfrGkvxfMooijCyhQB/pk6
         gpoVaG6AePe09ldHReY9dj6FxypdM7U3sgC0ifw+xBgnbGYrzrc6cd8ijMaF0G5VAH9K
         iV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KKap58d6zGDQ810DMkxdFRpP455mOwAiVfiW/L45Ahs=;
        b=uGMAvj0w+FqamIY8yZaWfEGRWtY54R0AjVn73WnWa3tJjow9bSMH84Z82iKUleaeoY
         vMKvTId1WazoiHnDVYIYll9ClqA7v/lEfEhoe/EGgjdd455nBDfT/PR23AfHkhOpjDFc
         k1zBn5frDklmwg4DsP+FTi4yvxLxOYDVlEW6SsQVmYwVS6OY+bQBYdw15iIfbL10G13P
         KsxYF4J10gspF/jObjHKMD7HGLYb04ykZ383TcJoLef5grUrA77XVy+RKnD8+GFD8BTF
         f3ceT6FAxnxkbdAm6JMTOQDKNCB/1s7+MS7pkNTa7LVDxZGy+p6AltySQsa0xPmsGw9a
         hblg==
X-Gm-Message-State: APjAAAUhsNb26bXABwWeuEzocaeu8GXh1dZl0TNRl0WgdskQJP7tzhH1
        oJSnRzYuwRZXWzgHLfzbPOU=
X-Google-Smtp-Source: APXvYqzHPU2BpFUJOTiqrOAreyWLD6mI+EprJPUtdtIQBFYve66D9V7A9Hw/NaiouCFSqJhRaR+Snw==
X-Received: by 2002:adf:f58a:: with SMTP id f10mr1767879wro.105.1575892397890;
        Mon, 09 Dec 2019 03:53:17 -0800 (PST)
Received: from localhost.localdomain (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id k8sm27239621wrl.3.2019.12.09.03.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 03:53:17 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 13/14] name-rev: eliminate recursion in name_rev()
Date:   Mon,  9 Dec 2019 12:52:57 +0100
Message-Id: <20191209115258.9281-14-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.801.g241c134b8d
In-Reply-To: <20191209115258.9281-1-szeder.dev@gmail.com>
References: <20191112103821.30265-1-szeder.dev@gmail.com>
 <20191209115258.9281-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The name_rev() function calls itself recursively for each interesting
parent of the commit it got as parameter, and, consequently, it can
segfault when processing a deep history if it exhausts the available
stack space.  E.g. running 'git name-rev --all' and 'git name-rev
HEAD~100000' in the gcc, gecko-dev, llvm, and WebKit repositories
results in segfaults on my machine ('ulimit -s' reports 8192kB of
stack size limit), and nowadays the former segfaults in the Linux repo
as well (it reached the necessasry depth sometime between v5.3-rc4 and
-rc5).

Eliminate the recursion by inserting the interesting parents into a
LIFO 'prio_queue' [1] and iterating until the queue becomes empty.

Note that the parent commits must be added in reverse order to the
LIFO 'prio_queue', so their relative order is preserved during
processing, i.e. the first parent should come out first from the
queue, because otherwise performance greatly suffers on mergy
histories [2].

The stacksize-limited test 'name-rev works in a deep repo' in
't6120-describe.sh' demonstrated this issue and expected failure.  Now
the recursion is gone, so flip it to expect success.  Also gone are
the dmesg entries logging the segfault of that segfaulting 'git
name-rev' process on every execution of the test suite.

Note that this slightly changes the order of lines in the output of
'git name-rev --all', usually swapping two lines every 35 lines in
git.git or every 150 lines in linux.git.  This shouldn't matter in
practice, because the output has always been unordered anyway.

This patch is best viewed with '--ignore-all-space'.

[1] Early versions of this patch used a 'commit_list', resulting in
    ~15% performance penalty for 'git name-rev --all' in 'linux.git',
    presumably because of the memory allocation and release for each
    insertion and removal. Using a LIFO 'prio_queue' has basically no
    effect on performance.

[2] We prefer shorter names, i.e. 'v0.1~234' is preferred over
    'v0.1^2~5', meaning that usually following the first parent of a
    merge results in the best name for its ancestors.  So when later
    we follow the remaining parent(s) of a merge, and reach an already
    named commit, then we usually find that we can't give that commit
    a better name, and thus we don't have to visit any of its
    ancestors again.

    OTOH, if we were to follow the Nth parent of the merge first, then
    the name of all its ancestors would include a corresponding '^N'.
    Those are not the best names for those commits, so when later we
    reach an already named commit following the first parent of that
    merge, then we would have to update the name of that commit and
    the names of all of its ancestors as well.  Consequently, we would
    have to visit many commits several times, resulting in a
    significant slowdown.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c  | 102 +++++++++++++++++++++++++++-----------------
 t/t6120-describe.sh |   2 +-
 2 files changed, 65 insertions(+), 39 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6c1e6e9868..a3b796eac4 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -6,6 +6,7 @@
 #include "tag.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "prio-queue.h"
 #include "sha1-lookup.h"
 #include "commit-slab.h"
 
@@ -104,52 +105,77 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 		return NULL;
 }
 
-static void name_rev(struct commit *commit,
+static void name_rev(struct commit *start_commit,
 		const char *tip_name, timestamp_t taggerdate,
 		int from_tag)
 {
-	struct rev_name *name = get_commit_rev_name(commit);
-	struct commit_list *parents;
-	int parent_number = 1;
-
-	for (parents = commit->parents;
-			parents;
-			parents = parents->next, parent_number++) {
-		struct commit *parent = parents->item;
-		const char *new_name;
-		int generation, distance;
-
-		parse_commit(parent);
-		if (parent->date < cutoff)
-			continue;
+	struct prio_queue queue;
+	struct commit *commit;
+	struct commit **parents_to_queue = NULL;
+	size_t parents_to_queue_nr, parents_to_queue_alloc = 0;
+
+	memset(&queue, 0, sizeof(queue)); /* Use the prio_queue as LIFO */
+	prio_queue_put(&queue, start_commit);
+
+	while ((commit = prio_queue_get(&queue))) {
+		struct rev_name *name = get_commit_rev_name(commit);
+		struct commit_list *parents;
+		int parent_number = 1;
+
+		parents_to_queue_nr = 0;
+
+		for (parents = commit->parents;
+				parents;
+				parents = parents->next, parent_number++) {
+			struct commit *parent = parents->item;
+			const char *new_name;
+			int generation, distance;
+
+			parse_commit(parent);
+			if (parent->date < cutoff)
+				continue;
 
-		if (parent_number > 1) {
-			size_t len;
+			if (parent_number > 1) {
+				size_t len;
+
+				strip_suffix(name->tip_name, "^0", &len);
+				if (name->generation > 0)
+					new_name = xstrfmt("%.*s~%d^%d",
+							   (int)len,
+							   name->tip_name,
+							   name->generation,
+							   parent_number);
+				else
+					new_name = xstrfmt("%.*s^%d", (int)len,
+							   name->tip_name,
+							   parent_number);
+				generation = 0;
+				distance = name->distance + MERGE_TRAVERSAL_WEIGHT;
+			} else {
+				new_name = name->tip_name;
+				generation = name->generation + 1;
+				distance = name->distance + 1;
+			}
 
-			strip_suffix(name->tip_name, "^0", &len);
-			if (name->generation > 0)
-				new_name = xstrfmt("%.*s~%d^%d",
-						   (int)len,
-						   name->tip_name,
-						   name->generation,
-						   parent_number);
-			else
-				new_name = xstrfmt("%.*s^%d", (int)len,
-						   name->tip_name,
-						   parent_number);
-			generation = 0;
-			distance = name->distance + MERGE_TRAVERSAL_WEIGHT;
-		} else {
-			new_name = name->tip_name;
-			generation = name->generation + 1;
-			distance = name->distance + 1;
+			if (create_or_update_name(parent, new_name, taggerdate,
+						  generation, distance,
+						  from_tag)) {
+				ALLOC_GROW(parents_to_queue,
+					   parents_to_queue_nr + 1,
+					   parents_to_queue_alloc);
+				parents_to_queue[parents_to_queue_nr] = parent;
+				parents_to_queue_nr++;
+			}
 		}
 
-		if (create_or_update_name(parent, new_name, taggerdate,
-					  generation, distance,
-					  from_tag))
-			name_rev(parent, new_name, taggerdate, from_tag);
+		/* The first parent must come out first from the prio_queue */
+		while (parents_to_queue_nr)
+			prio_queue_put(&queue,
+				       parents_to_queue[--parents_to_queue_nr]);
 	}
+
+	clear_prio_queue(&queue);
+	free(parents_to_queue);
 }
 
 static int subpath_matches(const char *path, const char *filter)
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 0d119e9652..09c50f3f04 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -381,7 +381,7 @@ test_expect_success 'describe tag object' '
 	test_i18ngrep "fatal: test-blob-1 is neither a commit nor blob" actual
 '
 
-test_expect_failure ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
+test_expect_success ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
 	i=1 &&
 	while test $i -lt 8000
 	do
-- 
2.24.0.801.g241c134b8d


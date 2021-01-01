Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82F8C433E9
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CA6207A5
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbhAACgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbhAACgO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:36:14 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D64BC0617A0
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:59 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id g185so8374659wmf.3
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3VWdFNzHStrIFPMTrcpUhepqI3KmHCI8z1cXv60VA8M=;
        b=X8lIEF9ato6VvSmjUquXv56t6tCfoz9hGBbzVdRZRaXksBL9SoFTyZEvv8iVgg3s9d
         q54AP+9nz92QVRvWqc8gwFQ57YA4eG3Dx3arKg7PSfIiO+XZy9mA1jyAol/k3K/D+fvV
         ZMG9UNEdPaJw/WqsAUoGQ/qVvz/gj7mJ1/Ipz+l1aZ/nafwPuv2BjPoKaYO3uYT+1iqL
         7aB3tUfzlym3xooAoxegBqWxjJXxUNddi6aR8GuJHSqNhwcmWk6B3zRjnoflkcsHZDj4
         JAZPucEE4Xtf9tAQNdAU+99MiYEmEfOJZq2SyHQcWZ9Cya+o3HTPDCXx/7UaolNhlxfS
         RJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3VWdFNzHStrIFPMTrcpUhepqI3KmHCI8z1cXv60VA8M=;
        b=db8hktBIFnLpg5ASSLfxX0IFyE4TvvN8wRgXPRz0CF6QFEE1MF0lfOBm9j2jwU9jz9
         uQltF0m5YC4MYaR3SQnmT5uamTbHnJDX3n0STeEnJHN2BN07F/CKGOngj3KCmOkx6mmT
         ObxZFsPtZo7DuV4e7UsRmR/OxApw8FDUB/DcaobSNH9TYDxV4b147JG//vikOIslh0bl
         TYqKJZnCrD8oq/kdcIhe0bedFLRxsScnG6RuZZJYoNSo9isR/mZFmXmnHk0nc2TvhRuZ
         mz5KnsHG0+8Ieh8XTiFLfo3EtMc9H+hyKN0v5pcme/FYm4dMQ/5tndA8xYJbKcj6jLIj
         2H2g==
X-Gm-Message-State: AOAM5312lsEch4IyQemfcmXQpQM9JXIeHb0R89AqBFlNcNlhN9mlSniY
        X4aieBSrvYjhsv3/itX3tscE1uehXW4=
X-Google-Smtp-Source: ABdhPJww7+XtnAVnk0NOpeRstsaJQNvUyZz5QXAnAcW8iy4JvwYZd+dA9vjE7VpyNi7y6nPl7/qc8Q==
X-Received: by 2002:a1c:5447:: with SMTP id p7mr13945036wmi.116.1609468497654;
        Thu, 31 Dec 2020 18:34:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8sm71096095wrm.17.2020.12.31.18.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:34:56 -0800 (PST)
Message-Id: <334cc7c65a60fa45b2c0e418d6b22d4dd53d3e71.1609468488.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
        <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 02:34:47 +0000
Subject: [PATCH v2 09/10] merge-ort: copy find_first_merges() implementation
 from merge-recursive.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Code is identical for the function body in the two files, the call
signature is just slightly different in merge-ort than merge-recursive
as noted a couple commits ago.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index bf704bcd34d..203fa987e43 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -25,6 +25,7 @@
 #include "dir.h"
 #include "ll-merge.h"
 #include "object-store.h"
+#include "revision.h"
 #include "strmap.h"
 #include "submodule.h"
 #include "tree.h"
@@ -658,7 +659,61 @@ static int find_first_merges(struct repository *repo,
 			     struct commit *b,
 			     struct object_array *result)
 {
-	die("Not yet implemented.");
+	int i, j;
+	struct object_array merges = OBJECT_ARRAY_INIT;
+	struct commit *commit;
+	int contains_another;
+
+	char merged_revision[GIT_MAX_HEXSZ + 2];
+	const char *rev_args[] = { "rev-list", "--merges", "--ancestry-path",
+				   "--all", merged_revision, NULL };
+	struct rev_info revs;
+	struct setup_revision_opt rev_opts;
+
+	memset(result, 0, sizeof(struct object_array));
+	memset(&rev_opts, 0, sizeof(rev_opts));
+
+	/* get all revisions that merge commit a */
+	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
+		  oid_to_hex(&a->object.oid));
+	repo_init_revisions(repo, &revs, NULL);
+	rev_opts.submodule = path;
+	/* FIXME: can't handle linked worktrees in submodules yet */
+	revs.single_worktree = path != NULL;
+	setup_revisions(ARRAY_SIZE(rev_args)-1, rev_args, &revs, &rev_opts);
+
+	/* save all revisions from the above list that contain b */
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+	while ((commit = get_revision(&revs)) != NULL) {
+		struct object *o = &(commit->object);
+		if (in_merge_bases(b, commit))
+			add_object_array(o, NULL, &merges);
+	}
+	reset_revision_walk();
+
+	/* Now we've got all merges that contain a and b. Prune all
+	 * merges that contain another found merge and save them in
+	 * result.
+	 */
+	for (i = 0; i < merges.nr; i++) {
+		struct commit *m1 = (struct commit *) merges.objects[i].item;
+
+		contains_another = 0;
+		for (j = 0; j < merges.nr; j++) {
+			struct commit *m2 = (struct commit *) merges.objects[j].item;
+			if (i != j && in_merge_bases(m2, m1)) {
+				contains_another = 1;
+				break;
+			}
+		}
+
+		if (!contains_another)
+			add_object_array(merges.objects[i].item, NULL, result);
+	}
+
+	object_array_clear(&merges);
+	return result->nr;
 }
 
 static int merge_submodule(struct merge_options *opt,
-- 
gitgitgadget


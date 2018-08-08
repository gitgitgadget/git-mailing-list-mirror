Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1DFC208F4
	for <e@80x24.org>; Wed,  8 Aug 2018 15:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeHHRnn (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:43:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33138 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeHHRnn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:43:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id x5-v6so1471149edr.0
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NaoNH5IIdosrnJrm75EWt3H65GtA8fIUoX2d7WdvyDo=;
        b=LU3txsW+3IKkb/yZ02mf4ZmxZDMwmYMHiruVyqneJNF+siMT1rgMYbr/dJfQQbFyPz
         ucbD9z/3lyEtzX5vmddkyJFyhzae0sppeKq8xociMsoHf1FqsmtsS1OqxSLJMxyC2n3S
         V099HW9B79EBsBcnd7ZIvwoDpmjwO5lQBZEK6OcPTl6Ck3tFVDpCCnVcq0IuaE4VYLZD
         eZjyBXXFS0ZGYxt7rQ1T+b48r1yiDjNTifRA0OPBjyUnNNnR0QS8Flc5QFFJJpK6dKu2
         NpKc9DXkhN8j3S+7DJY+/4GDt8EYSavPuZIKIfulDq+4xVMOxFReV41cSyTPrU1Q0Lg6
         vcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NaoNH5IIdosrnJrm75EWt3H65GtA8fIUoX2d7WdvyDo=;
        b=ax3HZE14sYzgXI3z7mInEoLG6t2Jf98Xe5KGeoiLzcRGe3xmH6eJ4PWMem0RkOue9y
         euEd85TEPgR8I6wIgffBusPFmZJp2uhyS59lODurhyXjjgsXQf3IOVf69h2JbAg3fsaC
         AHoONswM5NvKqLEcBTPPJTFo7tq8pN3gt5uNObdR2/FycPxi7Bcwl8/JcKi+drgUU4Ls
         ce4IeAm5SvzoEEjCskbz+kfwX4BN2nV10ai05tuDJwcXnDasLZQjYEWu0ml+odUMBwTn
         HX9Eby8bEmWbVv7sQNX/4HYC1wkb/7AT02kArlQyEgiF/gTKm5n72+Y93oJ08ZE5gzJI
         YzYg==
X-Gm-Message-State: AOUpUlHqGi6kTynwpyAogDGRM6k1d2qCPkDTo1RLgdNjB6M0GxRSTyVl
        GLUlZTlJyvDK6kqCVtUcne6EMV9O
X-Google-Smtp-Source: AA+uWPxwMmejpRFHY/Zt9Ja1mlCWBvwZx/itOycUfduty/L4wt/P3HQG2a0699zZTgRmupT6a0b8hA==
X-Received: by 2002:a50:af45:: with SMTP id g63-v6mr4045243edd.30.1533741812975;
        Wed, 08 Aug 2018 08:23:32 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:23:32 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 15/18] merge-base --fork-point: extract libified function
Date:   Wed,  8 Aug 2018 21:06:37 +0545
Message-Id: <20180808152140.14585-16-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need this functionality in the builtin rebase.

Note: to make this function truly reusable, we have to switch the call
get_merges_many_dirty() to get_merges_many() because we want the commit
flags to be reset (otherwise, subsequent get_merge_bases() calls would
obtain incorrect results). This did not matter when the function was
called in `git rev-parse --fork-point` because in that command, the
process definitely did not traverse any commits before exiting.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/merge-base.c | 81 ++++----------------------------------------
 commit.c             | 81 ++++++++++++++++++++++++++++++++++++++++++++
 commit.h             |  2 ++
 3 files changed, 89 insertions(+), 75 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 08d91b1f0c..790ceaeed6 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -110,54 +110,12 @@ static int handle_is_ancestor(int argc, const char **argv)
 		return 1;
 }
 
-struct rev_collect {
-	struct commit **commit;
-	int nr;
-	int alloc;
-	unsigned int initial : 1;
-};
-
-static void add_one_commit(struct object_id *oid, struct rev_collect *revs)
-{
-	struct commit *commit;
-
-	if (is_null_oid(oid))
-		return;
-
-	commit = lookup_commit(the_repository, oid);
-	if (!commit ||
-	    (commit->object.flags & TMP_MARK) ||
-	    parse_commit(commit))
-		return;
-
-	ALLOC_GROW(revs->commit, revs->nr + 1, revs->alloc);
-	revs->commit[revs->nr++] = commit;
-	commit->object.flags |= TMP_MARK;
-}
-
-static int collect_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
-				  const char *ident, timestamp_t timestamp,
-				  int tz, const char *message, void *cbdata)
-{
-	struct rev_collect *revs = cbdata;
-
-	if (revs->initial) {
-		revs->initial = 0;
-		add_one_commit(ooid, revs);
-	}
-	add_one_commit(noid, revs);
-	return 0;
-}
-
 static int handle_fork_point(int argc, const char **argv)
 {
 	struct object_id oid;
 	char *refname;
+	struct commit *derived, *fork_point;
 	const char *commitname;
-	struct rev_collect revs;
-	struct commit *derived;
-	struct commit_list *bases;
-	int i, ret = 0;
 
 	switch (dwim_ref(argv[0], strlen(argv[0]), &oid, &refname)) {
 	case 0:
@@ -173,41 +131,14 @@ static int handle_fork_point(int argc, const char **argv)
 		die("Not a valid object name: '%s'", commitname);
 
 	derived = lookup_commit_reference(the_repository, &oid);
-	memset(&revs, 0, sizeof(revs));
-	revs.initial = 1;
-	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
 
-	if (!revs.nr && !get_oid(refname, &oid))
-		add_one_commit(&oid, &revs);
+	fork_point = get_fork_point(refname, derived);
 
-	for (i = 0; i < revs.nr; i++)
-		revs.commit[i]->object.flags &= ~TMP_MARK;
-
-	bases = get_merge_bases_many_dirty(derived, revs.nr, revs.commit);
-
-	/*
-	 * There should be one and only one merge base, when we found
-	 * a common ancestor among reflog entries.
-	 */
-	if (!bases || bases->next) {
-		ret = 1;
-		goto cleanup_return;
-	}
-
-	/* And the found one must be one of the reflog entries */
-	for (i = 0; i < revs.nr; i++)
-		if (&bases->item->object == &revs.commit[i]->object)
-			break; /* found */
-	if (revs.nr <= i) {
-		ret = 1; /* not found */
-		goto cleanup_return;
-	}
-
-	printf("%s\n", oid_to_hex(&bases->item->object.oid));
+	if (!fork_point)
+		return 1;
 
-cleanup_return:
-	free_commit_list(bases);
-	return ret;
+	printf("%s\n", oid_to_hex(&fork_point->object.oid));
+	return 0;
 }
 
 int cmd_merge_base(int argc, const char **argv, const char *prefix)
diff --git a/commit.c b/commit.c
index 30d1af2b20..a3fc77a4eb 100644
--- a/commit.c
+++ b/commit.c
@@ -17,6 +17,7 @@
 #include "sha1-lookup.h"
 #include "wt-status.h"
 #include "advice.h"
+#include "refs.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -958,6 +959,86 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 	return result;
 }
 
+struct rev_collect {
+	struct commit **commit;
+	int nr;
+	int alloc;
+	unsigned int initial : 1;
+};
+
+static void add_one_commit(struct object_id *oid, struct rev_collect *revs)
+{
+	struct commit *commit;
+
+	if (is_null_oid(oid))
+		return;
+
+	commit = lookup_commit(the_repository, oid);
+	if (!commit ||
+	    (commit->object.flags & TMP_MARK) ||
+	    parse_commit(commit))
+		return;
+
+	ALLOC_GROW(revs->commit, revs->nr + 1, revs->alloc);
+	revs->commit[revs->nr++] = commit;
+	commit->object.flags |= TMP_MARK;
+}
+
+static int collect_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
+				  const char *ident, timestamp_t timestamp,
+				  int tz, const char *message, void *cbdata)
+{
+	struct rev_collect *revs = cbdata;
+
+	if (revs->initial) {
+		revs->initial = 0;
+		add_one_commit(ooid, revs);
+	}
+	add_one_commit(noid, revs);
+	return 0;
+}
+
+struct commit *get_fork_point(const char *refname, struct commit *commit)
+{
+	struct object_id oid;
+	struct rev_collect revs;
+	struct commit_list *bases;
+	int i;
+	struct commit *ret = NULL;
+
+	memset(&revs, 0, sizeof(revs));
+	revs.initial = 1;
+	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
+
+	if (!revs.nr && !get_oid(refname, &oid))
+		add_one_commit(&oid, &revs);
+
+	for (i = 0; i < revs.nr; i++)
+		revs.commit[i]->object.flags &= ~TMP_MARK;
+
+	bases = get_merge_bases_many(commit, revs.nr, revs.commit);
+
+	/*
+	 * There should be one and only one merge base, when we found
+	 * a common ancestor among reflog entries.
+	 */
+	if (!bases || bases->next)
+		goto cleanup_return;
+
+	/* And the found one must be one of the reflog entries */
+	for (i = 0; i < revs.nr; i++)
+		if (&bases->item->object == &revs.commit[i]->object)
+			break; /* found */
+	if (revs.nr <= i)
+		goto cleanup_return;
+
+	ret = bases->item;
+
+cleanup_return:
+	free_commit_list(bases);
+	return ret;
+}
+
 struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 {
 	struct commit_list *i, *j, *k, *ret = NULL;
diff --git a/commit.h b/commit.h
index da0db36eba..b34240017f 100644
--- a/commit.h
+++ b/commit.h
@@ -211,6 +211,8 @@ extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 /* To be used only when object flags after this call no longer matter */
 extern struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n, struct commit **twos);
 
+struct commit *get_fork_point(const char *refname, struct commit *commit);
+
 /* largest positive number a signed 32-bit integer can contain */
 #define INFINITE_DEPTH 0x7fffffff
 
-- 
2.18.0


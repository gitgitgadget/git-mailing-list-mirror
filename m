Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F11C21F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 18:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932160AbcJTSGi (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 14:06:38 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32921 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbcJTSGh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 14:06:37 -0400
Received: by mail-pf0-f175.google.com with SMTP id 128so41408516pfz.0
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=964aKQa7xRS7V61uqa1Mb3Z5iNOEFgHgQlDONKi5V7I=;
        b=ivBaJBacGzNAs5C2QEZStQt/aIzV+65louLHIEsP0pHTGPTUfO/2YyvsYsqVWyKlBu
         gf1LoIisqVSkEBjEHLa5LIHt2LGRcvv5r5jQ3diatWm54Z5AQ7GdG+M0QP8mYG00eLk5
         oIFAIMccWxJ6+qxLU7YaMtE4AqQLRQ0K3fFqUDsiSAaP9AX7f+Cgyz8UY4t1ZmMFMXo5
         0XPCpwi15hspYH1r6KRJC8Mf8cAeAmRVDNxdup+qHv6ZwAQPdhDKMZSg3dl+9bHosFTf
         dgq37a6OSUgx73SOQa9GJp6++CDQ1YNXTTnzoKb1E7xlo5QB1xDyTRpngS7QrRKIcYFA
         W4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=964aKQa7xRS7V61uqa1Mb3Z5iNOEFgHgQlDONKi5V7I=;
        b=G1yIySLlMznfvqDA1rytWePlLCigkIQJ4louH4U4jXn5lhpPLa2o5BpLw4fFNbSbbH
         bb2v37/N+HTNaraeGlsfpqOPKd1vHDpji8o1ZxeaJ3tGpS0Fwxie1FqlnIx60f6i6yh3
         ofJuWXKy5dULt2sFjg2j7lxuHXv0O06EF4Bhn4CQyTfqcmmmDO+rQ6h1npoGzlutH125
         Bet/IHT1cG4sWx/BR5TOvT2cogvd8HCbiRCP8OoY+NuYJe6uwC3uy4wfiUIdmCHohR5E
         2F06bEw9H86fNobGKFIf/fnUQZ8zjR1IE34ZJyux/h1N7yXDmyn/OkWekuRJefyOGA/d
         yK+A==
X-Gm-Message-State: AA6/9Rl8BDEWViuwedGkXPxL8sF1kNB+CDoXTvoyEFElIHj+lAbm+qY9/gO5ohgaKDkNtXKM
X-Received: by 10.99.53.6 with SMTP id c6mr2802172pga.179.1476986796057;
        Thu, 20 Oct 2016 11:06:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:acdc:e923:4e42:5c6a])
        by smtp.gmail.com with ESMTPSA id zh13sm73559405pab.4.2016.10.20.11.06.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Oct 2016 11:06:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] commit parsing: replace unchecked parse_commit by parse_commit_or_die
Date:   Thu, 20 Oct 2016 11:06:29 -0700
Message-Id: <20161020180629.11955-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.448.g862ec83.dirty
In-Reply-To: <xmqqoa2ehp5u.fsf@gitster.mtv.corp.google.com>
References: <xmqqoa2ehp5u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The reason parse_commit() would fail at these points would be because
the repository is corrupt.

This was noticed by coverity.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 developed on pu as that's where coverity spotted it.
 I have no overview if these areas are being worked on. (It may clash
 with at least jc/merge-base-fp-only)
 
 Thanks,
 Stefan

 builtin/blame.c       | 2 +-
 builtin/describe.c    | 4 ++--
 builtin/name-rev.c    | 2 +-
 builtin/show-branch.c | 4 ++--
 commit.c              | 2 +-
 fetch-pack.c          | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 992a79c..3b8564c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1801,7 +1801,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
 		 * so hold onto it in the meantime.
 		 */
 		origin_incref(suspect);
-		parse_commit(commit);
+		parse_commit_or_die(commit);
 		if (reverse ||
 		    (!(commit->object.flags & UNINTERESTING) &&
 		     !(revs->max_age != -1 && commit->date < revs->max_age)))
diff --git a/builtin/describe.c b/builtin/describe.c
index 01490a1..8299b16 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -199,7 +199,7 @@ static unsigned long finish_depth_computation(
 			best->depth++;
 		while (parents) {
 			struct commit *p = parents->item;
-			parse_commit(p);
+			parse_commit_or_die(p);
 			if (!(p->object.flags & SEEN))
 				commit_list_insert_by_date(p, list);
 			p->object.flags |= c->object.flags;
@@ -322,7 +322,7 @@ static void describe(const char *arg, int last_one)
 		}
 		while (parents) {
 			struct commit *p = parents->item;
-			parse_commit(p);
+			parse_commit_or_die(p);
 			if (!(p->object.flags & SEEN))
 				commit_list_insert_by_date(p, &list);
 			p->object.flags |= c->object.flags;
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index cd89d48..92c3316 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -29,7 +29,7 @@ static void name_rev(struct commit *commit,
 	struct commit_list *parents;
 	int parent_number = 1;
 
-	parse_commit(commit);
+	parse_commit_or_die(commit);
 
 	if (commit->date < cutoff)
 		return;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 974f340..fd911b5 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -218,7 +218,7 @@ static void join_revs(struct commit_list **list_p,
 			parents = parents->next;
 			if ((this_flag & flags) == flags)
 				continue;
-			parse_commit(p);
+			parse_commit_or_die(p);
 			if (mark_seen(p, seen_p) && !still_interesting)
 				extra--;
 			p->object.flags |= flags;
@@ -835,7 +835,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		if (!commit)
 			die(_("cannot find commit %s (%s)"),
 			    ref_name[num_rev], oid_to_hex(&revkey));
-		parse_commit(commit);
+		parse_commit_or_die(commit);
 		mark_seen(commit, &seen);
 
 		/* rev#0 uses bit REV_SHIFT, rev#1 uses bit REV_SHIFT+1,
diff --git a/commit.c b/commit.c
index b9c0c81..5b23eaf 100644
--- a/commit.c
+++ b/commit.c
@@ -910,7 +910,7 @@ static void mark_redundant(struct commit **array, int cnt)
 	ALLOC_ARRAY(filled_index, cnt - 1);
 
 	for (i = 0; i < cnt; i++)
-		parse_commit(array[i]);
+		parse_commit_or_die(array[i]);
 	for (i = 0; i < cnt; i++) {
 		struct commit_list *common;
 
diff --git a/fetch-pack.c b/fetch-pack.c
index cb45c34..8b4ab47 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -159,7 +159,7 @@ static const unsigned char *get_rev(void)
 			return NULL;
 
 		commit = prio_queue_get(&rev_list);
-		parse_commit(commit);
+		parse_commit_or_die(commit);
 		parents = commit->parents;
 
 		commit->object.flags |= POPPED;
-- 
2.10.1.448.g862ec83.dirty


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B9320D1E
	for <e@80x24.org>; Thu, 15 Jun 2017 23:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbdFOXQV (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 19:16:21 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33466 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbdFOXQV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 19:16:21 -0400
Received: by mail-wm0-f42.google.com with SMTP id m7so193598wmg.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 16:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=efgQg5O67HSs0HBCZEFF5G6GLSgXotQZR4CRvwNfZ/c=;
        b=K408P7IsXP3XLAnhQZQWN1aC8fwwtqxjD0qvpbFogcLr7r9dHlSne5AAMC0RPG9Nk7
         kWnyaQdjmCbxLnFgr9uW7j+ppprcWX1zuIsT1T2jluHBWZvZIEduIqhhvIX1jEeMJ34b
         pA19kJBzNMkWSOpRdYES0bnSjtBYt2PxrRboV68olWTtuZxNoyvWcpF4urhSTkNZDSxV
         8gv7REzHmfy9MWFJlMj0pzS9TJiND+DeDDuRaU0D8pmNpvw1odM1ouD3Xe0JD5G92Ym6
         Te4NtdZW9S6OmiDg25Ijktd09ekT3cWIRpfc9y3GK729LV5u/9hibiS0MlubcTOuV6kt
         TpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=efgQg5O67HSs0HBCZEFF5G6GLSgXotQZR4CRvwNfZ/c=;
        b=JgcYnf9DjUK7TiOc4sEFpXMcyFT5Me1baQL566GrpoYnZ3eg6oteUEGUWKt4IM9BKv
         tzzaHDPH1etWjQcB0tWBvNU8qh+kRc1W3t24sTR2OlWCLAlRDJVksQO1gCqbybvhkHoy
         9EI1AL6nmm2M2wN7DdJDacu6N6T00nIkU7YQbt1qKdwMtnTHf1K5P2j9F9rkoaCUx0wT
         5Od2nckZJtUroAR47QBolhdPjaBp/5S9kKBwlwNVTYMx73WOLPgHC1n5Jt34sjPqob7p
         kShJ3XVrjFsboV7fGI3oZAQ1vxCW1UWcAyKsGUdvl+kTfUahjR9OXbUAynCE/og7N3iD
         uc3w==
X-Gm-Message-State: AKS2vOyOy3Os2GTgHE+alTvvWa056BAMQIZSqNqVPwoM1UdvU0GgCQ9j
        FupPVlP1LalN4H87ppI=
X-Received: by 10.80.175.34 with SMTP id g31mr5118030edd.24.1497568574072;
        Thu, 15 Jun 2017 16:16:14 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o15sm305130edo.68.2017.06.15.16.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 16:16:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/6] *.[ch] refactoring: make use of the FREE_AND_NULL() macro
Date:   Thu, 15 Jun 2017 23:15:49 +0000
Message-Id: <20170615231549.20085-7-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc
In-Reply-To: <20170615231549.20085-1-avarab@gmail.com>
References: <20170615231549.20085-1-avarab@gmail.com>
In-Reply-To: <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
References: <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace occurrences of `free(ptr); ptr = NULL` which weren't caught by
the coccinelle rule. These fall into two categories:

 - free/NULL assignments one after the other which coccinelle all put
   on one line, which is functionally equivalent code, but very ugly.

 - manually spotted occurrences where the NULL assignment isn't right
   after the free() call.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c       | 15 ++++-----------
 builtin/worktree.c |  6 ++----
 commit-slab.h      |  3 +--
 credential.c       |  6 ++----
 gpg-interface.c    | 15 +++++----------
 grep.c             |  9 +++------
 help.c             |  3 +--
 line-log.c         |  3 +--
 prio-queue.c       |  3 +--
 refs/ref-cache.c   |  3 +--
 rerere.c           |  3 +--
 split-index.c      |  3 +--
 12 files changed, 23 insertions(+), 49 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 138fb98537..80368b6fe6 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1072,17 +1072,10 @@ static void am_next(struct am_state *state)
 {
 	struct object_id head;
 
-	free(state->author_name);
-	state->author_name = NULL;
-
-	free(state->author_email);
-	state->author_email = NULL;
-
-	free(state->author_date);
-	state->author_date = NULL;
-
-	free(state->msg);
-	state->msg = NULL;
+	FREE_AND_NULL(state->author_name);
+	FREE_AND_NULL(state->author_email);
+	FREE_AND_NULL(state->author_date);
+	FREE_AND_NULL(state->msg);
 	state->msg_len = 0;
 
 	unlink(am_path(state, "author-script"));
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 793306ea51..41d1c007a4 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -299,10 +299,8 @@ static int add_worktree(const char *path, const char *refname,
 	}
 
 	is_junk = 0;
-	free(junk_work_tree);
-	free(junk_git_dir);
-	junk_work_tree = NULL;
-	junk_git_dir = NULL;
+	FREE_AND_NULL(junk_work_tree);
+	FREE_AND_NULL(junk_git_dir);
 
 done:
 	if (ret || !opts->keep_locked) {
diff --git a/commit-slab.h b/commit-slab.h
index 42d16dcded..333d81e370 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -82,8 +82,7 @@ static MAYBE_UNUSED void clear_ ##slabname(struct slabname *s)		\
 	for (i = 0; i < s->slab_count; i++)				\
 		free(s->slab[i]);					\
 	s->slab_count = 0;						\
-	free(s->slab);							\
-	s->slab = NULL;							\
+	FREE_AND_NULL(s->slab);						\
 }									\
 									\
 static MAYBE_UNUSED elemtype *slabname## _at_peek(struct slabname *s,	\
diff --git a/credential.c b/credential.c
index 0ab247ff40..924ab58538 100644
--- a/credential.c
+++ b/credential.c
@@ -313,10 +313,8 @@ void credential_reject(struct credential *c)
 	for (i = 0; i < c->helpers.nr; i++)
 		credential_do(c, c->helpers.items[i].string, "erase");
 
-	free(c->username);
-	c->username = NULL;
-	free(c->password);
-	c->password = NULL;
+	FREE_AND_NULL(c->username);
+	FREE_AND_NULL(c->password);
 	c->approved = 0;
 }
 
diff --git a/gpg-interface.c b/gpg-interface.c
index e44cc27da1..3f377f89d0 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -13,16 +13,11 @@ static const char *gpg_program = "gpg";
 
 void signature_check_clear(struct signature_check *sigc)
 {
-	free(sigc->payload);
-	free(sigc->gpg_output);
-	free(sigc->gpg_status);
-	free(sigc->signer);
-	free(sigc->key);
-	sigc->payload = NULL;
-	sigc->gpg_output = NULL;
-	sigc->gpg_status = NULL;
-	sigc->signer = NULL;
-	sigc->key = NULL;
+	FREE_AND_NULL(sigc->payload);
+	FREE_AND_NULL(sigc->gpg_output);
+	FREE_AND_NULL(sigc->gpg_status);
+	FREE_AND_NULL(sigc->signer);
+	FREE_AND_NULL(sigc->key);
 }
 
 static struct {
diff --git a/grep.c b/grep.c
index 11513ec06d..909f35a984 100644
--- a/grep.c
+++ b/grep.c
@@ -1763,12 +1763,9 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 
 void grep_source_clear(struct grep_source *gs)
 {
-	free(gs->name);
-	gs->name = NULL;
-	free(gs->path);
-	gs->path = NULL;
-	free(gs->identifier);
-	gs->identifier = NULL;
+	FREE_AND_NULL(gs->name);
+	FREE_AND_NULL(gs->path);
+	FREE_AND_NULL(gs->identifier);
 	grep_source_clear_data(gs);
 }
 
diff --git a/help.c b/help.c
index db7f3d79a0..a2f48c0df3 100644
--- a/help.c
+++ b/help.c
@@ -267,9 +267,8 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 
 	for (i = 0; i < old->cnt; i++)
 		cmds->names[cmds->cnt++] = old->names[i];
-	free(old->names);
+	FREE_AND_NULL(old->names);
 	old->cnt = 0;
-	old->names = NULL;
 }
 
 /* An empirically derived magic number */
diff --git a/line-log.c b/line-log.c
index 79eded7363..2d60c347ca 100644
--- a/line-log.c
+++ b/line-log.c
@@ -34,9 +34,8 @@ void range_set_init(struct range_set *rs, size_t prealloc)
 
 void range_set_release(struct range_set *rs)
 {
-	free(rs->ranges);
+	FREE_AND_NULL(rs->ranges);
 	rs->alloc = rs->nr = 0;
-	rs->ranges = NULL;
 }
 
 /* dst must be uninitialized! */
diff --git a/prio-queue.c b/prio-queue.c
index fc3860fdcb..126d096727 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -27,10 +27,9 @@ void prio_queue_reverse(struct prio_queue *queue)
 
 void clear_prio_queue(struct prio_queue *queue)
 {
-	free(queue->array);
+	FREE_AND_NULL(queue->array);
 	queue->nr = 0;
 	queue->alloc = 0;
-	queue->array = NULL;
 	queue->insertion_ctr = 0;
 }
 
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index af2fcb2c12..76bb723c86 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -82,9 +82,8 @@ static void clear_ref_dir(struct ref_dir *dir)
 	int i;
 	for (i = 0; i < dir->nr; i++)
 		free_ref_entry(dir->entries[i]);
-	free(dir->entries);
+	FREE_AND_NULL(dir->entries);
 	dir->sorted = dir->nr = dir->alloc = 0;
-	dir->entries = NULL;
 }
 
 struct ref_entry *create_dir_entry(struct ref_cache *cache,
diff --git a/rerere.c b/rerere.c
index c26c29f87a..61f3804a1e 100644
--- a/rerere.c
+++ b/rerere.c
@@ -39,9 +39,8 @@ static void free_rerere_dirs(void)
 		free(rerere_dir[i]->status);
 		free(rerere_dir[i]);
 	}
-	free(rerere_dir);
+	FREE_AND_NULL(rerere_dir);
 	rerere_dir_nr = rerere_dir_alloc = 0;
-	rerere_dir = NULL;
 }
 
 static void free_rerere_id(struct string_list_item *item)
diff --git a/split-index.c b/split-index.c
index 49bd197f71..20477c6a48 100644
--- a/split-index.c
+++ b/split-index.c
@@ -174,10 +174,9 @@ void merge_base_index(struct index_state *istate)
 
 	ewah_free(si->delete_bitmap);
 	ewah_free(si->replace_bitmap);
-	free(si->saved_cache);
+	FREE_AND_NULL(si->saved_cache);
 	si->delete_bitmap  = NULL;
 	si->replace_bitmap = NULL;
-	si->saved_cache	   = NULL;
 	si->saved_cache_nr = 0;
 }
 
-- 
2.13.1.508.gb3defc5cc


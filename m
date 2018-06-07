Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02331F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932896AbeFGOEd (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:33 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38714 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeFGOEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:04:05 -0400
Received: by mail-qt0-f194.google.com with SMTP id x34-v6so9930880qtk.5
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TJ3zKHdH6H64XX9V+Z0OhPT5zrcWIXvU1NsXcBXglXA=;
        b=Pw+h+XWTJiPkoXu+MTN7TXayxfLPsfco1EYuhZ3msP6USnHGdpOhQt2dZLtr4d0X98
         7IUrS794FGeK0lzSq3WfSd/3cx9NNgLx2z3yRR6uLLcAwLrFgaye6zEFeKpuVfWr0ftq
         Da0i+KF+RetUwwdrDntgOfR/6BapJvXrIfLkZapijthslNUJIfKlmj1EJ/Qr3VWk1RK5
         1xUm96oPYH3YAmA9ydAdG++ijgo2lFC4cgR577PGe5OdRRXRuM5QmGfI2gU/N6yzeL9U
         MU4Oebq2gQvUPX+FDiRAnJ4xDNZZVJmkyX4grNLXJkj95VscUp5xNpxGgt4+ILMIPoY3
         1E1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TJ3zKHdH6H64XX9V+Z0OhPT5zrcWIXvU1NsXcBXglXA=;
        b=s5bSEVsiwHhq3EthQI5NhZFMfjWfdt2AyXwBromTGvBB/LphpzG2i5imkqzEh23bKY
         QxXS/dVk0DME8xlKc90/AP4Gdz6+2l3bAnTrLfsumP+ct+Ywm1XIicoKx7A0ca2998BR
         KYW/+tqAja68rUdTpXkWPL8FP5cbg6zgLACyFEOrXkTPeeMTCDK81XfRxBzHU2EM6EQt
         geTuBOyr75JTahELTSyFY3KKjqdU5VBrpxnbNUGT1JWmlkvyKgCRW1+QuilnO6bLwRjL
         MOYDNrAlwkWWsG/qwRcO8sSYH7uqqRwCVgskK4v5qPKPD1AisyqkeognCUOyox5qzEvc
         yZNg==
X-Gm-Message-State: APt69E2ND3E/nlPeZjJ2zeH4r9yZprXAHicr11THBcc3ARKYkWVrKZmo
        RQwJnsvp0J8JTYlOmAq4szjFCl/H
X-Google-Smtp-Source: ADUXVKIKIKTqIClKRvdrw9V+df6PPAbn+I6nOBusw1ScUtEgrnQQaT0bjYrHsqEJRKjP6WIMhGHKgA==
X-Received: by 2002:ac8:2888:: with SMTP id i8-v6mr1829562qti.275.1528380244713;
        Thu, 07 Jun 2018 07:04:04 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:04:04 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 18/23] midx: use midx in abbreviation calculations
Date:   Thu,  7 Jun 2018 10:03:33 -0400
Message-Id: <20180607140338.32440-19-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c          | 11 ++++++++
 midx.h          |  3 +++
 packfile.c      |  6 +++++
 packfile.h      |  1 +
 sha1-name.c     | 70 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/t5319-midx.sh |  3 ++-
 6 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 6eca8f1b12..25d8142c2a 100644
--- a/midx.c
+++ b/midx.c
@@ -203,6 +203,17 @@ int bsearch_midx(const struct object_id *oid, struct midxed_git *m, uint32_t *re
 			    MIDX_HASH_LEN, result);
 }
 
+struct object_id *nth_midxed_object_oid(struct object_id *oid,
+					struct midxed_git *m,
+					uint32_t n)
+{
+	if (n >= m->num_objects)
+		return NULL;
+
+	hashcpy(oid->hash, m->chunk_oid_lookup + m->hash_len * n);
+	return oid;
+}
+
 static off_t nth_midxed_offset(struct midxed_git *m, uint32_t pos)
 {
 	const unsigned char *offset_data;
diff --git a/midx.h b/midx.h
index 0c66812229..497bdcc77c 100644
--- a/midx.h
+++ b/midx.h
@@ -9,6 +9,9 @@
 
 struct midxed_git *load_midxed_git(const char *object_dir);
 int bsearch_midx(const struct object_id *oid, struct midxed_git *m, uint32_t *result);
+struct object_id *nth_midxed_object_oid(struct object_id *oid,
+					struct midxed_git *m,
+					uint32_t n);
 int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct midxed_git *m);
 int prepare_midxed_git_one(struct repository *r, const char *object_dir);
 
diff --git a/packfile.c b/packfile.c
index 73f8cc28ee..638e113972 100644
--- a/packfile.c
+++ b/packfile.c
@@ -919,6 +919,12 @@ struct packed_git *get_packed_git(struct repository *r)
 	return r->objects->packed_git;
 }
 
+struct midxed_git *get_midxed_git(struct repository *r)
+{
+	prepare_packed_git(r);
+	return r->objects->midxed_git;
+}
+
 struct list_head *get_packed_git_mru(struct repository *r)
 {
 	prepare_packed_git(r);
diff --git a/packfile.h b/packfile.h
index e0a38aba93..01e14b93fd 100644
--- a/packfile.h
+++ b/packfile.h
@@ -39,6 +39,7 @@ extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
+struct midxed_git *get_midxed_git(struct repository *r);
 
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
diff --git a/sha1-name.c b/sha1-name.c
index 60d9ef3c7e..d975a186c9 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "repository.h"
+#include "midx.h"
 
 static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
 
@@ -149,6 +150,32 @@ static int match_sha(unsigned len, const unsigned char *a, const unsigned char *
 	return 1;
 }
 
+static void unique_in_midx(struct midxed_git *m,
+			   struct disambiguate_state *ds)
+{
+	uint32_t num, i, first = 0;
+	const struct object_id *current = NULL;
+	num = m->num_objects;
+
+	if (!num)
+		return;
+
+	bsearch_midx(&ds->bin_pfx, m, &first);
+
+	/*
+	 * At this point, "first" is the location of the lowest object
+	 * with an object name that could match "bin_pfx".  See if we have
+	 * 0, 1 or more objects that actually match(es).
+	 */
+	for (i = first; i < num && !ds->ambiguous; i++) {
+		struct object_id oid;
+		current = nth_midxed_object_oid(&oid, m, i);
+		if (!match_sha(ds->len, ds->bin_pfx.hash, current->hash))
+			break;
+		update_candidates(ds, current);
+	}
+}
+
 static void unique_in_pack(struct packed_git *p,
 			   struct disambiguate_state *ds)
 {
@@ -177,8 +204,12 @@ static void unique_in_pack(struct packed_git *p,
 
 static void find_short_packed_object(struct disambiguate_state *ds)
 {
+	struct midxed_git *m;
 	struct packed_git *p;
 
+	for (m = get_midxed_git(the_repository); m && !ds->ambiguous;
+	     m = m->next)
+		unique_in_midx(m, ds);
 	for (p = get_packed_git(the_repository); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
@@ -527,6 +558,42 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 	return 0;
 }
 
+static void find_abbrev_len_for_midx(struct midxed_git *m,
+				     struct min_abbrev_data *mad)
+{
+	int match = 0;
+	uint32_t num, first = 0;
+	struct object_id oid;
+	const struct object_id *mad_oid;
+
+	if (!m->num_objects)
+		return;
+
+	num = m->num_objects;
+	mad_oid = mad->oid;
+	match = bsearch_midx(mad_oid, m, &first);
+
+	/*
+	 * first is now the position in the packfile where we would insert
+	 * mad->hash if it does not exist (or the position of mad->hash if
+	 * it does exist). Hence, we consider a maximum of two objects
+	 * nearby for the abbreviation length.
+	 */
+	mad->init_len = 0;
+	if (!match) {
+		if (nth_midxed_object_oid(&oid, m, first))
+			extend_abbrev_len(&oid, mad);
+	} else if (first < num - 1) {
+		if (nth_midxed_object_oid(&oid, m, first + 1))
+			extend_abbrev_len(&oid, mad);
+	}
+	if (first > 0) {
+		if (nth_midxed_object_oid(&oid, m, first - 1))
+			extend_abbrev_len(&oid, mad);
+	}
+	mad->init_len = mad->cur_len;
+}
+
 static void find_abbrev_len_for_pack(struct packed_git *p,
 				     struct min_abbrev_data *mad)
 {
@@ -565,8 +632,11 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 
 static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 {
+	struct midxed_git *m;
 	struct packed_git *p;
 
+	for (m = get_midxed_git(the_repository); m; m = m->next)
+		find_abbrev_len_for_midx(m, mad);
 	for (p = get_packed_git(the_repository); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
diff --git a/t/t5319-midx.sh b/t/t5319-midx.sh
index 1a50987778..e3873da7d6 100755
--- a/t/t5319-midx.sh
+++ b/t/t5319-midx.sh
@@ -94,7 +94,8 @@ compare_results_with_midx() {
 	MSG=$1
 	test_expect_success "check normal git operations: $MSG" '
 		midx_git_two_modes "rev-list --objects --all" &&
-		midx_git_two_modes "log --raw"
+		midx_git_two_modes "log --raw" &&
+		midx_git_two_modes "log --oneline"
 	'
 }
 
-- 
2.18.0.rc1


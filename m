Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052BDC49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 11:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6ACC60FF0
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 11:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhFQLY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 07:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhFQLYE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 07:24:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D969DC06175F
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 04:21:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id nd37so9289814ejc.3
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 04:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xEx3RpZGqNrwrSLJU5DUM8Kbmf3BAvF6Ko6IpNNbIew=;
        b=h+Y//hFZfzMRsdVns0X9Gm5fqhZ0P08lkqpkLeB+E/JnPy9wDQhvZJ4+W94LTvUqQD
         RLkhE3rIHU79xrWVOyScRXuVnlWkgpoYib/KQ8uQqzt/v98b+rgM3eKup9G/H2H1jdWm
         e4PMVPlRVi9rH8iqHYcI+NeA6OFPZt522as4PvtUZsUG6jc5H3UTxTXbj436OdaexO8V
         n14dd7DD55/M+GQ+9sPctII8fasFMb9PQyJCe3qblW7+RTj1KZtafDO/hRTwKXKvEwXK
         j8JZSdlD3gr8LNCxfA9zUihOfJF2xP5HkN1yjmwFyueNnZ72F9rmdKrgwE8DiDSB/e2r
         1Tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xEx3RpZGqNrwrSLJU5DUM8Kbmf3BAvF6Ko6IpNNbIew=;
        b=CIV0/30H3NMiIYtC0lfQosRE1LzFR59WUZSshGl++WrMT4YoJwuQSCwUmn0/s+F3R6
         4nNWlgp5LIUrL36K4TrVMzYUh4PSMqwpaXDbuugf3hgekR3QBdajtCX/iqV9MykWzPTM
         3lSi1QNNjN+GTEDte02cUGNYRFTa/Zy66Vat4iPXBuYbPvVHgDX/PzUi3BVUF/tFuCC2
         Z5G6NUkVkG6Dvl4WoBcB3ES5pbopaWqOsV4kmc3Yq9FkJwZMLAPcRvZD6iYHvXhmiTiZ
         ELabEuckQCOiFSME71/DTlzhwJ9SnHr65zPn2hgqaxz2Q4m+KYen5h0FYtTvTJXuN5kj
         Qbmw==
X-Gm-Message-State: AOAM531sJ7onQ/BZD/bfffp+WS5k5coafybaZvFPmDT/6o4XGaqamcdi
        F87Hn64JrZ7jBA0fAvx4HWJ75irNcoNJpw==
X-Google-Smtp-Source: ABdhPJwXCDO+SzHbULyGlqbIgHeuUCL6zYTDUAyoUYlfnCAxugrXvGJCj+0JoSk0sPq7vxmrMzv4XA==
X-Received: by 2002:a17:906:3057:: with SMTP id d23mr4635820ejd.131.1623928913215;
        Thu, 17 Jun 2021 04:21:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id cw10sm3583153ejb.62.2021.06.17.04.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:21:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] bundle.c: use a temporary variable for OIDs and names
Date:   Thu, 17 Jun 2021 13:21:48 +0200
Message-Id: <patch-2.3-f297fd0432-20210617T111934Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for moving away from accessing the OID and name via the
"oid" and "name" slots in a subsequent commit, change the code that
accesses it to use named variables. This makes the subsequent change
smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bundle.c    | 22 +++++++++++++++-------
 transport.c |  3 ++-
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/bundle.c b/bundle.c
index 693d619551..621708f40e 100644
--- a/bundle.c
+++ b/bundle.c
@@ -156,6 +156,9 @@ static int list_refs(struct ref_list *r, int argc, const char **argv)
 	int i;
 
 	for (i = 0; i < r->nr; i++) {
+		struct object_id *oid;
+		const char *name;
+
 		if (argc > 1) {
 			int j;
 			for (j = 1; j < argc; j++)
@@ -164,8 +167,10 @@ static int list_refs(struct ref_list *r, int argc, const char **argv)
 			if (j == argc)
 				continue;
 		}
-		printf("%s %s\n", oid_to_hex(&r->list[i].oid),
-				r->list[i].name);
+
+		oid = &r->list[i].oid;
+		name = r->list[i].name;
+		printf("%s %s\n", oid_to_hex(oid), name);
 	}
 	return 0;
 }
@@ -194,7 +199,8 @@ int verify_bundle(struct repository *r,
 	repo_init_revisions(r, &revs, NULL);
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
-		struct object *o = parse_object(r, &e->oid);
+		struct object_id *oid = &e->oid;
+		struct object *o = parse_object(r, oid);
 		if (o) {
 			o->flags |= PREREQ_MARK;
 			add_pending_object(&revs, o, e->name);
@@ -202,7 +208,7 @@ int verify_bundle(struct repository *r,
 		}
 		if (++ret == 1)
 			error("%s", message);
-		error("%s %s", oid_to_hex(&e->oid), e->name);
+		error("%s %s", oid_to_hex(oid), e->name);
 	}
 	if (revs.pending.nr != p->nr)
 		return ret;
@@ -219,19 +225,21 @@ int verify_bundle(struct repository *r,
 
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
-		struct object *o = parse_object(r, &e->oid);
+		struct object_id *oid = &e->oid;
+		struct object *o = parse_object(r, oid);
 		assert(o); /* otherwise we'd have returned early */
 		if (o->flags & SHOWN)
 			continue;
 		if (++ret == 1)
 			error("%s", message);
-		error("%s %s", oid_to_hex(&e->oid), e->name);
+		error("%s %s", oid_to_hex(oid), e->name);
 	}
 
 	/* Clean up objects used, as they will be reused. */
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
-		commit = lookup_commit_reference_gently(r, &e->oid, 1);
+		struct object_id *oid = &e->oid;
+		commit = lookup_commit_reference_gently(r, oid, 1);
 		if (commit)
 			clear_commit_marks(commit, ALL_REV_FLAGS);
 	}
diff --git a/transport.c b/transport.c
index 50f5830eb6..9d601c8c95 100644
--- a/transport.c
+++ b/transport.c
@@ -149,7 +149,8 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 	for (i = 0; i < data->header.references.nr; i++) {
 		struct ref_list_entry *e = data->header.references.list + i;
 		struct ref *ref = alloc_ref(e->name);
-		oidcpy(&ref->old_oid, &e->oid);
+		struct object_id *oid = &e->oid;
+		oidcpy(&ref->old_oid, oid);
 		ref->next = result;
 		result = ref;
 	}
-- 
2.32.0.571.gdba276db2c


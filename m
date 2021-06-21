Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510F1C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1936113E
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFUPSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUPSk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 11:18:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C847C06175F
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:16:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso106157wmc.1
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=erBQEf1m0g/Pfz+KFTPskL4rBmypbpy0a/wOyTbMnjs=;
        b=LFnVwKpZwAHS6VTLlKh+6EVNs+G3p/G6pJngRukCuCnDaGGB4pYsvy100dmJ3dBtcq
         ns/OodJVKn1QIHUwfe85UF5qLlKku0Sz25tjXeINB6hMnGnWoJzZ8+UyCPtD0oZDEsmN
         dbhI1sAeK5juKhFROC3GQJwWwt/OTtQeZynzCX3JzypPHUCTj5RNItTdV/VrwSz+9Wx6
         L+KWjqetNze6ytSS7QdXfY1zUlKSLhDlMufVfcfkRPysS4SenSw9eb1mOi+UHYRxx5tT
         eUtUkv3QFObVukyH3/jBXwViRu73x+b5fxDZYzA7/nurrXO/3QyGwbANxdOgPp4XQEGt
         DM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=erBQEf1m0g/Pfz+KFTPskL4rBmypbpy0a/wOyTbMnjs=;
        b=E/bnl6cZFQvZD/9lP5L8Mwn8j4y8SGnKi1GC5WqVOLDyFGANteifAar71QrwMCYjWT
         TG+zTxFql3h3ODpMQRGsUY8S+vf6RcOYWdFbu/Pd2QEIt6tkaDA1+ZvnloSr+mDccHTZ
         +piCtb8zDBbD+3vAM1Yp52yanLMfeGnxlD/lzoFM+XPkr1v8g59rtQmHhgbE+wM42nvX
         5tg05e9SRbO5TH1MqY0fJ9eoT+Ka5c8BVkifc9WLSPlPsZ42Fz++MsruiG419AniUEi0
         ruBLKSUcdfeoNz82O6sm3wBu7OJdF29br1VVVWJRNbVlfqxZKUGUJDlEzx/gIKUZGB8X
         fdOg==
X-Gm-Message-State: AOAM5328aSnsWw+DgepYyOF8tuvtUv+Km3djkt0qcE0IC4ITh0dfPEuG
        u4cJ8u53VmVo+o4cPrItJWCkQlj0q3VqWQ==
X-Google-Smtp-Source: ABdhPJxzPDQreBf+634sToCxZvBC9lbrE5PtE5bEzPFL1W/UsRMy/Jprnob58yec2/dkWYEInunRNQ==
X-Received: by 2002:a7b:c117:: with SMTP id w23mr3533623wmi.102.1624288581602;
        Mon, 21 Jun 2021 08:16:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u15sm15716019wmq.1.2021.06.21.08.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:16:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] bundle.c: use a temporary variable for OIDs and names
Date:   Mon, 21 Jun 2021 17:16:13 +0200
Message-Id: <patch-2.3-7e0d57951e5-20210621T151357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com> <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
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
 bundle.c    | 26 ++++++++++++++++++--------
 transport.c |  6 ++++--
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/bundle.c b/bundle.c
index 693d6195514..7210e5e7105 100644
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
@@ -194,15 +199,17 @@ int verify_bundle(struct repository *r,
 	repo_init_revisions(r, &revs, NULL);
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
-		struct object *o = parse_object(r, &e->oid);
+		const char *name = e->name;
+		struct object_id *oid = &e->oid;
+		struct object *o = parse_object(r, oid);
 		if (o) {
 			o->flags |= PREREQ_MARK;
-			add_pending_object(&revs, o, e->name);
+			add_pending_object(&revs, o, name);
 			continue;
 		}
 		if (++ret == 1)
 			error("%s", message);
-		error("%s %s", oid_to_hex(&e->oid), e->name);
+		error("%s %s", oid_to_hex(oid), name);
 	}
 	if (revs.pending.nr != p->nr)
 		return ret;
@@ -219,19 +226,22 @@ int verify_bundle(struct repository *r,
 
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
-		struct object *o = parse_object(r, &e->oid);
+		const char *name = e->name;
+		struct object_id *oid = &e->oid;
+		struct object *o = parse_object(r, oid);
 		assert(o); /* otherwise we'd have returned early */
 		if (o->flags & SHOWN)
 			continue;
 		if (++ret == 1)
 			error("%s", message);
-		error("%s %s", oid_to_hex(&e->oid), e->name);
+		error("%s %s", oid_to_hex(oid), name);
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
index 50f5830eb6b..95c1138e9ae 100644
--- a/transport.c
+++ b/transport.c
@@ -148,8 +148,10 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 
 	for (i = 0; i < data->header.references.nr; i++) {
 		struct ref_list_entry *e = data->header.references.list + i;
-		struct ref *ref = alloc_ref(e->name);
-		oidcpy(&ref->old_oid, &e->oid);
+		const char *name = e->name;
+		struct ref *ref = alloc_ref(name);
+		struct object_id *oid = &e->oid;
+		oidcpy(&ref->old_oid, oid);
 		ref->next = result;
 		result = ref;
 	}
-- 
2.32.0.599.g3967b4fa4ac


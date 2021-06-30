Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A3FC11F68
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 14:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE1D61452
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 14:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhF3OJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 10:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhF3OIx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 10:08:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7CBC061766
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 07:06:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id w13so2160405wmc.3
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lddp79Lgk80FKKHEi9+uVPIEPBz+dmYtDuZyeLqJ51I=;
        b=H90/CbL8i2HKTcIg2bZ9uzEB/ujWqocTpggGfYbEy2esxvhpWjzNUHJEK7IlQTRTdQ
         gwhrTy0uiZFgou2KZOzqhNor7qC5F3qhDZCAxM7h2pSO8BVRfU0r9vp19dCgYG/QVFmf
         +1UYWyR51B3kMJnS+OHlQNVghxQ2Di9TfJD4me+UEsAEeEImTFJ3affxeSQ4HvLeYNSj
         Vea+azdLwf0gpK9O/Ph+oLtT8NEkTGalxrt9UlA4yqQL+1aeg6O/YzzAu+Kztia61xJ9
         1l9WfkEgeRZC6MlQY7xtOhL6M+dvbj8PSFt1XD8wLhbwa+6Vd0u3AG15ia4PuG+CMNLy
         B4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lddp79Lgk80FKKHEi9+uVPIEPBz+dmYtDuZyeLqJ51I=;
        b=nIUl3jKVKhIFDeXy025NRK62454S9Q+3iNaEBwSdFQ/sBgoyA9RveCph6g10bZzX7y
         H0KpUxX1vymvy46F58AjCKwIPc31kns8CzAxed153+A3qjQqaiI/1qOCLGr4sZvEEIiI
         K3DDQ+kax3bLgimB7DsIkqyQVgHJVKZE03MKI8bW8uIQ1/MTJAmWy8xYbhjOUqZfwHbA
         CoDPALhoHNoYfsqH72Y4FXNtV5TzyYRsdCrc7Muv/ByxO51WPLINNBCtTeCSShtJMupT
         YcgaJdHo6izRCXDxDKx7nANFHpVR8Bi3ksSD2jN+SmcvM3eCsEQgDKnJX3q4ET3jyf0G
         IcLg==
X-Gm-Message-State: AOAM533SBUvKLxSpqljlRWPFiQEL6nC3qivA8YPaozWJLbPRXmGnsG5A
        or3HHSSOAr7frn6E6WiYdW1KhKHn/Z9ZGQ==
X-Google-Smtp-Source: ABdhPJyoutvC+XGI0/nddjDCW4lQI8BnMWxxoDoIW2n1OGvqp77k4rQlqqJA5WhhRRDlUGMuV3MIhw==
X-Received: by 2002:a7b:c316:: with SMTP id k22mr4764920wmj.56.1625061981230;
        Wed, 30 Jun 2021 07:06:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b20sm4763814wmj.7.2021.06.30.07.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 07:06:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/3] bundle.c: use a temporary variable for OIDs and names
Date:   Wed, 30 Jun 2021 16:06:15 +0200
Message-Id: <patch-2.3-e47646d3a98-20210630T140339Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.613.g8e17abc2eb
In-Reply-To: <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com> <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
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
2.32.0.613.g8e17abc2eb


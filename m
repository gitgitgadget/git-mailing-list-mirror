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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C94C11F6B
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 09:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5189C61411
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 09:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhGBKAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 06:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhGBKAL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 06:00:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBA6C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 02:57:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l8so11700666wry.13
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 02:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yjQU55FJ5FWAlV+EeUxRuV3c3kNRAyOfNe2csuWxUjY=;
        b=JPdleGIovWqIiVEo7I252Jy+1b5aANX4x2sXL0tHyu9xnedaqnj8E190ZGo+vxdkjQ
         zX1CZ3udLRU/p61K3aRbzEZ+tNtfVghvaKUCKXoKn0PcXfXGjEC9j8SgqxzQE7srucr0
         HqU0FoQ/ast0CMPBc1KFjzUOAkQNvzutp4zuZZpR9V6WgEMF2/sPHK32bepuoR3cv853
         kf08DCrR3L9222eyS6tMxE/kiP4+uHGm1WvSusNvMaId2sn5xF0busYiqf1vHNB3mYkb
         0oRPywVwKDAPD6BOpLRvSQbXjF+VnvCi7iHPOccG/yVU3HInMgjMH5pYooXFyrQ8LpEr
         P89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjQU55FJ5FWAlV+EeUxRuV3c3kNRAyOfNe2csuWxUjY=;
        b=t3ClqDImRUVgsBAyw/7pID3jGbn4FSE0W0eBW0cEI4eFczjTJFskXqsZ1VvBoZ4Qq1
         Njo/1R5hv4ijLD19XwvJVADHdjL9CHkgPcdkkKRT0dpTncyL5YCiIlsQWDWIJrpPGpe7
         Z7CkSAgnwRoEQNW9Y0QOD1chNr8VLyRmhxARPOopKloUGajDX5k476eEhAJfNMUK3dVN
         Oz8lHbGylcTD0ZSkpP4Mw6Gm613mhSSZ3Mb2E3sIic3E59HV0BXDitz4gSDQPNUTnYuv
         XQFmsskalPMoTYEl9tU+kv1KPF4n21Hw05eBg1Di6JL9WX4yegOxXlegkL8yELphYelW
         O59Q==
X-Gm-Message-State: AOAM532ugmoQ5KiTRLqRdNuthBolHnCaEGRqN1EgLqjgcj1swR4wa88g
        j6thM5AEkMLhzx40SCL20IAtra+iJJiX3w==
X-Google-Smtp-Source: ABdhPJxMOuYUHD7nfgo5tro8ORw++mJb0tEHaU7BBMu5J/Yuev8ukSy5QMV3778gn4rxkIxBs0u7Qg==
X-Received: by 2002:adf:f048:: with SMTP id t8mr4784758wro.35.1625219857315;
        Fri, 02 Jul 2021 02:57:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m6sm3307713wrw.9.2021.07.02.02.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 02:57:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/3] bundle.c: use a temporary variable for OIDs and names
Date:   Fri,  2 Jul 2021 11:57:31 +0200
Message-Id: <patch-2.3-5ce376682b3-20210702T095450Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.632.g49a94b9226d
In-Reply-To: <cover-0.3-00000000000-20210702T095450Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com> <cover-0.3-00000000000-20210702T095450Z-avarab@gmail.com>
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
2.32.0.632.g49a94b9226d


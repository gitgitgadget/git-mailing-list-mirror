Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200FDC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB83A61059
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFUPSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFUPSk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 11:18:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D1BC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:16:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n7so20117822wri.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XjoUdXGx23RaygUXJegLtBBYFX/UAvW8G3JvmcUMy6g=;
        b=uhf2zbdEnAAnKSWz6lzVkORYKCnPfQkYTw3RpUn6WOxj5fCEa1TA40jeIgsLpza/xW
         KdUsR/Lylssy4YNRl31TTsezBQGmX5wtIB6dqc5BbwZzLFuhwJTYkTGfpxyPiS5U0goj
         kPAoQNineW7IjVMdpt759dU7LnRQMGCrH+dmNte+6rJR8OeGqVF3cWnA6/dhSB2beomz
         U6AeYJ7xEKU/Y23oec0tyJiOuDY/tfb/GD2xRN65u4WWqBdH6BH0G463Oz3Oo9I9nYNF
         IGHgUUMVBuIenfMmVcbpPeESlkG9iHPxrVAKLgWqBF/GhGFeoSNh9uZ5qkafu8Ju/3QW
         qo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XjoUdXGx23RaygUXJegLtBBYFX/UAvW8G3JvmcUMy6g=;
        b=LHsBXoP2AkBApGYb5m73jNO+gAOomXjiMisE8BGeKJ95jmDFPHVsNmNsiMIKWq14bD
         mKtjAOkqlW15cuxIgMXeSx3jZYriq2UPczOMixBThcxaub5gw5GvsvDC5ZXY/6LmDNo3
         xumftTPPZD/VbJO1TlEis2lVyodlhX8f/h6CH0to1Gu/0VD38HsKgwInZCSZYLuTUzW9
         vL01xWMAzbGCfEjvT6WBgOE0zI/mg0LN4KKPOdUapVVOZqWryGywkSkgyxyJELOze9Tk
         jEdI8oQ9RhOvRGGQ+nQ5CtAzQM+Q68QVVJBiAvJ2bXMjZ/qgJuC+iaVhcyUQLksjRSod
         xgdQ==
X-Gm-Message-State: AOAM533Q9NvuXxxp5AjasJKYJyUkCJlvJwUkAGxkhCXwaSd1Txcd4fj0
        pIfamGfIRoVnJA5dizNuBy0Chm9Z5yFvEQ==
X-Google-Smtp-Source: ABdhPJy3NWY7Jiv4EW+3w6jtPc7M0QjAaL8SDDB4ohUw1mHgLhSXB/+sVHTZ3icZp1jmaRbqSf77zw==
X-Received: by 2002:a5d:40d1:: with SMTP id b17mr5147592wrq.421.1624288579925;
        Mon, 21 Jun 2021 08:16:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u15sm15716019wmq.1.2021.06.21.08.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:16:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] bundle.c: remove "ref_list" in favor of string-list.c API
Date:   Mon, 21 Jun 2021 17:16:11 +0200
Message-Id: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v2 addresses an omission noted by Andrei Rybak[1]. I didn't
factor out the "name" into a variable in 2/3 for ease of reading
3/3. That's now done.

1. https://lore.kernel.org/git/23c4ce5f-7769-1d2c-3a97-ac9733f73a25@gmail.com/

Ævar Arnfjörð Bjarmason (3):
  bundle cmd: stop leaking memory from parse_options_cmd_bundle()
  bundle.c: use a temporary variable for OIDs and names
  bundle: remove "ref_list" in favor of string-list.c API

 builtin/bundle.c | 91 ++++++++++++++++++++++++++++++++----------------
 bundle.c         | 74 ++++++++++++++++++++++-----------------
 bundle.h         | 20 +++++------
 transport.c      | 12 +++++--
 4 files changed, 122 insertions(+), 75 deletions(-)

Range-diff against v1:
1:  f4191088ac3 = 1:  932c0883ce0 bundle cmd: stop leaking memory from parse_options_cmd_bundle()
2:  f297fd0432a ! 2:  7e0d57951e5 bundle.c: use a temporary variable for OIDs and names
    @@ bundle.c: int verify_bundle(struct repository *r,
      	for (i = 0; i < p->nr; i++) {
      		struct ref_list_entry *e = p->list + i;
     -		struct object *o = parse_object(r, &e->oid);
    ++		const char *name = e->name;
     +		struct object_id *oid = &e->oid;
     +		struct object *o = parse_object(r, oid);
      		if (o) {
      			o->flags |= PREREQ_MARK;
    - 			add_pending_object(&revs, o, e->name);
    -@@ bundle.c: int verify_bundle(struct repository *r,
    +-			add_pending_object(&revs, o, e->name);
    ++			add_pending_object(&revs, o, name);
    + 			continue;
      		}
      		if (++ret == 1)
      			error("%s", message);
     -		error("%s %s", oid_to_hex(&e->oid), e->name);
    -+		error("%s %s", oid_to_hex(oid), e->name);
    ++		error("%s %s", oid_to_hex(oid), name);
      	}
      	if (revs.pending.nr != p->nr)
      		return ret;
    @@ bundle.c: int verify_bundle(struct repository *r,
      	for (i = 0; i < p->nr; i++) {
      		struct ref_list_entry *e = p->list + i;
     -		struct object *o = parse_object(r, &e->oid);
    ++		const char *name = e->name;
     +		struct object_id *oid = &e->oid;
     +		struct object *o = parse_object(r, oid);
      		assert(o); /* otherwise we'd have returned early */
    @@ bundle.c: int verify_bundle(struct repository *r,
      		if (++ret == 1)
      			error("%s", message);
     -		error("%s %s", oid_to_hex(&e->oid), e->name);
    -+		error("%s %s", oid_to_hex(oid), e->name);
    ++		error("%s %s", oid_to_hex(oid), name);
      	}
      
      	/* Clean up objects used, as they will be reused. */
    @@ bundle.c: int verify_bundle(struct repository *r,
     
      ## transport.c ##
     @@ transport.c: static struct ref *get_refs_from_bundle(struct transport *transport,
    + 
      	for (i = 0; i < data->header.references.nr; i++) {
      		struct ref_list_entry *e = data->header.references.list + i;
    - 		struct ref *ref = alloc_ref(e->name);
    +-		struct ref *ref = alloc_ref(e->name);
     -		oidcpy(&ref->old_oid, &e->oid);
    ++		const char *name = e->name;
    ++		struct ref *ref = alloc_ref(name);
     +		struct object_id *oid = &e->oid;
     +		oidcpy(&ref->old_oid, oid);
      		ref->next = result;
3:  887313d3b02 ! 3:  9d9cb5aaf9e bundle: remove "ref_list" in favor of string-list.c API
    @@ bundle.c: int verify_bundle(struct repository *r,
      	repo_init_revisions(r, &revs, NULL);
      	for (i = 0; i < p->nr; i++) {
     -		struct ref_list_entry *e = p->list + i;
    +-		const char *name = e->name;
     -		struct object_id *oid = &e->oid;
     +		struct string_list_item *e = p->items + i;
    ++		const char *name = e->string;
     +		struct object_id *oid = e->util;
      		struct object *o = parse_object(r, oid);
      		if (o) {
      			o->flags |= PREREQ_MARK;
    --			add_pending_object(&revs, o, e->name);
    -+			add_pending_object(&revs, o, e->string);
    - 			continue;
    - 		}
    - 		if (++ret == 1)
    - 			error("%s", message);
    --		error("%s %s", oid_to_hex(oid), e->name);
    -+		error("%s %s", oid_to_hex(oid), e->string);
    - 	}
    - 	if (revs.pending.nr != p->nr)
    - 		return ret;
     @@ bundle.c: int verify_bundle(struct repository *r,
      			i--;
      
      	for (i = 0; i < p->nr; i++) {
     -		struct ref_list_entry *e = p->list + i;
    +-		const char *name = e->name;
     -		struct object_id *oid = &e->oid;
     +		struct string_list_item *e = p->items + i;
    ++		const char *name = e->string;
     +		const struct object_id *oid = e->util;
      		struct object *o = parse_object(r, oid);
      		assert(o); /* otherwise we'd have returned early */
      		if (o->flags & SHOWN)
    - 			continue;
    - 		if (++ret == 1)
    - 			error("%s", message);
    --		error("%s %s", oid_to_hex(oid), e->name);
    -+		error("%s %s", oid_to_hex(oid), e->string);
    - 	}
    +@@ bundle.c: int verify_bundle(struct repository *r,
      
      	/* Clean up objects used, as they will be reused. */
      	for (i = 0; i < p->nr; i++) {
    @@ transport.c: static struct ref *get_refs_from_bundle(struct transport *transport
      
      	for (i = 0; i < data->header.references.nr; i++) {
     -		struct ref_list_entry *e = data->header.references.list + i;
    --		struct ref *ref = alloc_ref(e->name);
    --		struct object_id *oid = &e->oid;
    +-		const char *name = e->name;
     +		struct string_list_item *e = data->header.references.items + i;
    -+		struct ref *ref = alloc_ref(e->string);
    -+		const struct object_id *oid = e->util;
    ++		const char *name = e->string;
    + 		struct ref *ref = alloc_ref(name);
    +-		struct object_id *oid = &e->oid;
    ++		struct object_id *oid = e->util;
      		oidcpy(&ref->old_oid, oid);
      		ref->next = result;
      		result = ref;
-- 
2.32.0.599.g3967b4fa4ac


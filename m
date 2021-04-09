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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9875DC43461
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613A461177
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhDIIuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhDIIua (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:50:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790F0C061763
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:50:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f8so5616782edd.11
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a2iv9w+ZdqWP2KNltbPrlBVOLm2UiZ1n9P9fxtphSZ0=;
        b=tv2052qgkcRlvgKyATWP/n5cjekwqlDkK8qrHt8KqL/Pwe2FaNRv/FB+lNCQVhoSwo
         SgAg7d5eTRcLSnNwf2Z7HMh3zBcz+6o0RzEb5Pm/8uDNZuOADjHWZEpXeHM8nP1H3cfP
         AEuxJk6WKftHB5ea5zpYFky1PgC6fx2wX5uaFh0zSALiHTMvBhFB0d14taCnGavp6ZZi
         SlraI88g7Rcu5qpMBMEuu3hOr16a99hdX5f1Hr0s7aqw9CYVbyQzIj815+UL+PJMxOBQ
         2MzenGuOQuDcODJuB6bOCUkAxxdAimGm2rouqVWFGOjW7XSNzDgzJD4IG6p3M/qY+gg4
         eppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a2iv9w+ZdqWP2KNltbPrlBVOLm2UiZ1n9P9fxtphSZ0=;
        b=eyOqi9KBgeivugoMGTywZfglyGFWascXzUI6yO2ZkqauiTutwVuOgMv33pONZekii5
         mDCix4hMb8j8VyvHU7A2J+Lr5NY8+JS1noEILPixTFVgK0QyOV/WP+cSOv7plO7w5qj3
         8Vri/odjqHY6/Dk7TOyqDErrEwtajt4IlqUWQQyk+Imz4/kkA9vNRDSQ0Em+0PaV7pzx
         RhiEYYJ+rxbxeSZGvRog7GI4Huffyjqq4TOXqMx1zhN45/sCzfNJGngcHpLhI3r3bo4w
         dAT3FEdiDXEy9umw4TSGP/tW6/33NPgspQnuFS46BScJxrTJzD4QVj4Hv30fq8iVpLGs
         UrVA==
X-Gm-Message-State: AOAM533blF07PQzyvfyf7cPPyiUc7VRQFXLVzFjTh6nhJ+9ct49ASOoU
        0FJicjeOmT6KsdagKsZ7bB515JdJitUGHA==
X-Google-Smtp-Source: ABdhPJwtOfU7G5vdcwfBnpgHfoxylzDEO2Kct3A3pcpqjeaYQ2e0xU8arlniAIpMkYQvXXD0WG/j7A==
X-Received: by 2002:a50:c356:: with SMTP id q22mr3191640edb.206.1617958216064;
        Fri, 09 Apr 2021 01:50:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m29sm883601ejl.61.2021.04.09.01.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:50:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/7] commit.c: don't use deref_tag() -> object_as_type()
Date:   Fri,  9 Apr 2021 10:50:00 +0200
Message-Id: <patch-5.7-754d5ae267-20210409T083436Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.592.gdf54ba9003
In-Reply-To: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a use of the object_as_type() function introduced in
8ff226a9d5e (add object_as_type helper for casting objects,
2014-07-13) to instead assume that we're not dealing with OBJ_NONE (or
OBJ_BAD) from deref_tag().

This makes this code easier to read, as the reader isn't wondering why
the function would need to deal with that. We're simply doing a check
of OBJ_{COMMIT,TREE,BLOB,TAG} here, not the bare-bones initialization
object_as_type() might be called on to do.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index b370100367..437a8b8548 100644
--- a/commit.c
+++ b/commit.c
@@ -31,13 +31,19 @@ const char *commit_type = "commit";
 struct commit *lookup_commit_reference_gently(struct repository *r,
 		const struct object_id *oid, int quiet)
 {
-	struct object *obj = deref_tag(r,
-				       parse_object(r, oid),
-				       NULL, 0);
+	struct object *tmp = parse_object(r, oid);
+	struct object *obj = deref_tag(r, tmp, NULL, 0);
 
 	if (!obj)
 		return NULL;
-	return object_as_type(obj, OBJ_COMMIT, quiet);
+
+	if (obj->type != OBJ_COMMIT) {
+		enum object_type want = OBJ_COMMIT;
+		if (!quiet)
+			oid_is_type_or_error(oid, OBJ_COMMIT, &want);
+		return NULL;
+	}
+	return (struct commit *)obj;
 }
 
 struct commit *lookup_commit_reference(struct repository *r, const struct object_id *oid)
-- 
2.31.1.592.gdf54ba9003


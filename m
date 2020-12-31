Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97CDC433DB
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 11:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A772246B
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 11:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgLaL5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 06:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLaL5U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 06:57:20 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84029C061575
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 03:56:39 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id s26so43576115lfc.8
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 03:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8Kkov9m3OPmk5g7kCEf4JlRj4Zv4yENYlR417N8Up8=;
        b=C1+I7eHvwcIHXMfqPHXBSlSMjkI+1+mPeakLI0d/GtBoy9pujU8UdLDjQUMBTAMGZH
         n/sB0gdDzghwzF52NmxRFBRFnx6/oKvhsQKU31m3Z9UdvgXHIq8edq37Uqm9lkgAiJAD
         iDUAMCb2CGJ7u3EbvyeWcVD+BGDzUb+2/sJZhvD5J8dI6vGYRdYiw9Mj87NsbtXm5ucO
         y0Mz9JwPw8X/Ox+HnLQvhYw3A2cMnwBAagPTEUwHO26C4B6idEHSSUAyKWaJcb/slaB7
         +7tD/rCUCw63bz8WpdlTIqT4yaTD/svV3BjXxWNWxneSgrsJSN5t21UxgniULOF9VfYW
         q2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8Kkov9m3OPmk5g7kCEf4JlRj4Zv4yENYlR417N8Up8=;
        b=YEYqyJkGtpCUscJGsij9xAx/JE56376khxOizwU/f+MelOOXGrz1iOeUVDOQcipcRY
         lzeGw3mpPl2k3O2pmKeUzkM7hcV1pLhojZ26InDGBfZaTkJq4whlAAiX35T7r3pJyhpI
         lEiKDp0IZHcGfKlxb4ksqfg+ENUADhBaPSp7fsDBdMlHbrXHyP5h+OqfFu44vB/1MJfH
         ftQbK584D8B3FdLAAUrgaJPVxkg6NvZCVLyxcgb5sDt8jgo9RXiaI6ppVZcops/vxNX0
         hiR8dz7AdfJ5fxYcx3+sdwnVhgc4+0D60KUMQmqvv8H9EXmqZo1K5iyRPscRhLe6FPxI
         LyLg==
X-Gm-Message-State: AOAM532bM7zDj9R2t8lT8/SZd0IkMqPA/qPF918iIctnSXIw1VDnWk9j
        EGpkpc1B3CH4pEg+rvARUK3BOzNQjXE=
X-Google-Smtp-Source: ABdhPJwWPO/0nYzhEFSnKsl05xco6fqKI2y5x8gT9ZwrwnxyX8LaW7TdNbIMV376cdvXzd5/MgYm1A==
X-Received: by 2002:a05:6512:308c:: with SMTP id z12mr26561645lfd.138.1609415797656;
        Thu, 31 Dec 2020 03:56:37 -0800 (PST)
Received: from localhost.localdomain (host-189-203-5.junet.se. [207.189.203.5])
        by smtp.gmail.com with ESMTPSA id m11sm7505329ljp.12.2020.12.31.03.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 03:56:37 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 1/4] object-name.c: rename from sha1-name.c
Date:   Thu, 31 Dec 2020 12:56:20 +0100
Message-Id: <4d69d448a3057dfc1a1dcbbd0e4468060e4fde0d.1609415114.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609415114.git.martin.agren@gmail.com>
References: <cover.1609282997.git.martin.agren@gmail.com> <cover.1609415114.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Generalize the last remnants of "sha" and "sha1" in this file and rename
it to reflect that we're not just able to handle SHA-1 these days.

We need to update one test to check for an updated error string.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t1512-rev-parse-disambiguation.sh |  2 +-
 list-objects-filter.c               |  2 +-
 sha1-name.c => object-name.c        | 16 ++++++++--------
 Makefile                            |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)
 rename sha1-name.c => object-name.c (98%)

diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 18fa6cf40d..cc889d7a84 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -48,7 +48,7 @@ test_expect_success 'blob and tree' '
 
 test_expect_success 'warn ambiguity when no candidate matches type hint' '
 	test_must_fail git rev-parse --verify 000000000^{commit} 2>actual &&
-	test_i18ngrep "short SHA1 000000000 is ambiguous" actual
+	test_i18ngrep "short object ID 000000000 is ambiguous" actual
 '
 
 test_expect_success 'disambiguate tree-ish' '
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 0a3ef3cab3..4ec0041cfb 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -21,7 +21,7 @@
  * in the traversal (until we mark it SEEN).  This is a way to
  * let us silently de-dup calls to show() in the caller.  This
  * is subtly different from the "revision.h:SHOWN" and the
- * "sha1-name.c:ONELINE_SEEN" bits.  And also different from
+ * "object-name.c:ONELINE_SEEN" bits.  And also different from
  * the non-de-dup usage in pack-bitmap.c
  */
 #define FILTER_SHOWN_BUT_REVISIT (1<<21)
diff --git a/sha1-name.c b/object-name.c
similarity index 98%
rename from sha1-name.c
rename to object-name.c
index 0b23b86ceb..64202de60b 100644
--- a/sha1-name.c
+++ b/object-name.c
@@ -85,7 +85,7 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 	/* otherwise, current can be discarded and candidate is still good */
 }
 
-static int match_sha(unsigned, const unsigned char *, const unsigned char *);
+static int match_hash(unsigned, const unsigned char *, const unsigned char *);
 
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
@@ -102,7 +102,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 		while (!ds->ambiguous && pos < loose_objects->nr) {
 			const struct object_id *oid;
 			oid = loose_objects->oid + pos;
-			if (!match_sha(ds->len, ds->bin_pfx.hash, oid->hash))
+			if (!match_hash(ds->len, ds->bin_pfx.hash, oid->hash))
 				break;
 			update_candidates(ds, oid);
 			pos++;
@@ -110,7 +110,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 	}
 }
 
-static int match_sha(unsigned len, const unsigned char *a, const unsigned char *b)
+static int match_hash(unsigned len, const unsigned char *a, const unsigned char *b)
 {
 	do {
 		if (*a != *b)
@@ -145,7 +145,7 @@ static void unique_in_midx(struct multi_pack_index *m,
 	for (i = first; i < num && !ds->ambiguous; i++) {
 		struct object_id oid;
 		current = nth_midxed_object_oid(&oid, m, i);
-		if (!match_sha(ds->len, ds->bin_pfx.hash, current->hash))
+		if (!match_hash(ds->len, ds->bin_pfx.hash, current->hash))
 			break;
 		update_candidates(ds, current);
 	}
@@ -173,7 +173,7 @@ static void unique_in_pack(struct packed_git *p,
 	for (i = first; i < num && !ds->ambiguous; i++) {
 		struct object_id oid;
 		nth_packed_object_id(&oid, p, i);
-		if (!match_sha(ds->len, ds->bin_pfx.hash, oid.hash))
+		if (!match_hash(ds->len, ds->bin_pfx.hash, oid.hash))
 			break;
 		update_candidates(ds, &oid);
 	}
@@ -483,7 +483,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
 		struct oid_array collect = OID_ARRAY_INIT;
 
-		error(_("short SHA1 %s is ambiguous"), ds.hex_pfx);
+		error(_("short object ID %s is ambiguous"), ds.hex_pfx);
 
 		/*
 		 * We may still have ambiguity if we simply saw a series of
@@ -1811,7 +1811,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 	if (!ret)
 		return ret;
 	/*
-	 * sha1:path --> object name of path in ent sha1
+	 * tree:path --> object name of path in tree
 	 * :path -> object name of absolute path in index
 	 * :./path -> object name of path relative to cwd in index
 	 * :[0-3]:path -> object name of path in index at stage
@@ -1949,6 +1949,6 @@ enum get_oid_result get_oid_with_context(struct repository *repo,
 					 struct object_context *oc)
 {
 	if (flags & GET_OID_FOLLOW_SYMLINKS && flags & GET_OID_ONLY_TO_DIE)
-		BUG("incompatible flags for get_sha1_with_context");
+		BUG("incompatible flags for get_oid_with_context");
 	return get_oid_with_context_1(repo, str, flags, NULL, oid, oc);
 }
diff --git a/Makefile b/Makefile
index 7b64106930..8bb1163f70 100644
--- a/Makefile
+++ b/Makefile
@@ -937,6 +937,7 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += notes.o
+LIB_OBJS += object-name.o
 LIB_OBJS += object.o
 LIB_OBJS += oid-array.o
 LIB_OBJS += oidmap.o
@@ -995,7 +996,6 @@ LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
 LIB_OBJS += sha1-file.o
 LIB_OBJS += sha1-lookup.o
-LIB_OBJS += sha1-name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
-- 
2.30.0


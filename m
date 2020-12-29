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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196B8C433DB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 23:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D532621D1B
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 23:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgL2XzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 18:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgL2XzN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 18:55:13 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE5FC06179B
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 15:54:32 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id y19so34109713lfa.13
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 15:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1A35HLed5A5wPqE9NzqZfOamyyiAIJ3RW2UbL4pxII=;
        b=AZsUJpSpPMGZHCRxtWa9JTuk1udxhMzZvU02NeKTkZhId49rcko/WobC4GLolkb0ju
         IlLcZPQjjhOEsEx54fGBBMSBG4Vkk7HKskTDpPKNIRT9vYwjVatRF1wsNjKiJ+qHqujv
         sQBJnBQv8OUftbZ4y0Eh4MNHqufgdOZqMNzg0F00BtF0QjPgS42hq4bEL1ZN6oAhCJRG
         EdWGsnnINVOipWr3cYw2ioRyXjFGLKlsTdJFu4gIvqaIQmi4rahK/3pf93dMW+n6nVps
         5G9/8NuCiugWHh7ijqBeccU/n32v6cFdsOPmB9EEXzIaUhdpOyYD4hpg0meSHfpx2Nhz
         wwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1A35HLed5A5wPqE9NzqZfOamyyiAIJ3RW2UbL4pxII=;
        b=SD182vqQX/L40W4k/h79K1j3fag9eH01F4s21qrXgOw7MM69FDh1WPoayT8O/+5AYT
         OlJUJPQJz6uV3yj85HXk0oLCcZXrFh2kkLPKN6T9ZVWHIzId8SavTovK6U6KX+9Em6OV
         1gqr7X8nVyLUKJAHmVvYpUCAsEZCTaUJeJ3lo6FXcXRmZe4iad8tBvvoeecDEuatR7Px
         bljw+BeKG5REHD0NZPAK8qmYJc98KfJjCqISY7Vkwfy6xbPlcvU40PUVO5Sqm5jJwr3Q
         qiMK7x+blWdKX4Tj+r9K48j8vwSVDlM3UKxeWy4e2EV95AkLO10zfF1H8zqSnsFhPwRc
         fOGg==
X-Gm-Message-State: AOAM530+0swMYGCP+ygC+gabwDPUOkstZjVQlR0swuRge4TycBOulzqV
        6wHZP48ZflYKTQ1oHA6d6Mg4T/qsRFk=
X-Google-Smtp-Source: ABdhPJz0lnZ84tCFN8CngK/dI8RC+79wFIrayFS3z7x1I/uZs5h+9L7/KknBY1vX4YRdoroOrMxOGQ==
X-Received: by 2002:a19:f249:: with SMTP id d9mr13297372lfk.158.1609286070701;
        Tue, 29 Dec 2020 15:54:30 -0800 (PST)
Received: from localhost.localdomain (78-66-223-148-no2204.tbcn.telia.com. [78.66.223.148])
        by smtp.gmail.com with ESMTPSA id q25sm5777240lfd.282.2020.12.29.15.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 15:54:30 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/4] object-name.c: rename from sha1-name.c
Date:   Wed, 30 Dec 2020 00:52:57 +0100
Message-Id: <aac3a3c3e202f790f11089e2c8f814bea9943831.1609282997.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609282997.git.martin.agren@gmail.com>
References: <cover.1609282997.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Generalize the last remnants of "sha" and "sha1" in this file and rename
it to reflect that we're not just able to handle SHA-1 these days.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 list-objects-filter.c        |  2 +-
 sha1-name.c => object-name.c | 14 +++++++-------
 Makefile                     |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)
 rename sha1-name.c => object-name.c (99%)

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
similarity index 99%
rename from sha1-name.c
rename to object-name.c
index 0b23b86ceb..7e58a58777 100644
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


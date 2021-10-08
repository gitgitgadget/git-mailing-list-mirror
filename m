Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2071BC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF53460F90
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhJHTgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhJHTgw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:36:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC1AC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:34:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t2so32806930wrb.8
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HyWnXGE/7iFf5sBlOviRTZsS7GMcFLQnOaJwELfdCXQ=;
        b=nGfZ0uWAuVPLAa/7mus5n8m/ov9X2essHTyTnJNDrpGqksVdHmX6zxZ+kfRPzmlWmm
         Cpk0pc79lPiq38cVyLD8aKxRVmfkon5jTU0C3pNcsMGFZcqm32naEbm/hEZX5LVIDBia
         mEPi+1FqbewJ1OxNeFSxN0PgZstbII9V7I+PfdGRjzgl+zGnuUdJarl0XV9WhJEPc9QK
         4EV/467/zVPMQQIUGRPPwOrl2cjGQ9sa8Ct5rIdiJ0u/bPEfnxztPE1EdzVGrRHPE825
         ZglcuhGw6LYNYE8Gk/NJZnhlLErTsAOjLk9YLk0jX7rqTkfPqwi+ou53J6rKAvBuNVHT
         5blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HyWnXGE/7iFf5sBlOviRTZsS7GMcFLQnOaJwELfdCXQ=;
        b=bPye2pEBTkxI8DtiX+r/T9U6VX0f8uFKR5ZqzRplI8JOWogAlGVvRLA2v284UF1Osm
         m6JDwQGW1Uclcj91ibKU+TCfE93J1tFUwo3YiOPknAthyoJfyANqMuhAsgyVr7DcGHPO
         Bb0WL6c3zZTq8fX1DQN+in7ztThjhxqChLICOoQC0VZ0jf92R0a8qMNS8aCdCGjgmTSi
         VZyIOKXGsk/glfgPspzf92ajW9NDhfF5D7FW7GrRNrWxuymzCgvtuOtM9bGc+G3iN25+
         nh4NZyURrZi+oFMk58ke4Evp1q8V9x5rhNBLI6r5LTPQY5QT15Lpb7V/5BOqBecCZtoU
         lwPA==
X-Gm-Message-State: AOAM533/5XkYbkYDW8gprE/PBXt1GvD6Q8aTHMrYW6whDo/si1O6RwC1
        XcZYRbX3UtauC5fmFltJo6LV+6L54y2hLA==
X-Google-Smtp-Source: ABdhPJyKtp+dPprbWISJIz3eNbej+fySpJ68fqHWioGKi72MxW3pJdSXDc/hWezPGvfjO7G3fCxgQQ==
X-Received: by 2002:a5d:6ad2:: with SMTP id u18mr6553986wrw.47.1633721695404;
        Fri, 08 Oct 2021 12:34:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c204sm13056157wme.11.2021.10.08.12.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:34:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/3] object-name: make ambiguous object output translatable
Date:   Fri,  8 Oct 2021 21:34:47 +0200
Message-Id: <patch-v3-2.3-587a5717e47-20211008T193041Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1492.g76eb1af92bc
In-Reply-To: <cover-v3-0.3-00000000000-20211008T193041Z-avarab@gmail.com>
References: <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com> <cover-v3-0.3-00000000000-20211008T193041Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the output of show_ambiguous_object() added in [1] and last
tweaked in [2] and the preceding commit to be more friendly to
translators. By being able to customize the "<SP><SP>%s\n" format
we're even ready for RTL languages, who'd presumably like to change
that to "%s<SP><SP>\n".

1. 1ffa26c461 (get_short_sha1: list ambiguous objects on error,
   2016-09-26)
2. 5cc044e0257 (get_short_oid: sort ambiguous objects by type,
   then SHA-1, 2018-05-10)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/object-name.c b/object-name.c
index 59e934262e7..7a5355b4cf7 100644
--- a/object-name.c
+++ b/object-name.c
@@ -356,6 +356,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	const struct disambiguate_state *ds = data;
 	struct strbuf desc = STRBUF_INIT;
 	int type;
+	const char *hash;
 
 	if (ds->fn && !ds->fn(ds->repo, oid, ds->cb_data))
 		return 0;
@@ -363,22 +364,69 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	type = oid_object_info(ds->repo, oid, NULL);
 	assert(type == OBJ_TREE || type == OBJ_COMMIT ||
 	       type == OBJ_BLOB || type == OBJ_TAG);
+	hash = repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV);
+
 	if (type == OBJ_COMMIT) {
+		struct strbuf ad = STRBUF_INIT;
+		struct strbuf s = STRBUF_INIT;
 		struct commit *commit = lookup_commit(ds->repo, oid);
+
 		if (commit) {
 			struct pretty_print_context pp = {0};
 			pp.date_mode.type = DATE_SHORT;
-			format_commit_message(commit, " %ad - %s", &desc, &pp);
+			format_commit_message(commit, "%ad", &ad, &pp);
+			format_commit_message(commit, "%s", &s, &pp);
 		}
+
+		/*
+		 * TRANSLATORS: This is a line of ambiguous commit
+		 * object output. E.g.:
+		 *
+		 *    "deadbeef commit 2021-01-01 - Some Commit Message"
+		 */
+		strbuf_addf(&desc, _("%s commit %s - %s"), hash, ad.buf, s.buf);
+
+		strbuf_release(&ad);
+		strbuf_release(&s);
 	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(ds->repo, oid);
+		const char *tag_tag = "";
+
 		if (!parse_tag(tag) && tag->tag)
-			strbuf_addf(&desc, " %s", tag->tag);
+			tag_tag = tag->tag;
+
+		/*
+		 * TRANSLATORS: This is a line of
+		 * ambiguous tag object output. E.g.:
+		 *
+		 *    "deadbeef tag Some Tag Message"
+		 *
+		 * The second argument is the "tag" string from
+		 * object.c, it should (hopefully) already be
+		 * translated.
+		 */
+		strbuf_addf(&desc, _("%s tag %s"), hash, tag_tag);
+	} else if (type == OBJ_TREE) {
+		/*
+		 * TRANSLATORS: This is a line of ambiguous <type>
+		 * object output. E.g. "deadbeef tree".
+		 */
+		strbuf_addf(&desc, _("%s tree"), hash);
+	} else if (type == OBJ_BLOB) {
+		/*
+		 * TRANSLATORS: This is a line of ambiguous <type>
+		 * object output. E.g. "deadbeef blob".
+		 */
+		strbuf_addf(&desc, _("%s blob"), hash);
+	} else {
+		BUG("unreachable");
 	}
 
-	advise("  %s %s%s",
-	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
-	       type_name(type), desc.buf);
+	/*
+	 * TRANSLATORS: This is line item of ambiguous object output,
+	 * translated above.
+	 */
+	advise(_("  %s"), desc.buf);
 
 	strbuf_release(&desc);
 	return 0;
-- 
2.33.0.1492.g76eb1af92bc


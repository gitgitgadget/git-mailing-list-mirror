Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69D5C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 14:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhL1OfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 09:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhL1OfR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 09:35:17 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCED0C06173E
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 06:35:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s1so38830634wrg.1
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 06:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XmpgZw6IBeCZmb9hftaF4UGmBXF/+JSUtIMHZrqb0FU=;
        b=VHXbj3M+HpQdJwJhs04Z0GCI38k80ppDs1NZs3ky8FS9wDTimlYROfqS3tPmiOe+42
         JVj8nd7W0qd8CRp0AiOoo0SuetWmpCRqfol/CbuTW/19hTyHhLK3BnBIHj2pEONHBBNW
         cHgoqX1MMhHi4MgyvtwnjFgNRFGqQVy/cuFlwUbONVDmjLTvJQnHTshpSuKJaIsARalE
         tJHn9TWdJ0EV7URa5l5TDj2uy9dy3C2Wt5DsszKdPxco9IjdXPW3Caa5DEWJnQEzyGBy
         chFMm0UgeYIaJjBBu/XXKsyV6bDGAcJtSdPfyk1jurFn2Bfk5JGv5P9ifEkdqHaAHYtJ
         WjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XmpgZw6IBeCZmb9hftaF4UGmBXF/+JSUtIMHZrqb0FU=;
        b=R39CAqmD63hmqkPt3m1eAPN+LtGR609BDDmCFHqRU8tRKJWsWQU7RMKC+dAyCryTD4
         sXU8vJTJY8AtII26QR/YKVtxN112cLALGJiZv/na8J24nYXoLfRlwEZk+uarmYw4MHzN
         rePYQxYUwv7/CxJUl88T74d0WKcQZZTJX9kzy2Bu9GvJ2Pc0/dpiVSWyDDd45lElaXNJ
         0Q7tSJ4j/lRcSBOaR/b1gJVchVozjjVXamh85XZcCb1+H4wHMGsZREQUN94MblDTqY4P
         xwkLifkxQYb3YCXYl05F93afS9PEwzC5RLqOHOqCnHcDxXB13wMGrjadeHlp3N9TOhiT
         7N8Q==
X-Gm-Message-State: AOAM532xtTAl0TVocM453ZWNbbFL8v9XN+Tee9swzNQnqxGmJZoY/KCe
        dPIftg0y//ULi2MEq394VL2gW+x2tI714nxU
X-Google-Smtp-Source: ABdhPJw3z4mw0yNW44/FnJINNxATIpg0IyOYgaHpN7dKhpArsrnw5djcW8iUCdawHifp2Na85DpBJw==
X-Received: by 2002:adf:e286:: with SMTP id v6mr17129610wri.565.1640702115092;
        Tue, 28 Dec 2021 06:35:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m35sm42780660wms.1.2021.12.28.06.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 06:35:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 3/6] object-name: make ambiguous object output translatable
Date:   Tue, 28 Dec 2021 15:34:59 +0100
Message-Id: <patch-v6-3.6-daebc95542c-20211228T143223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
References: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com> <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the output of show_ambiguous_object() added in [1] and last
tweaked in [2] and the preceding commit to be more friendly to
translators.

By being able to customize the "<SP><SP>%s\n" format we're even ready
for RTL languages, who'd presumably like to change that to
"%s<SP><SP>\n".

1. 1ffa26c461 (get_short_sha1: list ambiguous objects on error,
   2016-09-26)
2. 5cc044e0257 (get_short_oid: sort ambiguous objects by type,
   then SHA-1, 2018-05-10)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 object-name.c | 65 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/object-name.c b/object-name.c
index 9750634ee76..dcf3ab99990 100644
--- a/object-name.c
+++ b/object-name.c
@@ -356,38 +356,89 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	const struct disambiguate_state *ds = data;
 	struct strbuf desc = STRBUF_INIT;
 	int type;
+	const char *hash;
 
 	if (ds->fn && !ds->fn(ds->repo, oid, ds->cb_data))
 		return 0;
 
+	hash = repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV);
 	type = oid_object_info(ds->repo, oid, NULL);
 
 	if (type < 0) {
-		strbuf_addstr(&desc, "[bad object]");
+		/*
+		 * TRANSLATORS: This is a line of ambiguous object
+		 * output shown when we cannot look up or parse the
+		 * object in question. E.g. "deadbeef [bad object]".
+		 */
+		strbuf_addf(&desc, _("%s [bad object]"), hash);
 		goto out;
 	}
 
 	assert(type == OBJ_TREE || type == OBJ_COMMIT ||
 	       type == OBJ_BLOB || type == OBJ_TAG);
-	strbuf_addstr(&desc, type_name(type));
 
 	if (type == OBJ_COMMIT) {
+		struct strbuf date = STRBUF_INIT;
+		struct strbuf msg = STRBUF_INIT;
 		struct commit *commit = lookup_commit(ds->repo, oid);
+
 		if (commit) {
 			struct pretty_print_context pp = {0};
 			pp.date_mode.type = DATE_SHORT;
-			format_commit_message(commit, " %ad - %s", &desc, &pp);
+			format_commit_message(commit, "%ad", &date, &pp);
+			format_commit_message(commit, "%s", &msg, &pp);
 		}
+
+		/*
+		 * TRANSLATORS: This is a line of ambiguous commit
+		 * object output. E.g.:
+		 *
+		 *    "deadbeef commit 2021-01-01 - Some Commit Message"
+		 */
+		strbuf_addf(&desc, _("%s commit %s - %s"),
+			    hash, date.buf, msg.buf);
+
+		strbuf_release(&date);
+		strbuf_release(&msg);
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
 	}
 
+
 out:
-	advise("  %s %s",
-	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
-	       desc.buf);
+	/*
+	 * TRANSLATORS: This is line item of ambiguous object output
+	 * from describe_ambiguous_object() above.
+	 */
+	advise(_("  %s"), desc.buf);
 
 	strbuf_release(&desc);
 	return 0;
-- 
2.34.1.1257.g2af47340c7b


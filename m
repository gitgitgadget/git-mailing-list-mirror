Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916C8C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbhKVR4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239540AbhKVR4j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:56:39 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A766C061757
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:53:31 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso17539789wmr.4
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nu/9T5T50bIMXcXdvyI7HcG2KydHMo6eSuteZgaGcTs=;
        b=q5n5fcNvKPPnf4RIF1ot4A3UA9UCqiw6gGAt12ZPfAmTqRJ+uiamPyG4AsXkfbeA32
         cI7/i9jxxEULgMHlEK7ojcUVnEvSSWFFHSoZgpZcVzixZfAzxfa6GQHoPxAwzoNnkXqg
         qhMHZqeJF7WuQkiPGNVDDsPSGl8LW4tfYE4lQGmQ5i5/EwFVXDSlxhyIth+obOkwHwbQ
         GJeD1xcbaE6Du561CKD/0SF1SfmmhoWMu5aGCGnzkFODCh33E2fO0scnx1H/DwCTfDcK
         UKhqZFkc2I7AndbijSeFzvJY/+tyCwch5qzZBk90gHvI3TyntC1hBx0VH4+VgcizhUDL
         Yp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nu/9T5T50bIMXcXdvyI7HcG2KydHMo6eSuteZgaGcTs=;
        b=2zKnRKcZSrx3mqmBbpGwL98UwmJtlleKwjNgy9tiAMfOi+WRgOygNMF/GYncCQYQT/
         ujtHBdiBPbyFgG4G40II3nQZoAyP3PkWpWifcYORZdXFncw57dlTrgqK+cveMtQHtQK1
         fUu63sdOhIOg15bOjHRCdsJ0WGcoGSD2sOmzWRLFQXY8wYZGim4CIiO/F3tLOFNq3Yma
         o72W5hr2ZTulHHCXd+4MeGysIl8wmUnbYNK75SO6I9LMp2MGgkNwTlNSw2E6N5d5FhGA
         yLVVSNCHQMFwdJkNB27wCZqrmXPp692TeLECz4AGZ3FP8L6VABEH8etTmTQbDQdTlcQp
         3uRg==
X-Gm-Message-State: AOAM532RIRcuU2+No9Csp1mvuV6WemDF+X6Gs1eLXXZb/TM2XuT55qau
        arVzdbeJMWBMrtIAHCVVyV7q8C2M0x3gHQ==
X-Google-Smtp-Source: ABdhPJxFHWJneIjVWuIx5ZqK4NXjN1lNmdlQBQBh6VIsUvfFza/tUuXuGy0ymTPDW9vviLZvIJGOzA==
X-Received: by 2002:a05:600c:1f17:: with SMTP id bd23mr19107100wmb.57.1637603609214;
        Mon, 22 Nov 2021 09:53:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l11sm9531664wrp.61.2021.11.22.09.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 09:53:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/3] object-name: make ambiguous object output translatable
Date:   Mon, 22 Nov 2021 18:53:24 +0100
Message-Id: <patch-v4-2.3-00d84faeb1d-20211122T175219Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.822.gc64b680fd55
In-Reply-To: <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com>
References: <cover-v3-0.3-00000000000-20211008T193041Z-avarab@gmail.com> <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com>
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
2.34.0.822.gc64b680fd55


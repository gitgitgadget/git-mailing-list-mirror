Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F077FC433FE
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 05:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbiA0F1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 00:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiA0F07 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 00:26:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5211C06173B
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 21:26:58 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s18so2607590wrv.7
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 21:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NrUDksqLiAVFkzbMo8K6Bau53hIy5hMUMZ2OKJNsgh4=;
        b=aOZ25ZA4QgxW1ZiA9rT4a+hRgdyKQerlD61MfX4V/mNHSSSLlntfnioZNErdATzDVr
         C4U8iYtmGq8O762Mzgz9Aixn7gJVvsxF2zGMT2fJnw3+XZvCPtSAw2l+CgSZax8BI01x
         hrasbDGeBt2TqPGg2sSxgIGMke1Oxm+A+/I93PDk3ASVosrOzNhgrHh66MkBIO6/8IIg
         fu3zunqwpu/ODM8JsQ3qz2hEgsrznpW9lSsbYb2na+zr9jTWAzMmBb6/x4VGMZuspvqC
         vIcqCgflqn/kDbmLgAqwvH2He1MyDQJORCTccmtgmvrGpeVQczDnNIRu7mHXoo++cgaT
         hilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NrUDksqLiAVFkzbMo8K6Bau53hIy5hMUMZ2OKJNsgh4=;
        b=QafDIGDhDquXWVEiLVUzxbHijKNJrw4rTYsd7h9oQWzfj+DLxmPfyBRc+v17M1VAXH
         iekz6HTvcwtbmJpxfAXqv/QXI3roRpvCLPrOC8sCJmIArvOzHJcU3dPVmKXEUQwC1RUH
         ko7fe4sEMZ6VlSTSP+lRG4ZbHDxGSXMKrVdsmDtRBr8K7RlNR4GWICh9E2FQUWXUa9Lh
         HkW98DwT5Z0NYoGRkcj7EaJvGcsB1ND6lGg0pE23jsOXIHlLeY1a6AyR4/dUhCTloGua
         sZiCvqICbWFHMepLCRctNPDTHSCNUPzv6QxqurBhLAVn1/nROsEbrUFaWkebbkZdKBXR
         2AeA==
X-Gm-Message-State: AOAM531443RnKk2OiYtOu3KJw5cTJaOKfB/5F5VBBAzF3+5fNJghpLSr
        9a8tSuF2ilKY93Tvrkjh4ngVV+yOPOz46g==
X-Google-Smtp-Source: ABdhPJx5jd7GEZj+K+0Z3fVecUFF3Bgi2aKDQtb+++I/tbqBL2dzUSs62A0GDSo1HZrR8NyNpX1Iig==
X-Received: by 2002:adf:ffd0:: with SMTP id x16mr1402368wrs.489.1643261217334;
        Wed, 26 Jan 2022 21:26:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm6017661wmp.10.2022.01.26.21.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 21:26:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 4/7] object-name: make ambiguous object output translatable
Date:   Thu, 27 Jan 2022 06:26:46 +0100
Message-Id: <patch-v8-4.7-6a26c917a94-20220127T052116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.890.gd7e422415d9
In-Reply-To: <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
References: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com> <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
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

In the case of the existing "tag [tag could not be parsed]" output
we'll now instead emit "[bad tag, could not parse it]". This is
consistent with the "[bad object]" output. Rephrasing the message like
this is possible because we're not unconditionally adding the
type_name() at the beginning.

1. 1ffa26c461 (get_short_sha1: list ambiguous objects on error,
   2016-09-26)
2. 5cc044e0257 (get_short_oid: sort ambiguous objects by type,
   then SHA-1, 2018-05-10)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 object-name.c | 78 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 10 deletions(-)

diff --git a/object-name.c b/object-name.c
index 298b742bac9..f31b50bc315 100644
--- a/object-name.c
+++ b/object-name.c
@@ -356,40 +356,98 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
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
-		if (!parse_tag(tag) && tag->tag)
-			strbuf_addf(&desc, " %s", tag->tag);
-		else
-			strbuf_addstr(&desc, " [tag could not be parsed]");
+
+		if (!parse_tag(tag) && tag->tag) {
+			/*
+			 * TRANSLATORS: This is a line of ambiguous
+			 * tag object output. E.g.:
+			 *
+			 *    "deadbeef tag Some Tag Message"
+			 *
+			 * The second argument is the "tag" string
+			 * from object.c.
+			 */
+			strbuf_addf(&desc, _("%s tag %s"), hash, tag->tag);
+		} else {
+			/*
+			 * TRANSLATORS: This is a line of ambiguous
+			 * tag object output where we couldn't parse
+			 * the tag itself. E.g.:
+			 *
+			 *    "deadbeef tag [bad tag, could not parse it]"
+			 */
+			strbuf_addf(&desc, _("%s [bad tag, could not parse it]"),
+				    hash);
+		}
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
+	 * from describe_ambiguous_object() above. For RTL languages
+	 * you'll probably want to swap the "%s" and leading " " space
+	 * around.
+	 */
+	advise(_("  %s"), desc.buf);
 
 	strbuf_release(&desc);
 	return 0;
-- 
2.35.0.890.gd7e422415d9


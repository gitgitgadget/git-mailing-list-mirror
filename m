Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEBAC4332F
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 12:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353224AbiALMkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 07:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353208AbiALMkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 07:40:09 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A8AC06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:40:08 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id e5so1510509wmq.1
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sk80vDWEKQkKWJ1XnQ1M6y8rCFkQxvxef22FR2JZTXk=;
        b=ogf5vCdVR6/5n3+iWRiSHs1Z/7D8y40lFB9Yrz98V91oC1Gicwx49hPI/RMRBY4VQT
         o53uUbaqqvORF3pFll+ZyV/R2ibzgqbVQ9mcQG9/Fg31Idk+J2zZHoZAmB/5WPwS7pS1
         rHvmPxW5f4BV/JO+wzMNUIQzg9Kw+Gn7aLXLyDClsRV2OfUCOyaCJxJ6x6IujFpgduR9
         yhJ9bjlWq9Q+UfQxVB6AkLSGain2ZX1Mjd86xwwEsRkQVkx6l5tql9JZIT5ORtX1G+lB
         MApPw2OHRiDFsSUh1mRzNm91y0oEov/2zsf8yYgJR3vax6W+Vu5gnZndPLYri4yR4N5o
         bSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sk80vDWEKQkKWJ1XnQ1M6y8rCFkQxvxef22FR2JZTXk=;
        b=NqtBFb8nUAjdmgQMvG+q1GyfHO0lyP/dCIwNlvuv0a6YjPSueiQzgwGyo5NPJjyxht
         TPxLnxiED4OWN/O8vStJ4tH4McXZjM17adCPxqNORJ7ARyu2typo31pW7RjgpmEWL9AV
         +KfYwsI6x8jCRTS+3BFOPd5r+DZrjPB02enJfaYsBBzXaClkv0GymnEcSCgcFUfnHQx9
         34WWnaImjaF2dUZVP23HhP4cn9Rze8O6JDML9p78ckEPRbJjhFk7YJo6NLdrcZcdyt8A
         0//F/Qu+HVA67fynvAziH1VTc3JMA48hYxR3YrE743SqjOnlGxR3nVoVbGCq3oP1i3cY
         ulLA==
X-Gm-Message-State: AOAM531X73KgRWT27PTLJ0NhEg9t3DLH/MxeXG8BHzGoRz9M/rzXe/eH
        UfR5TM1Epz85kmt6DK4Lkfyk/Y4XRPbVeg==
X-Google-Smtp-Source: ABdhPJyXI7sXEqu+IBS9Wimcc3Rb412lbzE0zTXQvP3yCcP/1RaJxikrqsNRJYIZZ7Lo1JgIwU8/uA==
X-Received: by 2002:a05:600c:4fcd:: with SMTP id o13mr6599773wmq.142.1641991207298;
        Wed, 12 Jan 2022 04:40:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm5174242wmq.11.2022.01.12.04.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 04:40:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 3/6] object-name: make ambiguous object output translatable
Date:   Wed, 12 Jan 2022 13:39:22 +0100
Message-Id: <patch-v7-3.6-65801f2c890-20220111T130811Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.848.gb9d3879eb1d
In-Reply-To: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com> <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
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
 object-name.c | 66 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/object-name.c b/object-name.c
index 9750634ee76..743f346842a 100644
--- a/object-name.c
+++ b/object-name.c
@@ -356,38 +356,90 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
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
+		 * object.c.
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
+	 * from describe_ambiguous_object() above. For RTL languages
+	 * you'll probably want to swap the "%s" and leading " " space
+	 * around.
+	 */
+	advise(_("  %s"), desc.buf);
 
 	strbuf_release(&desc);
 	return 0;
-- 
2.34.1.1373.g062f5534af2


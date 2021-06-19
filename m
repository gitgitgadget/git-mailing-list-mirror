Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3843CC2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09AE6610A2
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhFSHFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 03:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbhFSHFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 03:05:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063BAC06175F
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 00:03:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p8-20020a7bcc880000b02901dbb595a9f1so279724wma.2
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 00:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sslxU2Zj/H3zu0TbnQu1d/Mc+WxpiqXZj8t9ARAzits=;
        b=ry69f4eEuqi3uhNsccHqJ+aQPHqp29KzhVf3OtUOokSChljA+hPaG3tZtOxFfkwpuS
         r6wYhGBRTNirhfhV2FO8M5tuSA606kOd0RSm5Z5eDLLpVOCor3SN+FPc5NmA5GcUBgdk
         LK1hTNGUs28O6m3CIXRUeNDFDfGuP8XKxgdzy4I7dsVDe6ArtKxSOEkU7nmdlvga17Gr
         kNBiZve6JXg1Ub0F9JL3YXnRneG9HsosMDcwziGmDPhDl0vGmZJN6m/yB/w6yr9lfHMB
         kwEuK6dPIL13BLb73O31VLLRnouLcSne2nUcZavGKWX/icYScs5pgAWFwo11bCxL5TzT
         Eekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sslxU2Zj/H3zu0TbnQu1d/Mc+WxpiqXZj8t9ARAzits=;
        b=PWwOhtlAqiDYJiHIfMm8Bpq6/u1+u8/sQKFCxUCrxWTLNQiiTL8UAGXBMOVKE/qW+A
         eTQWtSImp9/uh9XEs2oaW4zCeBgLJVlCkcQbQ9urUuDs3VjzXFeZaZac64zQKFiG3r0C
         oNyu99a/1QQQ2QEM9Kl21zxCTK6dIVcGBCJgYGn6Zz1n9LEVfcCgVAuEK5v6XOdlPqYe
         cmBqa+H1HkOQLbatt3NvPriiXnHcTklcgTM2Xh9AVpEm2jmKUU3Sfm1RZJS5IyPvfICt
         O3EPdQIzxqbNs1HnOhXGzq6YyA7p0OxjXhZw7MX665ZYRFDRtAZQOQXvOPs2w7I+oGXp
         74Ig==
X-Gm-Message-State: AOAM532XJ0Fwvngg84Di6qZo3uwwOoJ6GfyG26RoGmfDaQbcZ0bZAKW9
        2mHnAUOuJhOMaTQGoFCz70j0+5sA/Bc=
X-Google-Smtp-Source: ABdhPJxQJKGiLK0Unn5aaSI6hwddX1p48VF2413GqSwU0JbUJYnSi7j7KktWBYv2eisCEnQe+AbQyg==
X-Received: by 2002:a05:600c:24c:: with SMTP id 12mr12044194wmj.174.1624086183608;
        Sat, 19 Jun 2021 00:03:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o26sm7576278wmr.29.2021.06.19.00.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 00:03:03 -0700 (PDT)
Message-Id: <f72ad9cc5e8b1f1139784df9ac7178f1561f70bb.1624086181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
References: <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
        <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Jun 2021 07:02:51 +0000
Subject: [PATCH v3 01/10] [GSOC] ref-filter: add obj-type check in grab
 contents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Only tag and commit objects use `grab_sub_body_contents()` to grab
object contents in the current codebase.  We want to teach the
function to also handle blobs and trees to get their raw data,
without parsing a blob (whose contents looks like a commit or a tag)
incorrectly as a commit or a tag.

Skip the block of code that is specific to handling commits and tags
early when the given object is of a wrong type to help later
addition to handle other types of objects in this function.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 4db0e40ff4c6..5cee6512fbaf 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1356,11 +1356,12 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 /* See grab_values */
-static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
+static void grab_sub_body_contents(struct atom_value *val, int deref, struct expand_data *data)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
 	size_t sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
+	void *buf = data->content;
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
@@ -1371,10 +1372,13 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 			continue;
 		if (deref)
 			name++;
-		if (strcmp(name, "body") &&
-		    !starts_with(name, "subject") &&
-		    !starts_with(name, "trailers") &&
-		    !starts_with(name, "contents"))
+
+		if ((data->type != OBJ_TAG &&
+		     data->type != OBJ_COMMIT) ||
+		    (strcmp(name, "body") &&
+		     !starts_with(name, "subject") &&
+		     !starts_with(name, "trailers") &&
+		     !starts_with(name, "contents")))
 			continue;
 		if (!subpos)
 			find_subpos(buf,
@@ -1438,17 +1442,19 @@ static void fill_missing_values(struct atom_value *val)
  * pointed at by the ref itself; otherwise it is the object the
  * ref (which is a tag) refers to.
  */
-static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf)
+static void grab_values(struct atom_value *val, int deref, struct object *obj, struct expand_data *data)
 {
+	void *buf = data->content;
+
 	switch (obj->type) {
 	case OBJ_TAG:
 		grab_tag_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf);
+		grab_sub_body_contents(val, deref, data);
 		grab_person("tagger", val, deref, buf);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf);
+		grab_sub_body_contents(val, deref, data);
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
 		break;
@@ -1678,7 +1684,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
 					       oid_to_hex(&oi->oid), ref->refname);
 		}
-		grab_values(ref->value, deref, *obj, oi->content);
+		grab_values(ref->value, deref, *obj, oi);
 	}
 
 	grab_common_values(ref->value, deref, oi);
-- 
gitgitgadget


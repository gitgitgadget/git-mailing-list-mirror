Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E618C432BE
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 14:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042BB60EB0
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 14:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhGXNdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jul 2021 09:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhGXNdx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jul 2021 09:33:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFEEC061575
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 07:14:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so3317132wmb.5
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 07:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O9u986p91/Gwi+fKy8spnM0GBKp3DiyL5kpCBbLklIA=;
        b=FASAhyMGTt/MkMMfGc5609LzBYdCrsP6Nv6tWfdPZ18ulQoaq9zVBE7YOFMYHrA6rw
         /VTm2MaK0KWDFjCPH/pPD+hmYVvAPznk46NZUT+kvDSpJt1IjtiMAcaGpLbQTTkU5qXw
         PdBHZGf7avTFm2+Bcu+qPlq9Oe+seODGxMqOJbXimLXb7I60KwJYGTjnO9kkdjgkyO/x
         nmeG2HF8mAbRS3DjBGPJfcNKQemp2pVZo7gpm8Rel1KABKfcR5G3uko9ElX6G8d7HsAh
         77XSwXXFz5nRkvVVkNg1uAsMNiUHrjdvQcRZ/WAzSBye7f/bmmOzgbLf8TAScGIu73l3
         oq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O9u986p91/Gwi+fKy8spnM0GBKp3DiyL5kpCBbLklIA=;
        b=faFMOtnGqFeJvcVQdTA1ggnMDfexbnu2jbf/eM96zDbOOIlggPh9LXvnGufF3harn6
         EsByWNkHEGHSffVh2PA89u0eRYnvf0B1m8opzQshnMwTPSv3Ub5vQnO5a81jMAmNOkpq
         RrPqSnS2vgreaQQD4yPibgt4kbMCaS/eKXMZ2x9Xbt/VnMFgq4833YqwvLtldoArC+8V
         tTohRFWtFa57MH6lgFuGor1TAabIMO2HN489uh8EkCeSaXeGz2toCtRpUGqzTx4pRwHx
         sbuAKgBwnyRI+mzC2WaqrWU4ZTv8bnMN8mM/D5NoYdQmpEk2bnmJpTB4/OHpMxoyhFi9
         TICQ==
X-Gm-Message-State: AOAM530aX24sIXKeJiHuwlDWQuSj2UevcyCFmGXnZyJwdsUlUrPUlfYQ
        tig8TJ5J3OYaj81sKV+tLWx08X7jylk=
X-Google-Smtp-Source: ABdhPJzpkh17uDGpvIVWBGQxD/8adMpL+2/cQrZPfnxoBqxdU3OKtNUSkkkbDUK1f/4LJD3CEgI5Nw==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr9143590wmj.87.1627136064091;
        Sat, 24 Jul 2021 07:14:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm35884737wrw.56.2021.07.24.07.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 07:14:23 -0700 (PDT)
Message-Id: <d77268bb1882a6cfbea740053baac5546ca5c5f1.1627136062.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com>
References: <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com>
        <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Jul 2021 14:14:17 +0000
Subject: [PATCH v3 1/5] [GSOC] ref-filter: add obj-type check in grab contents
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
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        Jacob Keller <jacob.keller@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Only tag and commit objects use `grab_sub_body_contents()` to grab
object contents in the current codebase.  We want to teach the
function to also handle blobs and trees to get their raw data,
without parsing a blob (whose contents looks like a commit or a tag)
incorrectly as a commit or a tag. So it's needed to pass a
`struct expand_data *data` instread of only `void *buf` to both
`grab_sub_body_contents()` and `grab_values()` to be able to check
the object type.

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
index 4db0e40ff4c..5cee6512fba 100644
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


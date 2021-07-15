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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C76C47E48
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F7D0613E0
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbhGOPnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbhGOPnX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 11:43:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD08C061760
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i94so8377568wri.4
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/+pHTUCgsn/eJhBt7TH6g2FT5CeygqVH9py2mRcVtgU=;
        b=BLNx5J7yMWNgRGAuvBSQiV3gzbdFnRrB5Ed6CWKfeAjErTX6+MiDaP/R0GVooAGEUL
         wSlWeSF1if8/slb2xb4C0whTut5vT0foIWnNEFOemBBwioU20ZcAGNmWD1hqMgLojWud
         Zh5lgMsN+WX5Pjb0+vdH74Zgc5Qn972MSV6wZjDsMN37WK1mCxxdSgz9BXnaLdn45LbJ
         k0xa5g+vdE0EsmeV1Lox0q5lUvQpSoxgjBD7texobPO3JuB/ch1s5S1P7C5hkFL1h+Nb
         uMDQprnVkL/3qHBMM1d+bwfd/lyE/NbSpC10DIs/9oRp4pTx6UUHG3hg3/ybXjXcz/J3
         S2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/+pHTUCgsn/eJhBt7TH6g2FT5CeygqVH9py2mRcVtgU=;
        b=Xxho878vMwTtnF+r/fY/CoBBrhgoLu8Ncy4fSaC+pGU882+NlcTYBoOHKofb3PzyVA
         9RaVZy/d126/j3sP7LOO0anZyc1fV/DXyB1uqyQh5U90dUkCRBjT/mHrYUI7yKT+fwgb
         WH6UccHaPtjGnd11EiYVtfx2ib6KhlRgLBKCj9MzdIATpR5uem93zX+JN4c+CqGwMAmu
         +u7k2RPW+xgm9b/9atMI+jon7FaJI7er26SmzSllMmAnRVYsxE8HFHBMNxUQnLzTJW/T
         /L0iDjt+0SVXLIOhLTRO/9lNlZ5Q/GA/cC3aQwZ1cR4rQpOe72cKTy8shHed8tPiEHHz
         nW8A==
X-Gm-Message-State: AOAM530C8iGnyvN4nFKG/e9s8nGiEXY0jGjii8aXx0F9CNUCtloQ5PJ4
        /ugyUuQ/FVNSS5In15tLQqC2xSzk8Rg=
X-Google-Smtp-Source: ABdhPJwgH0XCE05xp40zjc/xhxlQJbkUfU9PANlGkSkJu2z1azFcs1+Gb/NyUj35uAllEoY9YBfTxw==
X-Received: by 2002:a5d:6148:: with SMTP id y8mr6400053wrt.20.1626363628730;
        Thu, 15 Jul 2021 08:40:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15sm6870322wri.39.2021.07.15.08.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:40:28 -0700 (PDT)
Message-Id: <45c0cbe44d56b7f6dbe08db5fc1d06da529f6bd5.1626363626.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
        <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 15:40:09 +0000
Subject: [PATCH v2 01/17] [GSOC] ref-filter: add obj-type check in grab
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
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
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


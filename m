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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA68FC11F66
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8952161108
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhGLLt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhGLLtw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 07:49:52 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DA3C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:03 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso14231384wmh.4
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/+pHTUCgsn/eJhBt7TH6g2FT5CeygqVH9py2mRcVtgU=;
        b=s8lbXqKgk2lpWjeDmZ+m+5sRqq/nDpFZL5bZUH8dM7XrtOTtTIHvXwrhfmO1ubXqIW
         Bw/eiobMrFuuJL6rPAzCtxRCEapV43nlXvKn2aFgHieXMe9kUCf05oougYE98l809RIx
         tiiSMliIgHxzdBm2o6MRPpsLL5I5PXG3KwQi3oAu8hHHWwU6tQBkkX263Jzg4ixFmuvk
         2NzJ679Y1aVMupWn/9usYFUuNJD+ixC4o8/tBNUVUm7OeLpXq+qwSep5DTw6qtJY88WY
         JXjB7BBcANCs9mF6cv7U3yX7XRUzeYQjf6qEMB4PQTJ8RiH1a7NmfyNDUmWFqJxlXudj
         RyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/+pHTUCgsn/eJhBt7TH6g2FT5CeygqVH9py2mRcVtgU=;
        b=Mnkq2rWvX/vwHAQutJMmYEDApceHxwJHgOO2bRCj2DsziKqzHnwuTX3EMjK8MBqDMK
         Xp2MAjRlMlX4YiIEQxiSp5Ny8uT3nzcGVNGgMN+bunSn6+FtPaEMAMejysSWhOAC3hRX
         +yHWEH4sV2kOCfTkjxwSq5BkruyGcN+vLRqvrP9Nkdn9RZ8O6hsh13SaQt1/RMxJFm6e
         n5EVNYdSLYz3Mt+uDMm5vRHS+udM04zYYgOFw3/TD/mJ0NGxwo63dTRfUHdaLMXZgu2A
         kLZOx/9E3qcGQjnVAI85scURUEbLYpANJwlyDDeSGFK2fIqrLiytQtr3IJ4mq614aE5n
         4eQg==
X-Gm-Message-State: AOAM5303BCI4BBKwaVEnfCTxUIOkACBOgzcz+QQuv4Nq4ej5T/llw6mF
        k53aX0sz5LzFykRbJ000byUcE3ljdH0=
X-Google-Smtp-Source: ABdhPJzKrST1MCnxzHoo06hkCxk1J1eUbCgAHlr/IW0+E6sIkewu/pr2d3gcv6XRMIBRS5ZCHeS9kQ==
X-Received: by 2002:a1c:a903:: with SMTP id s3mr14054827wme.58.1626090422514;
        Mon, 12 Jul 2021 04:47:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5sm14528891wrd.25.2021.07.12.04.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:47:02 -0700 (PDT)
Message-Id: <0dacc60bbcc9ae4376f58c967f43bd0c2396fd7e.1626090419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 11:46:43 +0000
Subject: [PATCH 03/19] [GSOC] ref-filter: add obj-type check in grab contents
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


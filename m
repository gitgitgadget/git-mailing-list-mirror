Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92072C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB286128A
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFVDXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 23:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFVDXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 23:23:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F01C06175F
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:20:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n7so21849937wri.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sslxU2Zj/H3zu0TbnQu1d/Mc+WxpiqXZj8t9ARAzits=;
        b=rKJUUcCDNnrpNF8i7530y/Kpy3m+1j8aytkpgyp3nDesvyK8t1gYgwC09+BZji08hE
         WhVVcqkVuiwCUgjmujFYuu19bX1w3ZDgKGkxNXW1+cjY+j0hy5egpc4eLpdeeHQvB5h5
         L0x2GyJngXioWTfq1G0fRo0bshQ4FxXAN4QpMGFI4u9M93x+qSjQqsbafoycYgTchVoq
         fwMdOMD5a2xaivZYoTgFzQAHHC85kLenWsboa8EPvgxs63+X/pQa+2TUrjs39HGELwLQ
         r4gLI0MoKgY+ZeHXYkCODkQ5JiX2h0IjnpsNtm+2TEk3qNvXZ4r93Vjp7dehHcxLA2Am
         /QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sslxU2Zj/H3zu0TbnQu1d/Mc+WxpiqXZj8t9ARAzits=;
        b=uLFkjQB1xButNh/PVJCD9V76Q8RkrPEFlHbKNp3JWEq+a7pv28Ule7l/b2J9roFRTR
         Q/4lcQG8DKMXS62aXf6l8UaUnefDM/0ZqsTI4am0lurVe+ZvuZuRUslRC/3Z4cEnm29s
         cyWF5WbMUMZcVCICti5tcXHYH3sK0xqyJisXq3ypcBW2E1dlgTc5QDuKEO2EExb9m+yE
         SClo68ErepSyjw74Q1+BFH19+dR/gEEMHE0jDA5yQYzcMbm8ztOStO1lbwj4MZe+T3Hg
         ONYJIuqLQdKMdYj9372kpHo3RCvf3DqbjZCm2iHYhsckYFdnGNTUDmuw5OEBVeG3yTPO
         P59Q==
X-Gm-Message-State: AOAM531yQhgnyF9I/jCnsSXC0KmgFHRr6gKYQ3PrrfLxUAQOQ1NRnkbs
        fUomicwClrkY2zt35KwdbMY1RH+8VLY=
X-Google-Smtp-Source: ABdhPJy2qCYP8r/b8cV3082LcAdnH6HW24aafHx8C/gh3G6fYksHJSWeEE98HnxtbKVKYEv+fig4Rw==
X-Received: by 2002:a5d:6a41:: with SMTP id t1mr1918288wrw.113.1624332056848;
        Mon, 21 Jun 2021 20:20:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6sm19250109wrz.91.2021.06.21.20.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 20:20:56 -0700 (PDT)
Message-Id: <f72ad9cc5e8b1f1139784df9ac7178f1561f70bb.1624332054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
References: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
        <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 03:20:41 +0000
Subject: [PATCH v4 01/14] [GSOC] ref-filter: add obj-type check in grab
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


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F82BC47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 09:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB180613F8
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 09:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFEJPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 05:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFEJPl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 05:15:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CE6C061766
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 02:13:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u7so6182029wrs.10
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 02:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sslxU2Zj/H3zu0TbnQu1d/Mc+WxpiqXZj8t9ARAzits=;
        b=jweztjJrAY9mpHFTYOpGgk8LHnpziYbIxArmKZRqgmLUvoQtkgMRqG7/wvAQ/noT0W
         N8jrW6GItMMA+LRYmPS1gBUE8CCsV7uSbKkjslYBmeJQxmlaTOANeQIQxA3SCPfzv1Eb
         CWeTF2wjEMGLx76uYabmf7PRmvHFvLlnb5WoC8exmCQTecWPFiYwlAKYjtMoJegOWllz
         XOwJxBl7TfGm0S01HcNmp0AP5uY/3ELhkJDyuklW9Zb5VDr4jeVo9R6aTtB9hwCBVyaS
         TSlApYfzn6diCCxsiWjtUcKaLfOFv7cRZZtxuDKXv6wGA6fO6S8RSb7RRbLJ2IR14Fev
         6Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sslxU2Zj/H3zu0TbnQu1d/Mc+WxpiqXZj8t9ARAzits=;
        b=Jl5RyKInTQcqWpszBYIy+6x0ilIxcjKxk6oi7O9to5kDArRD2HGwRjlJhqU7l4/dF5
         66YaKlkFUKidyWgsxkQhDUHMDgJkLY2bSVGGxwnOkXxcWB/juh2XBfGu3AFsr52d88Ur
         eU3MP9FarCj4Rf9Uq1e4DvS48oN6yjhxmTc5l5v0o3BY1DosOVm9DEVQ/o2oOvLjv4wj
         E/sfqfs/LKoot2NLtRwKexfheGSO0l1M0g5dWgB+mlrelFGHo7bnjDdAfnErzFseC79I
         xATltLK+Ir4cJta+9y4dzp3VBcBMqRUrfvLSjHr4cRevWnBrOPd+zdWT5utqUjNUiep9
         iHnQ==
X-Gm-Message-State: AOAM531JhZ3092i/6Yz5SAJs1kwhZ1WMfGo5TlJtFmljrVFEPKGY0lqQ
        UpiCTP6qx1+wZN7FaJXzYypyOm6pmF0=
X-Google-Smtp-Source: ABdhPJxZ9J4OFWVHTob9gr7mi6d1V5K2DRmgPe9BIsCYJ0Qn8SUMwZFpXetynKQ9ah7Q/by+36htrg==
X-Received: by 2002:a05:6000:1b8d:: with SMTP id r13mr7803781wru.207.1622884417366;
        Sat, 05 Jun 2021 02:13:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h46sm10488394wrh.44.2021.06.05.02.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 02:13:37 -0700 (PDT)
Message-Id: <48d256db5c349c1fa0615bb60d74039c78a831fd.1622884415.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.972.git.1622884415.gitgitgadget@gmail.com>
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Jun 2021 09:13:29 +0000
Subject: [PATCH 1/6] [GSOC] ref-filter: add obj-type check in grab contents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
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


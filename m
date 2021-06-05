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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B939FC47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 09:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63EB613E9
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 09:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFEJPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhFEJPn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 05:15:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE419C061787
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 02:13:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p13-20020a05600c358db029019f44afc845so6862652wmq.3
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JV5L7KQsCKZPrk0i+4kiWMmCVhVOxM0DDCMEeVCaU38=;
        b=n1/qLbKpgLLQldgI0HCpWzkkOcd4WOZ7qt7HuV6kHTLUJ7pNAGu4XqL/Hvz0ViBj16
         MosRzZpMSWh16iR1aYbeO42lLStnqC441Qk4LWgdT9M4hGQfI9yKE+fcxJXA6U6ct/ER
         jSb+jSJc/5dc3IkxtEbzGvIfQ5tIAumcTo6MV5TXi1vUrk3yPmCOX/qM+PVC+/QqK/Xr
         l5tCUPVMBp43YxBqweD+E4Ym8P/IMJOe7QGbkpWvoROUXOXbL5vens4cUNN109WNQgSo
         dYjldPbdpWVXigBJgP2NpeFgBlHd/LMz2UmE1G4OP5DZ3fK1lhgRQQxBJX1LzZdvPH3v
         1yAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JV5L7KQsCKZPrk0i+4kiWMmCVhVOxM0DDCMEeVCaU38=;
        b=RzohSpDrkfVoszrlzAg8Is3c3jCwb5ucggbFAwWBFr6HHCW/iuTiUpHmFrvhU7Ut+K
         Xtx5OhWjGkcYZzXk/iL0gfqOlOyj07wy31fVwRoSIZMNz8KPHgoftwwC7qUXgv+46UT/
         iXZjsYnL+5JsHzlIy0V4EiYuIhI3ghvgMGluUEoSyYkc88Z19H6oVImZhk3JZgG9I3hs
         4G+KmrnnlpNL06kJLmLgSRv0wSjvUeuiLp4y0HsBGQDgiHl+dExGQtRyJwufIQx9hDOr
         pkd6K/vYee1axRitrBdUrn/h08EhAREicZeZ0UT75yS+ams1BlTZ/Vf5tod/bNxJ3xdX
         WY4A==
X-Gm-Message-State: AOAM533n/g/ZTsmB87810+2yTaNxOjmuvhsbNcTrPueSt4LMdysEXtoo
        CJ9eZrhnjLil65HIBVfL6VfirP8ofbk=
X-Google-Smtp-Source: ABdhPJym03MzsE0e+UcR5+NGSnm5NGar8RHxbaNFn2n3NwdRL7m8B+kyTG8zAPt0i9kuMEaRgh73Sw==
X-Received: by 2002:a7b:c10b:: with SMTP id w11mr7447015wmi.186.1622884419427;
        Sat, 05 Jun 2021 02:13:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9sm1972262wmq.14.2021.06.05.02.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 02:13:39 -0700 (PDT)
Message-Id: <1b74d4cb85ae197f1e1ab648f6db2fe516a42436.1622884415.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.972.git.1622884415.gitgitgadget@gmail.com>
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Jun 2021 09:13:33 +0000
Subject: [PATCH 5/6] [GSOC] ref-filter: teach grab_sub_body_contents() return
 value and err
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

Teach grab_sub_body_contents() return value and err can help us
report more useful error messages when when add %(raw:textconv)
and %(raw:filter) later.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 695f6f55e3e3..a859a94aa8e0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1403,7 +1403,8 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 /* See grab_values */
-static void grab_sub_body_contents(struct atom_value *val, int deref, struct expand_data *data)
+static int grab_sub_body_contents(struct atom_value *val, int deref, struct expand_data *data,
+				  struct strbuf *err)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
@@ -1478,6 +1479,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 
 	}
 	free((void *)sigpos);
+	return 0;
 }
 
 /*
@@ -1501,33 +1503,39 @@ static void fill_missing_values(struct atom_value *val)
  * pointed at by the ref itself; otherwise it is the object the
  * ref (which is a tag) refers to.
  */
-static void grab_values(struct atom_value *val, int deref, struct object *obj, struct expand_data *data)
+static int grab_values(struct atom_value *val, int deref, struct object *obj, struct expand_data *data, struct strbuf *err)
 {
 	void *buf = data->content;
+	int ret = 0;
 
 	switch (obj->type) {
 	case OBJ_TAG:
 		grab_tag_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, data);
+		if ((ret = grab_sub_body_contents(val, deref, data, err)))
+			return ret;
 		grab_person("tagger", val, deref, buf);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, data);
+		if ((ret = grab_sub_body_contents(val, deref, data, err)))
+			return ret;
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
-		grab_sub_body_contents(val, deref, data);
+		if ((ret = grab_sub_body_contents(val, deref, data, err)))
+			return ret;
 		break;
 	case OBJ_BLOB:
 		/* grab_blob_values(val, deref, obj, buf, sz); */
-		grab_sub_body_contents(val, deref, data);
+		if ((ret = grab_sub_body_contents(val, deref, data, err)))
+			return ret;
 		break;
 	default:
 		die("Eh?  Object of type %d?", obj->type);
 	}
+	return ret;
 }
 
 static inline char *copy_advance(char *dst, const char *src)
@@ -1725,6 +1733,8 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 {
 	/* parse_object_buffer() will set eaten to 0 if free() will be needed */
 	int eaten = 1;
+	int ret = 0;
+
 	if (oi->info.contentp) {
 		/* We need to know that to use parse_object_buffer properly */
 		oi->info.sizep = &oi->size;
@@ -1745,13 +1755,13 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
 					       oid_to_hex(&oi->oid), ref->refname);
 		}
-		grab_values(ref->value, deref, *obj, oi);
+		ret = grab_values(ref->value, deref, *obj, oi, err);
 	}
 
 	grab_common_values(ref->value, deref, oi);
 	if (!eaten)
 		free(oi->content);
-	return 0;
+	return ret;
 }
 
 static void populate_worktree_map(struct hashmap *map, struct worktree **worktrees)
@@ -1805,7 +1815,7 @@ static char *get_worktree_path(const struct used_atom *atom, const struct ref_ar
 static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 {
 	struct object *obj;
-	int i;
+	int i, ret = 0;
 	struct object_info empty = OBJECT_INFO_INIT;
 
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
@@ -1961,8 +1971,8 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 
 	oi.oid = ref->objectname;
-	if (get_object(ref, 0, &obj, &oi, err))
-		return -1;
+	if ((ret = get_object(ref, 0, &obj, &oi, err)))
+		return ret;
 
 	/*
 	 * If there is no atom that wants to know about tagged
@@ -1993,9 +2003,11 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 static int get_ref_atom_value(struct ref_array_item *ref, int atom,
 			      struct atom_value **v, struct strbuf *err)
 {
+	int ret = 0;
+
 	if (!ref->value) {
-		if (populate_value(ref, err))
-			return -1;
+		if ((ret = populate_value(ref, err)))
+			return ret;
 		fill_missing_values(ref->value);
 	}
 	*v = &ref->value[atom];
@@ -2568,6 +2580,7 @@ int format_ref_array_item(struct ref_array_item *info,
 			  struct strbuf *error_buf)
 {
 	const char *cp, *sp, *ep;
+	int ret = 0;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
 
 	state.quote_style = format->quote_style;
@@ -2581,10 +2594,10 @@ int format_ref_array_item(struct ref_array_item *info,
 		if (cp < sp)
 			append_literal(cp, sp, &state);
 		pos = parse_ref_filter_atom(format, sp + 2, ep, error_buf);
-		if (pos < 0 || get_ref_atom_value(info, pos, &atomv, error_buf) ||
+		if (pos < 0 || ((ret = get_ref_atom_value(info, pos, &atomv, error_buf))) ||
 		    atomv->handler(atomv, &state, error_buf)) {
 			pop_stack_element(&state.stack);
-			return -1;
+			return ret ? ret : -1;
 		}
 	}
 	if (*cp) {
-- 
gitgitgadget


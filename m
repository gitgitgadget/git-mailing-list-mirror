Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE420C432BE
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972B6610A5
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbhHMIYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238821AbhHMIXy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D321EC0612AB
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so6380352wmi.1
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LO+D6cv0mztmNnBkCrNz6+BCjUAnRRy35krJ9OQuw/0=;
        b=KQKXJRw32eN8X+OF6+OO8+5BST9m8h5j0qtgIKjJWaPjQR1zk8xkdVKGIgOIkvBiA2
         /POPj3iFBLucpi6V2osC8RyeVIg+glfSZjobUeKUzx1nfNvw7DRH2S/LSX7c+sf76sU3
         1HoqOyEff17m7KDtmDKCnzd+OFuD7dB2U9YiKd7+aRmHRTRZDQj1dfpO2ekTUxJf+xKr
         QBV/O1LwOpZMqmMA9V2ravpRE8lDGMWXa/DyYlOytyTF+VuppT4HRwI4hnNO+BbbqwAj
         4cgJ1UvUi08SAPPmHUz3QSNJXIN+QTcKLKMnqyF5CLYMGCU0VKPRg6JM0vAYNrIwwKHK
         4Urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LO+D6cv0mztmNnBkCrNz6+BCjUAnRRy35krJ9OQuw/0=;
        b=fxVWapGv23zz9tnCfO6HaAbMf5ijsaVQsMdhE2AC1tSwfKU2ozwLbqd2XvdfDeYEkB
         8HfTOTRR3vhPwtdQmTfJSSJ3jL4AixC8y8EDAfw/swsIx3MjX0T8YWwPzgjfu+Yoidq7
         fTOQmF9yRAvHCc5CV2AqgP/GW4i6itEmt2H5JUI1g1cJD19EfZcN0vgdllmz7htsCRTI
         VHclmLrM3kHJO+rV7jj2kQ2jzclSR3nn9SDkPhgF8Q25jKNMW21IEI0XVgaRj9Pxy+Qf
         dBVct2PCY0tNzckGK3oakpXLJK+BfqH8yUfI7PV5o6CtkVf0pkV/xnHddsqyqcVG2F08
         unvQ==
X-Gm-Message-State: AOAM533u8ERNKBd2EHCbNGPJEQ6RafU3YPUSmRFCzzaGoO4Zwa2SGGo8
        5CRSxZII1lzdDrNTIIpjuo2vTPqR0uM=
X-Google-Smtp-Source: ABdhPJxFBpy1JlK55x8gTPAdGX0jOh9i2hGlIoJzgjBE2VrGfTjfM76yL/kpMYGaDIBOugS17MWDFw==
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr1419155wmj.72.1628843005504;
        Fri, 13 Aug 2021 01:23:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm728098wma.7.2021.08.13.01.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:25 -0700 (PDT)
Message-Id: <b68c00dfa5de5fae77024f4c2949a36ae2c14abd.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:23:05 +0000
Subject: [PATCH 22/27] [GSOC] ref-filter: introduction ref_filter_slopbuf
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

xstrdup("") calls strdup(""), which in glibc will
call malloc(1), this means that there will have unwanted
memory allocations.

Introduce the global one-byte array ref_filter_slopbuf,
which learn from strbuf_slopbuf. let those places which
need fill strdup("") now fill ref_filter_slopbuf. This
can reduce some unnecessary memory allocation.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 53 ++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 771804c06f0..5e00dbd993a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -25,6 +25,8 @@
 #include "hashmap.h"
 #include "strvec.h"
 
+char ref_filter_slopbuf[1];
+
 static struct ref_msg {
 	const char *gone;
 	const char *ahead;
@@ -1225,7 +1227,7 @@ static const char *copy_name(const char *buf)
 		if (!strncmp(cp, " <", 2))
 			return xmemdupz(buf, cp - buf);
 	}
-	return xstrdup("");
+	return ref_filter_slopbuf;
 }
 
 static const char *copy_email(const char *buf, struct used_atom *atom)
@@ -1233,7 +1235,7 @@ static const char *copy_email(const char *buf, struct used_atom *atom)
 	const char *email = strchr(buf, '<');
 	const char *eoemail;
 	if (!email)
-		return xstrdup("");
+		return ref_filter_slopbuf;
 	switch (atom->u.email_option.option) {
 	case EO_RAW:
 		eoemail = strchr(email, '>');
@@ -1255,7 +1257,7 @@ static const char *copy_email(const char *buf, struct used_atom *atom)
 	}
 
 	if (!eoemail)
-		return xstrdup("");
+		return ref_filter_slopbuf;
 	return xmemdupz(email, eoemail - email);
 }
 
@@ -1309,7 +1311,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	v->value = timestamp;
 	return;
  bad:
-	v->s = xstrdup("");
+	v->s = ref_filter_slopbuf;
 	v->value = 0;
 }
 
@@ -1519,7 +1521,7 @@ static void fill_missing_values(struct atom_value *val)
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct atom_value *v = &val[i];
 		if (v->s == NULL)
-			v->s = xstrdup("");
+			v->s = ref_filter_slopbuf;
 	}
 }
 
@@ -1594,7 +1596,7 @@ static const char *lstrip_ref_components(const char *refname, int len)
 		switch (*start++) {
 		case '\0':
 			free((char *)to_free);
-			return xstrdup("");
+			return ref_filter_slopbuf;
 		case '/':
 			remaining--;
 			break;
@@ -1632,7 +1634,7 @@ static const char *rstrip_ref_components(const char *refname, int len)
 		char *p = strrchr(start, '/');
 		if (p == NULL) {
 			free((char *)to_free);
-			return xstrdup("");
+			return ref_filter_slopbuf;
 		} else
 			p[0] = '\0';
 	}
@@ -1663,7 +1665,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 				       AHEAD_BEHIND_FULL) < 0) {
 			v->s = xstrdup(msgs.gone);
 		} else if (!num_ours && !num_theirs)
-			v->s = xstrdup("");
+			v->s = ref_filter_slopbuf;
 		else if (!num_ours)
 			v->s = xstrfmt_len(&v->s_size, msgs.behind, num_theirs);
 		else if (!num_theirs)
@@ -1680,7 +1682,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		if (stat_tracking_info(branch, &num_ours, &num_theirs,
 				       NULL, atom->u.remote_ref.push,
 				       AHEAD_BEHIND_FULL) < 0) {
-			v->s = xstrdup("");
+			v->s = ref_filter_slopbuf;
 			return;
 		}
 		if (!num_ours && !num_theirs)
@@ -1739,7 +1741,7 @@ char *get_head_description(void)
 static const char *get_symref(struct used_atom *atom, struct ref_array_item *ref)
 {
 	if (!ref->symref)
-		return xstrdup("");
+		return ref_filter_slopbuf;
 	else
 		return show_ref(&atom->u.refname, ref->symref);
 }
@@ -1861,7 +1863,7 @@ static char *get_worktree_path(const struct used_atom *atom, const struct ref_ar
 	e = hashmap_get(&(ref_to_worktree_map.map), &entry, ref->refname);
 
 	if (!e)
-		return xstrdup("");
+		return ref_filter_slopbuf;
 
 	lookup_result = container_of(e, struct ref_to_worktree_entry, ent);
 
@@ -1884,7 +1886,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		ref->symref = resolve_refdup(ref->refname, RESOLVE_REF_READING,
 					     NULL, NULL);
 		if (!ref->symref)
-			ref->symref = xstrdup("");
+			ref->symref = ref_filter_slopbuf;
 	}
 
 	/* Fill in specials first */
@@ -1912,7 +1914,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			if (ref->kind == FILTER_REFS_BRANCHES)
 				v->s = get_worktree_path(atom, ref);
 			else
-				v->s = xstrdup("");
+				v->s = ref_filter_slopbuf;
 			continue;
 		}
 		else if (atom_type == ATOM_SYMREF)
@@ -1922,7 +1924,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			/* only local branches may have an upstream */
 			if (!skip_prefix(ref->refname, "refs/heads/",
 					 &branch_name)) {
-				v->s = xstrdup("");
+				v->s = ref_filter_slopbuf;
 				continue;
 			}
 			branch = branch_get(branch_name);
@@ -1931,11 +1933,11 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			if (refname)
 				fill_remote_ref_details(atom, refname, branch, v);
 			else
-				v->s = xstrdup("");
+				v->s = ref_filter_slopbuf;
 			continue;
 		} else if (atom_type == ATOM_PUSH && atom->u.remote_ref.push) {
 			const char *branch_name;
-			v->s = xstrdup("");
+			v->s = ref_filter_slopbuf;
 			if (!skip_prefix(ref->refname, "refs/heads/",
 					 &branch_name))
 				continue;
@@ -1948,8 +1950,6 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				if (!refname)
 					continue;
 			}
-			/* We will definitely re-init v->s on the next line. */
-			free((char *)v->s);
 			fill_remote_ref_details(atom, refname, branch, v);
 			continue;
 		} else if (atom_type == ATOM_COLOR) {
@@ -1962,7 +1962,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			if (ref->flag & REF_ISPACKED)
 				cp = copy_advance(cp, ",packed");
 			if (cp == buf)
-				v->s = xstrdup("");
+				v->s = ref_filter_slopbuf;
 			else {
 				*cp = '\0';
 				v->s = xstrdup(buf + 1);
@@ -1979,33 +1979,33 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			continue;
 		} else if (atom_type == ATOM_ALIGN) {
 			v->handler = align_atom_handler;
-			v->s = xstrdup("");
+			v->s = ref_filter_slopbuf;
 			continue;
 		} else if (atom_type == ATOM_END) {
 			v->handler = end_atom_handler;
-			v->s = xstrdup("");
+			v->s = ref_filter_slopbuf;
 			continue;
 		} else if (atom_type == ATOM_IF) {
 			const char *s;
 			if (skip_prefix(name, "if:", &s))
 				v->s = xstrdup(s);
 			else
-				v->s = xstrdup("");
+				v->s = ref_filter_slopbuf;
 			v->handler = if_atom_handler;
 			continue;
 		} else if (atom_type == ATOM_THEN) {
 			v->handler = then_atom_handler;
-			v->s = xstrdup("");
+			v->s = ref_filter_slopbuf;
 			continue;
 		} else if (atom_type == ATOM_ELSE) {
 			v->handler = else_atom_handler;
-			v->s = xstrdup("");
+			v->s = ref_filter_slopbuf;
 			continue;
 		} else if (atom_type == ATOM_REST) {
 			if (ref->rest)
 				v->s = xstrdup(ref->rest);
 			else
-				v->s = xstrdup("");
+				v->s = ref_filter_slopbuf;
 			continue;
 		} else
 			continue;
@@ -2356,7 +2356,8 @@ void free_ref_array_item_value(struct ref_array_item *item)
 	if (item->value) {
 		int i;
 		for (i = 0; i < used_atom_cnt; i++)
-			free((char *)item->value[i].s);
+			if (item->value[i].s != ref_filter_slopbuf)
+				free((char *)item->value[i].s);
 		free(item->value);
 	}
 }
-- 
gitgitgadget


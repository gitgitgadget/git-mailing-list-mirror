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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C080C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 106ED60F39
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbhHQImW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbhHQImU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 04:42:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B66C0613CF
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k29so27376057wrd.7
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pQwHZkBnmk4qKEh1WbWdn5OKpeAhR7FE3BEP540mhCo=;
        b=FaF5idmIOlort9eO/OUrBd5MRTsLqJtF/p3A8R+OqTmcP/YqBTJm3Cs0drjfPYKEs9
         dLDyW3zOEFNdgpJHqfHsGFcAJFhI7U1VRj1jyAlGCqUEvqYRx9dCMp/sceIC3GCIoPdx
         hj7dsdZcW862sRYbtmZ0MRl8oA+Rj20ggWkoFWUPHPQbsJeIBXG/HWnp29243Ydz/3Zo
         7NyWq11IbywXM9mf5hw+q6VI9E5zRkzeZar1fgw6+zrltGlLYQnTTblSzHfPlkl9S2Hh
         e0jg0u38igweyxcg+R5tLb+dZuBWT3hTDehhetSI0ZUS35ldwRClQ51puO7MleTO8nR1
         6r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pQwHZkBnmk4qKEh1WbWdn5OKpeAhR7FE3BEP540mhCo=;
        b=UIfa+KX/8c8uwOR5kgQVDOzjK2nJFY3RzfpSgYk9X16frVkmQu9zsuUJDYNsobetQ1
         tEdSKVQluW3myBq5K9HWb3iFZjdoDPAJV2c3psLoq3Z/zinH88ZAEfTf+8SB8+kuu+Dg
         BcT2C057LQvYj9X7xaANLwXw8y5u/dT81x8pCV056KhZbf4Qu7ynJ4qRG4OLL60FvCF5
         i3cXD0aty7S+jJftG7tCLf4Zy5u6vNq/D1jL8BG4ojaTSdhoHAlolUiZdq0BXYAd9iLo
         0og30rRkxARGeBt7YLhH2uzbRlkMhCB2EZ9b2ljx6Zc3nF0rL39f7V9c8r9C+fZZp1G7
         yNcg==
X-Gm-Message-State: AOAM531d1xqabs9E1BeFLNB3jpvibwI788GeNQk2sW4Z/zmWLNnSbJJG
        Qtozt1r6folc/QvdjvrzzGyl2GWH9+o=
X-Google-Smtp-Source: ABdhPJzz4XjXwq5/FSLCQKmWtlqNBmKd9qnpjIsKdBk+t+IhpL8jztiCMhxEFQXYLjGzbTYG9Rdv8w==
X-Received: by 2002:adf:fc45:: with SMTP id e5mr2526051wrs.127.1629189705601;
        Tue, 17 Aug 2021 01:41:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i14sm1250145wmq.40.2021.08.17.01.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:41:45 -0700 (PDT)
Message-Id: <296dd2ae0119b9f465a534019089cd330afe5a2a.1629189701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
References: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 08:41:38 +0000
Subject: [PATCH 5/8] [GSOC] ref-filter: introduction ref_filter_slopbuf[1]
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

The ref-filter code uses xstrdup("") extensively to indicate null
value.

xstrdup("") calls strdup(""), which in glibc will call malloc(1),
this means using xstrdup("") will cause unnecessary memory allocation.

Introduce the global one-byte array variable ref_filter_slopbuf[1],
which learn from strbuf_slopbuf[1] in strbuf.c. Using ref_filter_slopbuf
instead of xstrdup(""), we can reduce some malloc/free overhead.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 53 ++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3784c0af57c..b74fcbb4806 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -24,6 +24,8 @@
 #include "hashmap.h"
 #include "strvec.h"
 
+static char ref_filter_slopbuf[1];
+
 static struct ref_msg {
 	const char *gone;
 	const char *ahead;
@@ -1209,7 +1211,7 @@ static const char *copy_name(const char *buf)
 		if (!strncmp(cp, " <", 2))
 			return xmemdupz(buf, cp - buf);
 	}
-	return xstrdup("");
+	return ref_filter_slopbuf;
 }
 
 static const char *copy_email(const char *buf, struct used_atom *atom)
@@ -1217,7 +1219,7 @@ static const char *copy_email(const char *buf, struct used_atom *atom)
 	const char *email = strchr(buf, '<');
 	const char *eoemail;
 	if (!email)
-		return xstrdup("");
+		return ref_filter_slopbuf;
 	switch (atom->u.email_option.option) {
 	case EO_RAW:
 		eoemail = strchr(email, '>');
@@ -1239,7 +1241,7 @@ static const char *copy_email(const char *buf, struct used_atom *atom)
 	}
 
 	if (!eoemail)
-		return xstrdup("");
+		return ref_filter_slopbuf;
 	return xmemdupz(email, eoemail - email);
 }
 
@@ -1293,7 +1295,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	v->value = timestamp;
 	return;
  bad:
-	v->s = xstrdup("");
+	v->s = ref_filter_slopbuf;
 	v->value = 0;
 }
 
@@ -1503,7 +1505,7 @@ static void fill_missing_values(struct atom_value *val)
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct atom_value *v = &val[i];
 		if (v->s == NULL)
-			v->s = xstrdup("");
+			v->s = ref_filter_slopbuf;
 	}
 }
 
@@ -1576,7 +1578,7 @@ static const char *lstrip_ref_components(const char *refname, int len)
 		switch (*start++) {
 		case '\0':
 			free((char *)to_free);
-			return xstrdup("");
+			return ref_filter_slopbuf;
 		case '/':
 			remaining--;
 			break;
@@ -1614,7 +1616,7 @@ static const char *rstrip_ref_components(const char *refname, int len)
 		char *p = strrchr(start, '/');
 		if (p == NULL) {
 			free((char *)to_free);
-			return xstrdup("");
+			return ref_filter_slopbuf;
 		} else
 			p[0] = '\0';
 	}
@@ -1645,7 +1647,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 				       AHEAD_BEHIND_FULL) < 0) {
 			v->s = xstrdup(msgs.gone);
 		} else if (!num_ours && !num_theirs)
-			v->s = xstrdup("");
+			v->s = ref_filter_slopbuf;
 		else if (!num_ours)
 			v->s = xstrfmt_len(&v->s_size, msgs.behind, num_theirs);
 		else if (!num_theirs)
@@ -1662,7 +1664,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		if (stat_tracking_info(branch, &num_ours, &num_theirs,
 				       NULL, atom->u.remote_ref.push,
 				       AHEAD_BEHIND_FULL) < 0) {
-			v->s = xstrdup("");
+			v->s = ref_filter_slopbuf;
 			return;
 		}
 		if (!num_ours && !num_theirs)
@@ -1721,7 +1723,7 @@ char *get_head_description(void)
 static const char *get_symref(struct used_atom *atom, struct ref_array_item *ref)
 {
 	if (!ref->symref)
-		return xstrdup("");
+		return ref_filter_slopbuf;
 	else
 		return show_ref(&atom->u.refname, ref->symref);
 }
@@ -1805,7 +1807,7 @@ static char *get_worktree_path(const struct used_atom *atom, const struct ref_ar
 	e = hashmap_get(&(ref_to_worktree_map.map), &entry, ref->refname);
 
 	if (!e)
-		return xstrdup("");
+		return ref_filter_slopbuf;
 
 	lookup_result = container_of(e, struct ref_to_worktree_entry, ent);
 
@@ -1827,7 +1829,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		ref->symref = resolve_refdup(ref->refname, RESOLVE_REF_READING,
 					     NULL, NULL);
 		if (!ref->symref)
-			ref->symref = xstrdup("");
+			ref->symref = ref_filter_slopbuf;
 	}
 
 	/* Fill in specials first */
@@ -1855,7 +1857,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			if (ref->kind == FILTER_REFS_BRANCHES)
 				v->s = get_worktree_path(atom, ref);
 			else
-				v->s = xstrdup("");
+				v->s = ref_filter_slopbuf;
 			continue;
 		}
 		else if (atom_type == ATOM_SYMREF)
@@ -1865,7 +1867,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			/* only local branches may have an upstream */
 			if (!skip_prefix(ref->refname, "refs/heads/",
 					 &branch_name)) {
-				v->s = xstrdup("");
+				v->s = ref_filter_slopbuf;
 				continue;
 			}
 			branch = branch_get(branch_name);
@@ -1874,11 +1876,11 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
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
@@ -1891,8 +1893,6 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				if (!refname)
 					continue;
 			}
-			/* We will definitely re-init v->s on the next line. */
-			free((char *)v->s);
 			fill_remote_ref_details(atom, refname, branch, v);
 			continue;
 		} else if (atom_type == ATOM_COLOR) {
@@ -1905,7 +1905,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			if (ref->flag & REF_ISPACKED)
 				cp = copy_advance(cp, ",packed");
 			if (cp == buf)
-				v->s = xstrdup("");
+				v->s = ref_filter_slopbuf;
 			else {
 				*cp = '\0';
 				v->s = xstrdup(buf + 1);
@@ -1922,33 +1922,33 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
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
@@ -2297,7 +2297,8 @@ static void free_array_item(struct ref_array_item *item)
 	if (item->value) {
 		int i;
 		for (i = 0; i < used_atom_cnt; i++)
-			free((char *)item->value[i].s);
+			if (item->value[i].s != ref_filter_slopbuf)
+				free((char *)item->value[i].s);
 		free(item->value);
 	}
 	free(item);
-- 
gitgitgadget


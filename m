Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2C6C4320A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB40610CC
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbhHMIYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbhHMIXz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39ABC06129D
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so4912982wma.0
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7a6J0DpiisZQGuEWyGaP2+dSaNWMzzdBN3tBLkyi3Y8=;
        b=Rie+W8JCmCWdlQb5oXeS+LVf0QxVHV2hbmhQX7Hk6XPVYGpxsNhpDDV/uIcZjDqHtO
         FOVKCkMEOFUbnbZ/wDKLD9JPUkFQch+lAMWnAdKPc/IZHoTRq//t09+/cZRq23e4npaz
         cIPV6y2zSxnvV8vX88VNCVn2BL+tk25lsUhotF2V65wRKgicnjTLUWAVwmjD1HISqU5D
         Zcjt08LSKlH5E869RKd8/O0hN0lq9svoA/XfBLUzuvO4SyMeBkHuXUKCk+3NlOxSAKZZ
         y0z++r5hhGFUw3286meVZsZB9ZE/9uqkpck9bbAn4ldhH7eUKuYYe1Mm/4Lwd42Fko6M
         3vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7a6J0DpiisZQGuEWyGaP2+dSaNWMzzdBN3tBLkyi3Y8=;
        b=RMRA9/GRWgomaNU1PrCaiQJNcymJHMevfOoEo2ZTGuWNHESmoSqhbu27DGTomBv61G
         SK3cM+BWW+1KOwKQzg/XmQIvrqm1blK0veqCk419cyn8bb88M7epQg6Ck6FUOFcN5+Wl
         opN1L8QbAX/Z299oWlknf5UqIXch64RAsPzdwoZohtRqE9zvOrASTRyrGm5GvzLqqO+A
         gi2SaxdHK6n6HPl3dLlNThrqJlyc2uOzQl67Pd8ME20cZgF6c4AiMolMbkCFJkF6RUO9
         JXMDAhsfWQis02mis/MZZ8DKp4mpUh3nHOmJdMKKXu3pCdZjbw74iRTkRmlTaCTmKvEh
         DDeA==
X-Gm-Message-State: AOAM530XIDm3vTSiuHUmrnU8s7+ADLPZVGP6l9k4oI4onFtE3hNtlolv
        ZMOj2oABu2mZT00JeJWSVG/DEHEUFU8=
X-Google-Smtp-Source: ABdhPJzNgsNZlYZWaRywSebCJh+5sCtZkaJvQG/kkD08LR1QRzZbsM07Z3T4C2BL8unQOPuSy4lYvg==
X-Received: by 2002:a1c:638a:: with SMTP id x132mr1483013wmb.146.1628843007418;
        Fri, 13 Aug 2021 01:23:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9sm686013wmc.19.2021.08.13.01.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:27 -0700 (PDT)
Message-Id: <fc87a6c84a36c0da39a419aec0edf0e40dc54474.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:23:08 +0000
Subject: [PATCH 25/27] [GSOC] ref-filter: use switch case instread of if else
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

In the original code, the check of the atom type is through
if/else conditional check, using switch/case can allow the
compiler to reduce unnecessary branch checks and increase
the readability of the code.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 163 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 109 insertions(+), 54 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index a0de5f21ff5..6fbf38f1375 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1126,9 +1126,11 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 		struct atom_value *v = &val[i];
 		if (!!deref != used_atom[i].deref)
 			continue;
-		if (atom_type == ATOM_OBJECTTYPE)
+		switch (atom_type) {
+		case ATOM_OBJECTTYPE : {
 			v->s = xstrdup(type_name(oi->type));
-		else if (atom_type == ATOM_OBJECTSIZE) {
+			break;
+		} case ATOM_OBJECTSIZE : {
 			if (used_atom[i].u.objectsize.option == O_SIZE_DISK) {
 				v->value = oi->disk_size;
 				v->s = xstrfmt_len(&v->s_size, "%"PRIuMAX, (uintmax_t)oi->disk_size);
@@ -1136,10 +1138,20 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 				v->value = oi->size;
 				v->s = xstrfmt_len(&v->s_size, "%"PRIuMAX , (uintmax_t)oi->size);
 			}
-		} else if (atom_type == ATOM_DELTABASE)
+			break;
+		}
+		case ATOM_DELTABASE: {
 			v->s = xstrdup(oid_to_hex(&oi->delta_base_oid));
-		else if (atom_type == ATOM_OBJECTNAME && deref) {
-			v->s = xstrdup(do_grab_oid("objectname", &oi->oid, &used_atom[i]));
+			break;
+		}
+		case ATOM_OBJECTNAME: {
+			if (deref)
+				v->s = xstrdup(do_grab_oid("objectname", &oi->oid, &used_atom[i]));
+			break;
+		}
+		default: {
+			break;
+		}
 		}
 	}
 }
@@ -1154,13 +1166,22 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 		enum atom_type atom_type = used_atom[i].atom_type;
 		struct atom_value *v = &val[i];
 		if (!!deref != used_atom[i].deref)
-			continue;
-		if (atom_type == ATOM_TAG)
+			break;
+		switch (atom_type) {
+		case ATOM_TAG:
 			v->s = xstrdup(tag->tag);
-		else if (atom_type == ATOM_TYPE && tag->tagged)
-			v->s = xstrdup(type_name(tag->tagged->type));
-		else if (atom_type == ATOM_OBJECT && tag->tagged)
-			v->s = xstrdup(oid_to_hex(&tag->tagged->oid));
+			break;
+		case ATOM_TYPE:
+			if (tag->tagged)
+				v->s = xstrdup(type_name(tag->tagged->type));
+			break;
+		case ATOM_OBJECT:
+			if (tag->tagged)
+				v->s = xstrdup(oid_to_hex(&tag->tagged->oid));
+			break;
+		default:
+			break;
+		}
 	}
 }
 
@@ -1175,15 +1196,17 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 		struct atom_value *v = &val[i];
 		if (!!deref != used_atom[i].deref)
 			continue;
-		if (atom_type == ATOM_TREE) {
+		switch (atom_type) {
+		case ATOM_TREE: {
 			v->s = xstrdup(do_grab_oid("tree", get_commit_tree_oid(commit), &used_atom[i]));
-			continue;
+			break;
 		}
-		if (atom_type == ATOM_NUMPARENT) {
+		case ATOM_NUMPARENT: {
 			v->value = commit_list_count(commit->parents);
 			v->s = xstrfmt_len(&v->s_size, "%lu", (unsigned long)v->value);
+			break;
 		}
-		else if (atom_type == ATOM_PARENT) {
+		case ATOM_PARENT: {
 			struct commit_list *parents;
 			struct strbuf s = STRBUF_INIT;
 			for (parents = commit->parents; parents; parents = parents->next) {
@@ -1193,6 +1216,11 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 				strbuf_addstr(&s, do_grab_oid("parent", oid, &used_atom[i]));
 			}
 			v->s = strbuf_detach(&s, NULL);
+			break;
+		}
+		default: {
+			break;
+		}
 		}
 	}
 }
@@ -1900,24 +1928,40 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		v->handler = append_atom;
 		v->atom = atom;
 
-		if (atom_type == ATOM_REFNAME)
+		switch (atom_type) {
+		case ATOM_REFNAME: {
 			refname = get_refname(atom, ref);
-		else if (atom_type == ATOM_WORKTREEPATH) {
+			if (!deref)
+				v->s = xstrdup(refname);
+			else
+				v->s = xstrfmt_len(&v->s_size, "%s^{}", refname);
+			free((char *)refname);
+			break;
+		}
+		case ATOM_WORKTREEPATH: {
 			if (ref->kind == FILTER_REFS_BRANCHES)
 				v->s = get_worktree_path(atom, ref);
 			else
 				v->s = ref_filter_slopbuf;
-			continue;
+			break;
 		}
-		else if (atom_type == ATOM_SYMREF)
+		case ATOM_SYMREF: {
 			refname = get_symref(atom, ref);
-		else if (atom_type == ATOM_UPSTREAM) {
+			if (!deref)
+				v->s = xstrdup(refname);
+			else
+				v->s = xstrfmt_len(&v->s_size, "%s^{}", refname);
+			if (refname != ref_filter_slopbuf)
+				free((char *)refname);
+			break;
+		}
+		case ATOM_UPSTREAM: {
 			const char *branch_name;
 			/* only local branches may have an upstream */
 			if (!skip_prefix(ref->refname, "refs/heads/",
 					 &branch_name)) {
 				v->s = ref_filter_slopbuf;
-				continue;
+			break;
 			}
 			branch = branch_get(branch_name);
 
@@ -1926,13 +1970,17 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				fill_remote_ref_details(atom, refname, branch, v);
 			else
 				v->s = ref_filter_slopbuf;
-			continue;
-		} else if (atom_type == ATOM_PUSH && atom->u.remote_ref.push) {
+			break;
+		}
+		case ATOM_PUSH: {
 			const char *branch_name;
+
+			if (!atom->u.remote_ref.push)
+				break;
 			v->s = ref_filter_slopbuf;
 			if (!skip_prefix(ref->refname, "refs/heads/",
 					 &branch_name))
-				continue;
+				break;
 			branch = branch_get(branch_name);
 
 			if (atom->u.remote_ref.push_remote)
@@ -1940,14 +1988,16 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			else {
 				refname = branch_get_push(branch, NULL);
 				if (!refname)
-					continue;
+					break;
 			}
 			fill_remote_ref_details(atom, refname, branch, v);
-			continue;
-		} else if (atom_type == ATOM_COLOR) {
+			break;
+		}
+		case ATOM_COLOR: {
 			v->s = xstrdup(atom->u.color);
 			continue;
-		} else if (atom_type == ATOM_FLAG) {
+		}
+		case ATOM_FLAG: {
 			char buf[256], *cp = buf;
 			if (ref->flag & REF_ISSYMREF)
 				cp = copy_advance(cp, ",symref");
@@ -1959,54 +2009,59 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				*cp = '\0';
 				v->s = xstrdup(buf + 1);
 			}
-			continue;
-		} else if (!deref && atom_type == ATOM_OBJECTNAME) {
-			   v->s = xstrdup(do_grab_oid("objectname", &ref->objectname, atom));
-			   continue;
-		} else if (atom_type == ATOM_HEAD) {
+			break;
+		}
+		case ATOM_OBJECTNAME: {
+			if (!deref)
+				v->s = xstrdup(do_grab_oid("objectname", &ref->objectname, atom));
+			break;
+		}
+		case ATOM_HEAD: {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
 				v->s = xstrdup("*");
 			else
 				v->s = xstrdup(" ");
-			continue;
-		} else if (atom_type == ATOM_ALIGN) {
+			break;
+		}
+		case ATOM_ALIGN: {
 			v->handler = align_atom_handler;
 			v->s = ref_filter_slopbuf;
-			continue;
-		} else if (atom_type == ATOM_END) {
+			break;
+		}
+		case ATOM_END: {
 			v->handler = end_atom_handler;
 			v->s = ref_filter_slopbuf;
-			continue;
-		} else if (atom_type == ATOM_IF) {
+			break;
+		}
+		case ATOM_IF: {
 			const char *s;
 			if (skip_prefix(name, "if:", &s))
 				v->s = xstrdup(s);
 			else
 				v->s = ref_filter_slopbuf;
 			v->handler = if_atom_handler;
-			continue;
-		} else if (atom_type == ATOM_THEN) {
+			break;
+		}
+		case ATOM_THEN: {
 			v->handler = then_atom_handler;
 			v->s = ref_filter_slopbuf;
-			continue;
-		} else if (atom_type == ATOM_ELSE) {
+			break;
+		}
+		case ATOM_ELSE: {
 			v->handler = else_atom_handler;
 			v->s = ref_filter_slopbuf;
-			continue;
-		} else if (atom_type == ATOM_REST) {
+			break;
+		}
+		case ATOM_REST: {
 			if (ref->rest)
 				v->s = xstrdup(ref->rest);
 			else
 				v->s = ref_filter_slopbuf;
-			continue;
-		} else
-			continue;
-
-		if (!deref)
-			v->s = xstrdup(refname);
-		else
-			v->s = xstrfmt_len(&v->s_size, "%s^{}", refname);
-		free((char *)refname);
+			break;
+		}
+		default:
+			break;
+		}
 	}
 
 	for (i = 0; i < used_atom_cnt; i++) {
-- 
gitgitgadget


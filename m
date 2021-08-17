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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81F0C43214
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB9660F39
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbhHQIm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239310AbhHQImV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 04:42:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8151C061796
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so1625047wma.0
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9bWj2PH1+S+g2cTOYfOr+HqFSWSdUzasvDRTl6U/EZk=;
        b=WQ6H75ZjEeYqNRSxFck+ktKY1nDyx61Ju6/OxHe1Y1/IyzlF0zJiuDeOUsiXNJWviz
         ghd6Fd7bGyQWD1CfYlSu2bLFM5M+stJvA4CnMWr0rDyuL1LbXmSTP91eKtweXhQT2Lf2
         IEHnnkxucS/JzX2pxcbyc6Dqd42a9rsEuusz13QEI7y64n6lJhYJOWwGSVdTL1F7yufn
         tN5o4qM6u7kz+XQ4tWIg3J6c3FB5DrMD9qoAx5JYL9+m57xVusUUId7mr+XGZREUSdt9
         zE0qqvaOdweK86j9Dpo3256hPVBREMbdO9dvNnNGjmJlWkKInB0htlWZ/cTyv9u1M84l
         PvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9bWj2PH1+S+g2cTOYfOr+HqFSWSdUzasvDRTl6U/EZk=;
        b=KWCLKLxW91ThpzOoFKNux24s/pw7ZoGXFTljf6R2FluERJ6XEUEaQMGzV5R3uQcIrb
         mFTmV5sDGiAjasVFxiexGsv+RjL5biw6WCz3e7ocrUR+6Tprh40B8dK+K0jzG5d3fD20
         Nn43GjrjMfi2mcp2yaxuHsqVmwyAjQJEAxXpFoc3v0BZwr1Vduu2DXReT/egZOWc88qe
         Pt0o6OyrsP8QMFn8Z0cIQkrgH7pjBF/nDQZcqcAHFeIDLqS5FkQfKCbSZT1PsBcOwMzM
         tz9GLErbpXqE7bkm5ddLJwSPKvnhPZOC+1NuKFBGKa+VJ5Mwv/E3pUgzw7GVmEXewmqM
         yyzg==
X-Gm-Message-State: AOAM5301SnWBKEqE8eEi7qZ9LIS1REawCvvoMkZ+ILxGhchNl4onEF3I
        27+vTvUSM6IdmSe+EzpH7wqDXc3pxR8=
X-Google-Smtp-Source: ABdhPJx4au5vOi6GuOg4zQ0BrlymN5KG6rLJrwqLV6dGOCr6v97oZjNJdxgmkIeC1ApZeL1zUVCAEw==
X-Received: by 2002:a05:600c:4fcc:: with SMTP id o12mr2194352wmq.0.1629189707377;
        Tue, 17 Aug 2021 01:41:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm1606675wmj.2.2021.08.17.01.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:41:47 -0700 (PDT)
Message-Id: <2321b873d0c0223e553492d80ced2a51d8ce7281.1629189701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
References: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 08:41:41 +0000
Subject: [PATCH 8/8] [GSOC] ref-filter: use switch/case instead of if/else
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

In the logic of ref-filter, if/else is used extensively
to check the atom type. This is because before we introduce
atom_type, the atom check is achieved through string comparison.

Using switch/case can allow the compiler to reduce unnecessary
branch checks and increase the readability of the code.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 163 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 109 insertions(+), 54 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f1c82e20e3d..c0b5d30ac57 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1110,9 +1110,11 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
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
@@ -1120,10 +1122,20 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
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
@@ -1138,13 +1150,22 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
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
 
@@ -1159,15 +1180,17 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
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
@@ -1177,6 +1200,11 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
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
@@ -1843,24 +1871,40 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
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
 
@@ -1869,13 +1913,17 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
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
@@ -1883,14 +1931,16 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
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
@@ -1902,54 +1952,59 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
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

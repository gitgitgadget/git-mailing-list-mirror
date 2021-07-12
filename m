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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04623C11F66
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07B460C3F
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhGLLuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhGLLuA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 07:50:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7608C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so14216020wmb.3
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4Ib0SWYpLaPximun7MUajcXT3GjLWT38oNkCGu16y08=;
        b=Wp91Q2ZutHEIhigywgA03dN5p+wsX3dljb+6whNxmip751D1hOJrF2Nicle1AdYUpq
         SFckHELJaVKch6WfwqZ7KB/+jdHdAVIyh+scG1zxGe81dkEXKxYPDGqIGV50zuKyf+sy
         ZBiCuHJrNvgLSZpNn6SDVb5hgImNuT1lB3PGo1n/okGdhzH88NspwJmChMuw7pS9LYLS
         wpERxtOnKfM75thswI7KgGby7gpRegeXOunQZ6i4rc7KJYYPlUjwZM4IeFasCBDgjVWE
         tCJlizb2PznMg4jFSBmXEDrjmhyrk1TYa6QkbBJX6vEGEYImgmWSlD+gk5xquoJxprZW
         Pacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4Ib0SWYpLaPximun7MUajcXT3GjLWT38oNkCGu16y08=;
        b=d4CSjIwxfLHUylZDm3cceSSVbTW69fcSdI6C3rUy4Q2JGr19MQfUSqRtLLcb6k6FHl
         I8CEc22lWdLgasAlE2dp0SFt8DsYWg6nlLaycVRlyUFBKHb2GADQUqvzxkUDtCY7GFql
         iZkZsBUWslws18dM6JbYGReow90Z6wZEm8ZNjyEbsYcC3WOEriF6C6fYxgXRnWPb4xfs
         5ORiG5zhYY7I1za758GTjyRgovF5A52qFh/jHdLqLZvUJdRUhCFRotHh6Z7yLXO5Rff0
         37LuWYHHExNjP8VNwjJWR4CjcomG/CvFVDepK5JMUomUMaXRSBpLaNFYfFtxnoZrpbA9
         Z3+g==
X-Gm-Message-State: AOAM5328hrLOW1LJd9aZYh2CR7hr/Ogda0iw/bAomi9SbE/8K8rFlmAJ
        1vP8ypP16qtr09zSYy/h3iWs2UF4bGE=
X-Google-Smtp-Source: ABdhPJzB6alkGt6JHlaY2TLQ+imo5jwNeawPtVhi0IbG/8ygam9/6WOSPbS4VF0ABdqdpGaZZZFgfg==
X-Received: by 2002:a05:600c:3644:: with SMTP id y4mr14323803wmq.85.1626090430561;
        Mon, 12 Jul 2021 04:47:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b11sm14120165wrf.43.2021.07.12.04.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:47:10 -0700 (PDT)
Message-Id: <ff74fa9f2f2fb1ea77782254da74c2d0ce6c6bb8.1626090419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 11:46:57 +0000
Subject: [PATCH 17/19] [GSOC] ref-filter: remove grab_oid() function
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

Because "atom_type == ATOM_OBJECTNAME" implies the condition
of `starts_with(name, "objectname")`, "atom_type == ATOM_TREE"
implies the condition of `starts_with(name, "tree")`, so the
check for `starts_with(name, field)` in grab_oid() is redundant.

So Remove the grab_oid() from ref-filter, to reduce repeated check.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 91e26c9aba3..1c7287f1061 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1077,16 +1077,6 @@ static const char *do_grab_oid(const char *field, const struct object_id *oid,
 	}
 }
 
-static int grab_oid(const char *name, const char *field, const struct object_id *oid,
-		    struct atom_value *v, struct used_atom *atom)
-{
-	if (starts_with(name, field)) {
-		v->s = xstrdup(do_grab_oid(field, oid, atom));
-		return 1;
-	}
-	return 0;
-}
-
 /* See grab_values */
 static void grab_common_values(struct atom_value *val, int deref, struct expand_data *oi)
 {
@@ -1112,8 +1102,9 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 			}
 		} else if (atom_type == ATOM_DELTABASE)
 			v->s = xstrdup(oid_to_hex(&oi->delta_base_oid));
-		else if (atom_type == ATOM_OBJECTNAME && deref)
-			grab_oid(name, "objectname", &oi->oid, v, &used_atom[i]);
+		else if (atom_type == ATOM_OBJECTNAME && deref) {
+			v->s = xstrdup(do_grab_oid("objectname", &oi->oid, &used_atom[i]));
+		}
 	}
 }
 
@@ -1154,9 +1145,10 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 			continue;
 		if (deref)
 			name++;
-		if (atom_type == ATOM_TREE &&
-		    grab_oid(name, "tree", get_commit_tree_oid(commit), v, &used_atom[i]))
+		if (atom_type == ATOM_TREE) {
+			v->s = xstrdup(do_grab_oid("tree", get_commit_tree_oid(commit), &used_atom[i]));
 			continue;
+		}
 		if (atom_type == ATOM_NUMPARENT) {
 			v->value = commit_list_count(commit->parents);
 			v->s = xstrfmt("%lu", (unsigned long)v->value);
@@ -1959,9 +1951,9 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && atom_type == ATOM_OBJECTNAME &&
-			   grab_oid(name, "objectname", &ref->objectname, v, atom)) {
-				continue;
+		} else if (!deref && atom_type == ATOM_OBJECTNAME) {
+			   v->s = xstrdup(do_grab_oid("objectname", &ref->objectname, atom));
+			   continue;
 		} else if (atom_type == ATOM_HEAD) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
 				v->s = xstrdup("*");
-- 
gitgitgadget


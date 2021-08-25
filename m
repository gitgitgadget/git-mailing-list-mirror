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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE2DC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F39561178
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbhHYJJv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 05:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239551AbhHYJJo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 05:09:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CE4C0613CF
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 02:08:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso4053518wmi.5
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 02:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lpQhvxlL0QcXxpdG+yUKOp+FwwcDEMJUHfGIZGJpidQ=;
        b=f2mdwxi3RsVFns5oGRe4H3X3pCK5b0s0dwGzUDBqNU+A7OAnaxlinVntJiOxX48upE
         /vJp7YX5AcuX7vk65lo6QBz6wc/qWWQx+zH2PChRfRmbCXLgnWR1TeoJI+uwmh/KG/xu
         EDoZGukU9myAhtdWW3oIGYWK7A9kHj9u2G1dZfIoIPw1xuJ8fheA5rVDGxl3dga3C02N
         NCR+T/pmBBjXg2yQ2TBRE99kB+ethD5L3gtNqk1gvelUSBuKOajsIJVjGi7rqayYh8f7
         KvO3mDSSkUU9ITXtyelTRYi8k/7ja81VtlnFApRMpxS5/kVIuj3SpnqS8KtNEtUzDBQ6
         URqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lpQhvxlL0QcXxpdG+yUKOp+FwwcDEMJUHfGIZGJpidQ=;
        b=QNHeKGVDioBqX08ISIZDmw5LZOIiTpBhZXwUAdP6AALPH7VZdKlV58CaY8gwcikuag
         nZCyhikD8d7+Z8+JoLiEdqc1LSo2CRfykbNmrQYX3gwKfB6PtYBtFMyNddxCQAXbJNqC
         6ijjhRQaSahAMiQQKw1rO6ke56KmrPaeM6BXbdOq86QFVMTbhdmP4e8soK5+RbepAwCH
         SsW51NN5wf8yWBerdH9xUSy/xm5kt8xYBDIpcKVxtsdmeLhz6VxLUHFay0TmD57g57QV
         v8nh2gGgqZ1AItfqUwpWLBebYjctYsYkp/55vB1/rsM+dyG2KoTvnLeWWewT+c+3WOBD
         kG4Q==
X-Gm-Message-State: AOAM533HGpoJUQAj7KJhVG+aH12/PzgdSudANZ4Df/e1I5HAZsmmRgtS
        BJ9BiLPpioZ3I3aYuzya2tucG6rrPSo=
X-Google-Smtp-Source: ABdhPJzPhndRFOUO61RphkBwV3cB1WIuRMKU4b0U0z59lVufJgLwnnxpEStuWMB+K/+H0n742saKhA==
X-Received: by 2002:a05:600c:4ba3:: with SMTP id e35mr8233681wmp.130.1629882537048;
        Wed, 25 Aug 2021 02:08:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17sm4502822wmp.13.2021.08.25.02.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 02:08:56 -0700 (PDT)
Message-Id: <63758a71e4001aa0a09d64a2c61f8c8b256c480a.1629882532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1025.git.1629882532.gitgitgadget@gmail.com>
References: <pull.1025.git.1629882532.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Aug 2021 09:08:50 +0000
Subject: [PATCH 6/8] [GSOC] ref-filter: remove grab_oid() function
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

Because "atom_type == ATOM_OBJECTNAME" implies the condition
of `starts_with(name, "objectname")`, "atom_type == ATOM_TREE"
implies the condition of `starts_with(name, "tree")`, so the
check for `starts_with(name, field)` in grab_oid() is redundant.

Remove the grab_oid() from ref-filter, to reduce repeated check.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8dca273f720..67f62a3b591 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1071,16 +1071,6 @@ static const char *do_grab_oid(const char *field, const struct object_id *oid,
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
@@ -1106,8 +1096,9 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
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
 
@@ -1148,9 +1139,10 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
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
@@ -1923,9 +1915,9 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
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


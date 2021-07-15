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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB66C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19828613DB
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbhGOPnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbhGOPnc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 11:43:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB6EC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso3965855wmj.0
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4Ib0SWYpLaPximun7MUajcXT3GjLWT38oNkCGu16y08=;
        b=kkXc34dA2A4B4rvRIldrPJLWemUemgJzWlgV1nehTuA0MKeT8nyQ/FEUpcZ1lD/ho4
         7UTkbsZW5+hsXPQD9INj8+s1GgVsyiiQhmuJ6vKvpkHfUsl43Z7w8S69/wsIliuf5eob
         9Px9dwAXb4NQXh96o2ETRHFv/1CoJ+KROeLZz69PUJ7tqXjG5hQl7VQjvbCOHiDNZIDi
         BEo1HbMh2MiljCMVmxIsgZSuiXeD528SBP3cW+qwk/Y8FdOcmOHVFXhYNndezdB2+b0v
         sRGOiiIR4o+RAOTQMGj46AOXkWccvepTYfApleDUz5aFRjvuetP6xzb3UibvwgYXhNI7
         kVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4Ib0SWYpLaPximun7MUajcXT3GjLWT38oNkCGu16y08=;
        b=jMMay2hIpgB+5jqcurOQ6B8Alirf8QmnxlStK7AKjxhrhsMcTg5Opx8yw2NQd/Wvnh
         PxilGfaj18Kp42kgUBAatGwqIbliRWniDzFhu9wyqllEM7XNlqqlKAmj7agdX9ifeI8x
         BFmAXdlfitHiEblV2Sejd3WdPtu4S/0DaKYNiD4EknWSLx5qDvm0v/UPjyJNtCxPlvSO
         AlNyH/BgwoZFwc4P13/pAdh/XET0DhGgnUU+UmNUR0BVx9C8WOGmfdMmjj8KHKkJPmr4
         oyec76NVJ1pbNiGDdQM3hHrghvItUZLiBOkygZwG5S/i96GO9SgaGveih4yJMO7EytNV
         CI+g==
X-Gm-Message-State: AOAM533MTqpObPwPZ/BvPZ9fICZw9wKBLq+EcbaHesnc+rzA9F+x8Ggt
        wfJ81uKBZ9AQXpkL24UuPoOThPQiXG4=
X-Google-Smtp-Source: ABdhPJw9OHMl4+mKCyXabEotdiYgO1DY3qQvWNR2G+ic+NwJJDk4WM1lNzahht/7yuTgbNWvOfOvWw==
X-Received: by 2002:a7b:c30f:: with SMTP id k15mr11347905wmj.128.1626363638144;
        Thu, 15 Jul 2021 08:40:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm6953548wru.95.2021.07.15.08.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:40:37 -0700 (PDT)
Message-Id: <96ef6431a2b64bbf15a9fbe7755dc3e882db072e.1626363626.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
        <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 15:40:24 +0000
Subject: [PATCH v2 16/17] [GSOC] ref-filter: remove grab_oid() function
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


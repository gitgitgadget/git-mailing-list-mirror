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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BA5C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF3061416
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhGAQLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhGAQK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:10:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF65C0613DB
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 09:08:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o22so4909505wms.0
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5ITrPb59JYnXOBip2Mfl5gdpEcDZXZOW9cu3U4epO2Y=;
        b=i36P1x/whCdvXw4fEoUVaJJ7AO+Cs4C9qQnyIWjJ1VUQwQbYkie0Cu7Hilm2i2FPsh
         wupVZQ7BrFvMxw5obdedUb/7iLjemsfd26UHzW5IyIkuVeo8Dvv3feZK1BaziWR66RAB
         RQEZBwiFPnZNHz5Hia0DL1HkbOnQjARgUASboUoLOanngsL6/dodjhbWJZRhwmVs5fBD
         6z+/Pn4KBeVUewXx9sMVCdRAM4qPVRkzi1urpL0jJJiwZV+rwX2QTp6clk8asbNlkypq
         vip5+Ko4Er9ytPkJnXbyE7GkTKvihWukJqJMwI8RXFWreb2PWB/Te3ELmNzHSwE6WLHS
         0qOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5ITrPb59JYnXOBip2Mfl5gdpEcDZXZOW9cu3U4epO2Y=;
        b=YRhwwXWTv9/NSp10pYTrQagcT3u3qWlP7cToV5esolymIJWsF+hcPBwDLpH/Zv3Ikl
         L1qecp4dsecUwKdLYhWGtVfCZS3diuUCyTogUnmeK26oZ+llfKkQn27O3LtjBF9hS4Bo
         jBiHFfettQkGcUx9pm5fPb65f1gBiqqbCIf+fTVfemIEC1goxT907GwWRkLBfZ+tsBKU
         UMWz0/ewU22ygYxgWEqGSDOhFdnDLAQl2k0mS8/t6WdMO3YBSO+fL6dJL8z3wQAUrl7y
         AblFGGcRsaaYQ0YShdB9fG0gNV0rufm4/LijeHAZNj1lLYlp8Kc6RETOeU0X+5yFHcuq
         b8PA==
X-Gm-Message-State: AOAM532wHWt3PPsZrUgoHdLNPIh1HKvCNcu/rBtLXc0sPRT+gT9ucmtz
        Hr8A9I5NCLu5NtnlhgUenoG1Yo6Kc9s=
X-Google-Smtp-Source: ABdhPJwirxmEgz2G5L+b3jWrFy20Ex+AHkE6AH9UtUIJR27oZxH6j4j7ZZNCrKsATIDy42tApNgAUg==
X-Received: by 2002:a1c:25c6:: with SMTP id l189mr11944270wml.49.1625155704035;
        Thu, 01 Jul 2021 09:08:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z24sm390754wml.10.2021.07.01.09.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:08:23 -0700 (PDT)
Message-Id: <117e195fe5d64110fc0f03e87b839b8517e67f12.1625155693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.989.git.1625155693.gitgitgadget@gmail.com>
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 16:08:13 +0000
Subject: [PATCH 15/15] [GSOC] ref-filter: remove grab_oid() function
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
index 427552b8108..55bff4ed9e7 100644
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
@@ -1971,9 +1963,9 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
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

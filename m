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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9717DC48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81FDC61C23
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhF0Mii (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 08:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhF0Mi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 08:38:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B77C0617A8
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:36:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso9101790wmj.0
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5ITrPb59JYnXOBip2Mfl5gdpEcDZXZOW9cu3U4epO2Y=;
        b=ijEBjyXQ5aQEDoEGtzUJpFjGnwNQCNE2hyvrAFQ1j6VGSXOeTuMEOE+IXJnwAyfxHK
         YR9bdU2rU7qjCgAyFKLB9AjAZjJ24TPy1FkvAsiNKzQNotC2U6vW5t9+HjQI1Dq0gK8d
         gfk77bwt4VFbcZxnxsjZCuQkgijTj8PGH04BFBYcTGdEda/S3RV2Wbi4CdBVBhd93ucy
         MD8m0X/vpeWqHRTDQYPKYUjghtvN+i3cevLaMNmPPS+cyz5BNrExgITbs4aPgCilwgUM
         aCI1ZkbaJbDncYO6TJwA62fUqhG5Fa3fGKUzFahD+X/KmG+zoPZ1f/RGwPFJMYWITEH+
         uG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5ITrPb59JYnXOBip2Mfl5gdpEcDZXZOW9cu3U4epO2Y=;
        b=h14TfRFKi/SS5uGpjiOqf91jjS7cr2Gsgrw2ADIvS2Uw21QxgGZ12QYvfZjxE121MZ
         MOUIgz00UJYNVIBi7faPc4a47h2ka5WqPB5K+6ybPItHPfCo2gQHV+CTKKgPIC1A7it4
         eRNbGxwp1WZmzwL++FDOZ0OKp5RmqlVoBjBt/FURuieDslGChIT6XywsJPn1ySwWMnpx
         a1IRO4T94wVfS/tYZN03hgVCQWKXxTRmah3j8X6dMtydZCHgVAtsemSMd/HiWigC30Cw
         ABEBzO9g1exGfXcnVZZII3fqiop8r7tCxVJuXTE4uMl9bgJjbGX7vi5Y/lXkUYsLvD5Z
         yrpg==
X-Gm-Message-State: AOAM5300lvUTcpiXKd+RsV2OJNvsEyDmKYQv+E+8zWP3sTkx/MdVqa2N
        rM986bOeQ83KsxCCNnOCZtL36rFiptU=
X-Google-Smtp-Source: ABdhPJxlkqXt3FBaPcbaLQuh8IpSCloAz5dijExS/HvkBQQhYQMRqQ70WLC1ibb0YCqZHaGleR9YLw==
X-Received: by 2002:a05:600c:3b1e:: with SMTP id m30mr21119653wms.162.1624797361478;
        Sun, 27 Jun 2021 05:36:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm10215484wmb.35.2021.06.27.05.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 05:36:01 -0700 (PDT)
Message-Id: <891d62fd93f795219518d85aaf0cd50c84d7c652.1624797351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
References: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
        <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Jun 2021 12:35:50 +0000
Subject: [PATCH v6 15/15] [GSOC] ref-filter: remove grab_oid() function
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

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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ECFC432BE
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6DF6109E
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbhHMIYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbhHMIXv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:51 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5A7C0612A3
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so2933132wml.3
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sEKGboegygc9+Zf9rgcLf6+DcBSR9uC6Y122z9iM3lY=;
        b=UGnEoSCMdwOwwcsyZKvS0u8BWX7Bis93kZ1DYodywHBX8axWZLps1Hq403/cZNJSfD
         rZ5v0Khf2ht1JlYQVfiYJpXY4ONmGHTo88ZsxBXTghLil6EKnUcvyKA+3qHllGMLHGOg
         us17tR8bcSY4IT13TZFn8fBoOgbq7nyr9caHXDpXofNZpzdDrpuewdsItAxdBQrusxoy
         KdBzN6pCn3m1zOMLSp4D3nXNDFXR4bdlhDHPUIsCia8V8EN+ifkoREX3w+/BHqgB9adf
         yTcm/2oQ13qRo9FMofRE761oODr5xSBKsTi+r8kZRovECh7Q0LSybto0B6TW4fqi2Dtj
         9FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sEKGboegygc9+Zf9rgcLf6+DcBSR9uC6Y122z9iM3lY=;
        b=OGFOWvfG0mRdfZbun4wEizjWZmct0sWirHnJb/+EKM+y+sBXITPbYRw1l4HejxlMBt
         zRGMdXi3AWBF0DpsklnVenNQlflFVZH77p/qalTo87s0JVC8pB43BLG+oDrTYUbwA04y
         rPlsGrlejtQD1aWBojq/qC4kHbPVXWAQBi26EfOMCAvu33AUmYIuyIWLQ+V1Be2Y+Sx7
         WSHeARoTAqcX94L59eXz8BaOVyueXH5X6O016ARp9M9kqyErjGMnqxCPH9nWpqA5xalT
         w2I3Wb1Lig9njktUpIVdLQLb/StwP6xN9X7ixZ1/bq114kMqF+d8o8u/m63zaqc3lOf+
         OkoQ==
X-Gm-Message-State: AOAM5317RHN6z3kNqo/qLVzdLruFDDFiwmKVil2e942DfhWAUUZ6Yr5V
        X+I1Zkk+T8R4tKP7nFArZR1XQ7rrvcs=
X-Google-Smtp-Source: ABdhPJzURhI3hy6hZqLQSjaK9kUVUrC5B1GD4oxSKDEDxxf5rrkSbWxNdv5Ry+StJhb0J9jR3+BIaw==
X-Received: by 2002:a05:600c:1c9c:: with SMTP id k28mr1512169wms.148.1628843003106;
        Fri, 13 Aug 2021 01:23:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6sm800757wrm.73.2021.08.13.01.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:22 -0700 (PDT)
Message-Id: <a908402fb520c88d5b99294926b8687a1a53015a.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:23:01 +0000
Subject: [PATCH 18/27] [GSOC] ref-filter: use atom_type and merge two for loop
 in grab_person
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

grab_person() uses string for atom type comparison, this is very
inefficient, we can use atom_type to replace it. At the same time,
we can merge the two for loops in grab_person() into one, this can
reduce unnecessary traversal of the used_atom list.

With this patch, `git cat-file --batch` has a 2% performance
improvement.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 57 +++++++++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 39 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1251e062ff8..3ccb531e073 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1307,63 +1307,42 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 }
 
 /* See grab_values */
-static void grab_person(const char *who, struct atom_value *val, int deref, void *buf)
+static void grab_person(enum atom_type type, struct atom_value *val, int deref, void *buf)
 {
 	int i;
+	const char *who = valid_atom[type].name;
 	int wholen = strlen(who);
 	const char *wholine = NULL;
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i].name;
+		enum atom_type atom_type = used_atom[i].atom_type;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
 			name++;
-		if (strncmp(who, name, wholen))
-			continue;
-		if (name[wholen] != 0 &&
-		    strcmp(name + wholen, "name") &&
-		    !starts_with(name + wholen, "email") &&
-		    !starts_with(name + wholen, "date"))
+		if ((atom_type < type || atom_type > type + 3) &&
+		    /*
+		    * For a tag or a commit object, if "creator" or "creatordate" is
+		    * requested, do something special.
+		    */
+		    ((atom_type != ATOM_CREATOR && atom_type != ATOM_CREATORDATE) ||
+		     ((atom_type == ATOM_CREATOR || atom_type == ATOM_CREATORDATE) &&
+		      type != ATOM_TAGGER && type != ATOM_COMMITTER)))
 			continue;
 		if (!wholine)
 			wholine = find_wholine(who, wholen, buf);
 		if (!wholine)
 			return; /* no point looking for it */
-		if (name[wholen] == 0)
+		if (atom_type == type || atom_type == ATOM_CREATOR)
 			v->s = copy_line(wholine);
-		else if (!strcmp(name + wholen, "name"))
+		else if (atom_type == type + 1)
 			v->s = copy_name(wholine);
-		else if (starts_with(name + wholen, "email"))
+		else if (atom_type == type + 2)
 			v->s = copy_email(wholine, &used_atom[i]);
-		else if (starts_with(name + wholen, "date"))
-			grab_date(wholine, v, name);
-	}
-
-	/*
-	 * For a tag or a commit object, if "creator" or "creatordate" is
-	 * requested, do something special.
-	 */
-	if (strcmp(who, "tagger") && strcmp(who, "committer"))
-		return; /* "author" for commit object is not wanted */
-	if (!wholine)
-		wholine = find_wholine(who, wholen, buf);
-	if (!wholine)
-		return;
-	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i].name;
-		enum atom_type atom_type = used_atom[i].atom_type;
-		struct atom_value *v = &val[i];
-		if (!!deref != (*name == '*'))
-			continue;
-		if (deref)
-			name++;
-
-		if (atom_type == ATOM_CREATORDATE)
+		else if (atom_type == type + 3 || atom_type == ATOM_CREATORDATE)
 			grab_date(wholine, v, name);
-		else if (atom_type == ATOM_CREATOR)
-			v->s = copy_line(wholine);
 	}
 }
 
@@ -1553,14 +1532,14 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
 		if (obj)
 			grab_tag_values(val, deref, obj);
 		grab_sub_body_contents(val, deref, data);
-		grab_person("tagger", val, deref, buf);
+		grab_person(ATOM_TAGGER, val, deref, buf);
 		break;
 	case OBJ_COMMIT:
 		if (obj)
 			grab_commit_values(val, deref, obj);
 		grab_sub_body_contents(val, deref, data);
-		grab_person("author", val, deref, buf);
-		grab_person("committer", val, deref, buf);
+		grab_person(ATOM_AUTHOR, val, deref, buf);
+		grab_person(ATOM_COMMITTER, val, deref, buf);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
-- 
gitgitgadget


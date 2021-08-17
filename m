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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B81C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13B560FA0
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbhHQImS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239336AbhHQImR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 04:42:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD86EC061796
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q10so27424501wro.2
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R8s6iduAzpHv2zHqb74v5m/FmCTqBSmo4RcXr5WjrbM=;
        b=vdFWcwLaG4UUDFKllIwOQ9K74PD6zq1SATBDWS27+rkn9Hi7oMuxdy0kFk5qFa7guW
         j66iq7+UDWX/9MM0MbI/1hRdIim0U/9lFcRYUOAy2v/MhSAU61IYqzKd7Mj/uIVBaDT/
         Yv0HqqDhmFVBOycM4QrzMmcFFk2fyAUvfADwWsQIqS5Vnsh7Bc6WaGD7zd8NMOGmN/c7
         9HljK8ER2SIWZyJ59v4EsbtRZwVUO3mwwToLsKh/13n3hjo/hg6TNNdJwHOwzuOglZwx
         jwhtu80NQWOlvpWHDqI7gEWtInB4hDUGKW3RxJHC4puqEppt8DtiCKKgnHH/fnHNtU2x
         qX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R8s6iduAzpHv2zHqb74v5m/FmCTqBSmo4RcXr5WjrbM=;
        b=g90xo+pjFgG+TjZuvRtRNZznLHdbhAX4ZDOZsUWB6roiKMvpGNZTQxTeemtZAoJvne
         SyHvAJ5BgGqGV4HtNSPASulhEKBpmB4DzPouy03RjIFwUWwNrlMrVfvOTyRSSvxjK9EQ
         eyEsWzfyl8BmjjZzGR98mAXy1W/hJgP4juwH8cqWYChoKKxPot28/YevqScL8mU2wzdR
         qQ5qWU8GscpuJ4gieApEjOQeJFJEJPIKKRS8YT/BYEF5UMhJpZWi1vHXQgneu0a9zDeX
         8amAc1sc4DZf3ISEVulYD+nIeIQCGGdq7VVsHaka66U4/2HWS90B8L4Kaj+NTajWWXdL
         DKGQ==
X-Gm-Message-State: AOAM533Coo3enOQA2pfQCaBqixEkBJvR8sbO03JHJiWI9ELjLzvySeas
        9c6lUoeuXdzTOXZtgyDh3OPTO8u0GmI=
X-Google-Smtp-Source: ABdhPJwGnFfvQSN4mWUblp2JUqZbaD+Y/sBuH+QOlPBXkd5pqtrCwf2/RSDhmW3uJpXghDI9Z9O/Lg==
X-Received: by 2002:adf:9d86:: with SMTP id p6mr2644866wre.156.1629189703459;
        Tue, 17 Aug 2021 01:41:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm1652381wrt.24.2021.08.17.01.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:41:43 -0700 (PDT)
Message-Id: <9ff78d17f3839acd24df5439fac74ba5064579c8.1629189701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
References: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 08:41:35 +0000
Subject: [PATCH 2/8] [GSOC] ref-filter: merge two for loop in grab_person
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
inefficient. After the introduction of atom_type, we can use
atom_type to represent the atom type.

So modify the parameter type of grab_person() to atom_type,
and take use of the characteristics of ATOM_AUTHOR ==
ATOM_AUTHORNAME - 1 == ATOM_AUTHOREMAIL - 2 ==
ATOM_AUTHORDATE - 3 to check which author atom type is.
ATOM_COMMITTER, ATOM_TAGGER are same too.

At the same time, merge the for loop which handles %(creator*) in
grab_person() into the previous for loop which handles %(author*),
%(committer*),%(tagger*). This can reduce unnecessary traversal
of the used_atom list.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 57 +++++++++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 39 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e38046ca141..592b8d9bd0a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1275,63 +1275,42 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
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
 
@@ -1520,13 +1499,13 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
 	case OBJ_TAG:
 		grab_tag_values(val, deref, obj);
 		grab_sub_body_contents(val, deref, data);
-		grab_person("tagger", val, deref, buf);
+		grab_person(ATOM_TAGGER, val, deref, buf);
 		break;
 	case OBJ_COMMIT:
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


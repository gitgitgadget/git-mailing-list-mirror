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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F7FC49EAF
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF41F61969
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFYQFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhFYQFA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 12:05:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC424C061787
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso6202002wmj.0
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wzxPQDRwRGk2/Nmy4hWXIToRWnXsdBb3MWMALKink7A=;
        b=rfRoK/gGI/qlNpf+aj2lSGsjxIPAmfvNQWQ/0DqH1Boz1poXbPLGzPlbNTChMYZzOZ
         q1HwntlENYQ1OcKSoFiDmWOVua7raBBP8a+sS0JOVlx172QyBDh1JA+bdb8CQradyr+s
         UvsE3i3W6/n8PlnVWY3k7Tn/VLvz4RiD0mg5QNRLMuVPiqi3OQL+qOOp6pZJC6iBEgBF
         bM8XJAqgcXdlylWxt88C9q6SWjz/jEwQEMr8SeoVy+VgTqsM0AP9Sdy9fig2Gs+FDsxP
         H7eo8XPDW6tdJYqqCwW0V+oDwSwpusLX2oeGr4m3mcNcDv3CF6gPCH+0SzjQzdP+AO9d
         asZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wzxPQDRwRGk2/Nmy4hWXIToRWnXsdBb3MWMALKink7A=;
        b=BT862XEUitm4Sq/qiFsVvV1bOzEcoQJUfb3z9SHOA1OuH7BA8GGZqzhKBMmdnr02Wt
         h1jDhqPWMNfsEDccpOISAFbmppACTTAeSIpuSENY4aFmWo4UY7V8ggNJDV1vJXfW9h/d
         wYPk2G8iI2nb3cXjUeMr5L0WyVoc/6lt+tXQEUUV6aS6FDmXcI2bn9gIE1CgqDd88qG2
         QRIaORaCKAw7ZkU7WOhUfEwG3TCvgc45t3KK6joVF7dVcIvcWczlu3NJmJ2HAfUcLRKF
         MoDNXZ/5rvnIBeZO8QaZ1sYIOIz3HeHlW+pveU+IPiebK6rzxqkza795eqwv6xBUwAzh
         H3nA==
X-Gm-Message-State: AOAM533eoi+wHKANNL86n6jmopzCZ2ruUNzkwiOSK6qZ0idT7qu+b6vz
        YLIT2tPku7aBK1Yyh7cyksv7Z6wUPwo=
X-Google-Smtp-Source: ABdhPJw4J1cVvtmBoEhMxX+/8/jwzmri3mWv8PbzbZ2VUnlQ6XvQCHs3NZNKqfzWZTeFJNRXkW+jAg==
X-Received: by 2002:a1c:730d:: with SMTP id d13mr11786308wmb.129.1624636957237;
        Fri, 25 Jun 2021 09:02:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm4357640wms.20.2021.06.25.09.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:02:36 -0700 (PDT)
Message-Id: <843de8864a9fa0b89b5dede0d24a982959b0ad1a.1624636945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
        <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Jun 2021 16:02:25 +0000
Subject: [PATCH v5 15/15] [GSOC] ref-filter: remove grab_oid() function
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
index 99b87742b0f..ab53c1fd22f 100644
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

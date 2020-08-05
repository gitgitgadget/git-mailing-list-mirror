Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64A5C433E1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951FD206F6
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inhKOB2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgHEVwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgHEVvy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:51:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1385BC061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 14:51:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q76so7756196wme.4
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y/VnjvghSksd9o7DTiGkVg7LSzd8v4R354PReIpNDDk=;
        b=inhKOB2EzwX8hg7diggS9LUoYxeTtPfPXFJcmgKmJw+PMOwk1Cwgr+UZ58vVwNScEP
         rYWooqoDcrsCJ2SSoULyrguUd1OkF2fd3iNXKmSiRqfG7vfXjSCUhUGV/AuxlLux0puf
         Z7ZLVxhE+P8kdyJhHGZjI7qK7cWxernBEDMkTIcjrsJhV2JUMfjshfuKhsEeZ78I6Onp
         gmbhtVtrIyyo/2yoI1h723S/Dv7VgKDJnAy8lmYL8HL46CMZ87Q2AdwXedt8KTp+j6Cx
         3xYfV5kcSommtRm8ovwtMAe02vNM3bUmIZhslwFxqScKFNpFHVRIv0SszAtVAIKKryzx
         rdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y/VnjvghSksd9o7DTiGkVg7LSzd8v4R354PReIpNDDk=;
        b=t+awsSfDe767ESZ0N625a/5NDX3EC1mtD+4ijQ46rD87dEX4X1PYQCEmx+PCk6dkMX
         ukFFGXLtV9aGWXwssvnGsmDXcQ542UjJncbIfuskhzrA+RtJMk3iFOxUEbOzhbSBd0b2
         KHLb7gKIda6+qhFFl5psj4gdBSR8pvFa753RZnoRwW9+XGJu8wF63PZaddWV6FJikR+L
         INrpb73jwPPyXJHGCW4tNxza1WIxD1WNJG8eGsX/5IvXIPwclrpp2/U7bL4l1gfzPP91
         T0FYNpmJpKgQ88U3GckPmB+q4m6CQwEt9DoEJMhBl1DA2unZVuOZFObd63bOxgQQcqq9
         wphA==
X-Gm-Message-State: AOAM533IqretAD4xk66Ocqgo5vc2wfMHGg9a9kB/hD9gBeDRQvlNCbyE
        MyaKW0qipVLHa1/d/pR8xbxMDlBF
X-Google-Smtp-Source: ABdhPJzIJW8cQHlbkFko39NA2QXQ8G44kEPw7uPMkO3sSnfYsXBczhUiYH8g1Wwn8DoCIakzxGEPOw==
X-Received: by 2002:a7b:cbd0:: with SMTP id n16mr4998050wmi.123.1596664312019;
        Wed, 05 Aug 2020 14:51:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm4460961wrq.9.2020.08.05.14.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:51:51 -0700 (PDT)
Message-Id: <976f2041a41a6b2043c1bece262cb0a3f7a8af35.1596664306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
        <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 21:51:40 +0000
Subject: [PATCH v2 4/9] ref-filter: rename `objectname` related functions and
 fields
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

In previous commits, we prepared some `objectname` related functions
for more generic usage, so that these functions can be used for `tree`
and `parent` atom.

But the name of some functions and fields may mislead someone.
For ex: function `objectname_atom_parser()` implies that it is
for atom `objectname`.

Let's rename all such functions and fields.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 ref-filter.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 4183ee2797..cc544eadaf 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -139,7 +139,7 @@ static struct used_atom {
 		struct {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
 			unsigned int length;
-		} objectname;
+		} oid;
 		struct email_option {
 			enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
 		} email_option;
@@ -361,20 +361,20 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
 	return 0;
 }
 
-static int objectname_atom_parser(const struct ref_format *format, struct used_atom *atom,
-				  const char *arg, struct strbuf *err)
+static int oid_atom_parser(const struct ref_format *format, struct used_atom *atom,
+			   const char *arg, struct strbuf *err)
 {
 	if (!arg)
-		atom->u.objectname.option = O_FULL;
+		atom->u.oid.option = O_FULL;
 	else if (!strcmp(arg, "short"))
-		atom->u.objectname.option = O_SHORT;
+		atom->u.oid.option = O_SHORT;
 	else if (skip_prefix(arg, "short=", &arg)) {
-		atom->u.objectname.option = O_LENGTH;
-		if (strtoul_ui(arg, 10, &atom->u.objectname.length) ||
-		    atom->u.objectname.length == 0)
+		atom->u.oid.option = O_LENGTH;
+		if (strtoul_ui(arg, 10, &atom->u.oid.length) ||
+		    atom->u.oid.length == 0)
 			return strbuf_addf_ret(err, -1, _("positive value expected '%s' in %%(%s)"), arg, atom->name);
-		if (atom->u.objectname.length < MINIMUM_ABBREV)
-			atom->u.objectname.length = MINIMUM_ABBREV;
+		if (atom->u.oid.length < MINIMUM_ABBREV)
+			atom->u.oid.length = MINIMUM_ABBREV;
 	} else
 		return strbuf_addf_ret(err, -1, _("unrecognized argument '%s' in %%(%s)"), arg, atom->name);
 	return 0;
@@ -495,7 +495,7 @@ static struct {
 	{ "refname", SOURCE_NONE, FIELD_STR, refname_atom_parser },
 	{ "objecttype", SOURCE_OTHER, FIELD_STR, objecttype_atom_parser },
 	{ "objectsize", SOURCE_OTHER, FIELD_ULONG, objectsize_atom_parser },
-	{ "objectname", SOURCE_OTHER, FIELD_STR, objectname_atom_parser },
+	{ "objectname", SOURCE_OTHER, FIELD_STR, oid_atom_parser },
 	{ "deltabase", SOURCE_OTHER, FIELD_STR, deltabase_atom_parser },
 	{ "tree", SOURCE_OBJ },
 	{ "parent", SOURCE_OBJ },
@@ -918,14 +918,14 @@ int verify_ref_format(struct ref_format *format)
 	return 0;
 }
 
-static const char *do_grab_objectname(const char *field, const struct object_id *oid,
-				      struct used_atom *atom)
+static const char *do_grab_oid(const char *field, const struct object_id *oid,
+			       struct used_atom *atom)
 {
-	switch (atom->u.objectname.option) {
+	switch (atom->u.oid.option) {
 	case O_FULL:
 		return oid_to_hex(oid);
 	case O_LENGTH:
-		return find_unique_abbrev(oid, atom->u.objectname.length);
+		return find_unique_abbrev(oid, atom->u.oid.length);
 	case O_SHORT:
 		return find_unique_abbrev(oid, DEFAULT_ABBREV);
 	default:
@@ -933,11 +933,11 @@ static const char *do_grab_objectname(const char *field, const struct object_id
 	}
 }
 
-static int grab_objectname(const char *name, const char *field, const struct object_id *oid,
-			   struct atom_value *v, struct used_atom *atom)
+static int grab_oid(const char *name, const char *field, const struct object_id *oid,
+		    struct atom_value *v, struct used_atom *atom)
 {
 	if (starts_with(name, field)) {
-		v->s = xstrdup(do_grab_objectname(field, oid, atom));
+		v->s = xstrdup(do_grab_oid(field, oid, atom));
 		return 1;
 	}
 	return 0;
@@ -966,7 +966,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 		} else if (!strcmp(name, "deltabase"))
 			v->s = xstrdup(oid_to_hex(&oi->delta_base_oid));
 		else if (deref)
-			grab_objectname(name, "objectname", &oi->oid, v, &used_atom[i]);
+			grab_oid(name, "objectname", &oi->oid, v, &used_atom[i]);
 	}
 }
 
@@ -1746,7 +1746,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && grab_objectname(name, "objectname", &ref->objectname, v, atom)) {
+		} else if (!deref && grab_oid(name, "objectname", &ref->objectname, v, atom)) {
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
-- 
gitgitgadget


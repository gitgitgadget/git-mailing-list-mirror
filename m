Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DF7C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E0E2072E
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8lj2lkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390418AbgHQSKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbgHQSK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 14:10:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A75C061344
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:10:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id d190so14008577wmd.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Je82nXeOGu8QL9bFt/iOItm11C3ZGeKZmAsav9TQxm8=;
        b=Y8lj2lkz1FYCOdc49pHdYJMAbFWNct1xNUUX8Kq6P35Ag1rw3MflLjK0WCJrYKn1nw
         CVp7HTCkt5pkGvvL0hS1pTGSXzpOVcNlzf/MDpAGYnUrN32jAgDg7mq+bPBfys8+P7XW
         JT7KZaiqgdJCrxPfoyPYg4FzQ2S38QgTicmUBa9Ef4Hqkc7aUQSDCTMTo6/ozzeIVqHj
         GCtJ4egf1GLXoEPHaI1oBD0AFMoHzQw4H5NMJE2u2JAsuE7pRYPPR3DXNPoNljkHY9Cq
         z+l+OVZglYMNQv8iGDcahow2iqPHocWHAkcyBwIge7Zc31OFT94K2I51m8EPnFvL7+Ao
         06dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Je82nXeOGu8QL9bFt/iOItm11C3ZGeKZmAsav9TQxm8=;
        b=hYI+oQBGaNqIE9H+drEKbO0Ek3o6MYY+vI4X6xXJWZepEVsEBa+q1kLeG0s1XM8xOV
         oRV+VU34TRSYW6pHnL8cG3hw81VrNyxNRv4UEYUZeTkVbG8xn9zayg3T1nLcDYBAZD0d
         V1UeXceqYpSGeLB3ylOIMYJVbDQqCpwWAe5xeohTIf2C0dyzhtyhcpDtvYpwGZKE4FZb
         p3QDXnEVjMs9DKALdvEwQMk0vkgoOa/nBXvABU8ZQEv35BAEH1hBj9/BYO1hl0one0lT
         03jFrEW8LvBGMiLD7sfYlmohZVR2zA+eBaGe5/Ffe7SiEcoUM/IFKxKQbMan/on/GoCD
         wDrA==
X-Gm-Message-State: AOAM532qY3d+G0qMXH53P4gCzSOcTRvhiiu4HorLEVZ6LPlmZZNqGMCc
        R9aThNhPlcJxyII+fhE+MlMMvU26peA=
X-Google-Smtp-Source: ABdhPJxpEKlzA8nFZCeXnejGfw1CKAu8c6/d0HAN5NRh0OadHWx1eWeoG5ZWcfjgnkSRJgIvqEy+QA==
X-Received: by 2002:a7b:c2aa:: with SMTP id c10mr15403514wmk.86.1597687826797;
        Mon, 17 Aug 2020 11:10:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i4sm32144599wrw.26.2020.08.17.11.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 11:10:26 -0700 (PDT)
Message-Id: <d53ca56778a789dfef59bd4f0e06122c065f40d2.1597687822.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
References: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
        <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 18:10:17 +0000
Subject: [PATCH v3 4/9] ref-filter: rename `objectname` related functions and
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
index 4f4591cad0..066975b306 100644
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


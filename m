Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA40C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 03:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3222B60560
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 03:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhGZCq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 22:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhGZCqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 22:46:25 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB73C061760
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 20:26:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m19so568595wms.0
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 20:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mdpv2hXRspoTs+tDov4l+MjsbpgAXrXnXj116T+tLJI=;
        b=SN0Y0LcniIXtgjQJLuQELc/UKyunt/1V2hmqTcIOfX7+0fQ6nPMNIKna7xKPXYmTkn
         aU0b1ydzoynrLGsCQvr8SuHC90XluaFMaemYKqOVu5IwDMYUX08sQMcY1Tg9DeyxsLHJ
         fCtwdTWCnBFKnF65Uxi7XHqN5hQUm39GUQEmfk/xQ+54yr3QiHPsCZncKVWBjVohFcLH
         lAm9vlHI4A3lHrZjHb941E4EVBD6wsomnZeJIxsfPx7MjrP6qcm4b7dXPHF6pUNKRPuQ
         Ri/2RCApqo/axenaCq0spNp2gJMbmnf1X/loonYWr+iFfPwUIXm9S6e8r0yKRhqqFyEl
         Fyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mdpv2hXRspoTs+tDov4l+MjsbpgAXrXnXj116T+tLJI=;
        b=a+wJt6/3LLTLlj1Olk2FpgQ6LPc3N/phFEJSIRe8lbtN+zkO88lvPCmmjcL3wkOQAD
         VosBPiTHUd/eF47qAtB1G0MbV7RkMVVQpaKpHQ4ybYD4coOHn5GGXdWt6CrnKKWNKZQm
         RuaLfSDOumkovst9l2zHUW38uIa3KiScKPOkalVVNAQ3I7b3OHQAZf/n7Ok+nXRIof+6
         YVXo6vPVwZbbP68P76Nt8CDoqwrFSdxfiayEJzhptapMYeyDhYyVDu8YuU/p0gGy1rC9
         VH7BhSJLPruf1U7xACvwjME5Y4mSUF/Ng3OAYZFKmtnamjjrleoOuQdKDgmRrMcRMiCC
         GSDA==
X-Gm-Message-State: AOAM533kIfynaB6H08AbnftX43rRyNSZPVFNUlBt+gEVCgHGjqJYB8r0
        S+x00HA88xbF05G4GHD/7mkp3ZZ42SM=
X-Google-Smtp-Source: ABdhPJzb+dKvXMU4BMYFErqSbAw4DpX7PZXng2wn9pQyY4/06bLnsRffBz0R0mmLoUsBfH+gubK6FA==
X-Received: by 2002:a05:600c:1c93:: with SMTP id k19mr15088206wms.125.1627270012978;
        Sun, 25 Jul 2021 20:26:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z20sm814600wmi.36.2021.07.25.20.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 20:26:52 -0700 (PDT)
Message-Id: <0e294ff1626ef2b7992e84e8d960f5058bd39bdc.1627270010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1000.v4.git.1627270010.gitgitgadget@gmail.com>
References: <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com>
        <pull.1000.v4.git.1627270010.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 03:26:46 +0000
Subject: [PATCH v4 1/5] [GSOC] ref-filter: add obj-type check in grab contents
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
        Jacob Keller <jacob.keller@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Only tag and commit objects use `grab_sub_body_contents()` to grab
object contents in the current codebase.  We want to teach the
function to also handle blobs and trees to get their raw data,
without parsing a blob (whose contents looks like a commit or a tag)
incorrectly as a commit or a tag. So it's needed to pass a
`struct expand_data *data` instread of only `void *buf` to both
`grab_sub_body_contents()` and `grab_values()` to be able to check
the object type.

Skip the block of code that is specific to handling commits and tags
early when the given object is of a wrong type to help later
addition to handle other types of objects in this function.

Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 4db0e40ff4c..5cee6512fba 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1356,11 +1356,12 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 /* See grab_values */
-static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
+static void grab_sub_body_contents(struct atom_value *val, int deref, struct expand_data *data)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
 	size_t sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
+	void *buf = data->content;
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
@@ -1371,10 +1372,13 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 			continue;
 		if (deref)
 			name++;
-		if (strcmp(name, "body") &&
-		    !starts_with(name, "subject") &&
-		    !starts_with(name, "trailers") &&
-		    !starts_with(name, "contents"))
+
+		if ((data->type != OBJ_TAG &&
+		     data->type != OBJ_COMMIT) ||
+		    (strcmp(name, "body") &&
+		     !starts_with(name, "subject") &&
+		     !starts_with(name, "trailers") &&
+		     !starts_with(name, "contents")))
 			continue;
 		if (!subpos)
 			find_subpos(buf,
@@ -1438,17 +1442,19 @@ static void fill_missing_values(struct atom_value *val)
  * pointed at by the ref itself; otherwise it is the object the
  * ref (which is a tag) refers to.
  */
-static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf)
+static void grab_values(struct atom_value *val, int deref, struct object *obj, struct expand_data *data)
 {
+	void *buf = data->content;
+
 	switch (obj->type) {
 	case OBJ_TAG:
 		grab_tag_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf);
+		grab_sub_body_contents(val, deref, data);
 		grab_person("tagger", val, deref, buf);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf);
+		grab_sub_body_contents(val, deref, data);
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
 		break;
@@ -1678,7 +1684,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
 					       oid_to_hex(&oi->oid), ref->refname);
 		}
-		grab_values(ref->value, deref, *obj, oi->content);
+		grab_values(ref->value, deref, *obj, oi);
 	}
 
 	grab_common_values(ref->value, deref, oi);
-- 
gitgitgadget


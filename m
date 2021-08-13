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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9C5C432BE
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D23FD6109E
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbhHMIXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbhHMIXk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8BDC0617AD
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f10so3211382wml.2
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MMY3jZF25WfsbdhxZPrT7X1HRSO8COXkupSiBa9x7T0=;
        b=W1A6lbpTKRYRVEn+zWS/wsEBuv89ZOGvFiBUDpL8RJzqE3/DewcNBsfxpqsK17Fn81
         1iiBul8BHbm9O+KrdWVNbz3XVWvqrzEXActQOtklF2l6s356GyENBaPTiJSk7mF3eCj6
         tZPNcsxE8G9ZG9gy43lStQ1slW2+8nbFP2Vp2Ys4C08LNVdlKDY0c8wbsPiv26qXzEox
         n3QUhF/Z3nbFdLc5NfKIeRBI2g20Kc3qDvq/T1y5GzkPMJVjVVBhAhQ9drqhHoU5hQoE
         vgvIRs1gcwhBlVvN7T/d8HQHhgebnakPmvS1JVa0EatPUbJ1AbU7HiDw9oeWpBDupILl
         lixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MMY3jZF25WfsbdhxZPrT7X1HRSO8COXkupSiBa9x7T0=;
        b=uICDF4Jj7UwKyR2PaikkqhwnxLj5vt6EC53H+jIscAU8cq4hE0hlhZI+k3iYCwPQ1y
         +PwPurR2nBLaWDDyqpMDc/f5OX43dvecHfWXc6+iMlXjCFmjS+Ml5dP1oyOjBeg6FOLw
         BrGmje/iRkGSLXhd/84HpKErLSIiwe0AKVPtB45K2T0EVhNo1yXGldRcfh37pjyzx0Co
         KUlsk3+3+8FNoZ4oRFQ8aiAfykle68p8GBl/TNC2juDukuvIb5UWZg8BOwArjMeUPzzZ
         UNSLX6xTqkvnAGiH0KJYkmWo+k8cZOT8fRuOhFnfQyopANMpC/oLeIbLu7NlSLVeh24V
         M7aw==
X-Gm-Message-State: AOAM531D/XyvqWNWFMgJPJRKjSbiGkoDKkbC8GZqA4mrg2wduUFM9kaY
        wmjj6wEnW+nAvkeoAeYrErO1NS9+arY=
X-Google-Smtp-Source: ABdhPJw8QjIKPtn+Uev2KO6oFB0w20O7Lmg+wjmknSAnMXF/lAHgtk7jiTkGbAEvPcRI+T5ruAiH6A==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr1465035wmi.177.1628842992569;
        Fri, 13 Aug 2021 01:23:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm645667wme.47.2021.08.13.01.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:12 -0700 (PDT)
Message-Id: <aea5c26cc403b34401fcdb87e3947b8cc37787ea.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:22:44 +0000
Subject: [PATCH 01/27] [GSOC] ref-filter: add obj-type check in grab contents
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
index 0cfef7b719b..e3715210e5c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1357,11 +1357,12 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
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
@@ -1372,10 +1373,13 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
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
@@ -1439,17 +1443,19 @@ static void fill_missing_values(struct atom_value *val)
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
@@ -1679,7 +1685,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
 					       oid_to_hex(&oi->oid), ref->refname);
 		}
-		grab_values(ref->value, deref, *obj, oi->content);
+		grab_values(ref->value, deref, *obj, oi);
 	}
 
 	grab_common_values(ref->value, deref, oi);
-- 
gitgitgadget


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7235EC49361
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5DB61460
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhFONbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 09:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhFONbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 09:31:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB05C0611C2
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:29:10 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so1813519wms.0
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sslxU2Zj/H3zu0TbnQu1d/Mc+WxpiqXZj8t9ARAzits=;
        b=nvdJMJle3NaifwXpaSCM2jjsK7gxqPd/P04CXaqWYsbpVEyHsrohC7aT+51GcQIdmP
         vQ1T1qYLR+b5XeYjc1aoWt6BtkVdPwVUd/HX/F3W15RlEYYPAlNF+zcKuwX0Jpu7CAy4
         hP1d6tW3EHCJkIpJRVjfi164SICQ8GhLIvadHZvHuHfzWCVvgXurcVo0eGoZRIk/4Q8k
         /Ghsb9euEmOSoXyi6wCvj6AefQxTEcb2wBAO7+3qWGVbGrKTMvHf1msmcfCWhP073s15
         wiHhPfvVtzfcPpOPs2tz0li8mRWmjEvMiANXVjPKQCWL/h6J18TCGPWB1t+p4BgFCODj
         s52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sslxU2Zj/H3zu0TbnQu1d/Mc+WxpiqXZj8t9ARAzits=;
        b=RZ4xTZtbgtTRBiNL9uApvJhNzkL0HYoVtBWl3wn9ngK3RLKkTi1XhlkjbRs52C0YMy
         6MjRMQrwgMqzn8IE8X2yZB/RlTSReI3Wq9jrfISo7enXe3R5m8LUR4O/nvfA/vwXGxtC
         0Z2xiAhkmJcOD5Nt13nu5an4Xb4glicRMFKRUe0Wq9eJ1JuVWYp9Gs9mS+6UX8xvtm5q
         LAGG9n5fhc15q7X//uk6V1JniNx2tmPPXjGXGxeQM4n+ZwEdkhuj5aib1C6tVeXgk7fd
         LS5/kKwrgviKyKrFCVb9n7FwkjksSYVn0jcILWxnsqPXSMmNlnUn0cX0wHtYABNOR61g
         70NA==
X-Gm-Message-State: AOAM530U+37ND3Otwq/AdGpTe9xMsmc3oMqPTFiAEp81V5g3lgD68zRH
        THDbGC0Ph8N8lfqr9ujrwmVdbaPfYCc=
X-Google-Smtp-Source: ABdhPJwzvTPBp5vzuzCRxOf0/oQ1Sq2CN5i8kMyhp26e20akJurrWCXIW33LpDttUg2bgM6xR3PYNA==
X-Received: by 2002:a1c:32c6:: with SMTP id y189mr5317392wmy.54.1623763749110;
        Tue, 15 Jun 2021 06:29:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm17777458wri.77.2021.06.15.06.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 06:29:08 -0700 (PDT)
Message-Id: <48d256db5c349c1fa0615bb60d74039c78a831fd.1623763746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
        <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 13:28:57 +0000
Subject: [PATCH v2 1/9] [GSOC] ref-filter: add obj-type check in grab contents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Only tag and commit objects use `grab_sub_body_contents()` to grab
object contents in the current codebase.  We want to teach the
function to also handle blobs and trees to get their raw data,
without parsing a blob (whose contents looks like a commit or a tag)
incorrectly as a commit or a tag.

Skip the block of code that is specific to handling commits and tags
early when the given object is of a wrong type to help later
addition to handle other types of objects in this function.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 4db0e40ff4c6..5cee6512fbaf 100644
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


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571C2C432BE
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4454F60EC0
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhGWIXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbhGWIXd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 04:23:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F26DC061757
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:04:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q3so1615294wrx.0
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O9u986p91/Gwi+fKy8spnM0GBKp3DiyL5kpCBbLklIA=;
        b=qnr0Yy5U6hQmO78opT2udERzkJgzA2nemzwBdRa1lYr4qHolwrO6Bkz986GfuyenS3
         qzZsfGmj60bi9ERUnQOT1TrRji3TfC0cwRzpRtn9vLVa/fS2GUDtZa55cvuLH5oi9Yl/
         MH63Nvh3tQMGhfdPkZOYr1n3IJd6p7Dt/xtY5FI2ZhnP0klVhz7B3ldoiHlpGn/RTzJL
         7HOn7ojRAxmd2DpXl6STuQ35vMzrgRw8RaLYdu92r5hSokyRH095Q12eGdsbYkhkb3Li
         2ieHT7WJeoayGN8cbs3LYKRG+ufUFm04g8NQXK0kJZuZnquLPXFrWfAaFkYSY3kcWZ2/
         rB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O9u986p91/Gwi+fKy8spnM0GBKp3DiyL5kpCBbLklIA=;
        b=lh6VjDYuNxTYCXauysZUQIezm9jF5d652Fg0T3ZGDNNaUEYJakHlhcQrftKjf3Wqyb
         b7fVvSky1ZcRt7/X2LMXuyy1vWBsBbbee7YNO1yBAoZsZZn8h3W8xKDK3XKdJhvRcJs8
         5Y3PMcbjDDQXY6zzQGc7csmYZKRlXxTeuDuPy72B2hFRgzPrCNuHjNIM3iSkNS80eHaj
         v5vAuu7A5GJsAmP4UJaXxfgZidNlkiydTe0LGMUbEIlGbvWgiYeQUFIJkpnt37lato52
         kSKgYa6qsV8jRGaCh9k0MgYhiBh5xqe0z/G1GB53/ZU1JIaoGcMKD/XdpYuqGeUKw8F5
         vA2w==
X-Gm-Message-State: AOAM532AxwJEdGujxfnckYcR27s7igigRdqOquRM/gUuYgcOf/y4ndoy
        zQcIyfxe2PWHSf/+3o1+WssOxiUqhFc=
X-Google-Smtp-Source: ABdhPJwm7n0iuG8W9yKXDP/N/ElDP7+LzM+pdkCq70jrH1WhohKVEcR2fDlWUtNWjWPpwrhcz15z3Q==
X-Received: by 2002:a5d:4402:: with SMTP id z2mr4056506wrq.44.1627031045983;
        Fri, 23 Jul 2021 02:04:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6sm4693811wmi.3.2021.07.23.02.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 02:04:05 -0700 (PDT)
Message-Id: <d77268bb1882a6cfbea740053baac5546ca5c5f1.1627031043.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com>
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
        <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 09:03:59 +0000
Subject: [PATCH v2 1/5] [GSOC] ref-filter: add obj-type check in grab contents
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


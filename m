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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109ABC48BC2
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0A06196E
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFYQE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhFYQEv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 12:04:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BC1C061766
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a13so11113606wrf.10
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/+pHTUCgsn/eJhBt7TH6g2FT5CeygqVH9py2mRcVtgU=;
        b=Kus69Mx+Vi+MgbdHY15NQFME4jhAQQ6kbXUA4FZM0wsPc9hEvVYdrCf7lcJDSWlyLE
         8Nirh1wnkTgQD965nlf49gsh4bx34Ob0vLtWZeoHcWVbNi+aZ1Pm6pXDiSccCxsPHam3
         qZawr8kJmyz5CVl9kB5SRfQyYHVUanXGqY4TW9uFREYKtDogH5iuXlxbZZfjpoBaKBX1
         czL6S8EyAlf4UyGdfxiR0RnUzQhyXhIzyZy2iazzuxWY3IIru0XST7I1KSQ16UUDvp3E
         k86u9phj4ESZgxTM0MrOcdlPY7i2sEc191eBWnehlENEf/WDka1ydekZ4k3IyOAz6MsB
         pp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/+pHTUCgsn/eJhBt7TH6g2FT5CeygqVH9py2mRcVtgU=;
        b=Xks1P9CVj5hM0CBzlfKcR0fWv8npae+o6xMeOi0XUz9RXOesLzas9i6/oUKtKHULiw
         wPuFfOKywwNbVk7YGewK0bkD5/TKwsFu0Jj30pFHujppbsxG5xTaL4JmbUvkDhSb9NHT
         M/vmHH2fGHa2laQ6yUkP+ET/9fjlhVNkoABiomWii3SQgu8ZKEVhLmVpTkKD+aJwg7N1
         w5puIM14sJuhEExWo/wMad8yV8xi7Xmn+egLoi+jYDajdzVyIAEpg2q0KDMB/YAdkijd
         BH2JC4/yGFNtU6rktVgZu81gJfAqhFLZxZlXvj09DXupWkigN3lIht/ZEeRRccEK59W1
         HnMQ==
X-Gm-Message-State: AOAM53370h0BmHCexAhxW6nKqsQV3RfN8p5aLroNXlVh5T0kYRgNNKZB
        CLuGtEfZb+PAdGQs3JQRHTSmqB4TpQI=
X-Google-Smtp-Source: ABdhPJz4Wk8jDdPwz+xT9r3kLJj/HYht2JRUqCvWd5Xfe2ynaLFGOYyCcZdOw6sgmfRRyhqjsGmQmw==
X-Received: by 2002:a5d:440a:: with SMTP id z10mr12082897wrq.269.1624636947865;
        Fri, 25 Jun 2021 09:02:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o203sm6785960wmo.36.2021.06.25.09.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:02:27 -0700 (PDT)
Message-Id: <f72ad9cc5e8b1f1139784df9ac7178f1561f70bb.1624636945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
        <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Jun 2021 16:02:11 +0000
Subject: [PATCH v5 01/15] [GSOC] ref-filter: add obj-type check in grab
 contents
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


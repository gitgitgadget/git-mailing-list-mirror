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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83362C47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 13:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FB1610A6
	for <git@archiver.kernel.org>; Sun, 30 May 2021 13:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhE3NDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 09:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhE3NDl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 09:03:41 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2F5C061760
        for <git@vger.kernel.org>; Sun, 30 May 2021 06:02:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h3so4661998wmq.3
        for <git@vger.kernel.org>; Sun, 30 May 2021 06:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iw42JdAD0rkd0HjDfZcRfy1kz4zR2k6+QP7ZlytL6hU=;
        b=ZglusDGr0PChNtvLt5T2LzUIBl7qeo22Ufn1nU2ZKpfrHMFA4fc7RDDuTUI1l91KJo
         +Tr/e4rT6v4SKWhxtKL8Q03gXg869tU93ysCgx8y/Jng+0rjnMAymCWd1dtAxwqzn7Zf
         fXOEqOhSk1etXAtSijoQlSv+40OBQgBKrufUZuq9jhb1nzQ8WLKs6OfEGPcpBotF7tx9
         r42aYDyTZ8rPyYyKUbbxuCthePTYcHUSPe2/VERLU/C89obg1vzaPgNnOvpud+uikAgF
         56b5YtFqEgjNXiSZabOwFRLfzJvD9ttSfqKDLRXFuFtJKn92PoNXYsLCMfhZvL1wdpDw
         6+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iw42JdAD0rkd0HjDfZcRfy1kz4zR2k6+QP7ZlytL6hU=;
        b=k119MdkdTHN8P1Zlqvr2TaTEvGFgcafb6ho4RYGBS7mnekpbtccKuPy6Ay2nvOq0d3
         D+J6p/f52vYvWT6Lp98W3EuHXq2O2KFqHOwQCLhUFl4S64NoH6/vdkvASRMpTQwLYUS8
         6d+jYqa8Y7y9WFumnwoQDisrvsSvYHgtcnuD2/OQgSLjs2KElw7daGK4SH4DRr+CItHp
         FCf5X7fSLliM5TLkQ9ZCDs55cFyKgCKx8XJcAva+srON+ztZ5pqO3+CUU117eYXJSHs6
         j+T46v5BUjlUwcvu8JlBGocgV4dlUBSRApX3lY3+w3C1japAeAy0elTCkKaTwxZIjxnN
         mKDA==
X-Gm-Message-State: AOAM530smgPZGWvq/aw7j/yBU2o9GCzpFG8D81POdNJmTzGc5uN/XV1+
        3H+gJaB3gs0+4ew/Jmm0IhhzJsoLdOA=
X-Google-Smtp-Source: ABdhPJw9aqIdA2HTRvyYDKBP2mPEfoRIJfq36DEffI0+vYO39Ng0vah2lZ2BBBQsx7SMU1NM8mvmYA==
X-Received: by 2002:a7b:c742:: with SMTP id w2mr16772614wmk.76.1622379720757;
        Sun, 30 May 2021 06:02:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p25sm38399wmi.38.2021.05.30.06.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 06:02:00 -0700 (PDT)
Message-Id: <e6c26d19a3f3b4791c435867550da538cfe6e287.1622379718.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.963.v2.git.1622379718.gitgitgadget@gmail.com>
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
        <pull.963.v2.git.1622379718.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 30 May 2021 13:01:57 +0000
Subject: [PATCH v2 1/2] [GSOC] ref-filter: add obj-type check in grab contents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Only tag and commit will use `grab_sub_body_contents()`
to grab object contents in origin implement. If we want
to make blob, tree can also use `grab_sub_body_contents()`
to get objects' raw data, a blob look like commit or tag
will be wrongly regarded as commit, tag by `find_subpos()`.

So we must add a test before `find_subpos()` to reject
blob, tree objects. This will help us add %(raw) atom
which can grab raw data of four type objects.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 97116e12d7c4..f6a7b5290d54 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1292,7 +1292,8 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 /* See grab_values */
-static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
+static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf,
+				   struct object *obj)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
@@ -1307,10 +1308,13 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 			continue;
 		if (deref)
 			name++;
-		if (strcmp(name, "body") &&
-		    !starts_with(name, "subject") &&
-		    !starts_with(name, "trailers") &&
-		    !starts_with(name, "contents"))
+
+		if ((obj->type != OBJ_TAG &&
+		     obj->type != OBJ_COMMIT) ||
+		    (strcmp(name, "body") &&
+		     !starts_with(name, "subject") &&
+		     !starts_with(name, "trailers") &&
+		     !starts_with(name, "contents")))
 			continue;
 		if (!subpos)
 			find_subpos(buf,
@@ -1379,12 +1383,12 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
 	switch (obj->type) {
 	case OBJ_TAG:
 		grab_tag_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf);
+		grab_sub_body_contents(val, deref, buf, obj);
 		grab_person("tagger", val, deref, buf);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf);
+		grab_sub_body_contents(val, deref, buf, obj);
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
 		break;
-- 
gitgitgadget


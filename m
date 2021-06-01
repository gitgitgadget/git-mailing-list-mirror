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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3DDC4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 266A8613AE
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhFAOjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 10:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbhFAOjI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 10:39:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DA5C06174A
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 07:37:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z8so9482464wrp.12
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5DaEVzJW0q4b/I7s+7ljceldNG85JzStIUXJ2zS/X0E=;
        b=gDPZ0jT6gCWZW3RLS/wPeVq4uJpfUyTrKKgRSavA7mQRJ92G5B4bnT+V8BxKAUGVap
         B7siukwSuyc2BCZj13jldM5UmKebOUQPAsD7mRig0LFE0DpmWhozHZCVJpCT/yVkvadJ
         wPMAGJ5BQ1JZ6YYsSogWvhCDTJyP0YUXHwQAwBenEcTBagM8jQ4BheHG7a//GLQTdHMv
         bympMrkNToXyY+HYTAts+HbgT1sJrF0Y2+vpb96eTTiqfcfmLQrfuPSqVCktjOh25JeI
         XzJl0gYn2u759k2k3D01kqe2sLLFtAmiN19ltxq/CdrVxSALnGdialZfz/d8gHA1YLER
         RzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5DaEVzJW0q4b/I7s+7ljceldNG85JzStIUXJ2zS/X0E=;
        b=rMON34pZoxTWc4bTDsKT8wJxwQN5smAGNWCso2/jYLsRTEo6xbRaP5VybyGKIsdW6x
         gIKzN7cistM68rERhDmx2M+l9EhaJsBzREKNlM4HDokRE60sbG0NhKHMmRoFpBHDmZa5
         usuqixIMOb7FHEes+MhoOn55rE+iph9yDrMggZg3XtMf2uQvFpt8Op7IiBp9lojOYhGi
         NbvYYcZa+xEDXc1UrdYoUWf6tSmQeNUfjmjPD1vl5PteABPEYHYu5fz4vCUWSuM9MUT/
         ibMz08VZ2H15tOQqvGxmp0e36lXEM2Y6AEvXdiM06ikBVllILudXXY6zxevRtnmjhheE
         FPaA==
X-Gm-Message-State: AOAM530uIfAL/kByFKedgmGD25Ogb+2MHJlYJmAAzo37SYKUxCxHQTRe
        RnfA/1LC87i2zqDG1x9qO1gFHoohXRk=
X-Google-Smtp-Source: ABdhPJw+FpS32JOzVDcl32uEsY7+Zv/HMPiQDmE1hrFauHkhZO7x8PiuVWYXIczH+U0OPzBKbr7GUg==
X-Received: by 2002:adf:f2ce:: with SMTP id d14mr10035401wrp.102.1622558245194;
        Tue, 01 Jun 2021 07:37:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7sm3970038wrc.42.2021.06.01.07.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:37:24 -0700 (PDT)
Message-Id: <97955705c22e00a718a8de7555ab7e0e401e792e.1622558243.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.966.git.1622558243.gitgitgadget@gmail.com>
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Jun 2021 14:37:22 +0000
Subject: [PATCH 1/2] [GSOC] ref-filter: add obj-type check in grab contents
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
 ref-filter.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 4db0e40ff4c6..c0334857653a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1356,7 +1356,8 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 /* See grab_values */
-static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
+static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf,
+				   struct object *obj)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
@@ -1371,10 +1372,13 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
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
@@ -1443,12 +1447,12 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
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


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFDBC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB5A610CD
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhHYJJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 05:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbhHYJJt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 05:09:49 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A572BC06179A
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 02:08:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m2so2876980wmm.0
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LxBSAtjRmZzNVPjGW3EYc1+alzELuDnAH/h0kwGP7ZU=;
        b=HU3JYqCSUmnAdDWwcYU8eC6hXN+pFlL0hGh4wNvsIxYt11pG/5ioorEVtDIitENxdk
         cF9dH43lfxrJ8+B6kZmcGk74XfKLsY6hhGuW9PEHZ67Nj9j30gOoLrU8XOltdO9WGshE
         nKrOxF/vbMBIbjffWODGUh2xcmcqDsuw3ubJ/n198OW9Cm5t14jBY+foep3/JdKgYQQr
         EDiHRn/26dnLcKvgqBSp5UpeQ4SO3CXiaqi2qbWMOtvgpzHm6X1hRTYdeI7znrbfBBSq
         4eJ1J7SwM+MWX4bZLiBKoCMMHq3LEXoPDsNcG7ueSpyi5SM+KXBbpdOV4msp8f0hrrLm
         j2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LxBSAtjRmZzNVPjGW3EYc1+alzELuDnAH/h0kwGP7ZU=;
        b=Y53ICKd/F/jFJwyJ51i43AxjsR6F8BEkCU3VoxLy9MUIz2M6gr7VK81K1Z9Af8gIr2
         owkDBVIKHl/G+8hGPCYa4xL/Eafh0eT29kg6YpvuCyrOTCsvZqrCaa/MVItAkq2HGCR2
         2xdex+l8DR4oQJF7FYm3sKKXhnTB7GleP7tW6BWbLYZnrXcfgKEmPSgrPsftaWPD+wDp
         JPDv3rgQKiOjJ1Ac5yHdvM3xfYK4ITm4J5j53DtKXcneEjGa4FSRlzq6WBhbV0cGraET
         rJqVlCHIn0iruhhDr6yssmPJd1VC1w/p/uGdUYXVjMd124DIb8DAiU6x35VUxZoqZA/O
         nuLg==
X-Gm-Message-State: AOAM532apna0YbGeRZOhMyGl3UK7hNIyQ8DDmMVBh2YZ0VaW7hWBbWJ/
        amf8oNbPcIbAUJ+SyZ+FDyrkAynNNsw=
X-Google-Smtp-Source: ABdhPJwT+LZv7/ywT+AY6ZKd0KTmtgHdOxWTonQ7kFpyWP8wDb8McQU7+lGfVDHFbk+RAvtHx37+ZQ==
X-Received: by 2002:a7b:cbc2:: with SMTP id n2mr8179242wmi.155.1629882538269;
        Wed, 25 Aug 2021 02:08:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b24sm725242wmj.43.2021.08.25.02.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 02:08:57 -0700 (PDT)
Message-Id: <a7dfd0a5866c9c0474b8d02ab7a276d132925bc8.1629882532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1025.git.1629882532.gitgitgadget@gmail.com>
References: <pull.1025.git.1629882532.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Aug 2021 09:08:52 +0000
Subject: [PATCH 8/8] [GSOC] ref-filter: move need_symref, need_tagged into
 ref_format
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

There are many global options variables in ref-filter, e.g.
need_tagged, need_symref, which may affect the reentrancy of
the functions. Moving these variables into ref_format which
can make the code cleaner.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 14 +++++++-------
 ref-filter.h |  2 ++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e4f96dad504..29be1e865d2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -213,7 +213,7 @@ static struct used_atom {
 		char *head;
 	} u;
 } *used_atom;
-static int used_atom_cnt, need_tagged, need_symref;
+static int used_atom_cnt;
 
 /*
  * Expand string, append it to strbuf *sb, then return error code ret.
@@ -499,7 +499,7 @@ static int person_email_atom_parser(struct ref_format *format, struct used_atom
 static int symref_atom_parser(struct ref_format *format, struct used_atom *atom,
 			       const char *arg, struct strbuf *err)
 {
-	need_symref = 1;
+	format->need_symref = 1;
 	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name, err);
 }
 
@@ -769,7 +769,7 @@ static int parse_ref_filter_atom(struct ref_format *format,
 	if (valid_atom[i].parser && valid_atom[i].parser(format, &used_atom[at], arg, err))
 		return -1;
 	if (deref)
-		need_tagged = 1;
+		format->need_tagged = 1;
 	return at;
 }
 
@@ -1816,10 +1816,10 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	struct object *obj;
 	int i;
 	struct object_info empty = OBJECT_INFO_INIT;
-
+	struct ref_format *format = ref->format;
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
 
-	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
+	if (format->need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
 		ref->symref = resolve_refdup(ref->refname, RESOLVE_REF_READING,
 					     NULL, NULL);
 		if (!ref->symref)
@@ -1958,7 +1958,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 					       oid_to_hex(&ref->objectname), ref->refname);
 	}
 
-	if (need_tagged)
+	if (format->need_tagged)
 		oi.info.contentp = &oi.content;
 	if (!memcmp(&oi.info, &empty, sizeof(empty)) &&
 	    !memcmp(&oi_deref.info, &empty, sizeof(empty)))
@@ -1973,7 +1973,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	 * If there is no atom that wants to know about tagged
 	 * object, we are done.
 	 */
-	if (!need_tagged || (obj->type != OBJ_TAG))
+	if (!format->need_tagged || (obj->type != OBJ_TAG))
 		return 0;
 
 	/*
diff --git a/ref-filter.h b/ref-filter.h
index e95c055fb86..ec4cc1e5f9c 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -86,6 +86,8 @@ struct ref_format {
 
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
+	int need_tagged;
+	int need_symref;
 };
 
 #define REF_FORMAT_INIT { .use_color = -1 }
-- 
gitgitgadget

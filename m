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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9F4C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3705361183
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239582AbhHYJJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 05:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239540AbhHYJJn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 05:09:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CBBC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 02:08:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h13so35343024wrp.1
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 02:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0Gwt0qGbQp6JBOc3bncmKJ9Qs1Afo8N71MKuGNPRT8w=;
        b=YUf2yzcb0Z70bgQdVehn24iDORWOjR6glVuyGMrH29Pgb0k+4ZpXV6pjWTf/y0NuK3
         5bCJ/ti54S+JTGWoafWtEf9IqaMCc8kWar8UI7BUVkVFGPaR4j1metCN3tt4NJjDL2CG
         4sKIkBwVkWnp/55vBfBnv0a5TwoMSxC0OC7/QAoWmICdUXI0B7z0R4S11uqsUMPUcR5b
         2tTgbn3QzxFxWtfZXwQnA1KXkRJvCtb2TGeKFJzoKJrmy8ucl23Kzs4vqhxih5YIIPvP
         6FbF3omecd/iUe3W0wlXurCUxN2jUy+MINERj21u8jT61x4V/Lzmq/hEnkRGAueZ5qgM
         vMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0Gwt0qGbQp6JBOc3bncmKJ9Qs1Afo8N71MKuGNPRT8w=;
        b=poiMxYH05lOK8kOMcDoouX1/g/Rg3KgSObYyUpqoGPyIzGEEyX17A80PF5waXu0l5/
         ZWUPchKsO68WZ9ZldaCNiUq7H6kC8Ii5p3ChxNkNzhUPAnLQyk1+vBbG2zYLmG2ukPBx
         oo3BqAizExU3oFpDWp8xkunRMT5XWOFMz/d/5pA6OLErePhbWe2gft1DVYMsATnN4f6r
         DIajxUSzXMa0XaTC3stfAoNll+xeKEi3d4YRy6M1zm3TiS9s21fJWrFKO5uMaDZPLj+k
         Jhx9eObVEG6P5K0lJeXbgfWeEB2FBGO0SYutfNPfpawFrqvB++y202LV6p1z4v5aovpz
         RBUA==
X-Gm-Message-State: AOAM532t9JDrDpphJuYH7ev7iC6C2+LfbzOdsO0NIUuMD9IgRK47JYYI
        ccJkAcH1INxzy6yqTZa1PhzG1XDVVgQ=
X-Google-Smtp-Source: ABdhPJzmgQacazYe5mcwLTV/7DaKMvVq0eSwN/IUxZWIf2MxFlkhTSb222J8heYsV4RR4RvqyoBL7w==
X-Received: by 2002:a5d:4605:: with SMTP id t5mr23363197wrq.276.1629882536396;
        Wed, 25 Aug 2021 02:08:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f20sm4606122wml.38.2021.08.25.02.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 02:08:56 -0700 (PDT)
Message-Id: <40ab1faad39285ecd05ea57d6d2107e644d01bb7.1629882532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1025.git.1629882532.gitgitgadget@gmail.com>
References: <pull.1025.git.1629882532.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Aug 2021 09:08:49 +0000
Subject: [PATCH 5/8] [GSOC] ref-filter: introduce symref_atom_parser()
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

parse_ref_filter_atom() sets need_symref by checking
whether the atom type is ATOM_SYMREF. When we are operating
other atoms here, this step of checking is not necessary.

So add the symref_atom_parser() specifically to parse the
%(symref) atom, and set need_symref in it.

This can make the program logic more concise.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e42cd738c32..8dca273f720 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -495,6 +495,13 @@ static int person_email_atom_parser(struct ref_format *format, struct used_atom
 	return 0;
 }
 
+static int symref_atom_parser(struct ref_format *format, struct used_atom *atom,
+			       const char *arg, struct strbuf *err)
+{
+	need_symref = 1;
+	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name, err);
+}
+
 static int refname_atom_parser(struct ref_format *format, struct used_atom *atom,
 			       const char *arg, struct strbuf *err)
 {
@@ -634,7 +641,7 @@ static struct {
 	[ATOM_RAW] = { "raw", SOURCE_OBJ, FIELD_STR, raw_atom_parser },
 	[ATOM_UPSTREAM] = { "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
 	[ATOM_PUSH] = { "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
-	[ATOM_SYMREF] = { "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },
+	[ATOM_SYMREF] = { "symref", SOURCE_NONE, FIELD_STR, symref_atom_parser },
 	[ATOM_FLAG] = { "flag", SOURCE_NONE },
 	[ATOM_HEAD] = { "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
 	[ATOM_COLOR] = { "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
@@ -758,8 +765,6 @@ static int parse_ref_filter_atom(struct ref_format *format,
 		return -1;
 	if (*atom == '*')
 		need_tagged = 1;
-	if (i == ATOM_SYMREF)
-		need_symref = 1;
 	return at;
 }
 
-- 
gitgitgadget


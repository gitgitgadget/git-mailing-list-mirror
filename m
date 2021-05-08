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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F98C433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 15:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE8261155
	for <git@archiver.kernel.org>; Sat,  8 May 2021 15:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhEHPXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 11:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhEHPXh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 11:23:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41873C06175F
        for <git@vger.kernel.org>; Sat,  8 May 2021 08:22:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n84so6798741wma.0
        for <git@vger.kernel.org>; Sat, 08 May 2021 08:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gBHcabRsxOzaTZfqoW2cX/vxixQylnxsAwx9htHPiKg=;
        b=b4g+py7IoJsH5HsyZVVdBjS9C1FrDq/HCAxLkdh77/m16XPIun3jSCce7ScrGoQyv3
         JfI2xpAV9X4U9kssC8kkrBcDfOtMQTIMEKpJszJzaXpPe8ep11frJRpHHoRJmlWYvn25
         Q1vEoBoFqFlZdtXnVdUnQLy8G2zdFAmtCPqhdAueWf/rE/XH/1Tu+oO9R7hSPaL9soqu
         XwmF7IXt9UBLbYf1Zphfmsj0GUAas1b/4N4RiW6DWNV3y+RyKKzirBr92IE/vjO+v11O
         aw7w3hW76QpSTkzwKAZfWQ5FDyUPU1HNlb8/iAwsWdLdjV8Pjv/jZ86YWObhVnchA2zL
         kQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gBHcabRsxOzaTZfqoW2cX/vxixQylnxsAwx9htHPiKg=;
        b=GAwjvrjIpVU8hmX+1IPMxKPp3MiaX6CNJbn6omh0iZMiMngbfQwudw+ZWS58tklVUY
         XHGarFVEw5pAo20dXyGcPZu5sJ7d8nK3bI5ZgvRQsK+F8mYvpd7LyAgbJY40JmPncl8D
         hht1I/4RdJFIYjYovL56uCIAQuX2IZOWbR0SUU1Km98njd5k7RPNGHUAnIYr6wbc0zAX
         u94ZFyEPBLCvFdDRnu/dWM8iF/CBqEB7BObYrZXvc+mTecQmzkpYnV8bn3cbb4jzvJDg
         NKOfsW+iboXV5Y2xJTjWlw3zpuWUqSEMUd7VI1CX41if4Wth/DKAq9Lhi91yWrzLcIHY
         9tHw==
X-Gm-Message-State: AOAM533KN+HepeXjndTXV1akO8oUBC1AxNa7nGmOuDyKOlr71t4l1DN5
        kQyE7gZPrYM9ri2FtpCaHnKDidcHhug=
X-Google-Smtp-Source: ABdhPJzCS0NTW6fLltGIgRXjVbfKC8EhxGJ6nRNsf6nUN1j3ppD4KgOU60qMW0vGLJ8AhjGRccK0Sg==
X-Received: by 2002:a1c:b60b:: with SMTP id g11mr27806208wmf.68.1620487354960;
        Sat, 08 May 2021 08:22:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13sm16721128wrd.81.2021.05.08.08.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 08:22:34 -0700 (PDT)
Message-Id: <91ca57c9d04a822aa4955dbfe3962a6fb2444e81.1620487353.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.951.git.1620487353.gitgitgadget@gmail.com>
References: <pull.951.git.1620487353.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 15:22:31 +0000
Subject: [PATCH 1/2] [GSOC] ref-filter: add objectsize to used_atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Since "objectsize:size" is composed of two parts,
"type:attribute". However, the original implementation
did not decouple the two parts "type" and "attribute" well,
we still need to judge separately whether the atom is
"objectsize" or "objectsize:disk" in `grab_common_values()`.

Add a new member `objectsize` to the union `used_atom.u`,
so that we can separate the judgment of atom type from the
judgment of atom attribute, This will bring scalability to
atom `%(objectsize)`.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index a0adb4551d87..f420bae6e5ba 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -146,6 +146,9 @@ static struct used_atom {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
 			unsigned int length;
 		} oid;
+		struct {
+			enum { O_SIZE, O_SIZE_DISK } option;
+		} objectsize;
 		struct email_option {
 			enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
 		} email_option;
@@ -269,11 +272,13 @@ static int objectsize_atom_parser(const struct ref_format *format, struct used_a
 				  const char *arg, struct strbuf *err)
 {
 	if (!arg) {
+		atom->u.objectsize.option = O_SIZE;
 		if (*atom->name == '*')
 			oi_deref.info.sizep = &oi_deref.size;
 		else
 			oi.info.sizep = &oi.size;
 	} else if (!strcmp(arg, "disk")) {
+		atom->u.objectsize.option = O_SIZE_DISK;
 		if (*atom->name == '*')
 			oi_deref.info.disk_sizep = &oi_deref.disk_size;
 		else
@@ -967,12 +972,14 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 			name++;
 		if (!strcmp(name, "objecttype"))
 			v->s = xstrdup(type_name(oi->type));
-		else if (!strcmp(name, "objectsize:disk")) {
-			v->value = oi->disk_size;
-			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)oi->disk_size);
-		} else if (!strcmp(name, "objectsize")) {
-			v->value = oi->size;
-			v->s = xstrfmt("%"PRIuMAX , (uintmax_t)oi->size);
+		else if (starts_with(name, "objectsize")) {
+			if (used_atom[i].u.objectsize.option == O_SIZE_DISK) {
+				v->value = oi->disk_size;
+				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)oi->disk_size);
+			} else if (used_atom[i].u.objectsize.option == O_SIZE) {
+				v->value = oi->size;
+				v->s = xstrfmt("%"PRIuMAX , (uintmax_t)oi->size);
+			}
 		} else if (!strcmp(name, "deltabase"))
 			v->s = xstrdup(oid_to_hex(&oi->delta_base_oid));
 		else if (deref)
-- 
gitgitgadget


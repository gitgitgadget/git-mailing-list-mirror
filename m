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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E507C43460
	for <git@archiver.kernel.org>; Thu, 13 May 2021 15:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6492261406
	for <git@archiver.kernel.org>; Thu, 13 May 2021 15:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhEMPQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 11:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbhEMPQz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 11:16:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4A0C061756
        for <git@vger.kernel.org>; Thu, 13 May 2021 08:15:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r12so1640813wrp.1
        for <git@vger.kernel.org>; Thu, 13 May 2021 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fDE+qC3MxopjcG/DyvKrK9o/JpzHGjzgFneyJ1Haz+8=;
        b=lAF51sOMPvfwoVtZ0jo8JUitLjTDeSwuCB6XfBIQV1ayFLffQqquDHti2D2wJl51HV
         +bnKAU/5hzeLPn1IexG/1hY7UvXBRaHKIc6OguUhJDvclbsy59rwkHf69yWPJa47gvzn
         f5nix/0FF+OGDrrCvlT5VKtORv6MSd/1P7MnHSTLWKhPBoLuC/3rBKUjKD0GsPchocAJ
         ZTogy1mYx+EdAR2rMp5htlo0l938aFf34V7rzW4PCIOio2NEn4+rr7ga3boEwgqmRZM3
         aC80JV9JzKURYLJ1VWt+RF7TrKIKJ+wyONoQrwa7OuTtk8h9+pGjZ2XbJhAHzMb9hGpU
         /qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fDE+qC3MxopjcG/DyvKrK9o/JpzHGjzgFneyJ1Haz+8=;
        b=T9rPpyhxrVBL8ZO7xrMZ40rmxppyBxBW0TZ/7abDV3Ur7LUGXI9MgPj9oJKjQTF5eM
         Iw7TbZ87Xrn1a0yvCux5I7/sS6Dpv04I0E4aeXhO2LWnvcL/RvPA5/NRZuCrUbBH0tgk
         o7uNPQiXY2TQTZQ9fgYT7XSJjbFkRvC8glYOHVw4l+NSQhQsR/5MemTsKuH03sCKSMt5
         7ctSpVcm6ZsE3P2UBz5LOgSlRnjei+g00SvpYc+ucAJ9vuGcjNU7CeDRyKkx4c8DAo+r
         SIh/bqAwSejsf5xlmJFUqqNW0RbroYuNbNMidWK0iJVAqo+7HFRRbmpjswlwxCJmXgQP
         NBwA==
X-Gm-Message-State: AOAM532eavzlUX0v8NbkfTTia7MWObbV5ZD3SGuD2Niwb/XnSkr/NcqE
        nPUAvUyy5/8QnNPfnjgft9zDH20uqPM=
X-Google-Smtp-Source: ABdhPJygMbtFnt059l+lo5EyAQOZFMmIc96QgIKWm4T6+GUH/7NWUHjDAKDOzkg5QzJ5/JFjSehhrA==
X-Received: by 2002:a5d:5407:: with SMTP id g7mr4407257wrv.207.1620918941557;
        Thu, 13 May 2021 08:15:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m11sm3082456wri.44.2021.05.13.08.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 08:15:40 -0700 (PDT)
Message-Id: <23fc04f7eb23819473364d8392de95b1e77ddb03.1620918939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.951.v4.git.1620918939.gitgitgadget@gmail.com>
References: <pull.951.v3.git.1620821464.gitgitgadget@gmail.com>
        <pull.951.v4.git.1620918939.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 May 2021 15:15:37 +0000
Subject: [PATCH v4 1/2] [GSOC] ref-filter: add objectsize to used_atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

When the support for "objectsize:disk" was bolted onto the
existing support for "objectsize", it didn't follow the
usual pattern for handling "atomtype:modifier", which reads
the <modifier> part just once while parsing the format
string, and store the parsed result in the union in the
used_atom structure, so that the string form of it does not
have to be parsed over and over at runtime (e.g. in
grab_common_values()).

Add a new member `objectsize` to the union `used_atom.u`,
so that we can separate the check of <modifier> from the
check of <atomtype>, this will bring scalability to atom
`%(objectsize)`.

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


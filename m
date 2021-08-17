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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F341BC4320A
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 07:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D0460F5E
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 07:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbhHQHPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 03:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbhHQHP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 03:15:27 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4E8C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 00:14:54 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r7so27177849wrs.0
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 00:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hH5AYoT2omWwWQpGeFarOuPdMIQukXOrhc+KpYnmrJA=;
        b=RtYZA7X1mfBJFt5gz8TEE1hcR0ijiesHSvIakZvOG5VeUy3D13taYpwFtJW67I5Hy2
         MdSW+QQUOWkNZ158utGgTSmXgaFI8/RR6kBQ7r5uhRCgA39gp2d3PC+G2WHDWAl+nMvw
         GosVboI2JuWJqnaCBD8HK94ibAbDcEmFPA9z/4gsSUJMVV2AbR34IjDWOLWSxjQLODuH
         iOiKpbhN3SboEys3sUXauAE/wLl/dnV2dEA0MZBjfphaoX3y4Ax3FyUIWt8zGOzQHZ0A
         3GzsskHbmICOyCMttUN2pbVb6OVwWpWk/exlG/Zyq0LYOAscmVELp19VXm3FpnEv/fcV
         appg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hH5AYoT2omWwWQpGeFarOuPdMIQukXOrhc+KpYnmrJA=;
        b=ggU7BtoquinGP9Wyd0QjJqr5trRcn/Onn/VQKPforhyTHr7IenfgHLcel8Ycco4eR2
         ps3Ymh4bcmuPjv7s+qvF1JeIb0+2gHh874nRi75Z1+QWEK4OfGdPbPiks5VxbWeLXbPF
         McghNWqnKOO8qeVQgA8AFBBZPcDyPdbhThpFv+EiqYbFyDQlCEq/whgQSKfRUx5p8hhF
         +Kpv95FHZ3qn3ePvbB0FvdMWfVD8Jb6PVezoqWidUaZqVWVf3aTY9R8PnfTPQu9JYSvT
         C+h2gMBkTvi+v5uEK7b6ejogxNazr5AKpOWTBdqc8slLpIGsB+kZBfblltgCOwfITMl7
         ovlA==
X-Gm-Message-State: AOAM530ZS7SUaNbyKOpzSTGDk8MPi1YBdOYzxQphs5VswTEKfYH83BmH
        5WQH8odpmJnI8c94Zyev9B8uQmoQSSU=
X-Google-Smtp-Source: ABdhPJzs8ou1nUn/Xtfc198lApnB2AgsvQK7tpx8Vg7s0yYI2HmKygw5GzS9e49kOeDHEdh5B1V52g==
X-Received: by 2002:adf:f3ca:: with SMTP id g10mr450630wrp.379.1629184493091;
        Tue, 17 Aug 2021 00:14:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13sm1313410wrq.44.2021.08.17.00.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 00:14:52 -0700 (PDT)
Message-Id: <3899fbe498f629d1af7dcea792b14eccdbb51af5.1629184489.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.git.1629184489.gitgitgadget@gmail.com>
References: <pull.1020.git.1629184489.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 07:14:48 +0000
Subject: [PATCH 4/5] [GSOC] ref-filter: reduce unnecessary object_info
 comparisons
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

In populate_value() we use an empty struct object_info
compare with oi and oi_deref, which determine if we can
return early, this is actually very inefficient.

So add a need_get_object_info flag in global variables,
which used to indicate whether we need call get_object()
or we can return early.

So we only need to compare only one byte instead of comparing
the entire huge object_info struct.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7106d4c1c4c..35e221e7ec8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -212,7 +212,7 @@ static struct used_atom {
 		char *head;
 	} u;
 } *used_atom;
-static int used_atom_cnt, need_tagged, need_symref;
+static int used_atom_cnt, need_tagged, need_symref, need_get_object_info;
 
 /*
  * Expand string, append it to strbuf *sb, then return error code ret.
@@ -318,10 +318,13 @@ static int objecttype_atom_parser(struct ref_format *format, struct used_atom *a
 {
 	if (arg)
 		return strbuf_addf_ret(err, -1, _("%%(objecttype) does not take arguments"));
-	if (*atom->name == '*')
+	if (*atom->name == '*') {
 		oi_deref.info.typep = &oi_deref.type;
-	else
+		need_get_object_info = 1;
+	} else {
 		oi.info.typep = &oi.type;
+		need_get_object_info = 1;
+	}
 	return 0;
 }
 
@@ -330,16 +333,23 @@ static int objectsize_atom_parser(struct ref_format *format, struct used_atom *a
 {
 	if (!arg) {
 		atom->u.objectsize.option = O_SIZE;
-		if (*atom->name == '*')
+		if (*atom->name == '*') {
 			oi_deref.info.sizep = &oi_deref.size;
-		else
+			need_get_object_info = 1;
+		} else {
 			oi.info.sizep = &oi.size;
+			need_get_object_info = 1;
+		}
 	} else if (!strcmp(arg, "disk")) {
 		atom->u.objectsize.option = O_SIZE_DISK;
-		if (*atom->name == '*')
+		if (*atom->name == '*') {
 			oi_deref.info.disk_sizep = &oi_deref.disk_size;
-		else
+			need_get_object_info = 1;
+		}
+		else {
 			oi.info.disk_sizep = &oi.disk_size;
+			need_get_object_info = 1;
+		}
 	} else
 		return strbuf_addf_ret(err, -1, _("unrecognized %%(objectsize) argument: %s"), arg);
 	return 0;
@@ -354,6 +364,7 @@ static int deltabase_atom_parser(struct ref_format *format, struct used_atom *at
 		oi_deref.info.delta_base_oid = &oi_deref.delta_base_oid;
 	else
 		oi.info.delta_base_oid = &oi.delta_base_oid;
+	need_get_object_info = 1;
 	return 0;
 }
 
@@ -720,6 +731,7 @@ static int parse_ref_filter_atom(struct ref_format *format,
 	used_atom[at].type = valid_atom[i].cmp_type;
 	used_atom[at].source = valid_atom[i].source;
 	if (used_atom[at].source == SOURCE_OBJ) {
+		need_get_object_info = 1;
 		if (*atom == '*')
 			oi_deref.info.contentp = &oi_deref.content;
 		else
@@ -1871,7 +1883,6 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 {
 	struct object *obj;
 	int i;
-	struct object_info empty = OBJECT_INFO_INIT;
 
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
 
@@ -2019,10 +2030,11 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 					       oid_to_hex(&ref->objectname), ref->refname);
 	}
 
-	if (need_tagged)
+	if (need_tagged) {
 		oi.info.contentp = &oi.content;
-	if (!memcmp(&oi.info, &empty, sizeof(empty)) &&
-	    !memcmp(&oi_deref.info, &empty, sizeof(empty)))
+		need_get_object_info = 1;
+	}
+	if (!need_get_object_info)
 		return 0;
 
 
-- 
gitgitgadget


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE2BC432BE
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801E2610CC
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbhHMIYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbhHMIX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3739C0617AE
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:29 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k4so6336667wms.3
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n530dLlV5/doLmnyndxzdNlCvHcz0xSPoKIsuUSlh7E=;
        b=VVy+vx8wreGHRe3OIX8xxAyWBABjWb385wfOZkHdex9xqzszlZsKfA0NrGIm5PwGYj
         c+NRzHbjUssX0dl+zLZJ/mWfAiWaktNuPLfA8BFDPzItOtixn5Wsk/HUM2wPgnXX4Dv3
         48QzP2D4EXlQZ7O3pqxkovFEbE1ZJRpjo3avC+ZegPcn+FjXsU4GoIvvi7isMtP3LR/B
         X+eHX3wvF8I94x7fQpf66Qz8amsUwMe/Xg1iqhxXdzyjKNT24poh6gIOJZ36FO+4UWSv
         Q97DxIAR5XX2Of1J74hb4KZ8o/gCjCACt9Vfkm7V1cGwQrWpt04kD+2by7KjxAIqcYVD
         ez4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n530dLlV5/doLmnyndxzdNlCvHcz0xSPoKIsuUSlh7E=;
        b=mCaWw/BorJP2+k1jrZVxHjCTvSaSDqIUdem/4fTjNVLpmf6fSsYbZYclLPVR/G8JOi
         w/aXpevGtVaGZtRVjc81FwfFyhN18m0Yyn8wliu3zJzNN4R/wDDSekVAdWplBFcab28g
         XUuCEoxijWoDu994OYrEaR4esGN08wYrSGawtrCUQZFGhlG/I8QTiX1PKFxs5gTtx493
         q/SzKe93n2wKc3SMYkA9Jjw/W9jrm14DP13exqEZZYK0LqTTihBxsbwQfsX1xqAOkqxq
         QAcP1TZ3Mc3ii/dbL7xu8JLYzLNwZIwt+wvFFpYS05b81ZEyPVd1FIPAxXNzLFJYJq49
         5k/A==
X-Gm-Message-State: AOAM531H6EY+GQ0cnyIW+Ddg6QiddCm5Jvu/KsTVYDN2pSBYGTfxpmUN
        XIaVUdgzhpTtSlCysORLm3Gohk4pnF0=
X-Google-Smtp-Source: ABdhPJzG4K7Swa0Vya1qRD2yWU//lK1WCJKs3IqzPbzCtMJUhKSeKKW2EQ0UEsoVf/LGeRDWJnnmGQ==
X-Received: by 2002:a05:600c:190f:: with SMTP id j15mr1407291wmq.11.1628843008565;
        Fri, 13 Aug 2021 01:23:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17sm845716wrw.17.2021.08.13.01.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:28 -0700 (PDT)
Message-Id: <8591897fbce05e9987a6ee9af157471a3fc9359f.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:23:10 +0000
Subject: [PATCH 27/27] [GSOC] ref-filter: add need_get_object_info flag to
 struct expand_data
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

So add a `need_get_object_info` flag to struct expand_data,
which used to indicate whether we need call get_object()
or we can return early.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 4d7aa60da0f..edcb5d04cf9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -77,6 +77,7 @@ static struct ref_trailer_buf {
 } ref_trailer_buf = {STRING_LIST_INIT_NODUP, STRBUF_INIT, STRBUF_INIT};
 
 static struct expand_data {
+	unsigned int need_get_object_info : 1;
 	struct object_id oid;
 	enum object_type type;
 	unsigned long size;
@@ -322,10 +323,13 @@ static int objecttype_atom_parser(struct ref_format *format, struct used_atom *a
 {
 	if (arg)
 		return strbuf_addf_ret(err, -1, _("%%(objecttype) does not take arguments"));
-	if (atom->deref)
+	if (atom->deref) {
 		oi_deref.info.typep = &oi_deref.type;
-	else
+		oi_deref.need_get_object_info = 1;
+	} else {
 		oi.info.typep = &oi.type;
+		oi.need_get_object_info = 1;
+	}
 	return 0;
 }
 
@@ -334,16 +338,23 @@ static int objectsize_atom_parser(struct ref_format *format, struct used_atom *a
 {
 	if (!arg) {
 		atom->u.objectsize.option = O_SIZE;
-		if (atom->deref)
+		if (atom->deref) {
 			oi_deref.info.sizep = &oi_deref.size;
-		else
+			oi_deref.need_get_object_info = 1;
+		} else {
 			oi.info.sizep = &oi.size;
+			oi.need_get_object_info = 1;
+		}
 	} else if (!strcmp(arg, "disk")) {
 		atom->u.objectsize.option = O_SIZE_DISK;
-		if (atom->deref)
+		if (atom->deref) {
 			oi_deref.info.disk_sizep = &oi_deref.disk_size;
-		else
+			oi_deref.need_get_object_info = 1;
+		}
+		else {
 			oi.info.disk_sizep = &oi.disk_size;
+			oi.need_get_object_info = 1;
+		}
 	} else
 		return strbuf_addf_ret(err, -1, _("unrecognized %%(objectsize) argument: %s"), arg);
 	return 0;
@@ -354,10 +365,14 @@ static int deltabase_atom_parser(struct ref_format *format, struct used_atom *at
 {
 	if (arg)
 		return strbuf_addf_ret(err, -1, _("%%(deltabase) does not take arguments"));
-	if (atom->deref)
+	if (atom->deref) {
 		oi_deref.info.delta_base_oid = &oi_deref.delta_base_oid;
-	else
+		oi_deref.need_get_object_info = 1;
+
+	} else {
 		oi.info.delta_base_oid = &oi.delta_base_oid;
+		oi.need_get_object_info = 1;
+	}
 	return 0;
 }
 
@@ -735,10 +750,13 @@ static int parse_ref_filter_atom(struct ref_format *format,
 	used_atom[at].type = valid_atom[i].cmp_type;
 	used_atom[at].source = valid_atom[i].source;
 	if (used_atom[at].source == SOURCE_OBJ) {
-		if (deref)
+		if (deref) {
 			oi_deref.info.contentp = &oi_deref.content;
-		else
+			oi_deref.need_get_object_info = 1;
+		} else {
 			oi.info.contentp = &oi.content;
+			oi.need_get_object_info = 1;
+		}
 	}
 	if (arg) {
 		arg = used_atom[at].name + (arg - sp) + 1;
@@ -1910,7 +1928,6 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	struct object *obj;
 	int i;
 	int ret;
-	struct object_info empty = OBJECT_INFO_INIT;
 
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
 
@@ -2078,10 +2095,11 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 					       oid_to_hex(&ref->objectname), ref->refname);
 	}
 
-	if (need_tagged)
+	if (need_tagged) {
 		oi.info.contentp = &oi.content;
-	if (!memcmp(&oi.info, &empty, sizeof(empty)) &&
-	    !memcmp(&oi_deref.info, &empty, sizeof(empty)))
+		oi.need_get_object_info = 1;
+	}
+	if (!oi.need_get_object_info && !oi_deref.need_get_object_info)
 		return 0;
 
 
-- 
gitgitgadget

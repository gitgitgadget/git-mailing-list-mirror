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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB675C4320E
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C334A610CC
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbhHMIYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbhHMIXt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4800C0613A3
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id g138so6324086wmg.4
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fOADI/trlN6mNVmwFa7qg+nRyb7bve53nFF5H0UTQbo=;
        b=LpUEekryTfxCTWfVNEPDJoEaXm5LQRvM0q1K75Ko28ewH5iaU2OKXjD43GwStWmzKT
         UVTlkZW8309P/YotIeov4waE1PVRYHFhd6fYQNRyHWw7XKzcd7nioKtCLlP+O7qwYESH
         x/Noe1pK733vpVYBJys134RGAxrJA+BPpFs+WG1IXXws5y75Jy84tIJw6NbgZw1WGaER
         HvjK03As49gfeYUOqIOlHRepYCnNmlf89CNlEg8uX11Nh9w6/QN2vuxvxShK6iUPaHHr
         ikuxoelb3NWfGoktnFowIIfBtueAvNoTLaGl7DEWNfyYiCwZDlZhdu1mQrs4EhDmsCle
         ta4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fOADI/trlN6mNVmwFa7qg+nRyb7bve53nFF5H0UTQbo=;
        b=qzU+M5gHZ/hxns18djIvYus09q1F1rBi2mVL4VNiuvuPvZpA7DEGku96Adh41EPFfV
         zwpSliokNOJKzc4OkiTGmkTmeWQCV/6KBS96d4l6fFYz0hKNnNKEYgZEzyRnq6hAwjTI
         LgEpPQyiGskZEv1paFf1Ankh4JRn9CZmuRuoki29wK3vnZccWVYkapo2H4jaUYMrKku/
         R1D2J+mZouE7jJ/KiAUS1AQMUlbF1Tge5x1So10tO8QscVfM3hxtcIOUR10QWKZgG6LV
         /N9ExSWoQ5mzFi22mVse4/LkmAivvYRwXUqj8UBMne2SJnhHotnWIbEM+2IWZvoD4M2W
         anoQ==
X-Gm-Message-State: AOAM531i26MbSDz6Kjpuc1txV8Kn2FXASDmbchjX0sLzFdwrdEpCOM/P
        BNt4dfTAYCbG9FvUKFnNPW2J0bUUcEQ=
X-Google-Smtp-Source: ABdhPJxd7hZZi3YTUfZJUX6qWKwrfIcPdvEJ9WATivmL0SjrTiNdz1/zVCS4G7VPreGTjPjcJYmeUw==
X-Received: by 2002:a1c:80c9:: with SMTP id b192mr1468430wmd.73.1628843001393;
        Fri, 13 Aug 2021 01:23:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm705306wmi.42.2021.08.13.01.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:21 -0700 (PDT)
Message-Id: <898e36a92b778a7ec9dfb4f7780dc2dcf95057c1.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:22:58 +0000
Subject: [PATCH 15/27] [GSOC] cat-file: re-implement --textconv, --filters
 options
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

After cat-file reuses the ref-filter logic, we re-implement the
functions of --textconv and --filters options.

Add members `cat_file_cmdmode` to struct `ref_array_item`,
so that struct `batch_option` member `cmdmode` will be passed
to ref-filter, and then ref-filter will take use of it to filter
the content of the object in get_object().

Use `actual_oi` to record the real expand_data: it may point to the
original `oi` or the `act_oi` processed by `textconv_object()` or
`convert_to_working_tree()`. `grab_values()` will grab the contents
of `actual_oi` and `grab_common_values()` to grab the contents of origin
`oi`, this ensures that `%(objectsize)` still uses the size of the
unfiltered data.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/cat-file.c |  2 +-
 ref-filter.c       | 37 +++++++++++++++++++++++++++++++++++--
 ref-filter.h       |  1 +
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 034094dc640..77b470687e1 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -217,7 +217,7 @@ static void batch_object_write(const char *obj_name,
 			       struct expand_data *data)
 {
 	int ret;
-	struct ref_array_item item = { data->oid, data->rest };
+	struct ref_array_item item = { data->oid, data->rest, opt->cmdmode };
 
 	strbuf_reset(scratch);
 	strbuf_reset(err);
diff --git a/ref-filter.c b/ref-filter.c
index f83b6f83494..f7c448f6fa1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "cache.h"
 #include "parse-options.h"
@@ -1759,6 +1760,9 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 {
 	/* parse_object_buffer() will set eaten to 0 if free() will be needed */
 	int eaten = 1;
+	struct expand_data *actual_oi = oi;
+	struct expand_data act_oi = {0};
+
 	if (oi->info.contentp) {
 		/* We need to know that to use parse_object_buffer properly */
 		oi->info.sizep = &oi->size;
@@ -1772,19 +1776,47 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 		BUG("Object size is less than zero.");
 
 	if (oi->info.contentp) {
-		*obj = parse_object_buffer(the_repository, &oi->oid, oi->type, oi->size, oi->content, &eaten);
+		if ((ref->cat_file_cmdmode == 'c' || ref->cat_file_cmdmode == 'w') && !ref->rest)
+			return strbuf_addf_ret(err, -1, _("missing path for '%s'"),
+					       oid_to_hex(&act_oi.oid));
+		if (oi->type == OBJ_BLOB) {
+			if (ref->cat_file_cmdmode == 'c') {
+				act_oi = *oi;
+				if (textconv_object(the_repository,
+						    ref->rest, 0100644, &act_oi.oid,
+						    1, (char **)(&act_oi.content), &act_oi.size))
+					actual_oi = &act_oi;
+			} else if (ref->cat_file_cmdmode == 'w') {
+				struct strbuf strbuf = STRBUF_INIT;
+				struct checkout_metadata meta;
+				act_oi = *oi;
+
+				init_checkout_metadata(&meta, NULL, NULL, &act_oi.oid);
+				if (!convert_to_working_tree(&the_index, ref->rest, act_oi.content, act_oi.size, &strbuf, &meta))
+					die("could not convert '%s' %s",
+					    oid_to_hex(&oi->oid), ref->rest);
+				act_oi.size = strbuf.len;
+				act_oi.content = strbuf_detach(&strbuf, NULL);
+				actual_oi = &act_oi;
+			}
+		}
+		*obj = parse_object_buffer(the_repository, &actual_oi->oid, actual_oi->type, actual_oi->size, actual_oi->content, &eaten);
 		if (!*obj) {
 			if (!eaten)
+				free(actual_oi->content);
+			if (actual_oi != oi)
 				free(oi->content);
 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
 					       oid_to_hex(&oi->oid), ref->refname);
 		}
-		grab_values(ref->value, deref, *obj, oi);
+		grab_values(ref->value, deref, *obj, actual_oi);
 	}
 
 	grab_common_values(ref->value, deref, oi);
 	if (!eaten)
 		free(oi->content);
+	if (actual_oi != oi)
+		free(actual_oi->content);
 	return 0;
 }
 
@@ -2193,6 +2225,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 	FLEX_ALLOC_STR(ref, refname, refname);
 	oidcpy(&ref->objectname, oid);
 	ref->rest = NULL;
+	ref->cat_file_cmdmode = 0;
 
 	return ref;
 }
diff --git a/ref-filter.h b/ref-filter.h
index ef3d89d73d4..853eb554a5b 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -39,6 +39,7 @@ struct ref_sorting {
 struct ref_array_item {
 	struct object_id objectname;
 	const char *rest;
+	int cat_file_cmdmode;
 	int flag;
 	unsigned int kind;
 	const char *symref;
-- 
gitgitgadget


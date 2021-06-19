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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734A2C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E86C6120A
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbhFSHF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 03:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbhFSHFS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 03:05:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EABC06175F
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 00:03:07 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o3so13252977wri.8
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 00:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=QrPsR+/+Y0fx01ZuHjFa/T8LVqomMCEjfnnX4uUqrmU=;
        b=TSBEMfHR2J5EFh4JwLtngSeQOkH0I6IMIqnRK/LCCFqXyguIAXwKWHB9LpxbHhLvjn
         FyDwEEAzepHKJmECerBH5e4fvgkB4M12vRjpXHYZLCuG3T8r/LC4CPRpye95rwZUe0Nr
         WV+etqnCLfYmj9LcDRCHvJa81+j6Rj8vENaK1Bgh0AlCTUScvsHQg38ouYP8knf8NP2V
         LSPbIc7ZZt3GAqmcqSnC72ulgf8eFv1Tqi+WDS4y/mvGvn+1y0txNtzwCpFQjvMsR1t/
         2V4GdNC0YBJXMlUebJf2lYxYprlG64gFHb3XwHTiqXoqxMQ5VrQ4Chxj+CYKJNET5DhP
         1CKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=QrPsR+/+Y0fx01ZuHjFa/T8LVqomMCEjfnnX4uUqrmU=;
        b=IjrwSOexe4Yu1hz/mNhQaPG0uaZrlEPtlUv8EP9du9CB58ETnkUTqg6EPCOXhnjeLO
         PvAlpMd/mP8ElVBExNKHTkXAvzynjRcvRwoUtEjNA0kI/z+PhIoPfDHs5BA6pqv4web9
         UM104tslAwclSRNRmZsSFMCLPjrvVahfWWZtL0dSSA0jl5Ed5ZRi2kmwV/7zXxD7THmT
         I7kb2i10v5DWHxde1xXVRadSuRXzhZmLk19IVMERqHWf9U+Fhs8TNmyOeaWKQVRVDF22
         YpAFTph7IKxFMKTG6QgDKQ217jTDLhTzABH37adzuzYRC/5mJHfAysOIK6UPsQv1o0HR
         q7BA==
X-Gm-Message-State: AOAM531nXRfM0x8LfMsrd+HD0f1durg2aR6hc0h055HbgQaySzOAkaR0
        AaIga1nCzLVsGxFXXtUkB3PfQobW2L0=
X-Google-Smtp-Source: ABdhPJxtfOHLQk5fKus9NLVXEeNpvdxcpnCd4QdssNdubAE12Ben6ceFwkk8wV7TJptWvcIPImHBRw==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr16302508wrr.35.1624086186516;
        Sat, 19 Jun 2021 00:03:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5sm11784215wrd.25.2021.06.19.00.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 00:03:06 -0700 (PDT)
Message-Id: <35a376db1fc144c68f72273363882ded42501cfd.1624086181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
References: <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
        <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Jun 2021 07:02:56 +0000
Subject: [PATCH v3 06/10] [GSOC] ref-filter: pass get_object() return value to
 their callers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

Since in the refactor of `git cat-file --batch` later,
oid_object_info_extended() in get_object() will be used to obtain
the info of an object with it's oid. When the object cannot be
obtained in the git repository, `cat-file --batch` expects to output
"<oid> missing" and continue the next oid query instead of letting
Git exit. In other error conditions, Git should exit normally. So we
can achieve this function by passing the return value of get_object().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 10c78de9cfa4..58def6ccd33a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1816,6 +1816,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 {
 	struct object *obj;
 	int i;
+	int ret = 0;
 	struct object_info empty = OBJECT_INFO_INIT;
 
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
@@ -1972,8 +1973,9 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 
 	oi.oid = ref->objectname;
-	if (get_object(ref, 0, &obj, &oi, err))
-		return -1;
+	ret = get_object(ref, 0, &obj, &oi, err);
+	if (ret)
+		return ret;
 
 	/*
 	 * If there is no atom that wants to know about tagged
@@ -2005,8 +2007,10 @@ static int get_ref_atom_value(struct ref_array_item *ref, int atom,
 			      struct atom_value **v, struct strbuf *err)
 {
 	if (!ref->value) {
-		if (populate_value(ref, err))
-			return -1;
+		int ret = populate_value(ref, err);
+
+		if (ret)
+			return ret;
 		fill_missing_values(ref->value);
 	}
 	*v = &ref->value[atom];
@@ -2580,6 +2584,7 @@ int format_ref_array_item(struct ref_array_item *info,
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
+	int ret = 0;
 
 	state.quote_style = format->quote_style;
 	push_stack_element(&state.stack);
@@ -2592,10 +2597,10 @@ int format_ref_array_item(struct ref_array_item *info,
 		if (cp < sp)
 			append_literal(cp, sp, &state);
 		pos = parse_ref_filter_atom(format, sp + 2, ep, error_buf);
-		if (pos < 0 || get_ref_atom_value(info, pos, &atomv, error_buf) ||
+		if (pos < 0 || (ret = get_ref_atom_value(info, pos, &atomv, error_buf)) ||
 		    atomv->handler(atomv, &state, error_buf)) {
 			pop_stack_element(&state.stack);
-			return -1;
+			return ret ? ret : -1;
 		}
 	}
 	if (*cp) {
-- 
gitgitgadget


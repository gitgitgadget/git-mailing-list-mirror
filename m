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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CE8C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FBCA61969
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFYQFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhFYQEy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 12:04:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBF4C061766
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p8-20020a7bcc880000b02901dbb595a9f1so6170393wma.2
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=lI8pf131+MruoryekmU3fntYx6Qx5psRY7MDQCJZF8c=;
        b=WFazJh5YJvq6k0cWChurbEH2tJiU7IlyGPkHdHEa7ofmv8PoHDHrGHuQp23vPm2JDg
         OEby6YWoSg7ryVidKq+2mDGF1D+wJ85T5Yrh0tOijHLuO0Y/MUy9YPJYBChpNrF/7Dv/
         CXrRDTKR/LHvK17nDnWHq4FvOHlkulrWWmzaftYrO4U6MlIiAAMIlBYGGJNJuCPp5upS
         QJJNu4ApwxmVnUKLeMoBtWadJ4SkImokAuI26rRXwSfyN8tEyIFXX7icmFr2zqDAZjBa
         qHKPRxc5VWHbX09d4PbT26fs3fUfdWbDKua027pPccolW+mQvTv6HY4LyWXEwNiIQW0m
         Gc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=lI8pf131+MruoryekmU3fntYx6Qx5psRY7MDQCJZF8c=;
        b=U7mKgMrEzd7F4LNVhEWZpu1MLZcIbO4Vu3MaH5uKE+YN44vMo74zlI4f0q6AjbdAvj
         nCkU0wNo6FZmUElSN5XHSQFMD9+uIREniXOxOVBByL7B42Cv7bqzNN6oZYEwwYMriQ1Y
         GfVoUMMTien1nt0050O/VKO+YeDbU4w8NRa/ClsW7GgkVU6CF/3TFZeQeU2Ar6oSFP5H
         MtqWx9W68RzDifucUtYOE+b1O29UasjzAO3GtApRoxVBFD/lwLuWZ9sWK99sA+S5Y5ai
         /6XTXW5U2RpB+30a5kPHqOX1oGK0Ckdgj8UUzvHTqXSl3p6VUgwS3wA5GJ+xZjAVXYA7
         zhgA==
X-Gm-Message-State: AOAM530luMkxzAB8VpSTFpbxIyqxA+bEgGjj20UvTPDXYbN6yio8l/qq
        T3GX/sf38lmUvYCbeIjKqjW3iVp66Bc=
X-Google-Smtp-Source: ABdhPJypX2khtNsSBjYv1ntay1AzJm+XSi/r3gUnNQRZmauPc0Z+nyqauQAGA5QSpRfS3hhpl96qaQ==
X-Received: by 2002:a05:600c:2318:: with SMTP id 24mr11884817wmo.36.1624636951471;
        Fri, 25 Jun 2021 09:02:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x81sm13639544wmg.36.2021.06.25.09.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:02:31 -0700 (PDT)
Message-Id: <67f1a3cca9a85fa94cb0158de71b36ce3dd6b444.1624636945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
        <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Jun 2021 16:02:16 +0000
Subject: [PATCH v5 06/15] [GSOC] ref-filter: pass get_object() return value to
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

Because in the refactor of `git cat-file --batch` later,
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
index 10c78de9cfa..58def6ccd33 100644
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


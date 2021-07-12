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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EBDC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7281061153
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhGLLt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhGLLty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 07:49:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91F7C0613EE
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i94so25173386wri.4
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=LqZxe2oaGgcckekUnkv6Q220abzHTuwYCh+rcznSRcU=;
        b=emm7hWbr0PT4PNq6RqmBJiXvQMLqmcZSXltDO5ZCxnrh6A6fB56KcS7YoGMgYKtprB
         tE0nmE4+0Jy3CMHGXod5kMyNluDZG9SLNk0dYWOUybqTVwzYYN4V7Anax7G1wYa7gPM5
         Y32VWU+lmkMPXZfs+5fs7FoXGx4h1ZxOTTRDDFpYaiuOOTt8o5DFX3zKfzA68TSrFTOP
         ZNTREamtBaQtWxLN2TvKQEVF1jG9nMz1OPrsCL0rxP4teO01udbeWqs1sFCeBkY+X/Zs
         upv96SGjJLCcNx3cvjDXcBRzUvXw/qlFvyMk/7MzorwCGBBfJAzQum4RSSf32xJ6o168
         eHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=LqZxe2oaGgcckekUnkv6Q220abzHTuwYCh+rcznSRcU=;
        b=M7dhYCEfO13j8abebK1km9OQGZF/+v+K+hkGsPPB+G8CzhSDVqsxP14qmlb26v8AWw
         Ny1SSEpJ0LpcycV5YEaRpLKJfTBYw2LY4/Zf5cSTX5h4q4lQ/RY/V0KyQZiYeod/P4K8
         4ATCNud9LBc6YxjzD4kcyDL+vsHj3BMlPGuTqD90ZolgULXI7Qz+c+A6CGu5VQqZHJDk
         PSJWDuMm+ff2RXjcFm1A7so/0RQD4DHu4RKe7nxminSnx5JGfS0I1a9P/BLgKP9SJxAI
         yo4G5lBXgzfAXqjgDGRjj88Qh0cTkfv0HHZG/8/0mG5vaUvEtc8O/mq7HN8F7AixWsYJ
         kZ4g==
X-Gm-Message-State: AOAM532/fWjTqP2iymN6b2kEleYyMYWaXYZOWShLadMPPyfkILQAINA+
        eOvqQTzqLd28wC9kSAMX0g7RGyk2RMg=
X-Google-Smtp-Source: ABdhPJyMnAVMITUf1oaKT+FRlsJRAEyR/APp1iqnnPob5YMjS+vbZgJuXrx18i98AtImZcCXxkz/0g==
X-Received: by 2002:a5d:408a:: with SMTP id o10mr19667461wrp.272.1626090425406;
        Mon, 12 Jul 2021 04:47:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6sm1589747wmi.3.2021.07.12.04.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:47:05 -0700 (PDT)
Message-Id: <e1aca51d500736722295b4c371c9698c168261cd.1626090419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 11:46:48 +0000
Subject: [PATCH 08/19] [GSOC] ref-filter: pass get_object() return value to
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
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>,
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
index ee6c906f22d..3189872188a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1817,6 +1817,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 {
 	struct object *obj;
 	int i;
+	int ret;
 	struct object_info empty = OBJECT_INFO_INIT;
 
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
@@ -1973,8 +1974,9 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 
 	oi.oid = ref->objectname;
-	if (get_object(ref, 0, &obj, &oi, err))
-		return -1;
+	ret = get_object(ref, 0, &obj, &oi, err);
+	if (ret)
+		return ret;
 
 	/*
 	 * If there is no atom that wants to know about tagged
@@ -2006,8 +2008,10 @@ static int get_ref_atom_value(struct ref_array_item *ref, int atom,
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
@@ -2581,6 +2585,7 @@ int format_ref_array_item(struct ref_array_item *info,
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
+	int ret;
 
 	state.quote_style = format->quote_style;
 	push_stack_element(&state.stack);
@@ -2593,10 +2598,10 @@ int format_ref_array_item(struct ref_array_item *info,
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


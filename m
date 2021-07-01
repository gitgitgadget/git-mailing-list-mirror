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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959DFC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFEB61414
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhGAQK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhGAQKv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:10:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABA1C0613DB
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 09:08:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j34so4858383wms.5
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 09:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Ksg2FtXRhnosuihFiEAuxtS7xyeUFAMa47e/tO+Lqq4=;
        b=nGF0Exmn7Y60uHHxTTBypSxDE0xZBqTk4gow4zPqLkA7MXfGM/YACmX6DsSEzGR1Ru
         UA/azmAFk+mbEq8f4FvLlQGnqn+ZfVfMvXtVXud36lFdJ3QuyfVHqSQL/ZnYbls88QcK
         eZZeVGkDvyUtnrgaoFT0xl2pMG0mLGgTxgdmrUbTvO6+RSOCEMFRISaGVaYJ2uQZgeH4
         iPWwK2pCd7nwkcM+BPWx4rmi7j08o0oRriabWw3s3rZqivGuVc1qBjLexmPhXfdcs62v
         X/kvVyOiFObnQ5fuYAtCZDvGFm9CuBSAAo0+PU4769n+zXzrszsj3Zmc7jUgKK5SFxRF
         JEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Ksg2FtXRhnosuihFiEAuxtS7xyeUFAMa47e/tO+Lqq4=;
        b=F01G+mcI+/xc3XLGIVWyqqhEVsMX2Crk+TYcpxgmXNDhKeyQQYSZz3CYf7DFfeJqiC
         dmrYnRS6BC3x3ZDsshqEbzvAlJ2nOEQZt0s4GsMrZt8YApMGo6dg3hgNkgh6tM3rXRiv
         JryVyG/uldbisbQ6krpBcOkzo/EqA07ZJ1dJ6lclLiorNWjrIIcSq/J1mk01qziO344+
         XYZmzBzQXlZY0TayXUV7hrKGJmvxXK2L7YcWI3gS+QtwDJrwh57iq7MXFb1rTcf5grsF
         vB3g32iiZJQ5iJYTrlE5XoEuZ7Y56yzN1ecWtVyxLPeerVp429d4IP6AbeSTUI+aI4xr
         UYQw==
X-Gm-Message-State: AOAM533R1SvvOoR8+qns2D1fGWb/YdV1irF/3mwWtyxu/odh4uJlgGqT
        eT09UBU9M1PbEupEyc+FxPTA52LD/FM=
X-Google-Smtp-Source: ABdhPJyUiV6Y3FYUAV4LeORX3cTQPkFsAOwEQwGlIPFziNYen037+uuP1Eu+novYfvAx9prt6xzDQw==
X-Received: by 2002:a1c:7917:: with SMTP id l23mr469448wme.99.1625155698472;
        Thu, 01 Jul 2021 09:08:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15sm386704wri.75.2021.07.01.09.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:08:18 -0700 (PDT)
Message-Id: <d7af86dc1cb6ccee5b9ad6d4da13334c0d4c7dcc.1625155693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.989.git.1625155693.gitgitgadget@gmail.com>
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 16:08:04 +0000
Subject: [PATCH 06/15] [GSOC] ref-filter: pass get_object() return value to
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
index 10c78de9cfa..e4988aa8a24 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1816,6 +1816,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 {
 	struct object *obj;
 	int i;
+	int ret;
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
+	int ret;
 
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


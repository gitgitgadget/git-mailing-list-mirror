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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5A1C49EA4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22BF0611CE
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhFVDXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 23:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhFVDXR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 23:23:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E36C061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:21:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m41-20020a05600c3b29b02901dcd3733f24so744526wms.1
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=QrPsR+/+Y0fx01ZuHjFa/T8LVqomMCEjfnnX4uUqrmU=;
        b=fcEUaJVIjohvnXzREzHuZbUA3hwQ1t64vpyWzQF6UsFp+wxuyPyewq1OYrqDef2IpH
         gK49zuKVR83jVv+8Bgkk3s9lophX+wBqT7hRUXLzKPpsxPm/wG9MVrikxHAdTO/ySqMa
         6ySN0a7H/lJQvmP3F4hrfzTCzhURtkkuDigSjnfT0nvt1F+Yr+50RaIC/zho0ZicaRxp
         UAg+ayxG2RC9a0GrppE9SBV/3FvNsQ+ciFXRviJp+sXqyWqAIRnW2kEsGh71Q/6X1BLt
         P0ata/E0kqdrJhmLJ2aCB82TmnqYRIKaD005GED4JMm355cEoXDV9fPfRj1afTTTQFeK
         1Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=QrPsR+/+Y0fx01ZuHjFa/T8LVqomMCEjfnnX4uUqrmU=;
        b=q3O2TTBPylJaySlUNydIgTAIJjW+hFSGWaYwegXcyJ8y/2Q4hmCJpxl+8OWMGThnqC
         cso3hPeqBGIqEhY/H8LdPZ0qf0hUljotNVTs2dlOes5fI/TP9Z7sJb2759NbtlcmNlfX
         U+5BNG7DX/ZsqhjQ0ghze+OCPJggbOigqrFUnAL8FLIVoGci3pY0m1zL/h6K6JdIY0ln
         lcPew+/B7aLniJiPDDbY/2oTrN4Qw4SJv/UhOgc1x9wmt2W5gGHu4PTMmFDqIdcATH/f
         9yZ+/VGRuNcpNhrPs+JMkqgNKH6aWx3sWMpYTUvKHkmpY7j2A3fhNJkwJkiLY6twhNz6
         S6dw==
X-Gm-Message-State: AOAM5307bQR2bglruswamUS5oTuysqlOKvA1Kf5tnRRD3X+RE3vW1d49
        SKs5Tv8IyKYFMAMBy77m5S3PE2m8gaE=
X-Google-Smtp-Source: ABdhPJyRAi/4nIDoTs1AhyG13j7dgtN2w8zkUtNv0vtPv6PpsQ0JyLjLJMiff8W9zmCavlExMiQ1kw==
X-Received: by 2002:a05:600c:4f10:: with SMTP id l16mr1753233wmq.5.1624332059681;
        Mon, 21 Jun 2021 20:20:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v22sm776938wmh.40.2021.06.21.20.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 20:20:59 -0700 (PDT)
Message-Id: <05682bccf9f947ce77ad035c02038286d0661c35.1624332055.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
References: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
        <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 03:20:46 +0000
Subject: [PATCH v4 06/14] [GSOC] ref-filter: pass get_object() return value to
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


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A89C49EAF
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C94F461C5E
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhF0Mi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 08:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhF0MiW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 08:38:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DA2C061768
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:35:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p8-20020a7bcc880000b02901dbb595a9f1so9066074wma.2
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Ksg2FtXRhnosuihFiEAuxtS7xyeUFAMa47e/tO+Lqq4=;
        b=EbrALKPuSxMpiQ6HyYPx9Ma6zf20QWka8C6EHblL/D/hvwBTFTqEizBJSjfP2gOv2T
         p/bj+IfY18SEWQQRJZkENygUALwgQAPbtanwHV2wlFwyEMul07ryrgYBqru5CkAKrx0g
         OIa5W+DgMVnWjGTolA1OuJtAtcGswLRrxa0/hvDUGjXmt5hUd3OzOLH2E2OFztSTrxe0
         fTI1tILMNoGXz8V4qwDcK1ANC3uzcDhr0eYtz1g6unC7tWMksUkuEl5gLswN/MJAtTR/
         BoSlgEvfGqlbqLQ0C2AKZZ703CB0qDMNnlwlMz6sPCHlmsqPRP9Q2vQ1ca7+SZ0rl8KV
         rhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Ksg2FtXRhnosuihFiEAuxtS7xyeUFAMa47e/tO+Lqq4=;
        b=DZHUmx0NnNM8mOKpvCsWCQTcMnlTTBYIhP5oNVJ9y+EEwYcOiBhEFPLAAc5+lm8ykf
         3PbdHPxkKen8uRDofNryQB0AIozCn9BDYENMDKYcUvweCRSKxe1tAgEV++JqtRdYfSjd
         aW78aZHXxjyLrMlvQzAyBgAqACaFjUVaTI1c1d56ETOkA7aLVChISLeTQtI6SkYq8dhX
         BCUwTZaZdwN7Sa4Hng8DjKBJCHlMosUZeCBCx3Jvf4PXHviBKvW78wcfdWLYRRsCb3mR
         omYlWBp3N5LKQNWvqtlIYI73UU6qtX9HNWF5GUxoY5GRLWECsFYiuW71CPKGzG6WUsDj
         YNFQ==
X-Gm-Message-State: AOAM5337wgGHd8t2rFfuufAJAPfyHSw2HgsP7bW8RuKplpd120BDYwBA
        5rgCYPW6tYw6YAdDQH0GTbrCCH8RPrY=
X-Google-Smtp-Source: ABdhPJzTPHrIXfRU8f230m6CJT3/uJoc/x+A/b/zzQYuLbM+dM4Pa/Z8/t+asIos4BP+9SpwvmJlVQ==
X-Received: by 2002:a05:600c:4e93:: with SMTP id f19mr15548726wmq.169.1624797356170;
        Sun, 27 Jun 2021 05:35:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11sm11878364wre.57.2021.06.27.05.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 05:35:55 -0700 (PDT)
Message-Id: <9873354930a51d6480beaf20a8e096bdae247f39.1624797351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
References: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
        <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Jun 2021 12:35:41 +0000
Subject: [PATCH v6 06/15] [GSOC] ref-filter: pass get_object() return value to
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


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8362AC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3CF61468
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFONbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhFONbS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 09:31:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9EBC06124C
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:29:13 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id t11-20020a1cc30b0000b02901cec841b6a0so908250wmf.0
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8t2HQy4s1AMM54eo+tWceP4/zrvrBW6bxYmPB8mQ9/A=;
        b=kULpzdfTbkkci3tdD0yvQ0yVRtUazmq7eBBE0r7m/sNq9LrZwJHRgygMsl3NAjFBx2
         cPoA5yF4I2aUFiUzpJ1owfoEEF3q/hCBNv70bR8TwUWI+l+x6MXVYCsTGuooZhJIFXlJ
         8busLLQgowKREfTT5ye+cOB99bALorftmvxkEBeRfFpliwsYWRPzuVOsCxAnSZvdYmqW
         z7aeLcGZ+AXnd62ilyRZFBTLN2hcB/qKbp9NIzcgo0hwCVPYGA+hrQYgbV/L8vGQKJnz
         9ocYVhWDdf+qElLhOxcY9JMF/6wkzHjKZSFdgh2GQE1iUSckt9m3Ugj5Q/V9ypgpF5An
         jByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8t2HQy4s1AMM54eo+tWceP4/zrvrBW6bxYmPB8mQ9/A=;
        b=fnj7P9D0G+KM5L/A/lC4TKgoglq3fZC+EnJXoA8FP7oHmg4fcKWKqhFzFWyX+ciODV
         Spnz38/HB1csR7LsGMMCKzq2GrJefQLWI3G5zzSAtu4WJ7IlZ1Eflq9320vftIWw32CH
         c+7rI7ldEFVU2quBGOlR2j6EtyQKhK8iC5sAIwXnvOvNLEa49j51FWtBsOCaOmaFs7HR
         73XAJ+sb1LqSpQ0l2SrwVj6M28C+v9ufIp0GXQh59BlLwlWhuelHhMD8DI26FKMuBE+y
         pN1edBIdrHp+4CKXIaM9JiNaFrh5sSUxEw4/71217il/hhAG0NYnqSLvDCrLYh2T4Rv1
         HiMQ==
X-Gm-Message-State: AOAM531ZjKtnNlAK13rz7SxxZykvbSYt/9m2ztcy8mWEq1oDCr0sygK2
        Egtyfxw4FRXQZ4q7fBFbmJPpleqny0w=
X-Google-Smtp-Source: ABdhPJziwmegzTFWRNBvG3YNJ7ZUamF1oxEn8GFZleqoehMSK4q14NvgEeqmIpkYZwtuBXjBLdukFQ==
X-Received: by 2002:a7b:c097:: with SMTP id r23mr22933744wmh.30.1623763751737;
        Tue, 15 Jun 2021 06:29:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm18491462wrx.28.2021.06.15.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 06:29:11 -0700 (PDT)
Message-Id: <49063372e0035c5384f834d78854da56f5726d13.1623763747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
        <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 13:29:01 +0000
Subject: [PATCH v2 5/9] [GSOC] ref-filter: teach get_object() return useful
 value
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Let `populate_value()`, `get_ref_atom_value()` and
`format_ref_array_item()` get the return value of `get_object()`
correctly. This can help us later let `cat-file --batch` get the
correct error message and return value of `get_object()`.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8868cf98f090..420c0bf9384f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1808,7 +1808,7 @@ static char *get_worktree_path(const struct used_atom *atom, const struct ref_ar
 static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 {
 	struct object *obj;
-	int i;
+	int i, ret = 0;
 	struct object_info empty = OBJECT_INFO_INIT;
 
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
@@ -1965,8 +1965,8 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 
 	oi.oid = ref->objectname;
-	if (get_object(ref, 0, &obj, &oi, err))
-		return -1;
+	if ((ret = get_object(ref, 0, &obj, &oi, err)))
+		return ret;
 
 	/*
 	 * If there is no atom that wants to know about tagged
@@ -1997,9 +1997,11 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 static int get_ref_atom_value(struct ref_array_item *ref, int atom,
 			      struct atom_value **v, struct strbuf *err)
 {
+	int ret = 0;
+
 	if (!ref->value) {
-		if (populate_value(ref, err))
-			return -1;
+		if ((ret = populate_value(ref, err)))
+			return ret;
 		fill_missing_values(ref->value);
 	}
 	*v = &ref->value[atom];
@@ -2573,6 +2575,7 @@ int format_ref_array_item(struct ref_array_item *info,
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
+	int ret = 0;
 
 	state.quote_style = format->quote_style;
 	push_stack_element(&state.stack);
@@ -2585,10 +2588,10 @@ int format_ref_array_item(struct ref_array_item *info,
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
@@ -2610,7 +2613,7 @@ int format_ref_array_item(struct ref_array_item *info,
 	}
 	strbuf_addbuf(final_buf, &state.stack->output);
 	pop_stack_element(&state.stack);
-	return 0;
+	return ret;
 }
 
 void pretty_print_ref(const char *name, const struct object_id *oid,
-- 
gitgitgadget


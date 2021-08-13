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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C90C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B634610CC
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbhHMIYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbhHMIXz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CF5C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f12-20020a05600c4e8c00b002e6bdd6ffe2so3270331wmq.5
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xl3wEz5h/ZW0dKlQedupx1l6uCaGvRFZ7ih/9kSSfRY=;
        b=HnzovCXbFOGQDmra17RpyZRI8Oip8YnPtRf8Qn/H5EyDB+/zmtVlVmFaCvLWSKk8sr
         YOf+O8A7EZRNk9AB/fvN9+MYXB7d2HU+QxXMw5MKcTyhHToNgV6p7S+c0SD1mSy5cbYV
         Ni2e8gaOts3R4Hoe/mogKmbFE2eB58/y+jSRbgfH4mSNoq+4qMKhwwNeRdPt5QcrVwtX
         Ezsu+TOllzXUE7olwJQcimsccdHojc1YruEqj4REDtLPit/BW1GqRxyXDY4L1SQpHm/5
         QhLEynQs7ECo07gK1Z1dyjGYHN2lGdQbA6LZP0H6MNU4xqc0kC1iV1oYFB0sTBeowwoX
         ODhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xl3wEz5h/ZW0dKlQedupx1l6uCaGvRFZ7ih/9kSSfRY=;
        b=jdcMlaPdijQSGbBNjMWRs97JppZuP/7yyWXxwMhocXd+1qwjwnLOVSYQg0bTatQYKZ
         e0Om45poe3Ppi73MDugtCvJMhAY6wmXc7OirVTz6WHbd3FEe38nckL62msAeTHTY1TCQ
         DXAlI9bkN1KYB3BRg42xB7EvaNsSthcrrwGEQN2ogrehdLhC9vKlkWcq0zfQj7Z+cOQ4
         SX3CVz2bdLNuk2nBO2ddrk0M51ZrHO7Mt3Dp4+MBRTbiAvdHt5z2ZvXY8LlCqdAstHL6
         t/GC1F1TY99BPqnPw/9zx6lBRgD+UFTanZwGHFBEeOWaXw83PSmaGxKwi8B9kFoI7n/D
         baAg==
X-Gm-Message-State: AOAM533x3I8IVQ4TgX/wWmqCdK10u86tOTLXGnH2z/YFHz1e9FwvzlxS
        kEq96e7T1WyiRDr8JUI7GX4e6nsEeeA=
X-Google-Smtp-Source: ABdhPJzIt8mVewE45Hi5swYsOgTa6Qk8dvOHFiu2yAC/B7UsJTgu+AZ3DZ/jKdpMABL3ppv+ZMioGg==
X-Received: by 2002:a7b:c188:: with SMTP id y8mr1428192wmi.174.1628843007967;
        Fri, 13 Aug 2021 01:23:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w14sm803745wrt.23.2021.08.13.01.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:27 -0700 (PDT)
Message-Id: <d7af20a228b91d7990214ebe4fe7a5d5ee44d02b.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:23:09 +0000
Subject: [PATCH 26/27] [GSOC] ref-filter: reuse finnal buffer if no stack need
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

Because finnal_buf will be cleared before every time
we call format_ref_array_item(). So we actually add
content to an empty strbuf, We can add the object's
data directly to this finnal_buffer instead of adding
objects' data to state.stack->output first, then
copying to finnal_buf.

So add a can_reuse_final_buffer flag to struct
ref_format to check if we are use %(align), %(end),
%(if), %(then), %(else). if not, we can reuse the buf
of finnal_buf.

This can bring 2% performance improvement for
git cat-file --batch.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 36 +++++++++++++++++++++++++++++-------
 ref-filter.h |  3 ++-
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 6fbf38f1375..4d7aa60da0f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1083,6 +1083,13 @@ int verify_ref_format(struct ref_format *format)
 		if (reject_atom(format->cat_file_mode, used_atom[at].atom_type))
 			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
 
+		if (used_atom[at].atom_type == ATOM_ALIGN ||
+		    used_atom[at].atom_type == ATOM_END ||
+		    used_atom[at].atom_type == ATOM_IF ||
+		    used_atom[at].atom_type == ATOM_THEN ||
+		    used_atom[at].atom_type == ATOM_ELSE)
+			format->can_reuse_final_buffer = 0;
+
 		if ((format->quote_style == QUOTE_PYTHON ||
 		     format->quote_style == QUOTE_SHELL ||
 		     format->quote_style == QUOTE_TCL) &&
@@ -2710,7 +2717,14 @@ int format_ref_array_item(struct ref_array_item *info,
 	int ret;
 
 	state.quote_style = format->quote_style;
-	push_stack_element(&state.stack);
+	if (format->can_reuse_final_buffer) {
+		struct ref_formatting_stack *s = xmalloc(sizeof(struct ref_formatting_stack));
+		s->output = *final_buf;
+		s->prev = state.stack;
+		state.stack = s;
+	} else {
+		push_stack_element(&state.stack);
+	}
 	info->can_skip_parse_buffer = format->can_skip_parse_buffer;
 
 	cp = format->format;
@@ -2722,9 +2736,10 @@ int format_ref_array_item(struct ref_array_item *info,
 
 		if (cp < e->beg - 2)
 			append_literal(cp, e->beg - 2, &state);
-		if ((ret = get_ref_atom_value(info, e->at, &atomv, error_buf)) ||
-		    atomv->handler(atomv, &state, error_buf)) {
-			pop_stack_element(&state.stack);
+		if (((ret = get_ref_atom_value(info, e->at, &atomv, error_buf)) ||
+		    atomv->handler(atomv, &state, error_buf))) {
+			if (!format->can_reuse_final_buffer)
+				pop_stack_element(&state.stack);
 			return ret ? ret : -1;
 		}
 		cp = e->end + 1;
@@ -2739,16 +2754,23 @@ int format_ref_array_item(struct ref_array_item *info,
 		struct atom_value resetv = ATOM_VALUE_INIT;
 		resetv.s = GIT_COLOR_RESET;
 		if (append_atom(&resetv, &state, error_buf)) {
-			pop_stack_element(&state.stack);
+			if (!format->can_reuse_final_buffer)
+				pop_stack_element(&state.stack);
 			return -1;
 		}
 	}
 	if (state.stack->prev) {
+		assert(!format->can_reuse_final_buffer);
 		pop_stack_element(&state.stack);
 		return strbuf_addf_ret(error_buf, -1, _("format: %%(end) atom missing"));
 	}
-	strbuf_addbuf(final_buf, &state.stack->output);
-	pop_stack_element(&state.stack);
+	if(format->can_reuse_final_buffer) {
+		*final_buf = state.stack->output;
+		free(state.stack);
+	} else {
+		strbuf_addbuf(final_buf, &state.stack->output);
+		pop_stack_element(&state.stack);
+	}
 	return 0;
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 2b871f9ed4f..bf1d2fa18c6 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -94,10 +94,11 @@ struct ref_format {
 	int can_skip_parse_buffer;
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
+	int can_reuse_final_buffer;
 	struct list_head parsed_atom_head;
 };
 
-#define REF_FORMAT_INIT { .use_color = -1, .can_skip_parse_buffer = 1 }
+#define REF_FORMAT_INIT { .use_color = -1, .can_skip_parse_buffer = 1, .can_reuse_final_buffer = 1 }
 
 /*  Macros for checking --merged and --no-merged options */
 #define _OPT_MERGED_NO_MERGED(option, filter, h) \
-- 
gitgitgadget


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9F2C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 07:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC3060F5E
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 07:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbhHQHPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 03:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238067AbhHQHP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 03:15:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD234C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 00:14:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q10so27112494wro.2
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 00:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c+lkod6TvlzaEEpGl/bzbZCP/LPjMFQTQhy6j7hTJQ0=;
        b=eTvhvtF1ZVFmDVQoOLQBw0IzSAwsW1tQj3MDBCmq09sCa2tQNvKqYVp823F8OzXWZt
         hsENRDtZqXGKw1s/0qz/43HJX/IdAXXd5RgeWhh5O/lS+TCkyKV2zq0O4wCM14euia/n
         6Lk/xnBnPHM1a+DDn97QZlqfxBNJCI2UZefmCnagSH0kIJvwtVtkVRUo0DzbsSdXz7rF
         6DGlsKWCkZVh9t1Vgiqy/7Ic0RziOfaKIsXdq59mxIgNVed2LpCvTr29EGzAAUng16sV
         gjL3t9BwOenl+e3mzA2o/mT/aZ7C7UxUOXflvswGzkvL7wkcwyC2TyKU3yzo0Rl0XfJy
         JqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c+lkod6TvlzaEEpGl/bzbZCP/LPjMFQTQhy6j7hTJQ0=;
        b=M5s1C6KEqHZKojkGQzSjeknwFFGaP0YrpCWCQCIdLVBJMv/tCEoavR/4FtpswTqqm/
         LeJOifjkIOV80QhB1FwKWOGmClMEQoV6z2Gdy18GLmn4VIvNqJuco01Pxuogh30iUxMx
         hbo59quCghSFqf58SXD2gWaUY70xifRAFC/Ip1n3QdFTtkq1aiFiMrXkHGkgAEkCHyBr
         EDT9k6zzmq25E2pQQmN1IxzGILCIswWkPOmAMBJHkAdbEreHXlk8sYh/NAxRjD2iWD+o
         3VOkH6z76LWaJGQRkAQaMnYl6v6U6558Q9qQRHJTdduA2t1YzVD5tqHtpnonDiiD/iap
         II/A==
X-Gm-Message-State: AOAM5337aBx86yL2fQhKy8xdL7gGggtLR3IVA9N+YRygvo6so2PIS9NA
        kMVmNmoM94H+CkmyDYC6PE9qeAdBlrU=
X-Google-Smtp-Source: ABdhPJyA8FdMIFNbvFa5CWIJx4XutfWDtbJ3URu1E4kYfkqBdNkwOKIw24k5Ier1OBu+fX3ZUtSqcg==
X-Received: by 2002:a5d:6912:: with SMTP id t18mr2167618wru.359.1629184492548;
        Tue, 17 Aug 2021 00:14:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm1320811wrx.38.2021.08.17.00.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 00:14:52 -0700 (PDT)
Message-Id: <3760ff032bb1dec3812881fd408f8d78ec125477.1629184489.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.git.1629184489.gitgitgadget@gmail.com>
References: <pull.1020.git.1629184489.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 07:14:47 +0000
Subject: [PATCH 3/5] [GSOC] ref-filter: reuse final buffer
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

In format_ref_array_item(), we add the object data
to ref_formatting_state, and copy the data from
ref_formatting_state to final_buf at the end. There
are huge copies of data.

Because final_buf will be cleared before every time
we call format_ref_array_item(). So we actually add
content to an empty strbuf. We can add the object's
data directly to this final_buffer instead of adding
objects' data to state.stack->output first, then
copy to final_buf.

Add a can_reuse_final_buffer flag to struct ref_format
and create can_reuse_final_buffer() to check if we are
use %(align), %(end), %(if), %(then), %(else). If not,
we can reuse the buf of finnal_buf.

Reuse the buffer address of final_buf in
format_ref_array_item(), we directly add the data to the
final buffer, return the content to final_buf at the end.

This will bring performance improvements.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 39 ++++++++++++++++++++++++++++++++++-----
 ref-filter.h |  3 ++-
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 76a31fb79b1..7106d4c1c4c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1023,6 +1023,19 @@ static int need_parse_buffer(enum atom_type atom_type) {
 	}
 }
 
+static int can_reuse_final_buffer(enum atom_type atom_type) {
+	switch (atom_type) {
+	case ATOM_ALIGN:
+	case ATOM_END:
+	case ATOM_IF:
+	case ATOM_THEN:
+	case ATOM_ELSE:
+		return 0;
+	default:
+		return 1;
+	}
+}
+
 /*
  * Make sure the format string is well formed, and parse out
  * the used atoms.
@@ -1054,6 +1067,7 @@ int verify_ref_format(struct ref_format *format)
 			format->can_skip_parse_buffer = 0;
 		if (reject_atom(used_atom[at].atom_type))
 			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
+		format->can_reuse_final_buffer = can_reuse_final_buffer(used_atom[at].atom_type);
 
 		if ((format->quote_style == QUOTE_PYTHON ||
 		     format->quote_style == QUOTE_SHELL ||
@@ -2627,7 +2641,14 @@ int format_ref_array_item(struct ref_array_item *info,
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
 
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
@@ -2641,7 +2662,8 @@ int format_ref_array_item(struct ref_array_item *info,
 			append_literal(cp, e->beg - 2, &state);
 		if (get_ref_atom_value(info, e->at, &atomv, error_buf) ||
 		    atomv->handler(atomv, &state, error_buf)) {
-			pop_stack_element(&state.stack);
+			if (!format->can_reuse_final_buffer)
+				pop_stack_element(&state.stack);
 			return -1;
 		}
 		cp = e->end + 1;
@@ -2656,16 +2678,23 @@ int format_ref_array_item(struct ref_array_item *info,
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
index df54836a643..a62a14a2e43 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -92,10 +92,11 @@ struct ref_format {
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


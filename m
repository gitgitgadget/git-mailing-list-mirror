Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B758FC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8763E2076E
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gggGPEs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHUVGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgHUVGW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:06:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9DFC061575
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:06:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d16so3115453wrq.9
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dZAUavJ6VP6u1mFNS5vtETsXLir357LHWkUpb5ONnvg=;
        b=gggGPEs763bfwS3CDgRVs0ky/8YsTEa30/Mdamx+e36ToZ2qMhbA+2wPWqA7ZwEyKz
         1rHsmAMVyAqbUlFuSbP5NIYrJKSCmLYEMFSvdAjSZoC3/fZVWUdZKp5iklAWA3GpAWY1
         IrNt6fQdsZTZfupmLIozXhv5ugDqGkKiVuUb+aZ0eYKRWpQsoYjuRe1QPp1UWl5H8XzX
         r0F3dWwBDJIuYToTN80j+kxcmqw9deSQmS+GUT3lxW+fzG7vMt4XRhkixb489X+vYlFz
         cuRUfEUUt1WhZM3bQXYrgpi9jLhYc/BZ1mdYXSWQECNpeJqvOBUUwtLIQMzh+PC465Ag
         XkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dZAUavJ6VP6u1mFNS5vtETsXLir357LHWkUpb5ONnvg=;
        b=QY60FMGTA4ULXuRra/nvZoYerh7AEEcI3bxsSv2a9HvdYqcw7lPYZqXNKWdJF8+6dz
         L9Y8u4UOmtdSoemrZIUtuEuDKpYxAUIW+0l/jzYG07zWlLALgILv9dy4faRoMB0rcCaK
         XiRnALdFDfbY8LXyjPi69MQC7GTBeh7f/F3dWecG8IfT8Ig4pwk6a5u+08YNwLpmaDyb
         qTAQs7F95zrRtQ14m17sB7Bb6D9STWozOu2yOkIuHdLPHTDt9Lr/xJ+EI3yUjreeaCA/
         cn2G+Lqj94oX/q9qZmfL0D3K7+/emf/wAB+CZfEPkmjL9F79ZqHB1XIGF7aVyAO5ixs5
         hvcg==
X-Gm-Message-State: AOAM531fVnMCqFHr41Z3P+PyBkpBREpgsCr1sUVLnUtluGfoFWCux6KM
        PCefgw3ApNWu+boajfZg5UQP5JvAC7w=
X-Google-Smtp-Source: ABdhPJwwkqDr+Z7B5o4y+8xzs9i26x2TDuqGa6772xC07jVDYMUF4vz5X2XtMQQuClE5RDe/PVzz+w==
X-Received: by 2002:adf:bc4b:: with SMTP id a11mr4001498wrh.381.1598043979880;
        Fri, 21 Aug 2020 14:06:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16sm7417041wmc.7.2020.08.21.14.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:06:19 -0700 (PDT)
Message-Id: <712ab9aacf240a02d808af6b6837e682b929493c.1598043976.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.707.v3.git.1598043976.gitgitgadget@gmail.com>
References: <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
        <pull.707.v3.git.1598043976.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 21:06:15 +0000
Subject: [PATCH v3 3/4] pretty.c: refactor trailer logic to
 `format_set_trailers_options()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

Refactored trailers formatting logic inside pretty.c to a new function
`format_set_trailers_options()`.

Also, introduced a code to get invalid trailer arguments. As we would
like to use same logic in ref-filter, it's nice to get invalid trailer
argument. This will allow us to print accurate error message, while
using `format_set_trailers_options()` in ref-filter.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 Hariom Verma via GitGitGadget |  0
 pretty.c                      | 83 ++++++++++++++++++++++-------------
 pretty.h                      | 11 +++++
 3 files changed, 64 insertions(+), 30 deletions(-)
 create mode 100644 Hariom Verma via GitGitGadget

diff --git a/Hariom Verma via GitGitGadget b/Hariom Verma via GitGitGadget
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/pretty.c b/pretty.c
index 2a3d46bf42..bd8d38e27b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1147,6 +1147,55 @@ static int format_trailer_match_cb(const struct strbuf *key, void *ud)
 	return 0;
 }
 
+int format_set_trailers_options(struct process_trailer_options *opts,
+				struct string_list *filter_list,
+				struct strbuf *sepbuf,
+				const char **arg,
+				const char **err)
+{
+	for (;;) {
+		const char *argval;
+		size_t arglen;
+
+		if (**arg != ')') {
+			size_t vallen = strcspn(*arg, "=,)");
+			const char *valstart = xstrndup(*arg, vallen);
+			if (strcmp(valstart, "key") &&
+				strcmp(valstart, "separator") &&
+				strcmp(valstart, "only") &&
+				strcmp(valstart, "valueonly") &&
+				strcmp(valstart, "unfold")) {
+					*err = xstrdup(valstart);
+					return 1;
+				}
+			free((char *)valstart);
+		}
+		if (match_placeholder_arg_value(*arg, "key", arg, &argval, &arglen)) {
+			uintptr_t len = arglen;
+
+			if (!argval)
+				return 1;
+
+			if (len && argval[len - 1] == ':')
+				len--;
+			string_list_append(filter_list, argval)->util = (char *)len;
+
+			opts->filter = format_trailer_match_cb;
+			opts->filter_data = filter_list;
+			opts->only_trailers = 1;
+		} else if (match_placeholder_arg_value(*arg, "separator", arg, &argval, &arglen)) {
+			char *fmt = xstrndup(argval, arglen);
+			strbuf_expand(sepbuf, fmt, strbuf_expand_literal_cb, NULL);
+			free(fmt);
+			opts->separator = sepbuf;
+		} else if (!match_placeholder_bool_arg(*arg, "only", arg, &opts->only_trailers) &&
+				!match_placeholder_bool_arg(*arg, "unfold", arg, &opts->unfold) &&
+				!match_placeholder_bool_arg(*arg, "valueonly", arg, &opts->value_only))
+			break;
+	}
+	return 0;
+}
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				void *context)
@@ -1417,41 +1466,14 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		struct string_list filter_list = STRING_LIST_INIT_NODUP;
 		struct strbuf sepbuf = STRBUF_INIT;
 		size_t ret = 0;
+		const char *unused = NULL;
 
 		opts.no_divider = 1;
 
 		if (*arg == ':') {
 			arg++;
-			for (;;) {
-				const char *argval;
-				size_t arglen;
-
-				if (match_placeholder_arg_value(arg, "key", &arg, &argval, &arglen)) {
-					uintptr_t len = arglen;
-
-					if (!argval)
-						goto trailer_out;
-
-					if (len && argval[len - 1] == ':')
-						len--;
-					string_list_append(&filter_list, argval)->util = (char *)len;
-
-					opts.filter = format_trailer_match_cb;
-					opts.filter_data = &filter_list;
-					opts.only_trailers = 1;
-				} else if (match_placeholder_arg_value(arg, "separator", &arg, &argval, &arglen)) {
-					char *fmt;
-
-					strbuf_reset(&sepbuf);
-					fmt = xstrndup(argval, arglen);
-					strbuf_expand(&sepbuf, fmt, strbuf_expand_literal_cb, NULL);
-					free(fmt);
-					opts.separator = &sepbuf;
-				} else if (!match_placeholder_bool_arg(arg, "only", &arg, &opts.only_trailers) &&
-					   !match_placeholder_bool_arg(arg, "unfold", &arg, &opts.unfold) &&
-					   !match_placeholder_bool_arg(arg, "valueonly", &arg, &opts.value_only))
-					break;
-			}
+			if (format_set_trailers_options(&opts, &filter_list, &sepbuf, &arg, &unused))
+				goto trailer_out;
 		}
 		if (*arg == ')') {
 			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
@@ -1460,6 +1482,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	trailer_out:
 		string_list_clear(&filter_list, 0);
 		strbuf_release(&sepbuf);
+		free((char *)unused);
 		return ret;
 	}
 
diff --git a/pretty.h b/pretty.h
index 071f2fb8e4..cfe2e8b39b 100644
--- a/pretty.h
+++ b/pretty.h
@@ -6,6 +6,7 @@
 
 struct commit;
 struct strbuf;
+struct process_trailer_options;
 
 /* Commit formats */
 enum cmit_fmt {
@@ -139,4 +140,14 @@ const char *format_subject(struct strbuf *sb, const char *msg,
 /* Check if "cmit_fmt" will produce an empty output. */
 int commit_format_is_empty(enum cmit_fmt);
 
+/*
+ * Set values of fields in "struct process_trailer_options"
+ * according to trailers arguments.
+ */
+int format_set_trailers_options(struct process_trailer_options *opts,
+				struct string_list *filter_list,
+				struct strbuf *sepbuf,
+				const char **arg,
+				const char **err);
+
 #endif /* PRETTY_H */
-- 
gitgitgadget


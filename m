Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB362C433E2
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F9432074D
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn/GSezH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgIETsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 15:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgIETsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 15:48:16 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73823C061245
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 12:48:15 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so10713675wrx.7
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 12:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dZAUavJ6VP6u1mFNS5vtETsXLir357LHWkUpb5ONnvg=;
        b=Fn/GSezH76H5bTtM1o6YQ+Vjp4uwaPNt1jVpVsFXUTvDbRRxFwxF8Y1yl+GME7WDGP
         9cdnt7JhBdVEihytUyc+VMi8EKLUc0cM1H26iC5HgqCpYc/FiSzTe72aMAYed5Y1tQWK
         RN6oCLLbS6a/Lk5oCSpJo+0tmPo0eZK9Gz6dSr4cDuHRMUnOs/XMrLgEh9fazqiTAodf
         FDAl/F5Oj6eqbFxQoadqtMZ97SE+PSyLj9ojNtCeZ84Ro/HlN9OOY0qHJ7Qzdn7Te2dE
         bODXcFoiJt9jkyT7SwNxPcjubcosYo25R6Nl19cgRCtNlIpVzcZGwqTToxq+IF+7yB9T
         TymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dZAUavJ6VP6u1mFNS5vtETsXLir357LHWkUpb5ONnvg=;
        b=gT0d6rZb5xWLnwwbiQ9ooq1O2wCkXowh4SKT2g2m+rpJimSkgqX2G++cXbOM3SbAwl
         pbGn47upXYCT55oSDRjm/zQrjkRjh0EhSAs3RgQhE1nUepvsivlf4n8hcB5GKnUmEop0
         GkMKdR3OW66wKBo4hy4jWmUu3VYWORmzBHtF+7TJeeaLChoslU1gMhg84e8/4f9zNg8A
         wfImW/rU7DBz2+QaSkmuYVO9rcSrqsZ/WHFkbbGWLTNHJ/bsT02MRVdqz9QAWUcor3be
         IFmqoOirSf3pOI+QtVjemVhoWIHK8pyT4oQjWfz3vOcqJpQTtnYw7Zw7D/PXxBgJff0c
         ee9g==
X-Gm-Message-State: AOAM532tOpGckcbAGNSYrApY7eBXywgRtPDSeIk9ZUAjDqRaeS1bwRcO
        0yncHMP3fU48xXC0D22mzBM1NXJKKFU=
X-Google-Smtp-Source: ABdhPJz1RKheEIoqh04Y36ugj59HyiS3qvPfH7we0bEoTZh4Akx8ftZqJ0eaoUHr2IIIVKlxiKO3GQ==
X-Received: by 2002:a5d:69c2:: with SMTP id s2mr13579187wrw.389.1599335293717;
        Sat, 05 Sep 2020 12:48:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o129sm17479844wmb.27.2020.09.05.12.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 12:48:13 -0700 (PDT)
Message-Id: <4180f54c1de51a3b9e29ef42b035bb31215875e3.1599335291.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.git.1599335291.gitgitgadget@gmail.com>
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Sep 2020 19:48:10 +0000
Subject: [PATCH 1/2] pretty.c: refactor trailer logic to
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


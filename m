Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218D0C11D0B
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 14:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3B8208E4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 14:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9yTJUvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgBTOP0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:15:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50994 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTOPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 09:15:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so2175204wmb.0
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 06:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5GeC/i0jOh/h5LFvr8yBgDUY0Sqq5RQOGLt0EzzNlGA=;
        b=X9yTJUvOxZ/2JcdLtOOEayabOKrCGLO+S1/zbxiLsB2oRXi3A5EuLUEmxXHZonKmix
         aXD1rFKHl0vKJiFQM8F3IWdv1/XQMGu7jFbFyIFG65yOX67xRUw6du8BRowHWT0rAvBA
         paz4UdRvqFvrBx8EmhSWQHIcnCj7Z/xABN7Vc0uAFMWYXo2xZMpum01MDecHzTuasJb5
         L620CVGfmNg+YBl2xj9Izn5zdHyp3a5A9PFD0hNw5tSqR7z50/s2CZ3gRloM9EiXhaXF
         7J7kx5vznjYuzk/gmyJWYkibXf5Mqvw65nVLx6kyxMGEbXRs8Cfj8dtGemRuuue39tv/
         iOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5GeC/i0jOh/h5LFvr8yBgDUY0Sqq5RQOGLt0EzzNlGA=;
        b=sTuXOBCWCm5iRyWnhL7ghXk7L3YQR6rc5vV9ttk9SzWjCIQ3rGWAcCaWcewp8Q7jyD
         mcYk7jY0H38ylfccFRNTopVGJR1Tuf91opi++1+yVtHw/A3d863cvzqfwmgNr14Z7rvd
         rLUnFJcHKOMMuk1n9osBOEN5km6i3a9sJNN/lZL1G+mjOHdmg6iVF5KZaXk0cCH0ES3e
         PKuxOZLWuI8K6jKx/9P99D/3AC113wg0JHCJSPw/6APnaRsAm4P4GSwXlTHfzizY/gjp
         jelK/pHaLRP9FKPIlqZjs5WQ7iMBY8u9S9h5MrZMI516KIBKtpyJBLMKjNRMFerAq14X
         6U2Q==
X-Gm-Message-State: APjAAAX8nMzA/SQnVqa2CP2BBo/y71qWqRzBJjizOGJJCD3LHxaKB8Op
        +pji0G6v7mMuZoP2L9udpcZvfFDs
X-Google-Smtp-Source: APXvYqwftoDMXb9EdZ58dAkGuktk28ButYWo+35w8jk++8zfqCcc5/8Yq/USoEqhvszoP+XtGXeN/A==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr4590873wmi.37.1582208123367;
        Thu, 20 Feb 2020 06:15:23 -0800 (PST)
Received: from donizetti.redhat.com (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id v15sm4933614wrf.7.2020.02.20.06.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 06:15:22 -0800 (PST)
From:   pbonzini@redhat.com
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com
Subject: [PATCH v2 2/5] parse-options: convert "command mode" to a flag
Date:   Thu, 20 Feb 2020 15:15:16 +0100
Message-Id: <20200220141519.28315-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220141519.28315-1-pbonzini@redhat.com>
References: <20200220141519.28315-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

OPTION_CMDMODE is essentially OPTION_SET_INT plus an extra check that
the variable had not set before.  In order to allow custom processing
of the option, for example a "command mode" option that also has an
argument, it would be nice to use OPTION_CALLBACK and not have to rewrite
the extra check on incompatible options.  In other words, making the
processing of the option orthogonal to the "only one of these" behavior
provided by OPTION_CMDMODE.

Add a new flag that takes care of the check, and modify OPT_CMDMODE to
use it together with OPTION_SET_INT.  The new flag still requires that the
option value points to an int, but any OPTION_* value can be specified as
long as it does not require a non-int type for opt->value.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
v1->v2: - improve commit message [Junio]

 parse-options.c | 20 +++++++++-----------
 parse-options.h |  8 ++++----
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index a0cef401fc..63d6bab60c 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -61,7 +61,7 @@ static enum parse_opt_result opt_command_mode_error(
 	 */
 	for (that = all_opts; that->type != OPTION_END; that++) {
 		if (that == opt ||
-		    that->type != OPTION_CMDMODE ||
+		    !(that->flags & PARSE_OPT_CMDMODE) ||
 		    that->value != opt->value ||
 		    that->defval != *(int *)opt->value)
 			continue;
@@ -95,6 +95,14 @@ static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
 	if (!(flags & OPT_SHORT) && p->opt && (opt->flags & PARSE_OPT_NOARG))
 		return error(_("%s takes no value"), optname(opt, flags));
 
+	/*
+	 * Giving the same mode option twice, although unnecessary,
+	 * is not a grave error, so let it pass.
+	 */
+	if ((opt->flags & PARSE_OPT_CMDMODE) &&
+	    *(int *)opt->value && *(int *)opt->value != opt->defval)
+		return opt_command_mode_error(opt, all_opts, flags);
+
 	switch (opt->type) {
 	case OPTION_LOWLEVEL_CALLBACK:
 		return opt->ll_callback(p, opt, NULL, unset);
@@ -130,16 +138,6 @@ static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
 		*(int *)opt->value = unset ? 0 : opt->defval;
 		return 0;
 
-	case OPTION_CMDMODE:
-		/*
-		 * Giving the same mode option twice, although is unnecessary,
-		 * is not a grave error, so let it pass.
-		 */
-		if (*(int *)opt->value && *(int *)opt->value != opt->defval)
-			return opt_command_mode_error(opt, all_opts, flags);
-		*(int *)opt->value = opt->defval;
-		return 0;
-
 	case OPTION_STRING:
 		if (unset)
 			*(const char **)opt->value = NULL;
diff --git a/parse-options.h b/parse-options.h
index 1d60205881..fece5ba628 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -18,7 +18,6 @@ enum parse_opt_type {
 	OPTION_BITOP,
 	OPTION_COUNTUP,
 	OPTION_SET_INT,
-	OPTION_CMDMODE,
 	/* options with arguments (usually) */
 	OPTION_STRING,
 	OPTION_INTEGER,
@@ -47,7 +46,8 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LITERAL_ARGHELP = 64,
 	PARSE_OPT_SHELL_EVAL = 256,
 	PARSE_OPT_NOCOMPLETE = 512,
-	PARSE_OPT_COMP_ARG = 1024
+	PARSE_OPT_COMP_ARG = 1024,
+	PARSE_OPT_CMDMODE = 2048
 };
 
 enum parse_opt_result {
@@ -168,8 +168,8 @@ struct option {
 #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
-#define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
+#define OPT_CMDMODE(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
+				      (h), PARSE_OPT_CMDMODE|PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
 #define OPT_INTEGER(s, l, v, h)     OPT_INTEGER_F(s, l, v, h, 0)
 #define OPT_MAGNITUDE(s, l, v, h)   { OPTION_MAGNITUDE, (s), (l), (v), \
 				      N_("n"), (h), PARSE_OPT_NONEG }
-- 
2.21.1



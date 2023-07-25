Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B59C001DF
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 21:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjGYVAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 17:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGYVAk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 17:00:40 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12AFE78
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 14:00:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-563dc551518so323362a12.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690318839; x=1690923639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jAhX67aDWSFINhDD7/JZNnyzc5gP0DcUfd6E5+ChDo=;
        b=CpgpIeHpfccv0D/EBmkopL1aHDnHd+3LMSJthT+TUAzPdO7d0xV4EY0jmo8LAmwGSf
         WkziJGWEE8h6qdC62cmHecbbjijfp33m+tLXoLInQiTmATJ37ysQZmVTb1eRXX8opCdJ
         pLcHa7MMp1UCcbIFJ44gPbg3kM1FPS92+W4vn92/zwLlOkG5pea0Y0s01WKkOz0FQCaN
         3msrftU+cJGR45pa9ZoPfE/r+DWQ+hp1ydmzofusf7ixLv6IRA50qMJH8Zlskp6eT8jx
         IaZpx5LsOsbiW3nyCUcyXZNmCtQ5tXDQ43WX+kPsmIxexoYxisWUF+8Lyd3+xKG4Qscf
         QMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690318839; x=1690923639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jAhX67aDWSFINhDD7/JZNnyzc5gP0DcUfd6E5+ChDo=;
        b=fBdsx4ex91KwBCcKoCSljjs+zFCvUCsAfVQrn9adwsBPzY+E8k28vgPJQwdcAeELph
         E5u18tijv4tsfTU8eNEMtEreFeTAm3ckuLqfqCwoSNvgAr656rT2iUlzyBK0k1UwofN3
         j4iIbHCDYnUW5Pklgp9l1q31ehoyFblOpAt0kzMh0+jleiW8BPYw1ZxZJaRO+swStcYy
         iKS+kPVZTVsNYjd4QH5prMFIGgtXPCv8oUgBkNB29ktbslrV954z/yXtcCVzRNxxzMiV
         PZPUpFGl4k9MwOpdhaYfsqoAhyTVLRr7gl1+yxpJZkS1X/0om64Uq3oBnK0PeIeTlJKc
         lwxQ==
X-Gm-Message-State: ABy/qLYT1pjlwH8MlQ+NKDYemSnY0ePB7ZMvB+4MUcdEWpIryK6DItNq
        5boaadxhOTAVxjiAD7dtlEVusDy0K3WyivLn
X-Google-Smtp-Source: APBJJlGr6kTWTyaptBpcb9qG4L75LeuzNQj/XtjvibHfIb83bdSTavQEOhqwYmkYdH8zxrjeXM4LrQ==
X-Received: by 2002:a17:90b:1b42:b0:268:18bd:d2b8 with SMTP id nv2-20020a17090b1b4200b0026818bdd2b8mr277806pjb.16.1690318838745;
        Tue, 25 Jul 2023 14:00:38 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.158.194])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090a818600b00262e485156esm10003071pjn.57.2023.07.25.14.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 14:00:38 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Glen Choo <chooglen@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Siddharth Singh <siddhartth@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v5 1/2] ref-filter: add multiple-option parsing functions
Date:   Wed, 26 Jul 2023 02:21:21 +0530
Message-ID: <20230725205924.40585-2-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.396.g77a2a56520
In-Reply-To: <20230725205924.40585-1-five231003@gmail.com>
References: <20230723162717.68123-1-five231003@gmail.com>
 <20230725205924.40585-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The functions

	match_placeholder_arg_value()
	match_placeholder_bool_arg()

were added in pretty 4f732e0fd7 (pretty: allow %(trailers) options
with explicit value, 2019-01-29) to parse multiple options in an
argument to --pretty. For example,

	git log --pretty="%(trailers:key=Signed-Off-By,separator=%x2C )"

will output all the trailers matching the key and seperates them by
a comma followed by a space per commit.

Add similar functions,

	match_atom_arg_value()
	match_atom_bool_arg()

in ref-filter.

There is no atom yet that can use these functions in ref-filter, but we
are going to add a new %(describe) atom in a subsequent commit where we
parse options like tags=<bool-value> or match=<pattern> given to it.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 ref-filter.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 0f3df132b8..8d5f85e0a7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
+#include "config.h"
 #include "gpg-interface.h"
 #include "hex.h"
 #include "parse-options.h"
@@ -255,6 +256,110 @@ static int err_bad_arg(struct strbuf *sb, const char *name, const char *arg)
 	return -1;
 }
 
+/*
+ * Parse option of name "candidate" in the option string "to_parse" of
+ * the form
+ *
+ *	"candidate1[=val1],candidate2[=val2],candidate3[=val3],..."
+ *
+ * The remaining part of "to_parse" is stored in "end" (if we are
+ * parsing the last candidate, then this is NULL) and the value of
+ * the candidate is stored in "valuestart" and its length in "valuelen",
+ * that is the portion after "=". Since it is possible for a "candidate"
+ * to not have a value, in such cases, "valuestart" is set to point to
+ * NULL and "valuelen" to 0.
+ *
+ * The function returns 1 on success. It returns 0 if we don't find
+ * "candidate" in "to_parse" or we find "candidate" but it is followed
+ * by more chars (for example, "candidatefoo"), that is, we don't find
+ * an exact match.
+ *
+ * This function only does the above for one "candidate" at a time. So
+ * it has to be called each time trying to parse a "candidate" in the
+ * option string "to_parse".
+ */
+static int match_atom_arg_value(const char *to_parse, const char *candidate,
+				const char **end, const char **valuestart,
+				size_t *valuelen)
+{
+	const char *atom;
+
+	if (!skip_prefix(to_parse, candidate, &atom))
+		return 0; /* definitely not "candidate" */
+
+	if (*atom == '=') {
+		/* we just saw "candidate=" */
+		*valuestart = atom + 1;
+		atom = strchrnul(*valuestart, ',');
+		*valuelen = atom - *valuestart;
+	} else if (*atom != ',' && *atom != '\0') {
+		/* key begins with "candidate" but has more chars */
+		return 0;
+	} else {
+		/* just "candidate" without "=val" */
+		*valuestart = NULL;
+		*valuelen = 0;
+	}
+
+	/* atom points at either the ',' or NUL after this key[=val] */
+	if (*atom == ',')
+		atom++;
+	else if (*atom)
+		BUG("Why is *atom not NULL yet?");
+
+	*end = atom;
+	return 1;
+}
+
+/*
+ * Parse boolean option of name "candidate" in the option list "to_parse"
+ * of the form
+ *
+ *	"candidate1[=bool1],candidate2[=bool2],candidate3[=bool3],..."
+ *
+ * The remaining part of "to_parse" is stored in "end" (if we are parsing
+ * the last candidate, then this is NULL) and the value (if given) is
+ * parsed and stored in "val", so "val" always points to either 0 or 1.
+ * If the value is not given, then "val" is set to point to 1.
+ *
+ * The boolean value is parsed using "git_parse_maybe_bool()", so the
+ * accepted values are
+ *
+ *	to set true  - "1", "yes", "true"
+ *	to set false - "0", "no", "false"
+ *
+ * This function returns 1 on success. It returns 0 when we don't find
+ * an exact match for "candidate" or when the boolean value given is
+ * not valid.
+ */
+static int match_atom_bool_arg(const char *to_parse, const char *candidate,
+				const char **end, int *val)
+{
+	const char *argval;
+	char *strval;
+	size_t arglen;
+	int v;
+
+	if (!match_atom_arg_value(to_parse, candidate, end, &argval, &arglen))
+		return 0;
+
+	if (!argval) {
+		*val = 1;
+		return 1;
+	}
+
+	strval = xstrndup(argval, arglen);
+	v = git_parse_maybe_bool(strval);
+	free(strval);
+
+	if (v == -1)
+		return 0;
+
+	*val = v;
+
+	return 1;
+}
+
 static int color_atom_parser(struct ref_format *format, struct used_atom *atom,
 			     const char *color_value, struct strbuf *err)
 {
-- 
2.41.0.396.g77a2a56520


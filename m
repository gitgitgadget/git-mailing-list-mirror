Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABB7C001B0
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 16:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGSQYw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 12:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjGSQYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 12:24:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26022B6
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 09:24:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6686ef86110so4834855b3a.2
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 09:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689783889; x=1692375889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21vjTDTr5bmwk5BipWdxp8j0+tzsNF88MCvulGlEbL8=;
        b=UKg57YBb5jJFjE4vIlTQ5kI+YK/X5He7XA7tJDmPC8zfjzNG9FMICPMKuE1ko6RlEo
         QCFK4QM1+8m8QxVi+787s+GogcgL5nlD8YBTVYfMubyh1Lkn9TtEfxKwoc22RxwYd0Jl
         K+rhMlx1f8LxDBZYLDL/V7wB0POQeNTaf2Ftl2/jn3RclW++PMeQnJXirOJ9u0YH+o5f
         V9pYEa51BskEnMul+ZfffF4gkU5V/5hOK9KWpmd4a/ZPqzy+OjHAJqfZLC5Z4fSnN3Kf
         BTMp1CMVHJMhBJ63xTBGZz798r3s+R9f1iqn0pBzjuSPWppP/wBpKpWqHClIUieLZNaW
         8kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689783889; x=1692375889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21vjTDTr5bmwk5BipWdxp8j0+tzsNF88MCvulGlEbL8=;
        b=LL33GaWhkGenRDwajlgPnyn736RjL76Sbm1aTsh8QHb9pRZh8HHkTN8v8g/mt4dtGK
         bDBMz2uL4nSdq4FJZtrsseNTug5rQe6NCQQpHz4jQJiCS8ZbYzD9Y04VP/9w9bOnRdyq
         mHxBJupExglYF81RSW1Y8dgEzOIi0AGo1srDesKENX8K827GRq7g2XECz7afS1BN0e7w
         TcJLgIXycVmz6oF6QFAKUxNBdKAHapWH4GXSyK1+HM4YhCNf2sGak3rKr15Bjaq7i6pM
         mW/n32GuUJPV6MjBfCozJrGYbKUwvBPQkKFUKozafDCJVoWxmXKEPp8eHqnfloOlfe3n
         9k3w==
X-Gm-Message-State: ABy/qLYfafCIbFtwqo5C+K3tcdu8z77PV+VNpgsbuYkHp2SI8JLPIrQ5
        YnUsRjq5jJHs266Q54veBCrfQcNJhLW0Kl8L
X-Google-Smtp-Source: APBJJlF4QjbuOzOjA8n7qR9lM2aoVKuvArlG3zUrwzTyeKJL/9jIn3R3FoQUaOxwt16ktNMnWYLzyg==
X-Received: by 2002:a05:6a20:9147:b0:131:f504:a631 with SMTP id x7-20020a056a20914700b00131f504a631mr2716696pzc.51.1689783889099;
        Wed, 19 Jul 2023 09:24:49 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.156.16])
        by smtp.gmail.com with ESMTPSA id bm17-20020a056a00321100b0067b643b814csm3484907pfb.6.2023.07.19.09.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 09:24:48 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v3 1/2] ref-filter: add multiple-option parsing functions
Date:   Wed, 19 Jul 2023 21:45:05 +0530
Message-ID: <20230719162424.70781-2-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.378.g42703afc1f.dirty
In-Reply-To: <20230719162424.70781-1-five231003@gmail.com>
References: <20230714194249.66862-1-five231003@gmail.com>
 <20230719162424.70781-1-five231003@gmail.com>
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

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 ref-filter.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 60919f375f..f64437e781 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -255,6 +255,65 @@ static int err_bad_arg(struct strbuf *sb, const char *name, const char *arg)
 	return -1;
 }
 
+static int match_atom_arg_value(const char *to_parse, const char *candidate,
+				const char **end, const char **valuestart,
+				size_t *valuelen)
+{
+	const char *atom;
+
+	if (!(skip_prefix(to_parse, candidate, &atom)))
+		return 0;
+	if (valuestart) {
+		if (*atom == '=') {
+			*valuestart = atom + 1;
+			*valuelen = strcspn(*valuestart, ",\0");
+			atom = *valuestart + *valuelen;
+		} else {
+			if (*atom != ',' && *atom != '\0')
+				return 0;
+			*valuestart = NULL;
+			*valuelen = 0;
+		}
+	}
+	if (*atom == ',') {
+		*end = atom + 1;
+		return 1;
+	}
+	if (*atom == '\0') {
+		*end = atom;
+		return 1;
+	}
+	return 0;
+}
+
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
2.41.0.378.g42703afc1f.dirty


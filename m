Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F499C0015E
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 19:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbjGNTnU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 15:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbjGNTnR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 15:43:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1D13A96
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 12:43:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2633fe9b6c0so2354665a91.1
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689363791; x=1691955791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIq083vpn9XP9510hqKokeYSfJjKT6YtmBy5zh8DXEw=;
        b=RDFgVJDiRN7XR5mYLPqUwCXs/x0zO8dk64FrIsX4EM8ns/HF4j+H+GKG/6GDpbknyt
         Lfb1ugZjyU5MJ+RnziZ3a4qo+kVYFd/oQUNFyg2WlKY6VTjUf1GE4GTPBzF8Cbvur8gM
         BFk/pr877xadKRJ/7c4NqamDraCy2XOlNRxjSuEsUwwMCR2tishp6oK+K5jd46Q0xkZF
         AXHzNrTAv505SHwojjtfxY1jtMiWemYQxstSxWI9gJCtrEGmEpXGC20BERLrOOwXlN87
         cR69/hr122PI/Mmkzx6ltLm0bQs9gj9yZjecsHgYePn5lwPdPjfXmFdRsBJOWFFn1uG8
         Xiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689363791; x=1691955791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIq083vpn9XP9510hqKokeYSfJjKT6YtmBy5zh8DXEw=;
        b=WgRXZPVlVzcjZupCiHTeF7Obk0+RWcJcB6ZVbClsC+HpbsbdAJCPCqEWag47EHz29X
         wtaaSN3x6pzbn6+zTW5Mg5fo7AUAosT1t28sgLlquyC9Xw5boYMeK91wAQZOVK6DuXmN
         z/dWFH+Z/wne2NZmy9tzduiNCTAjMyH6hLQxqJ73d6D7vcGBsELuQ0g0DP8EwMBjJ/tg
         o7l5Iet1ELReeGkYAB1BWXh0XHkNBsdhsfnx6CypyOWBipp6pyR1fGdiabl8nDl6ISng
         Qnim8y5bid2ZjaEhEZHcnhWNDxAB9/pXF1r+gsko9hcrZ+NnYB0DRLnjgKs0ocehPwBr
         RN/g==
X-Gm-Message-State: ABy/qLb4y2DzN2+lOX4NkIfOnL9MHdDQ89tJ4yC+ocksECSBDWpeiZ1V
        8sq61TkCsjtTig3UdVWrpU6GSYy43sU=
X-Google-Smtp-Source: APBJJlGEQMbRCIbHc3tl3GIxgEAGk/AIOIO+8/bpyjrUZ4k66tMmY+TcOT+ev5Ko/GDSM0pv/qzKmA==
X-Received: by 2002:a17:90b:3143:b0:263:e299:dff9 with SMTP id ip3-20020a17090b314300b00263e299dff9mr4701734pjb.23.1689363790724;
        Fri, 14 Jul 2023 12:43:10 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.159.128])
        by smtp.gmail.com with ESMTPSA id u63-20020a17090a51c500b00260a5ecd273sm1514820pjh.1.2023.07.14.12.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 12:43:10 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: [RFC PATCH v2 1/3] ref filter: add multiple-option parsing functions
Date:   Sat, 15 Jul 2023 00:50:26 +0530
Message-ID: <20230714194249.66862-2-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.29.g8148156d44.dirty
In-Reply-To: <20230714194249.66862-1-five231003@gmail.com>
References: <20230705175942.21090-1-five231003@gmail.com>
 <20230714194249.66862-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The functions

	match_placeholder_arg_value()
	match_placeholder_bool_arg()

were added in pretty (4f732e0fd7 (pretty: allow %(trailers) options
with explicit value, 2019-01-29)) to parse multiple options in an
argument to --pretty. For example,

	git log --pretty="%(trailers:key=Signed-Off-By,separator=%x2C )"

will output all the trailers matching the key and seperates them by
commas per commit.

Add similar functions,

	match_atom_arg_value()
	match_atom_bool_arg()

in ref-filter. A particular use of this can be seen in the subsequent
commit where we parse the options given to a new atom "describe".

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 ref-filter.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index e0d03a9f8e..b170994d9d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -251,6 +251,65 @@ static int err_bad_arg(struct strbuf *sb, const char *name, const char *arg)
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
2.41.0.321.g26b82700c0.dirty


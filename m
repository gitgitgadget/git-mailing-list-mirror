Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B5DC54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiIGOpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIGOpe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:45:34 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7B927FE0
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:45:28 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-127d10b4f19so10782121fac.9
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 07:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=T0FKv/g0I+IhUNWt7/i6j1dKWo11xjy2e0Ch002Fk0s=;
        b=ucs9zhHTrpfhPkaPgv3PmjhPRHT+xJPvkkdx7toexjrOso86FM+u+LNkEKyKhgNaw8
         HBuHFpheh/Qh77baaqdwgyYQr/DYQdyvgtVKdXeULWGLtgg3As929rvIz6xsNBlTxgLI
         UlMavPiTAA6x+aHheFymmxRxoqIhXXwSJiMVFS8+YUc1jzT07NixOKZtZY2WZflmbQqM
         ZSBBLt73aD434JceEcW86R7agnZo3M82W97aHpVeqaL5+QK8fLHhrcoFzO/1aZZZKrmz
         RJY2YnLI1sXvzGwIB3k/1tb2tRhYjFhdGG1xbH6o3f4+3Q2o0uwrHWqjSVEWoftONetD
         U4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=T0FKv/g0I+IhUNWt7/i6j1dKWo11xjy2e0Ch002Fk0s=;
        b=RPE4gSo8uWOeAhhxJgNEpBEi+oGSoB2Ox8KUDH6DdYwtva2970NRb/oEUIPWM+NXUF
         QcckNgFMd/xJrxV4h+UQINwOLsRG6gNSaQtXOzqBnv/aW7wjxpf7+YRJ8fqARlY0CDqS
         Hg2diDnapvKJWQh7NYTy+P9SWfYjXrqz5f97bBOEaNcpbt2QFAW3+g0Ds2AxDELbuvxp
         twSn1L2nLLKbl4aAUGYZ+vxPK5TCCGSOfK9giVupU4CTtU1NdzoXQ/CzOOuu37TVXfbX
         tJdFn5cYHnfVBxhyostGE98Iubzn/orKIPGRCzS0GvmQxaOcYX4rnxPj9JnQQl6KjWJa
         XC6Q==
X-Gm-Message-State: ACgBeo3SHFTD/eKbKwDqW2BjGl750Mc6RCSfKfEXlFOltWYyKK5GiOcB
        nXlr+O3FhIDhm2Cfe3oLgFl7RQQhmtSrjA==
X-Google-Smtp-Source: AA6agR5mGE7Keb2lu25Z1mLPePgu9Hh6VgM22UE8xuZNtUtXrLb0Iqs9ThOkwoluMNQOYCPFOPbkXw==
X-Received: by 2002:a05:6870:a713:b0:127:70ba:aa86 with SMTP id g19-20020a056870a71300b0012770baaa86mr1999314oam.154.1662561927609;
        Wed, 07 Sep 2022 07:45:27 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id p21-20020a056830319500b00638bfd0673bsm7175012ots.51.2022.09.07.07.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:45:27 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, l.s.r@web.de
Subject: [PATCH v2 2/2] format-patch: warn if commit msg contains a patch delimiter
Date:   Wed,  7 Sep 2022 11:44:57 -0300
Message-Id: <a2c4514aa03657f3b1d822efe3dd630713287ee6.1662559356.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1662559356.git.matheus.bernardino@usp.br>
References: <cover.1662559356.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When applying a patch, `git am` looks for special delimiter strings
(such as "---") to know where the message ends and the actual diff
starts. If one of these strings appears in the commit message itself,
`am` might get confused and fail to apply the patch properly. This has
already caused inconveniences in the past [1][2]. To help avoid such
problem, let's make `git format-patch` warn on commit messages
containing one of the said strings.

[1]: https://lore.kernel.org/git/20210113085846-mutt-send-email-mst@kernel.org/
[2]: https://lore.kernel.org/git/16297305.cDA1TJNmNo@earendil/

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/log.c           |  1 +
 log-tree.c              |  1 +
 mailinfo.c              |  4 ++--
 mailinfo.h              |  3 +++
 pretty.c                | 16 +++++++++++++++-
 pretty.h                |  3 ++-
 revision.h              |  3 ++-
 t/t4014-format-patch.sh | 26 ++++++++++++++++++++++++++
 8 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 56e2d95e86..edc84abaef 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1973,6 +1973,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.diffopt.flags.recursive = 1;
 	rev.diffopt.no_free = 1;
 	rev.subject_prefix = fmt_patch_subject_prefix;
+	rev.check_in_body_patch_breaks = 1;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.def = "HEAD";
 	s_r_opt.revarg_opt = REVARG_COMMITTISH;
diff --git a/log-tree.c b/log-tree.c
index 3e8c70ddcf..25ed5452b1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -766,6 +766,7 @@ void show_log(struct rev_info *opt)
 	ctx.after_subject = extra_headers;
 	ctx.preserve_subject = opt->preserve_subject;
 	ctx.encode_email_headers = opt->encode_email_headers;
+	ctx.check_in_body_patch_breaks = opt->check_in_body_patch_breaks;
 	ctx.reflog_info = opt->reflog_info;
 	ctx.fmt = opt->commit_format;
 	ctx.mailmap = opt->mailmap;
diff --git a/mailinfo.c b/mailinfo.c
index f0a690b6e8..d227397f1c 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -646,7 +646,7 @@ static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
 	free(ret);
 }
 
-static inline int patchbreak(const char *buf, size_t len)
+int patchbreak(const char *buf, size_t len)
 {
 	/* Beginning of a "diff -" header? */
 	if (skip_prefix_mem(buf, len, "diff -", &buf, &len))
@@ -680,7 +680,7 @@ static inline int patchbreak(const char *buf, size_t len)
 	return 0;
 }
 
-static int is_scissors_line(const char *line, size_t len)
+int is_scissors_line(const char *line, size_t len)
 {
 	const char *c;
 	int scissors = 0, gap = 0;
diff --git a/mailinfo.h b/mailinfo.h
index f2ffd0349e..347eefe856 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -53,4 +53,7 @@ void setup_mailinfo(struct mailinfo *);
 int mailinfo(struct mailinfo *, const char *msg, const char *patch);
 void clear_mailinfo(struct mailinfo *);
 
+int patchbreak(const char *line, size_t len);
+int is_scissors_line(const char *line, size_t len);
+
 #endif /* MAILINFO_H */
diff --git a/pretty.c b/pretty.c
index 6d819103fb..913d974b3a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "string-list.h"
+#include "mailinfo.h"
 #include "mailmap.h"
 #include "log-tree.h"
 #include "notes.h"
@@ -2097,7 +2098,7 @@ void pp_remainder(struct pretty_print_context *pp,
 		  int indent)
 {
 	struct grep_opt *opt = pp->rev ? &pp->rev->grep_filter : NULL;
-	int first = 1;
+	int first = 1, found_delimiter = 0;
 
 	for (;;) {
 		const char *line = *msg_p;
@@ -2107,6 +2108,14 @@ void pp_remainder(struct pretty_print_context *pp,
 		if (!linelen)
 			break;
 
+		if (pp->check_in_body_patch_breaks &&
+		    (patchbreak(line, linelen) || is_scissors_line(line, linelen))) {
+			warning(_("commit message has a patch delimiter: '%.*s'"),
+				line[linelen - 1] == '\n' ? linelen - 1 : linelen,
+				line);
+			found_delimiter = 1;
+		}
+
 		if (is_blank_line(line, &linelen)) {
 			if (first)
 				continue;
@@ -2133,6 +2142,11 @@ void pp_remainder(struct pretty_print_context *pp,
 		}
 		strbuf_addch(sb, '\n');
 	}
+
+	if (found_delimiter) {
+		warning(_("git am might fail to apply this patch. "
+			  "Consider indenting the offending lines."));
+	}
 }
 
 void pretty_print_commit(struct pretty_print_context *pp,
diff --git a/pretty.h b/pretty.h
index f34e24c53a..12df2f4a39 100644
--- a/pretty.h
+++ b/pretty.h
@@ -49,7 +49,8 @@ struct pretty_print_context {
 	struct string_list *mailmap;
 	int color;
 	struct ident_split *from_ident;
-	unsigned encode_email_headers:1;
+	unsigned encode_email_headers:1,
+		 check_in_body_patch_breaks:1;
 	struct pretty_print_describe_status *describe_status;
 
 	/*
diff --git a/revision.h b/revision.h
index 61a9b1316b..f384ab716f 100644
--- a/revision.h
+++ b/revision.h
@@ -230,7 +230,8 @@ struct rev_info {
 			date_mode_explicit:1,
 			preserve_subject:1,
 			encode_email_headers:1,
-			include_header:1;
+			include_header:1,
+			check_in_body_patch_breaks:1;
 	unsigned int	disable_stdin:1;
 	/* --show-linear-break */
 	unsigned int	track_linear:1,
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index fbec8ad2ef..4bbf1156e9 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2329,4 +2329,30 @@ test_expect_success 'interdiff: solo-patch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'warn if commit message contains patch delimiter' '
+	>delim &&
+	git add delim &&
+	cat >msg <<-\EOF &&
+	title
+
+	---
+	EOF
+	git commit -F msg &&
+	git format-patch -1 2>stderr &&
+	grep "warning: commit message has a patch delimiter" stderr
+'
+
+test_expect_success 'warn if commit message contains scissors' '
+	>scissors &&
+	git add scissors &&
+	cat >msg <<-\EOF &&
+	title
+
+	-- >8 --
+	EOF
+	git commit -F msg &&
+	git format-patch -1 2>stderr &&
+	grep "warning: commit message has a patch delimiter" stderr
+'
+
 test_done
-- 
2.37.2


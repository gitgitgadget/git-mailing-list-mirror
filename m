Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC07ECAAD5
	for <git@archiver.kernel.org>; Sun,  4 Sep 2022 23:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbiIDXMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Sep 2022 19:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDXMW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2022 19:12:22 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9288B201AB
        for <git@vger.kernel.org>; Sun,  4 Sep 2022 16:12:18 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11e9a7135easo17970169fac.6
        for <git@vger.kernel.org>; Sun, 04 Sep 2022 16:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Fv7EipD4piemLRLCfHaRedKyKXyu2JdvbZw4ZCFzJqk=;
        b=NdAcv+VwdQByYyVIHh4gaU4s4F43c9e0H1AwdCpKcuMcx78tjUfAq4NVg8kID1TYSG
         YRyc/PGmVsncQ+Wib+VSKyYoCpZTDG0yTiGC0FjYjgo5S3yP0iYp1460UPz1rTpdOzMC
         zslJ+TNDHTMEDCi/9ZeUmgxbJ82/gR0+R7ht9eL9l91XbXbb5O6MZ3lnLdNRGbO6CKEZ
         cgGz0GfJUN/ljykXaUjc1a0814wwFjfTqjmk0p6nQrREPdk2sanY4IbKj7jwdT7/2UhI
         lGsL/UuhdAbOrvzB7jbsWRZDXmBnNOgmXiR5dhXOxIHj/hmRrTEeP/QmeJ2ROdBUguuq
         ttfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Fv7EipD4piemLRLCfHaRedKyKXyu2JdvbZw4ZCFzJqk=;
        b=RPKfomgvCb4VteUTWfKKlFuD7RDO4hxPi4KXhpYG2C6T1kImmo2YxBEVTdc2rswWPo
         Fk4365lWvmLkFtoWg/5WXODMJSIrfXcpvnwUpMO+UQksQPkvGQocUhwNHxWB2bmh//vF
         8haKsK75oDCjkIYyli8X8hv4N6E0YJCgD64xy4YZxwE3K9OjoEEtlwUuGRVt6uYTSGgh
         X+tpP0jFstMXhj22+2o3Ti4KdQmuv13Ym7W4mrlz1xvELRiZllN7eM5YSuBUrX0JMtXA
         9ZZdVouC8roTVobTzGt13pfdzL0b2p4HdyVIBugj3Ji8BZHQG6UIkXRvEDHqOf0IoLas
         ElPw==
X-Gm-Message-State: ACgBeo21VGDm3WAvymlDMomAXR4JE2Q+Ws3M1uI9xlRLsIAjNjIXZumV
        q4qpw0DSz8ho9lzh3//P6NxUj+ktWVGXvg==
X-Google-Smtp-Source: AA6agR6BLpZ5/As2nZWHLptOnmlGoNHJYysjJF05zgWRM6I2daHuk576B8fCoTzcWBKfklvdQlZ2WQ==
X-Received: by 2002:a05:6870:b606:b0:122:4eaf:e6d0 with SMTP id cm6-20020a056870b60600b001224eafe6d0mr7479114oab.167.1662333137435;
        Sun, 04 Sep 2022 16:12:17 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id m15-20020a9d73cf000000b006393aa233d5sm3958609otk.27.2022.09.04.16.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 16:12:16 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     l.s.r@web.de, gitster@pobox.com
Subject: [PATCH] format-patch: warn if commit msg contains a patch delimiter
Date:   Sun,  4 Sep 2022 20:12:05 -0300
Message-Id: <d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.2
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
 pretty.c                | 21 ++++++++++++++++++++-
 pretty.h                |  3 ++-
 revision.h              |  3 ++-
 t/t4014-format-patch.sh | 16 ++++++++++++++++
 8 files changed, 47 insertions(+), 5 deletions(-)

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
index 9621ba62a3..9945ea6267 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -646,7 +646,7 @@ static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
 	free(ret);
 }
 
-static inline int patchbreak(const struct strbuf *line)
+int patchbreak(const struct strbuf *line)
 {
 	size_t i;
 
@@ -682,7 +682,7 @@ static inline int patchbreak(const struct strbuf *line)
 	return 0;
 }
 
-static int is_scissors_line(const char *line)
+int is_scissors_line(const char *line)
 {
 	const char *c;
 	int scissors = 0, gap = 0;
diff --git a/mailinfo.h b/mailinfo.h
index f2ffd0349e..8d4dda5deb 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -53,4 +53,7 @@ void setup_mailinfo(struct mailinfo *);
 int mailinfo(struct mailinfo *, const char *msg, const char *patch);
 void clear_mailinfo(struct mailinfo *);
 
+int patchbreak(const struct strbuf *line);
+int is_scissors_line(const char *line);
+
 #endif /* MAILINFO_H */
diff --git a/pretty.c b/pretty.c
index 6d819103fb..9f999029f5 100644
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
@@ -2097,7 +2098,8 @@ void pp_remainder(struct pretty_print_context *pp,
 		  int indent)
 {
 	struct grep_opt *opt = pp->rev ? &pp->rev->grep_filter : NULL;
-	int first = 1;
+	int first = 1, found_delimiter = 0;
+	struct strbuf linebuf = STRBUF_INIT;
 
 	for (;;) {
 		const char *line = *msg_p;
@@ -2107,6 +2109,17 @@ void pp_remainder(struct pretty_print_context *pp,
 		if (!linelen)
 			break;
 
+		if (pp->check_in_body_patch_breaks) {
+			strbuf_reset(&linebuf);
+			strbuf_add(&linebuf, line, linelen);
+			if (patchbreak(&linebuf) || is_scissors_line(linebuf.buf)) {
+				strbuf_strip_suffix(&linebuf, "\n");
+				warning("commit message has a patch delimiter: '%s'",
+					linebuf.buf);
+				found_delimiter = 1;
+			}
+		}
+
 		if (is_blank_line(line, &linelen)) {
 			if (first)
 				continue;
@@ -2133,6 +2146,12 @@ void pp_remainder(struct pretty_print_context *pp,
 		}
 		strbuf_addch(sb, '\n');
 	}
+
+	if (found_delimiter)
+		warning("git am might fail to apply this patch. "
+			"Consider indenting the offending lines.");
+
+	strbuf_release(&linebuf);
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
index fbec8ad2ef..4868ea2b91 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2329,4 +2329,20 @@ test_expect_success 'interdiff: solo-patch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'warn if commit message contains patch delimiter' '
+	>delim &&
+	git add delim &&
+	GIT_EDITOR="printf \"title\n\n---\" >" git commit &&
+	git format-patch -1 2>stderr &&
+	grep "warning: commit message has a patch delimiter" stderr
+'
+
+test_expect_success 'warn if commit message contains scissors' '
+	>scissors &&
+	git add scissors &&
+	GIT_EDITOR="printf \"title\n\n-- >8 --\" >" git commit &&
+	git format-patch -1 2>stderr &&
+	grep "warning: commit message has a patch delimiter" stderr
+'
+
 test_done
-- 
2.37.2


Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB721C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A82D5206B7
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA4+ZCMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgFOK55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFOK5t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 06:57:49 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C252C08C5C2
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 03:57:49 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f7so16931606ejq.6
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 03:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r43m2yxYlbGAKJwzgsddPndCXqdlS15ECGuS7g+K0+4=;
        b=KA4+ZCMZuR71tl3RrKYaXgrtOcSZATDT9wnZC2CfQBBMJcMbAcnuf7GKXhrRueSEjx
         dB+mn9UCUFkTFHISycjMph0g0XwTyC5kxqFmOCdNWTzAL6UmZei6e9sm+bMp51Z/g/T5
         M94UYN5hpNjVDq3rv54mC/NISlHMqF8ofJwYABj6n73w2e5oNhW9zbXk3MEq84exHkqU
         ip9+QKZUD1WHpn11Q7+IFKocohV+uCBjBi4mr85xjFtMbrwB30OVjxpC3rQSySjXY9UP
         pf1qJ0MKLcE63zEl3UG+nN//SunANMBwFMStIpTf0kN1fkidxFRaWWfcSwfAsKncZ30L
         LODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r43m2yxYlbGAKJwzgsddPndCXqdlS15ECGuS7g+K0+4=;
        b=sq87hUkm0AMZ3oWX045JvHT244PeyG66TkyaFbc+/EMvMN+hHVH4RWcbgCiwRwCCP/
         5eEgR6fVc1i3L6VNwvPvr8ZcBQU+o3jQ4CykTfYJHOhlCgQItDN5gzurq3D9PPJuyuA1
         wF4C6xIWsWupTSrk4iRRcuboW69cklQq2QOi8j57KhDKrWd2yhGGWMGBvHoYChh8AwKq
         g5mthvpYnusLLqDezjFw6JlqSksSuOdCZeP62e2G7ah6PR3HK0OY+rBmYVPTeS54S0sO
         ccxHe47aVNJ7e87MOyN0BUFS9tbJ6dKwhsit4oiEbfIDQZ7qHWaSgDG3HlL6dL8ZNRtK
         4WoA==
X-Gm-Message-State: AOAM533PoUAoOhOwJ3/J7w45tty46mEkxfgixFxTJ9ebRZzI1MC3UV5P
        FkMztNwq9MZA/isPKz1csQa3wxem
X-Google-Smtp-Source: ABdhPJwneSF2D2PeNoOStYBuk8LWJFO1ds+BOAG+YVnr2ka7GQpCC1HZ/xO5a/oJv+cDoIsGdsZQ9w==
X-Received: by 2002:a17:907:4240:: with SMTP id oi24mr24342674ejb.127.1592218667603;
        Mon, 15 Jun 2020 03:57:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id oq28sm8881774ejb.12.2020.06.15.03.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 03:57:47 -0700 (PDT)
Message-Id: <a83270485be2bebb1ce77be55ff73d136b735922.1592218662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.658.git.1592218662.gitgitgadget@gmail.com>
References: <pull.658.git.1592218662.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 10:57:42 +0000
Subject: [PATCH 5/5] pretty-lib: print commits using ref-filters logic
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

This change intends to use ref-filters logic to print commits.

Add `ref_pretty_print_commit()` which might be a future possible replacement
for `pretty_print_commit()`.

This is an introductory commit. Some features of `git log` might not work.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 Makefile     |  1 +
 log-tree.c   |  7 ++++-
 pretty-lib.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 pretty-lib.h | 21 +++++++++++++
 4 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 pretty-lib.c
 create mode 100644 pretty-lib.h

diff --git a/Makefile b/Makefile
index 372139f1f24..bcc65e87827 100644
--- a/Makefile
+++ b/Makefile
@@ -943,6 +943,7 @@ LIB_OBJS += pathspec.o
 LIB_OBJS += pkt-line.o
 LIB_OBJS += preload-index.o
 LIB_OBJS += pretty.o
+LIB_OBJS += pretty-lib.o
 LIB_OBJS += prio-queue.o
 LIB_OBJS += progress.o
 LIB_OBJS += promisor-remote.o
diff --git a/log-tree.c b/log-tree.c
index 55a68d0c610..663056664f9 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -17,6 +17,7 @@
 #include "help.h"
 #include "interdiff.h"
 #include "range-diff.h"
+#include "pretty-lib.h"
 
 static struct decoration name_decoration = { "object names" };
 static int decoration_loaded;
@@ -756,7 +757,11 @@ void show_log(struct rev_info *opt)
 		ctx.from_ident = &opt->from_ident;
 	if (opt->graph)
 		ctx.graph_width = graph_width(opt->graph);
-	pretty_print_commit(&ctx, commit, &msgbuf);
+
+	if (opt->use_ref_filter)
+		ref_pretty_print_commit(&ctx, commit, &msgbuf);
+	else
+		pretty_print_commit(&ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
 		append_signoff(&msgbuf, 0, APPEND_SIGNOFF_DEDUP);
diff --git a/pretty-lib.c b/pretty-lib.c
new file mode 100644
index 00000000000..abe4228290b
--- /dev/null
+++ b/pretty-lib.c
@@ -0,0 +1,84 @@
+#include "commit.h"
+#include "ref-filter.h"
+#include "pretty-lib.h"
+
+static size_t convert_format(struct strbuf *sb, const char *start, void *data)
+{
+	/* TODO - Add support for more formatting options */
+	switch (*start) {
+	case 'H':
+		strbuf_addstr(sb, "%(objectname)");
+		return 1;
+	case 'h':
+		strbuf_addstr(sb, "%(objectname:short)");
+		return 1;
+	case 'T':
+		strbuf_addstr(sb, "%(tree)");
+		return 1;
+	case 'P':
+		strbuf_addstr(sb, "%(parent)");
+		return 1;
+	case 'a':
+		if (start[1] == 'n')
+			strbuf_addstr(sb, "%(authorname)");
+		else if (start[1] == 'e')
+			strbuf_addstr(sb, "%(authoremail)");
+		else if (start[1] == 'd')
+			strbuf_addstr(sb, "%(authordate)");
+		else
+			die(_("invalid formatting option '%c'"), *start);
+		return 2;
+	case 'c':
+		if (start[1] == 'n')
+			strbuf_addstr(sb, "%(committername)");
+		else if (start[1] == 'e')
+			strbuf_addstr(sb, "%(committeremail)");
+		else if (start[1] == 'd')
+			strbuf_addstr(sb, "%(committerdate)");
+		else
+			die(_("invalid formatting option '%c'"), *start);
+		return 2;
+	case 's':
+		strbuf_addstr(sb, "%(subject)");
+		return 1;
+	case 'b':
+		strbuf_addstr(sb, "%(body)");
+		return 1;
+	case 'n':
+		strbuf_addstr(sb, "\n");
+		return 1;
+	default:
+		die(_("invalid formatting option '%c'"), *start);
+	}
+}
+
+void ref_pretty_print_commit(struct pretty_print_context *pp,
+			 const struct commit *commit,
+			 struct strbuf *sb)
+{
+	struct ref_format format = REF_FORMAT_INIT;
+	struct strbuf sb_fmt = STRBUF_INIT;
+	const char *name = "refs";
+	const char *usr_fmt = get_user_format();
+
+	if (pp->fmt == CMIT_FMT_USERFORMAT) {
+		strbuf_expand(&sb_fmt, usr_fmt, convert_format, NULL);
+		format.format = sb_fmt.buf;
+	} else if (pp->fmt == CMIT_FMT_DEFAULT || pp->fmt == CMIT_FMT_MEDIUM) {
+		format.format = "Author: %(authorname) %(authoremail)\nDate:\t%(authordate)\n\n%(subject)\n\n%(body)";
+	} else if (pp->fmt == CMIT_FMT_ONELINE) {
+		format.format = "%(subject)";
+	} else if (pp->fmt == CMIT_FMT_SHORT) {
+		format.format = "Author: %(authorname) %(authoremail)\n\n\t%(subject)\n";
+	} else if (pp->fmt == CMIT_FMT_FULL) {
+		format.format = "Author: %(authorname) %(authoremail)\nCommit: %(committername) %(committeremail)\n\n%(subject)\n\n%(body)";
+	} else if (pp->fmt == CMIT_FMT_FULLER) {
+		format.format = "Author:\t\t%(authorname) %(authoremail)\nAuthorDate:\t%(authordate)\nCommit:\t\t%(committername) %(committeremail)\nCommitDate:\t%(committerdate)\n\n%(subject)\n\n%(body)";
+	}
+
+	format.need_newline_at_eol = 0;
+
+	verify_ref_format(&format);
+	pretty_print_ref(name, &commit->object.oid, &format);
+	strbuf_release(&sb_fmt);
+}
diff --git a/pretty-lib.h b/pretty-lib.h
new file mode 100644
index 00000000000..324499b1150
--- /dev/null
+++ b/pretty-lib.h
@@ -0,0 +1,21 @@
+#ifndef PRETTY_LIB_H
+#define PRETTY_LIB_H
+
+/**
+ * This is a possibly temporary interface between
+ * ref-filter and pretty. This interface may disappear in the
+ * future if a way to use ref-filter directly is found.
+ * In the meantime, this interface would enable us to
+ * step by step replace the formatting code in pretty by the
+ * ref-filter code.
+*/
+
+/**
+ * Possible future replacement for "pretty_print_commit()".
+ * Uses ref-filter's logic.
+*/
+void ref_pretty_print_commit(struct pretty_print_context *pp,
+			const struct commit *commit,
+			struct strbuf *sb);
+
+#endif /* PRETTY_LIB_H */
-- 
gitgitgadget

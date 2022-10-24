Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9E2C67871
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiJXUub (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiJXUtg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:49:36 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB18F52DE5
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:56:54 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id l127so8482795iof.12
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPNL/OcdIuambt0Tm/HNOVTgI32GrLe4U2yhDI/QHxw=;
        b=uWLs/KMntVyxhQ0aQpuo99zbcozZgVP53P8bzatRsRam1QuJF5eebo8qHQ3UOu4pUI
         iHU1aaX40L/6ZWImJuINh0z62G+JuvMpW0zErtvg/KDlzY/g1P/oksbMVcg3B1JWwJbT
         tUT9QH4jX/FXvUJoyA1wzQ8ej8Zrzu8hBst/UEltGuV5u1ICGb9b4FIDRfVEwk+ynL5O
         HV5OJvg9h+Ztx1t51BgNes6e9PqKRrrc+hx6JflxzbwXJwsHeerT8YqnGEWXQBbhlrEf
         ah4s+lgN/LEDZg0RdOVfWCtbqOjcC/SCZ/xJImYVJ3kQiMivbSZ0wjkOelMgs0IVn+Np
         +2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPNL/OcdIuambt0Tm/HNOVTgI32GrLe4U2yhDI/QHxw=;
        b=7NEy9slQtfINx9QFb/xxGrlEES8ueLK5wABa6mcFiztdrEZ5VTlXVns87aVWu0PoRW
         BhYCVyUXyDsa3ieb/2CCAAVsRpoxb+szb7zHW8rQrSOfEsE5IsRzdlnUjc1RwK661rPL
         MXCP+6VCgAsWhAWmspsTOnIOLTBg9xEMnhiByXtz+y37ifFd9iR3Pj0FMTQvcCV0QaXN
         nBlea6h3n5Dcctyplog38lAltsEnWbI2dz6hgAx6lRMCBp6fYOMZzW4+0+Kgg17+SMG/
         43BHxrVoH92sKqNm13lFSQvNnhkusJKaz/+ZyLWWnJphHemPxDvHPY0fTM/bLlc7QDgk
         HUkw==
X-Gm-Message-State: ACrzQf1aUfxHEOHXN5oxBvXxQqvlviZNnRO9nnEmZSoonqEZJnlvuUDC
        3TWD92MuCwhAEolBMavAsaL6vYL+irPwPK/5
X-Google-Smtp-Source: AMsMyM4W/5lQU+0t2foqOTRBlYTyXaUAV69oRXkuyQm52ip1/p4G5WrIBngrJoq7JFkeMoVLfX4Y8w==
X-Received: by 2002:a02:3548:0:b0:362:4000:9010 with SMTP id y8-20020a023548000000b0036240009010mr22927861jae.69.1666637731646;
        Mon, 24 Oct 2022 11:55:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n20-20020a02a194000000b00349d33a92a2sm83658jah.140.2022.10.24.11.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:55:30 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:55:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jacob Stopak <jacob@initialcommit.io>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 1/7] shortlog: accept `--date`-related options
Message-ID: <38b60641c0f09a4cc6f8a9a69faafe8e3bd7635f.1666637725.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666637725.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666637725.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Prepare for a future patch which will introduce arbitrary pretty formats
via the `--group` argument.

To allow additional customizability (for example, to support something
like `git shortlog -s --group='%aD' --date='format:%Y-%m' ...` (which
groups commits by the datestring 'YYYY-mm' according to author date), we
must store off the `--date` parsed from calling `parse_revision_opt()`.

Note that this also affects custom output `--format` strings in `git
shortlog`. Though this is a behavior change, this is arguably fixing a
long-standing bug (ie., that `--format` strings are not affected by
`--date` specifiers as they should be).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-shortlog.txt | 5 +++++
 builtin/shortlog.c             | 3 ++-
 shortlog.h                     | 2 ++
 t/t4201-shortlog.sh            | 7 +++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index f64e77047b..9ed9d6a9e7 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -47,6 +47,11 @@ OPTIONS
 
 	Each pretty-printed commit will be rewrapped before it is shown.
 
+--date=<format>::
+	Show dates formatted according to the given date string. (See
+	the `--date` option in the "Commit Formatting" section of
+	linkgit:git-log[1]).
+
 --group=<type>::
 	Group commits based on `<type>`. If no `--group` option is
 	specified, the default is `author`. `<type>` is one of:
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 7a1e1fe7c0..53c379a51d 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -211,7 +211,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	ctx.fmt = CMIT_FMT_USERFORMAT;
 	ctx.abbrev = log->abbrev;
 	ctx.print_email_subject = 1;
-	ctx.date_mode.type = DATE_NORMAL;
+	ctx.date_mode = log->date_mode;
 	ctx.output_encoding = get_log_output_encoding();
 
 	if (!log->summary) {
@@ -407,6 +407,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	log.user_format = rev.commit_format == CMIT_FMT_USERFORMAT;
 	log.abbrev = rev.abbrev;
 	log.file = rev.diffopt.file;
+	log.date_mode = rev.date_mode;
 
 	if (!log.groups)
 		log.groups = SHORTLOG_GROUP_AUTHOR;
diff --git a/shortlog.h b/shortlog.h
index 3f7e9aabca..dc388dd459 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -2,6 +2,7 @@
 #define SHORTLOG_H
 
 #include "string-list.h"
+#include "date.h"
 
 struct commit;
 
@@ -15,6 +16,7 @@ struct shortlog {
 	int in2;
 	int user_format;
 	int abbrev;
+	struct date_mode date_mode;
 
 	enum {
 		SHORTLOG_GROUP_AUTHOR = (1 << 0),
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 3095b1b2ff..7547da539d 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -83,6 +83,13 @@ test_expect_success 'pretty format' '
 	test_cmp expect log.predictable
 '
 
+test_expect_success 'pretty format (with --date)' '
+	sed "s/SUBJECT/2005-04-07 OBJECT_NAME/" expect.template >expect &&
+	git shortlog --format="%ad %H" --date=short HEAD >log &&
+	fuzz log >log.predictable &&
+	test_cmp expect log.predictable
+'
+
 test_expect_success '--abbrev' '
 	sed s/SUBJECT/OBJID/ expect.template >expect &&
 	git shortlog --format="%h" --abbrev=35 HEAD >log &&
-- 
2.38.0.16.g393fd4c6db


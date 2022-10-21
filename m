Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF1BC38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 22:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJUWZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJUWZo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 18:25:44 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE7E1BB554
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:25:42 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id l127so3472386iof.12
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPNL/OcdIuambt0Tm/HNOVTgI32GrLe4U2yhDI/QHxw=;
        b=Xw8wksyKtJ0LO8wMAm675WYPSsd++UhcV3ogDBuky1REpvI3PL+1xQGr7O5gh/qrtI
         jZlwcDvXs0tILVBGSuTqVqCWMssoMC8keGxX5DrTP5kPTQdVpgEjfXyKRkIiGyRMPcGN
         Wg2dv2OBixx+QEOlwl/K0J+lCnwntBLjiDbe+xyfwTWqse7pUJ+rISiZvh25r1un9o0T
         UDv7AHlILpxxn/dYkML497gn+H0+IVDf++qhq/c7bUqmeYyg91HLmso8+j/NSJ4MGuCr
         QXkf6W5dzsZCGWlGxul1xCsRC+IlKPHGDp+llQY9TCLhhhK3Ev2cTYd50NiXaCOuQhyl
         a9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPNL/OcdIuambt0Tm/HNOVTgI32GrLe4U2yhDI/QHxw=;
        b=nCPMbSAx3Z1I3t4jevKiagvodCLS3yrxBuBl+qIKnB4G9EQ7+ovHXpN5OZL/Y6qCk+
         jU2jmyPl+f+7dsyxzuusyC0XVgzg7Bhuy2pQmrP6Ti91jNoAerIYBUtsK4sO0fOq84pr
         uX0cmhc2rZbzbCymsBx4yOn0+5ifM/Rr8oYuUPnmlQZXG0aGAdFqk43udqY5hYjVsjFV
         /Uy9lH5eVYaFFT94SsJYO2hyN/xrhGSwyOg0VhRNXwXlBXxQLK4zl1RUPos9S/3NTOAC
         aKsMTiw3gjs8UO8jncvaSi4woNTR9Ff9pVmgMSY1J7263JN8kSpZvBEWXVWcKsHqlNuV
         HPBw==
X-Gm-Message-State: ACrzQf0Ti2Dj3Ari7S+le31lu1bpP3CAyOp2rueErbXwI3mqGna7Az/n
        v7vy+KPYiyprILoaEq7FAhnSUCUYyehXwN+U
X-Google-Smtp-Source: AMsMyM6nP1F5tq58UXmEJjrJGlEUL3GiUxUbIZC2pQd5RizxZXfK59+nr8FVOtjmCFGVJb5mWNhYoQ==
X-Received: by 2002:a05:6602:2c42:b0:6bc:e15d:4c65 with SMTP id x2-20020a0566022c4200b006bce15d4c65mr15615115iov.31.1666391141838;
        Fri, 21 Oct 2022 15:25:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i17-20020a0566022c9100b006bccaa66ee4sm4882284iow.40.2022.10.21.15.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:25:41 -0700 (PDT)
Date:   Fri, 21 Oct 2022 18:25:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v3 1/7] shortlog: accept `--date`-related options
Message-ID: <add457f31916f81226f9104730af5a1dc58a041a.1666391136.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666391136.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666391136.git.me@ttaylorr.com>
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


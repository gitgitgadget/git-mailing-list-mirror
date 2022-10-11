Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35968C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJKAeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiJKAeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:34:09 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2372880E8C
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:34:07 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id a2so6409966iln.13
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oewU+Aj9bd7zcbDhSwe7FMeW0onZ/E8bpCZvaVtMCso=;
        b=xR96KNYVO78+Wa8TLFK6enHNdb/crZ3dAReix9oItAr0KZfVMcrLolMo3UMoqngwta
         +LE8rUQXqESUfF1iYvpdczWQ5NrbocXdmdc9EeQ2G+1t2wcRICByf2ZV6kIVDIZHuvJo
         hy/Ddljb3V4LleGAz97K6kKrkVLIERoC/Y3FKeBAie+9PPCRSECY/pIEQYWFFDJtTATH
         C4VJjZIldJWanBUB5VUf+MFfuAxb0dStVFOKSKVYvVw3wXWHUOrNkuBw8sNXHolpoDKx
         cky+7bISoOST66tFCAH4fjx1gT++JnahnWq0A123H9YfwggT8AvupucG6YqgJXQmlndJ
         pWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oewU+Aj9bd7zcbDhSwe7FMeW0onZ/E8bpCZvaVtMCso=;
        b=smTGqZkoU+pUAnU63iERAtPLGMhJD8kDhfbpS5QEzbLrEBqbTOhIhKMhzBtqqBcYri
         OeJRGFyAyGCLKTLIzEebbVzNuj7zvffWmhJYu25keULnRM8zoKY20A3//23S+PQlLtGV
         zhNAbuVwRHAll5pi2yCiivQlRVtO1GGH58ofI+3ddz6HzpgRC40oKXI33pVGItO33yoG
         IZV4AWULWROmoMGQ/dPU3eP/5ibiXUVEoOql12neRCjhzf+0Q9D1dIVu7Akk7jwTpCHI
         fF1kLTzMkDML4IfI04z5WxhR8FkZ/Dg13hUFWSabvvy56DQp5o2TTwnTtbzBmS4ylZnk
         GItg==
X-Gm-Message-State: ACrzQf0V9GpXemTALnswoxLQMD0cqxhWyr07fKqTaGLIz8Nk34MpPu+7
        nOS4Z6XhZzIgnoRWmu5ItWpjZCs2nX7TOI9K
X-Google-Smtp-Source: AMsMyM6eZ5EvIu/NR2Ec2jiZ8ki3GA3MKButtVaDIoGGrVPAweFGnO/BCp0QQLpgo3C9F/X2uz77Zg==
X-Received: by 2002:a92:d34c:0:b0:2f8:d52d:4049 with SMTP id a12-20020a92d34c000000b002f8d52d4049mr10534614ilh.53.1665448447107;
        Mon, 10 Oct 2022 17:34:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k8-20020a6b4008000000b0067fb21ad9c3sm4787972ioa.22.2022.10.10.17.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 17:34:06 -0700 (PDT)
Date:   Mon, 10 Oct 2022 20:34:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com
Subject: [PATCH 2/7] shortlog: accept `--date`-related options
Message-ID: <b587b8ea4ab593806b9fb6d1db8751591991455b.1665448437.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1665448437.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Prepare for the future patch which will introduce arbitrary pretty
formats via the `--group` argument.

To allow additional customizability (for example, to support something
like `git shortlog -s --group='%aD' --date='format:%Y-%m' ...` (which
groups commits by the datestring 'YYYY-mm' according to author date), we
must store off the `--date` parsed from calling `parse_revision_opt()`.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-shortlog.txt | 2 ++
 builtin/shortlog.c             | 3 ++-
 shortlog.h                     | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index f64e77047b..4982ceee21 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -108,6 +108,8 @@ options or the revision range, when confusion arises.
 :git-shortlog: 1
 include::rev-list-options.txt[]
 
+include::date-options.txt[]
+
 MAPPING AUTHORS
 ---------------
 
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
-- 
2.37.0.1.g1379af2e9d


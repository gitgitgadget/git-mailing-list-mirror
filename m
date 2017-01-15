Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81A662079E
	for <e@80x24.org>; Sun, 15 Jan 2017 18:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbdAOSrd (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 13:47:33 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33668 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbdAOSr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 13:47:28 -0500
Received: by mail-qk0-f193.google.com with SMTP id 11so13855731qkl.0
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 10:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BJ7gVSEc8jG+isdH4xYpH/g3BM7/a6b6xL7xDIcfUEk=;
        b=UoU1xtr82KqWGlyj2eyR1NLOkZeGX2yaa7DzoJz0mZ9yGYsKS10omPzLr6txz/CwA3
         39pw41O63TxHR9+dOTlYY29ux5WiaZvPQTh9VT8U+sA+ghjUtcQ4ROC6RrnB6ZMp0XlO
         sMPpul/u0v/+MY0NO6yPea/iQWW/AJbZ4c4DHlyG/Slj4+AtVUBTUrF6ip6lFnWKWKjr
         C5C3zwT81xOEQ4peSgNj95cRBRyNQFVJosm3UFtDvndSCa04xj5+/bL1F49eicKpi4y+
         i1n5iNdsea+EmxflsJi0FX3pEn5DgQGwSL+sld4Nysv5jU0VMUv53XU0Q34iAONquckj
         B2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BJ7gVSEc8jG+isdH4xYpH/g3BM7/a6b6xL7xDIcfUEk=;
        b=qlTco72PZrMFp98oJZq7TMGJMiQllpC5vVBuYtqvCIPGyyd0HdBiCPBeytRDARg/Dv
         KWN+B21NXEghCMTo2YViAjx0HOGrmC09fu4YRDOM+fvPj7jJ9Bm0+v5la+IqIekTBBh1
         VOTO2RQxTvB/zr6hMjdKeQ1hXStHHoDNOQ82myio7MVck09IAOlBpgsG88pnQeIWbEcz
         FbuPAtggBkr5mXtrforq494KryO45aI/Bw3w5msjBmAWQ8ddMD99dbbsfo60C1ZFvKmz
         YtGUrVLRdGR+ZSoIEF5jxPeDCDSrrTOs/uYf3EJXwRr+DrYyI7BDn76UMLGkwH8u7PEv
         W9iA==
X-Gm-Message-State: AIkVDXJ29q+yGur1NiTk5UKQzxDMcRD22uWccrHcIZal9KP4xCv361ed/eW/BcdOcCKcfhGN
X-Received: by 10.55.102.199 with SMTP id a190mr26485525qkc.168.1484506047810;
        Sun, 15 Jan 2017 10:47:27 -0800 (PST)
Received: from localhost.localdomain ([2604:2000:8183:da00::3])
        by smtp.gmail.com with ESMTPSA id x40sm14362243qtx.12.2017.01.15.10.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jan 2017 10:47:27 -0800 (PST)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v5 4/7] builtin/verify-tag: add --format to verify-tag
Date:   Sun, 15 Jan 2017 13:47:02 -0500
Message-Id: <20170115184705.10376-5-santiago@nyu.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170115184705.10376-1-santiago@nyu.edu>
References: <20170115184705.10376-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

Callers of verify-tag may want to cross-check the tagname from refs/tags
with the tagname from the tag object header upon GPG verification. This
is to avoid tag refs that point to an incorrect object.

Add a --format parameter to git verify-tag to print the formatted tag
object header in addition to or instead of the --verbose or --raw GPG
verification output.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 Documentation/git-verify-tag.txt |  2 +-
 builtin/verify-tag.c             | 13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index d590edceb..0b8075dad 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -8,7 +8,7 @@ git-verify-tag - Check the GPG signature of tags
 SYNOPSIS
 --------
 [verse]
-'git verify-tag' <tag>...
+'git verify-tag' [--format=<format>] <tag>...
 
 DESCRIPTION
 -----------
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index de10198c4..212449f47 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -12,12 +12,14 @@
 #include <signal.h>
 #include "parse-options.h"
 #include "gpg-interface.h"
+#include "ref-filter.h"
 
 static const char * const verify_tag_usage[] = {
-		N_("git verify-tag [-v | --verbose] <tag>..."),
+		N_("git verify-tag [-v | --verbose] [--format=<format>] <tag>..."),
 		NULL
 };
 
+
 static int git_verify_tag_config(const char *var, const char *value, void *cb)
 {
 	int status = git_gpg_config(var, value, cb);
@@ -30,9 +32,11 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
+	char *fmt_pretty = NULL;
 	const struct option verify_tag_options[] = {
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
 		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
+		OPT_STRING(  0 , "format", &fmt_pretty, N_("format"), N_("format to use for the output")),
 		OPT_END()
 	};
 
@@ -46,12 +50,17 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (verbose)
 		flags |= GPG_VERIFY_VERBOSE;
 
+	if (fmt_pretty) {
+		verify_ref_format(fmt_pretty);
+		flags |= GPG_VERIFY_QUIET;
+	}
+
 	while (i < argc) {
 		unsigned char sha1[20];
 		const char *name = argv[i++];
 		if (get_sha1(name, sha1))
 			had_error = !!error("tag '%s' not found.", name);
-		else if (verify_and_format_tag(sha1, name, NULL, flags))
+		else if (verify_and_format_tag(sha1, name, fmt_pretty, flags))
 			had_error = 1;
 	}
 	return had_error;
-- 
2.11.0


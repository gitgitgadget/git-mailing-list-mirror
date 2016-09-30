Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50529207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 22:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933544AbcI3WSY (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 18:18:24 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34324 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbcI3WSP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 18:18:15 -0400
Received: by mail-qk0-f194.google.com with SMTP id n189so4796846qke.1
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MLX2p2FE5aRVBA3TchvbtCk68W5SKlnwwEokuNayxb8=;
        b=MJH/LO+RxgAtloNYhsNZn/Lffus2nj/B6cfkNb2CehkxEaHllV0jha3yUIp9J9P2l6
         tt2lfSuyLEM+6dlcKJnvZjonZ3n8m829NLYwkLc90tzS6LIUPEvIHL0QrZOvGO58VMU+
         T4YiYwwy21LPKg06iSqWnr5MwYqqFbdaUU1D0P/dEVH55dhM1R3UEvpgccTfMPsfgzWj
         4CxW+qu02YvUkZqeMEPLkNvaI8Iex0/3stynYrRNcN4ejCfSe13k3ns0InnNkblrhC11
         H2jCBSdf51NwICE+1UedQi43M5tHzojU7KoEf5CcP8oDjVf0gq4TAU7RlY9aqGQ48u+o
         5r4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MLX2p2FE5aRVBA3TchvbtCk68W5SKlnwwEokuNayxb8=;
        b=YqCqTEtxNREcl10OIAM+ci3AvTSbH0C8EwiCxpYsHdnwZbCGHaQrA5hgG1j0dYy5O9
         az1DJTt8VDtQThDNudr/HiYoSM7gF2FyomEvYZ5aCQzObXiM6jX9PWXIAlL6uI83dx5L
         KBpkrATEbCZAeiEK+wVDcFmTtcqyUVSqVHip5pjdSGRnNTanLqyXQ4N7Wipy+1QmdhFm
         O/Sqn4mfAd0YKpfr7N703a/Fxj5wndbuykjv2i73z6zW6P4gRv6/25bA0ho4RkijoFad
         EiXz4N9VZiSDU5r+vZ0L7Jh5FJaWMBEOSJzUw1+4JodYbSBlqL3DwaxDW20oOD+Ay74E
         cjhg==
X-Gm-Message-State: AA6/9RmtgsHRRJ8nUjWsfXBpPrpKRH+8b4qM2wt8pXh+P4ehWIi91t11tmLYtJQ1Dfs8tAaE
X-Received: by 10.55.42.73 with SMTP id q70mr10070224qkh.282.1475273894763;
        Fri, 30 Sep 2016 15:18:14 -0700 (PDT)
Received: from LykOS.localdomain (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id x21sm11347615qkb.19.2016.09.30.15.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2016 15:18:14 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v3 4/5] builtin/verify-tag: add --format to verify-tag
Date:   Fri, 30 Sep 2016 18:18:05 -0400
Message-Id: <20160930221806.3398-5-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160930221806.3398-1-santiago@nyu.edu>
References: <20160930221806.3398-1-santiago@nyu.edu>
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
index d590edc..0b8075d 100644
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
index de10198..745b6a6 100644
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
+    char *fmt_pretty;
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
2.10.0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D7C420756
	for <e@80x24.org>; Tue, 17 Jan 2017 23:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbdAQXi7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 18:38:59 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35058 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbdAQXhc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 18:37:32 -0500
Received: by mail-qk0-f193.google.com with SMTP id u25so17289095qki.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 15:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q5A4fDuksTL8dxDcwlYLNoVguICMyLnnbfAYxGWfunw=;
        b=RsK5uqjRyiOA4E4xjHm+Kc9AgrG0DNgRXDTQSSVmc/F3PXLB9/fhb+yFQBre79rUhe
         2rAQUPYIJyH/D1vKeWZ2QIpUYeN1eMPtkkZ5uM8nFSEjLZREz0ag5ykfjuizgR5beddX
         I+rARguXjtrkdPwYWumQo4yTiQ23dKFmMLTXSdX9Mvq5oGz7rUwmbLrHLSfF+Oo0ztnT
         UpJqoJuRETMOluidmX+Js5l2XwHU1HPhltIMA545zTzug2Lf2X6M+3WS9Ut3K4Mu+Un0
         ODu5ebcFw0Ip+0ei82mnXf9KebdwPTneGyunWSdXuFaFK03LRSWgLQpBRzP6vlP7zKO2
         /19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q5A4fDuksTL8dxDcwlYLNoVguICMyLnnbfAYxGWfunw=;
        b=Ejb1gnJk8U8M2GdGwdxR6HfMqDa7uWJVlzn57CHDETLErOn00xDQ82mviKu0HXj8es
         qfANKHhJKgG1TWGx3uc5Qa0Z+vrSeQXzWTxwBqEYjLDGa6i13wuJ23a9oF+4qszXx9cc
         SZLdkITFleEIqzPVpr5F2dKKPwf6J7+O02CT7gJl8qylo7dULAivLwJh6lAqj/88oHae
         om5m2sQVgjok34rnV8aASNC7lhd1spmOxqsTnFK6c5yZ9Dvaj8sWLP1jdWBMX0A1c2zR
         gk9vpEqfksQh61igxrISezCo3poDPgn520PWNMmNcpVjtHeH5JVGW1hNmFZ0LKHGi+B0
         V8qw==
X-Gm-Message-State: AIkVDXJwb0JwyYgrHOrjGxk8zYVb0QmhIilX4hrxsnqOlemzHTDfENTDWuozHsWr92t7pduz
X-Received: by 10.55.98.194 with SMTP id w185mr222065qkb.41.1484696252070;
        Tue, 17 Jan 2017 15:37:32 -0800 (PST)
Received: from localhost.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id c1sm3405814qke.36.2017.01.17.15.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2017 15:37:31 -0800 (PST)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v6 3/6] builtin/verify-tag: add --format to verify-tag
Date:   Tue, 17 Jan 2017 18:37:20 -0500
Message-Id: <20170117233723.23897-4-santiago@nyu.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170117233723.23897-1-santiago@nyu.edu>
References: <20170117233723.23897-1-santiago@nyu.edu>
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
 builtin/verify-tag.c             | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

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
index 99f8148cf..18443bf9f 100644
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
 
@@ -46,13 +50,26 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (verbose)
 		flags |= GPG_VERIFY_VERBOSE;
 
+	if (fmt_pretty) {
+		verify_ref_format(fmt_pretty);
+		flags |= GPG_VERIFY_OMIT_STATUS;
+	}
+
 	while (i < argc) {
 		unsigned char sha1[20];
 		const char *name = argv[i++];
-		if (get_sha1(name, sha1))
+		if (get_sha1(name, sha1)) {
 			had_error = !!error("tag '%s' not found.", name);
-		else if (gpg_verify_tag(sha1, name, flags))
+			continue;
+		}
+
+		if (gpg_verify_tag(sha1, name, flags)) {
 			had_error = 1;
+			continue;
+		}
+
+		if (fmt_pretty)
+			pretty_print_ref(name, sha1, fmt_pretty);
 	}
 	return had_error;
 }
-- 
2.11.0


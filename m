Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E19A220986
	for <e@80x24.org>; Fri,  7 Oct 2016 21:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756338AbcJGVIS (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 17:08:18 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35195 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755334AbcJGVIL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 17:08:11 -0400
Received: by mail-qk0-f194.google.com with SMTP id v138so2013703qka.2
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D8AtYnvZwiTW4D4RhmuD7qA/F3ys+lMtklCCT0CIVTc=;
        b=B2XU1Xyq7rnFwO6LG33rodG6R/ZaV1xnMeQv2nubFNsOmxw7KDc21ZF6GKqcDw4fpA
         jLJHBtRZLqlmW6wBt1h9qrDNoNAsG1SaXjkgj2r2SUUuoGrkMlZCJmEriNc8qEKeuQ3g
         ABlrj1kK8r1RRKJRbDOiug0JA0pkUbChqrvEl4cadkyO89YNj8dWSBq6YGUAmtVXMC7k
         ZMDbhYSOa48aKWLkVGC141D3rOeELtq55YKa6EzMIF5Ph2v1WDzRL5rFBQ2YTiGZ4yst
         yHdzl9XgdGo/1mgR6n8KDkKabR223CDBTmlT16GwXm9O1ahd/njELzVw6p28bxBO8f57
         rnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D8AtYnvZwiTW4D4RhmuD7qA/F3ys+lMtklCCT0CIVTc=;
        b=LQj4kdWTcr3SSqjUyoar5yMPiQtldO5rap66OaLuVpIhs3M3ZWwOaZSYUU9q7a439t
         ezFRI0OrpGYzU+Mn/XMsv3NtvCpUQAiQkadIsKk9SxDKztaVm3al2gWDXqG8HtZmnfQx
         k9D5yAP7s0sB1E03bu9xqW2PPIAkoCGY2DJQ22UdBLo8fFdVLxzRmoJAKtSAB+NQsZdP
         aOJTbcqq2bfZOUtCgt2DOw8nomlkdMbsFa9knVEHGB2V2hPraGeVcy5L2NR4z+c3q3WX
         0tOdo6va9RQaPkUOx6N05XGpI1GePsaGPgkFpPKKBRKf+0QuiFnN9rc7h3V++rQZgm0K
         PTMA==
X-Gm-Message-State: AA6/9RkB9TJOxkb9dGSTeiYnrVE9Gd6VvqcaXxSs5nw0rSPk6BoOLaB8UX79ke8pIODAjoVk
X-Received: by 10.55.128.66 with SMTP id b63mr20878314qkd.69.1475874450453;
        Fri, 07 Oct 2016 14:07:30 -0700 (PDT)
Received: from LykOS.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-05.NATPOOL.NYU.EDU. [216.165.95.76])
        by smtp.gmail.com with ESMTPSA id a192sm7544808qkc.26.2016.10.07.14.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 14:07:29 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v4 4/7] builtin/verify-tag: add --format to verify-tag
Date:   Fri,  7 Oct 2016 17:07:18 -0400
Message-Id: <20161007210721.20437-5-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161007210721.20437-1-santiago@nyu.edu>
References: <20161007210721.20437-1-santiago@nyu.edu>
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
2.10.0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12B281F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 18:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965979AbcIVSxy (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 14:53:54 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35598 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941025AbcIVSx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 14:53:27 -0400
Received: by mail-qk0-f195.google.com with SMTP id n185so1736800qke.2
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8deIN9UuAnnX8AYD0oSb3yHkVMpE8Lxc/06tVYo/xsE=;
        b=vsqPyySdrM24qlMNYR+gXBQBMLJkhyXGtoeNALAi58VqLv6tjmifXbAcbooNQM+NAh
         iLaptm+wAxM6F8Lo/77YrvBm6KiIB75B3SxFnepwlZSFadyAaSlUUQgHuY+RXwccxMsD
         xMA63plk0oFwXJyslY88TxQkyuEpsUR8bYtYWXZI6foBk5BNj35BDF/GJidX3of9Fi8S
         8e8hSPK6UQN4GKufGH528LI4Q3e0idHMqYQ2RTPfKZI+07xFPPrD/+OBt+KDyHzt0qVK
         xetigZufH+vILn4AvJA83izWXu1lQIbQes9h2B6g8yFEgPaVR6mcoA323fG6ycUy3O+L
         4T3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8deIN9UuAnnX8AYD0oSb3yHkVMpE8Lxc/06tVYo/xsE=;
        b=JIe7NA5K6Gk8AWm18YxKCS3kNTWI3NR7UmmIWsIArYQcxD+aYgXUpj/gZvV0oGwUv4
         fIyBMTZCTpn1y1QV8vAETishojFEIr7gnri92PlX7deQ0vhWye3UaKOI4ksMq+7lU/jZ
         WPFCnWrZzmt0JqhKyUVJ4IVHbHqChGxwmZRl0+bNjPpR5vIGSgMu7HxS6wYzPZQrls5M
         4Vficjx5dtYBlUqKesJXEtbOrMGZL0uRzeQ2ebeSGKd/3/uE72o21DvyMPc0PHyRc0AS
         +1al3v8PzFJgay30D92ZwWBXSjbVGvow93jl1Mlk27Ru4NMOERrcTCmoTUEU47tzFpez
         ht5g==
X-Gm-Message-State: AA6/9RlE4YH9G9tqnsX6zcqUr+QH22yL7Aldka9i8i0LhuYtuGl6EDyvMLaBa23ZtqKrSTYv
X-Received: by 10.55.71.198 with SMTP id u189mr3875721qka.251.1474570406516;
        Thu, 22 Sep 2016 11:53:26 -0700 (PDT)
Received: from LykOS.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id m87sm1675117qkl.21.2016.09.22.11.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Sep 2016 11:53:26 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH 5/6] builtin/verify-tag: Add --format to verify-tag
Date:   Thu, 22 Sep 2016 14:53:16 -0400
Message-Id: <20160922185317.349-6-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160922185317.349-1-santiago@nyu.edu>
References: <20160922185317.349-1-santiago@nyu.edu>
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
 builtin/verify-tag.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 7a1121b..319d469 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -12,12 +12,15 @@
 #include <signal.h>
 #include "parse-options.h"
 #include "gpg-interface.h"
+#include "ref-filter.h"
 
 static const char * const verify_tag_usage[] = {
-		N_("git verify-tag [-v | --verbose] <tag>..."),
+		N_("git verify-tag [-v | --verbose] [--format=<format>] <tag>..."),
 		NULL
 };
 
+char *fmt_pretty;
+
 static int git_verify_tag_config(const char *var, const char *value, void *cb)
 {
 	int status = git_gpg_config(var, value, cb);
@@ -33,6 +36,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	const struct option verify_tag_options[] = {
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
 		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
+		OPT_STRING(  0 , "format", &fmt_pretty, N_("format"), N_("format to use for the output")),
 		OPT_END()
 	};
 
@@ -46,13 +50,18 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
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
 		else {
-			if (verify_and_format_tag(sha1, name, NULL, flags))
+			if (verify_and_format_tag(sha1, name, fmt_pretty, flags))
 				had_error = 1;
 		}
 	}
-- 
2.10.0


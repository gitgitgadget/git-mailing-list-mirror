Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68DB720986
	for <e@80x24.org>; Mon, 26 Sep 2016 22:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933332AbcIZWnH (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 18:43:07 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36242 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933262AbcIZWnA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 18:43:00 -0400
Received: by mail-qk0-f193.google.com with SMTP id m184so4646624qkb.3
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gm1Wl4++KD7L9aQDygo/zpgnAGF8Vqf4fxBjuS0gwys=;
        b=tiRFyk34LcvUw4rCPUu2Y/U0QCEUHeGTcbI+Blgk9TJAB2jlQnZaWPyiC83kgmT+SP
         RFaqIHp1yFfR7Mn0ITQEYm3eKIjL7Ryie81U4uSK3DLUR4SL5wjXFOYTI4YOxX9HcsuG
         +AdPM549gtWX941LMRIxkjXJnfDlGz949evvsQYM7m8KxjNwQ/fUV09vCFRztWh6HSoi
         aO39fmJHnxp0vxB2/la6vtwqb7qzIpE68njgsJIeq8qojYAn6hnEgfyWpjAmgzVqqqFS
         1o+soNPA910oXdeVpDcjHgT4XJEdJP+8sAcGDmRf2HGm9CVz99niuWe38Ll5ypVKDe1v
         5SLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gm1Wl4++KD7L9aQDygo/zpgnAGF8Vqf4fxBjuS0gwys=;
        b=ljeg1/ss6zRJO2Z5fADA59GNBGoeYAjVNFCGefsUDbA+vTy10OuDSjOZBnvAodMI+M
         78oNPMF3IjWy4V5OPdlcbH/8/pjDM5bwuPV+9s6B+OOIvzXJ5Ezgbz9gWTVUG/z146nG
         GLesuJQrK2wjnea81M1Z3jRgnTiNPfQo3km/3I7PZmHxYCzQzNiPJi4kcWYQKFh0Effq
         U67rLR6D2BilmRPSXiHCPwWxzMSPZQQcjetGMfHlCl9xuwt4XcTCFGEZsz4xjcDtiYCy
         PonMzRKWypUKJWzirvMZavyKBvuWiu7J1xCMH2oJcA4/LhT27D6DotJS7H9f3HEurSPr
         RRcg==
X-Gm-Message-State: AA6/9Rny1qtGSaXioNnNCCpvQgNUg5g0WfU3WCSi83o42j3olf+SyNn9ReTE8D0A2FKY4xBE
X-Received: by 10.55.5.21 with SMTP id 21mr2950589qkf.231.1474929774719;
        Mon, 26 Sep 2016 15:42:54 -0700 (PDT)
Received: from LykOS.localdomain (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id 62sm12840092qtg.14.2016.09.26.15.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Sep 2016 15:42:54 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v2 4/5] builtin/verify-tag: add --format to verify-tag
Date:   Mon, 26 Sep 2016 18:42:32 -0400
Message-Id: <20160926224233.32702-5-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160926224233.32702-1-santiago@nyu.edu>
References: <20160926224233.32702-1-santiago@nyu.edu>
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
index de10198..a941053 100644
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
 
+static char *fmt_pretty;
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


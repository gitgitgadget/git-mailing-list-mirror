From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/3] config: add git_config_option_string()
Date: Fri,  6 Mar 2009 17:15:13 -0500
Message-ID: <12addb53ef5c0e62ee22847591c8e7b884dc0bd2.1236377358.git.jaysoffian@gmail.com>
References: <cover.1236377358.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	jean-luc malet <jeanluc.malet@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 23:17:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfiLk-0006q9-6T
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 23:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755815AbZCFWPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 17:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755504AbZCFWPd
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 17:15:33 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:2047 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753973AbZCFWPb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 17:15:31 -0500
Received: by qw-out-2122.google.com with SMTP id 5so793684qwi.37
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 14:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=i+KsLfFA53N07H1C4DBJTJITElX6HJbSYdmirqzziDU=;
        b=mCnyp5/Fy4ESh6x3T3jCxv/Cd7WkQc4Ro74cTLYqIydnWLoGY4m9iEj4QHaRW3KSCp
         p16xqW/OfCJQfdVl+ipGzryfT+Gk/iUS9HyQLcmzNFdOjf5+f9ofj0MkYY5tDj/Ez0ke
         DcBedhuugWxhPBHRbAUq95t5cMGVRLkPcQZzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FBYhYVGRh2i1uNm4x+cJw2Cus1p+ga5P4zDEaDRIB1InAEaSDDbtNcxHQl+CKBno3N
         Jr066qBCCx2RSfqcZTuaQM+noid+kR0BMhfk62aNX0N9pVdLaEXH9BUSYvIzBzGfh69x
         j76mpgt141eKXtuho6g1POIt0GFXhNpkMXkms=
Received: by 10.224.2.212 with SMTP id 20mr4511730qak.338.1236377730307;
        Fri, 06 Mar 2009 14:15:30 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 5sm1349617qwh.49.2009.03.06.14.15.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 14:15:29 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2.332.g5d21b
In-Reply-To: <cover.1236377358.git.jaysoffian@gmail.com>
In-Reply-To: <cover.1236377358.git.jaysoffian@gmail.com>
References: <cover.1236377358.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112482>

This patch teaches config a new function, git_config_option_string(),
which parses a string using parse-options.

This is useful for any command that allows command-line options to
appear in a config.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Originally I had just factored this into its own function in
builtin-merge, but it seemed that it might be generally useful, so I
moved it to config.c

 cache.h         |    2 ++
 config.c        |   39 +++++++++++++++++++++++++++++++++++++++
 parse-options.c |    2 ++
 3 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 189151d..c6d3f05 100644
--- a/cache.h
+++ b/cache.h
@@ -854,6 +854,8 @@ extern unsigned long git_config_ulong(const char *, const char *);
 extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
+struct option;
+extern int git_config_option_string(const struct option *, int, const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
diff --git a/config.c b/config.c
index 0c8c76f..29cfd5b 100644
--- a/config.c
+++ b/config.c
@@ -7,6 +7,7 @@
  */
 #include "cache.h"
 #include "exec_cmd.h"
+#include "parse-options.h"
 
 #define MAXNAME (256)
 
@@ -353,6 +354,44 @@ int git_config_string(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
+int git_config_option_string(const struct option *options, int flags,
+			     const char *var, const char *value)
+{
+	int argc, ret;
+	const char **argv;
+	char *buf;
+	struct parse_opt_ctx_t ctx;
+
+	if (!value)
+		return config_error_nonbool(var);
+
+	buf = xstrdup(value);
+	if ((argc = split_cmdline(buf, &argv)) < 0) {
+		free(buf);
+		return error("Malformed value for %s", var);
+	}
+	argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
+	memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
+	argc++;
+
+	parse_options_start(&ctx, argc, argv, flags);
+	switch (parse_options_step(&ctx, options, NULL)) {
+	case PARSE_OPT_DONE:
+		ret = parse_options_end(&ctx);
+		break;
+	case PARSE_OPT_HELP: /* not supported in a config */
+	default: /* PARSE_OPT_UNKNOWN */
+		if (ctx.argv[0][1] == '-') {
+			ret = error("unknown option `%s'", ctx.argv[0] + 2);
+		} else {
+			ret = error("unknown switch `%c'", *ctx.opt);
+		}
+		break;
+	}
+	free(buf);
+	return ret;
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
diff --git a/parse-options.c b/parse-options.c
index 4c5d09d..7996b50 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -356,6 +356,8 @@ int parse_options(int argc, const char **argv, const struct option *options,
 int usage_with_options_internal(const char * const *usagestr,
 				const struct option *opts, int full)
 {
+	if (!usagestr)
+		return PARSE_OPT_HELP;
 	fprintf(stderr, "usage: %s\n", *usagestr++);
 	while (*usagestr && **usagestr)
 		fprintf(stderr, "   or: %s\n", *usagestr++);
-- 
1.6.2.rc2.332.g5d21b

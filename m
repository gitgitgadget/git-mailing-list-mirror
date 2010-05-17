From: Giuseppe Scrivano <gscrivano@gnu.org>
Subject: [RFC][PATCH] Print the usage string on stdout instead of stderr.
Date: Mon, 17 May 2010 11:48:38 +0200
Message-ID: <878w7ieu4p.fsf@thor.thematica.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 17 11:48:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODwvY-0004V4-T3
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 11:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774Ab0EQJry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 05:47:54 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:44639 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab0EQJrx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 05:47:53 -0400
Received: by wwi17 with SMTP id 17so365075wwi.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject
         :user-agent:date:message-id:mime-version:content-type;
        bh=jk3BjHaVEIH9SBOYQBT3xd3r/bcthbqnksUbg0DudSc=;
        b=kEFAKjBUk9SXHgmSVt9FHoPxA0SnQohvyzxZGa/jH/6sIVCOobuu96Nh8XRzAXMeuU
         st/Q+4Hh/366pmKwTLH//0FDQnPfS5V1A/YgsXSNJ72LTq/rG2gRf7lwX+sFURcCvsKd
         Dzt7ffZm2sz9DSV84KrfTMysH8NRQrwLJg3Ic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:user-agent:date:message-id:mime-version
         :content-type;
        b=vgei/dZWQkUvbkwK5Np3KU39Y9k8N9RRX2d6Yo9CA0hrQx/aba0XPlQKBeOVRMmNir
         jCjjpKwg1M4Nl/oe1KGKJjl9aN18uWEjbZJgeIhbBYOnyvDk9CwUWhXQXwHbI3NfJTzG
         01kPP3byEzgmS+fRqKFToZ3ByG1gFmI0UhWKs=
Received: by 10.216.188.201 with SMTP id a51mr2892979wen.224.1274089668447;
        Mon, 17 May 2010 02:47:48 -0700 (PDT)
Received: from thor.thematica.it (host41-158-static.104-82-b.business.telecomitalia.it [82.104.158.41])
        by mx.google.com with ESMTPS id v59sm1582529wec.3.2010.05.17.02.47.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 May 2010 02:47:47 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147220>

--=-=-=

Hello,

I have noticed that the -h flag uses stderr to print the usage string,
is there any reason for it?

The small patch I have attached changes -h to print on stdout.

Thanks,
Giuseppe


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-Print-the-usage-string-on-stdout-instead-of-stderr.patch

>From 4a5c4e4470dae11e22ff233b34a10b6a912fcd3e Mon Sep 17 00:00:00 2001
From: Giuseppe Scrivano <gscrivano@gnu.org>
Date: Mon, 17 May 2010 11:31:09 +0200
Subject: [PATCH] Print the usage string on stdout instead of stderr.

Signed-off-by: Giuseppe Scrivano <gscrivano@gnu.org>
---
 parse-options.c |   36 +++++++++++++++++-------------------
 1 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 8546d85..9adaf44 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -479,7 +479,7 @@ static int usage_argh(const struct option *opts)
 			s = literal ? "[%s]" : "[<%s>]";
 	else
 		s = literal ? " %s" : " <%s>";
-	return fprintf(stderr, s, opts->argh ? opts->argh : "...");
+	return printf(s, opts->argh ? opts->argh : "...");
 }
 
 #define USAGE_OPTS_WIDTH 24
@@ -491,47 +491,45 @@ static int usage_with_options_internal(const char * const *usagestr,
 	if (!usagestr)
 		return PARSE_OPT_HELP;
 
-	fprintf(stderr, "usage: %s\n", *usagestr++);
+	printf("usage: %s\n", *usagestr++);
 	while (*usagestr && **usagestr)
-		fprintf(stderr, "   or: %s\n", *usagestr++);
+		printf("   or: %s\n", *usagestr++);
 	while (*usagestr) {
-		fprintf(stderr, "%s%s\n",
-				**usagestr ? "    " : "",
-				*usagestr);
+		printf("%s%s\n",**usagestr ? "    " : "", *usagestr);
 		usagestr++;
 	}
 
 	if (opts->type != OPTION_GROUP)
-		fputc('\n', stderr);
+		fputc('\n', stdout);
 
 	for (; opts->type != OPTION_END; opts++) {
 		size_t pos;
 		int pad;
 
 		if (opts->type == OPTION_GROUP) {
-			fputc('\n', stderr);
+			fputc('\n', stdout);
 			if (*opts->help)
-				fprintf(stderr, "%s\n", opts->help);
+				printf("%s\n", opts->help);
 			continue;
 		}
 		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
 			continue;
 
-		pos = fprintf(stderr, "    ");
+		pos = printf("    ");
 		if (opts->short_name && !(opts->flags & PARSE_OPT_NEGHELP)) {
 			if (opts->flags & PARSE_OPT_NODASH)
-				pos += fprintf(stderr, "%c", opts->short_name);
+				pos += printf("%c", opts->short_name);
 			else
-				pos += fprintf(stderr, "-%c", opts->short_name);
+				pos += printf("-%c", opts->short_name);
 		}
 		if (opts->long_name && opts->short_name)
-			pos += fprintf(stderr, ", ");
+			pos += printf(", ");
 		if (opts->long_name)
-			pos += fprintf(stderr, "--%s%s",
+			pos += printf("--%s%s",
 				(opts->flags & PARSE_OPT_NEGHELP) ?  "no-" : "",
 				opts->long_name);
 		if (opts->type == OPTION_NUMBER)
-			pos += fprintf(stderr, "-NUM");
+			pos += printf("-NUM");
 
 		if (!(opts->flags & PARSE_OPT_NOARG))
 			pos += usage_argh(opts);
@@ -539,12 +537,12 @@ static int usage_with_options_internal(const char * const *usagestr,
 		if (pos <= USAGE_OPTS_WIDTH)
 			pad = USAGE_OPTS_WIDTH - pos;
 		else {
-			fputc('\n', stderr);
+			fputc('\n', stdout);
 			pad = USAGE_OPTS_WIDTH;
 		}
-		fprintf(stderr, "%*s%s\n", pad + USAGE_GAP, "", opts->help);
+		printf("%*s%s\n", pad + USAGE_GAP, "", opts->help);
 	}
-	fputc('\n', stderr);
+	fputc('\n', stdout);
 
 	return PARSE_OPT_HELP;
 }
@@ -560,7 +558,7 @@ void usage_msg_opt(const char *msg,
 		   const char * const *usagestr,
 		   const struct option *options)
 {
-	fprintf(stderr, "%s\n\n", msg);
+	printf("%s\n\n", msg);
 	usage_with_options(usagestr, options);
 }
 
-- 
1.7.1


--=-=-=--

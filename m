From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 1/2] parse-options: make OPT_INTEGER's argh explicit
Date: Thu,  4 Jun 2009 16:43:56 -0700
Message-ID: <1244159037-9292-1-git-send-email-bebarino@gmail.com>
References: <4A26DBA3.90604@lsrfire.ath.cx>
Cc: =?utf-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 01:44:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCMbS-0000dy-U3
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 01:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbZFDXoC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 19:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbZFDXoB
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 19:44:01 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:2495 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbZFDXoA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 19:44:00 -0400
Received: by rv-out-0506.google.com with SMTP id k40so525129rvb.39
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 16:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=6yop+yayymxE5GRgl5V0SCRrrSx2lB68dwVN7V2w8kw=;
        b=iHpL+5cRzY+CtlOqhIBo/zhsRhhoT+StdfoMmvQzN/gNL7L4fqzHIrtbbmXuZ5HwAh
         7oZgjzmEL1RetnxeyMJN5VZdF2kXAJaDijKL6HkTVyNAVrud0iE42CVzKL30B2SnhD+a
         Bc4ZV9WyK/1XZFD8VNFjdP0vBugEY0TJOBaGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NVh5/WA1EKyegwTtXBdQHew2IE6A6sFDQ0nF+Zt0whQ57uQoHckztaUzV35jR5tfjR
         xVDgSu4Ai8y+rXzyOOzxE3Oa2UxS8UwucF+8lrgJqP+zuCH9Ky3fMOgumtXk3PwFWPGn
         TWd9TB04rvQ+FoYMLMzBXASlIR3bqgivdccZY=
Received: by 10.141.146.15 with SMTP id y15mr2570161rvn.23.1244159042224;
        Thu, 04 Jun 2009 16:44:02 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id k37sm9441885rvb.48.2009.06.04.16.43.59
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 16:44:01 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 04 Jun 2009 16:43:57 -0700
X-Mailer: git-send-email 1.6.3.1.266.gb11cf
In-Reply-To: <4A26DBA3.90604@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120727>

OPTION_INTEGER hardcodes its argh member to be "n", but the decision is
hidden deep in usage_with_options_internal(). Make "n" the default argh
for the OPT_INTEGER macro while leaving it undecided for the OPTION_INTEGER
enum.

This make it less suprising to users that argh is "n" when using the
OPT_INTEGER macro.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-tag.c   |    4 ++--
 parse-options.c |   11 ++---------
 parse-options.h |    2 +-
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index dc3db62..080e04a 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -376,8 +376,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct commit_list *with_commit = NULL;
 	struct option options[] = {
 		OPT_BOOLEAN('l', NULL, &list, "list tag names"),
-		{ OPTION_INTEGER, 'n', NULL, &lines, NULL,
-				"print n lines of each tag message",
+		{ OPTION_INTEGER, 'n', NULL, &lines, "n",
+				"print <n> lines of each tag message",
 				PARSE_OPT_OPTARG, NULL, 1 },
 		OPT_BOOLEAN('d', NULL, &delete, "delete tags"),
 		OPT_BOOLEAN('v', NULL, &verify, "verify tags"),
diff --git a/parse-options.c b/parse-options.c
index b85cab2..48ba62b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -503,19 +503,12 @@ int usage_with_options_internal(const char * const *usagestr,
 		switch (opts->type) {
 		case OPTION_ARGUMENT:
 			break;
-		case OPTION_INTEGER:
-			if (opts->flags & PARSE_OPT_OPTARG)
-				if (opts->long_name)
-					pos += fprintf(stderr, "[=<n>]");
-				else
-					pos += fprintf(stderr, "[<n>]");
-			else
-				pos += fprintf(stderr, " <n>");
-			break;
 		case OPTION_CALLBACK:
 			if (opts->flags & PARSE_OPT_NOARG)
 				break;
 			/* FALLTHROUGH */
+		case OPTION_INTEGER:
+			/* FALLTHROUGH */
 		case OPTION_FILENAME:
 			/* FALLTHROUGH */
 		case OPTION_STRING:
diff --git a/parse-options.h b/parse-options.h
index b374ade..b141ae6 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -108,7 +108,7 @@ struct option {
 #define OPT_BOOLEAN(s, l, v, h)     { OPTION_BOOLEAN, (s), (l), (v), NULL, (h) }
 #define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, (h), 0, NULL, (i) }
 #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), NULL, (h), 0, NULL, (p) }
-#define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), NULL, (h) }
+#define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), "n", (h) }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
 #define OPT_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), "time",(h), 0, \
-- 
1.6.3.1.266.gb11cf

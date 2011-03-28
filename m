From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH/RFC 8/9] add long forms %(authordate) and %(committerdate)
Date: Tue, 29 Mar 2011 00:17:30 +0100
Message-ID: <1301354251-23380-9-git-send-email-wmpalmer@gmail.com>
References: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 01:18:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Lhg-00010L-1d
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 01:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181Ab1C1XSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 19:18:22 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35885 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755538Ab1C1XSF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 19:18:05 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so4410093wwa.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 16:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=5DWr41Iw4IB3gyOYL/M25treWE4z8tg9KjvNKZeeUWw=;
        b=mdx3FLzZBqvFHx2tN507wvTj0O6HOa3O0U1r0J7oGQZalmXejgRB38h+rBUnUMwfOW
         CER7EiaYeRtAXSfChnJMQS0dP0CGgjnXklPjzrEKGIp+boFGfctVCo9LFOsyWZd2jIRy
         lGWKZW3JzS0YSXEFaQbSSzRNgG+Sd/yYfOiZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RKVgPQ8FFnS6wAQb8l6Lsh8Lc1kh9nXURuEobfwneQ1/CPPAf140br0l5LA0+Nhl2T
         q3ox07WXmminjClzxblCMrwXTAV3MvzQhwFYe0O/2FsSVG628MtfHkY1X1DJ0P2NClYS
         ERQRUbuyJth09a917OJVa4fRktlzqUElRzFs8=
Received: by 10.216.9.159 with SMTP id 31mr3505553wet.0.1301354284901;
        Mon, 28 Mar 2011 16:18:04 -0700 (PDT)
Received: from localhost.localdomain (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id b54sm1678272wer.45.2011.03.28.16.18.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 16:18:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170207>

this adds the long forms %(authordate) and %(committerdate) to
complement the existing placeholders %ad, %aD, %ar, %at, %ai, %cd, %cC,
%cr, %ct, and %ci. The specific format is specified as with --date, eg:
	%(committerdate:rfc2822)

This change exists mostly to give a place for new date formatting
options to go, though it also has the benefit of matching the format of
the date placeholders in git for-each-ref.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 Documentation/pretty-formats.txt |    4 ++
 cache.h                          |    2 +
 date.c                           |   58 +++++++++++++++++++++++++------------
 pretty.c                         |   51 +++++++++++++++++++++++++++++----
 test-pretty.c                    |   10 ++++++
 5 files changed, 100 insertions(+), 25 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index d987102..dfb81a7 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -114,6 +114,8 @@ The placeholders are:
 - '%ar': author date, relative
 - '%at': author date, UNIX timestamp
 - '%ai': author date, ISO 8601 format
+- '%(authordate[:<format>])': author date. Without a <format>, the --date= option is respected.
+  Otherwise, a format of the type which can be specified via the --date= option is taken.
 - '%cn': committer name
 - '%cN': committer name (respecting .mailmap, see linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%ce': committer email
@@ -123,6 +125,8 @@ The placeholders are:
 - '%cr': committer date, relative
 - '%ct': committer date, UNIX timestamp
 - '%ci': committer date, ISO 8601 format
+- '%(committerdate[:<format>])': committer date. Without a <format>, the --date= option is respected.
+  Otherwise, a format of the type which can be specified via the --date= option is taken.
 - '%d': ref names, like the --decorate option of linkgit:git-log[1]
 - '%e': encoding
 - '%s': subject
diff --git a/cache.h b/cache.h
index fa564fa..b769cf8 100644
--- a/cache.h
+++ b/cache.h
@@ -829,6 +829,8 @@ void datestamp(char *buf, int bufsize);
 #define approxidate(s) approxidate_careful((s), NULL)
 unsigned long approxidate_careful(const char *, int *);
 unsigned long approxidate_relative(const char *date, const struct timeval *now);
+#define DATE_FORMAT_MAX 9 /* strlen("relative") + 1 */
+size_t parse_date_format_len(const char *format, enum date_mode *dmode);
 enum date_mode parse_date_format(const char *format);
 
 #define IDENT_WARN_ON_NO_NAME  1
diff --git a/date.c b/date.c
index ce48220..1834ab6 100644
--- a/date.c
+++ b/date.c
@@ -659,28 +659,48 @@ int parse_date(const char *date, char *result, int maxlen)
 	return date_string(timestamp, offset, result, maxlen);
 }
 
+size_t parse_date_format_len(const char *format, enum date_mode *dmode)
+{
+	if (!strcmp(format, "relative")) {
+		*dmode = DATE_RELATIVE;
+		return 8;
+	} else if (!strcmp(format, "iso8601")) {
+		*dmode = DATE_ISO8601;
+		return 7;
+	} else if (!strcmp(format, "iso")) {
+		*dmode = DATE_ISO8601;
+		return 3;
+	} else if (!strcmp(format, "rfc2822")) {
+		*dmode = DATE_RFC2822;
+		return 7;
+	} else if (!strcmp(format, "rfc")) {
+		*dmode = DATE_RFC2822;
+		return 3;
+	} else if (!strcmp(format, "short")) {
+		*dmode = DATE_SHORT;
+		return 5;
+	} else if (!strcmp(format, "local")) {
+		*dmode = DATE_LOCAL;
+		return 5;
+	} else if (!strcmp(format, "default")) {
+		*dmode = DATE_NORMAL;
+		return 7;
+	} else if (!strcmp(format, "raw")) {
+		*dmode = DATE_RAW;
+		return 3;
+	} else if (!strcmp(format, "unix")) {
+		*dmode = DATE_UNIX;
+		return 4;
+	} else
+		return 0;
+}
+
 enum date_mode parse_date_format(const char *format)
 {
-	if (!strcmp(format, "relative"))
-		return DATE_RELATIVE;
-	else if (!strcmp(format, "iso8601") ||
-		 !strcmp(format, "iso"))
-		return DATE_ISO8601;
-	else if (!strcmp(format, "rfc2822") ||
-		 !strcmp(format, "rfc"))
-		return DATE_RFC2822;
-	else if (!strcmp(format, "short"))
-		return DATE_SHORT;
-	else if (!strcmp(format, "local"))
-		return DATE_LOCAL;
-	else if (!strcmp(format, "default"))
-		return DATE_NORMAL;
-	else if (!strcmp(format, "raw"))
-		return DATE_RAW;
-	else if (!strcmp(format, "unix"))
-		return DATE_UNIX;
-	else
+	enum date_mode dmode;
+	if (!parse_date_format_len(format, &dmode))
 		die("unknown date format %s", format);
+	return dmode;
 }
 
 void datestamp(char *buf, int bufsize)
diff --git a/pretty.c b/pretty.c
index 616b857..006bbe3 100644
--- a/pretty.c
+++ b/pretty.c
@@ -102,19 +102,38 @@ const char *parse_arg(struct format_part *part, enum format_arg_type type,
 	struct format_arg arg = {0};
 	const char *c = unparsed;
 	char *t;
+	size_t len;
+	char date_format[DATE_FORMAT_MAX];
 
-	if (type != FORMAT_ARG_UINT)
-		return NULL;
 	arg.type = type;
 
 	c += strspn(c, WHITESPACE);
-	if (isdigit(*c)) {
-		arg.uint = strtoul(c, &t, 10);
-		c = t + strspn(t, WHITESPACE);
+
+	switch (type){
+	case FORMAT_ARG_UINT:
+		if (isdigit(*c)) {
+			arg.uint = strtoul(c, &t, 10);
+			c = t;
+		}
+		break;
+	case FORMAT_ARG_DATE_MODE:
+		len = strcspn(c, WHITESPACE ",)");
+		if (len >= DATE_FORMAT_MAX)
+			return NULL;
+		strncpy(date_format, c, len);
+		len = parse_date_format_len(date_format, &arg.dmode);
+		if (!len)
+			return NULL;
+		c += len;
+		break;
+	default:
+		return NULL;
 	}
+
+	c += strspn(c, WHITESPACE);
 	if (*c == ',' || *c == ')'){
 		ALLOC_GROW(part->args, part->argc+1, part->args_alloc);
-		memcpy(&(part->args[part->argc]), &arg,
+		memcpy(&part->args[part->argc], &arg,
 		       sizeof(struct format_arg));
 		part->argc++;
 		return c;
@@ -130,6 +149,26 @@ static struct format_part *parse_extended(const char *unparsed)
 
 	c += strspn(c, WHITESPACE);
 
+	if (!prefixcmp(c, "author") || !prefixcmp(c, "committer")) {
+		e = c;
+		c += (*e == 'a') ? 6 : 9;
+		if (!prefixcmp(c, "date")) {
+			part->type = (*e == 'a') ? FORMAT_PART_AUTHOR_DATE :
+						   FORMAT_PART_COMMITTER_DATE;
+			c += 4 + strspn(c + 4, WHITESPACE);
+			if (*c == ')')
+				goto success;
+			if (*c != ':')
+				goto fail;
+			c = parse_arg(part, FORMAT_ARG_DATE_MODE, c+1);
+			if (!c)
+				goto fail;
+			goto success;
+		}
+
+		c = e;
+	}
+
 	if (!prefixcmp(c, "color")) {
 		part->type = FORMAT_PART_LITERAL;
 		c += 5 + strspn(c + 5, WHITESPACE);
diff --git a/test-pretty.c b/test-pretty.c
index eb88e3a..6a92c65 100644
--- a/test-pretty.c
+++ b/test-pretty.c
@@ -19,6 +19,16 @@ static const char *all = "a"
 "%m%w()%w(1)%w(1,2)%w(1,2,3)"
 "%(wrap)%(wrap:1)%(wrap:1,2)%(wrap:1,2,3)"
 "%(color)%(color:red)%(color:red bold)%(color:red green bold)"
+"%(authordate)%(authordate:default)%(authordate:relative)"
+"%(authordate:short)%(authordate:local)"
+"%(authordate:iso8601)%(authordate:iso)"
+"%(authordate:rfc2822)%(authordate:rfc)"
+"%(authordate:unix)%(authordate:raw)"
+"%(committerdate)%(committerdate:default)%(committerdate:relative)"
+"%(committerdate:short)%(committerdate:local)"
+"%(committerdate:iso8601)%(committerdate:iso)"
+"%(committerdate:rfc2822)%(committerdate:rfc)"
+"%(committerdate:unix)%(committerdate:raw)"
 "%x0a%n%%%@";
 
 static struct strbuf *parts_debug(struct format_parts *parts,
-- 
1.7.4.2

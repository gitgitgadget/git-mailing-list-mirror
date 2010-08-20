From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 2/4] fmt-merge-msg: Update command line options to sync with config options
Date: Fri, 20 Aug 2010 22:24:50 +0530
Message-ID: <1282323292-11412-3-git-send-email-artagnon@gmail.com>
References: <1282323292-11412-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 18:57:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmUuN-0004cf-Is
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 18:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab0HTQ5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 12:57:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49051 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab0HTQ5N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 12:57:13 -0400
Received: by iwn5 with SMTP id 5so999518iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nspt+EiHeb/09N6k7XCY3Dv60+h/v84DGJsiYyqD4SE=;
        b=YgEPwctnRPmBIhKdQ4ziArov1zPgNf7fSxoa9aGUGstievhQF/jaXuC7UsSxCUmSU1
         LDcyihTsbXnboDaVjXn8w1pogQq9vHAmCI2VcgXo2NTvKAY44SAPZFj58j+8lWGQWU8s
         TLBjtC5NLFNXyaLOfAE018eazpbXOVS1pZugM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WsaN5iLfPJdrDVg1ZLnKIqTe4MqCOkxXN2x8BBgKU/6OIlvk8t2h/QXhCBQGUSpS5n
         yG50WdxWv4Ef2MO4xa4kMLbWfWFOYMyHh4C1y9yhnA9ewx+uREXdnYd7o6hx9t4KmBZQ
         h15NZ1eEtiXQ+K71Vqt3CXLq2FVvOk4TS5B5M=
Received: by 10.231.191.6 with SMTP id dk6mr1988402ibb.51.1282323432907;
        Fri, 20 Aug 2010 09:57:12 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id e8sm2761091ibb.20.2010.08.20.09.57.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 09:57:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.408.g7357
In-Reply-To: <1282323292-11412-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154055>

Update the `--log` and `--summary` command line options to be integers
and have the same effect as the `merge.log` and `merge.summary`
configuration options.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/fmt-merge-msg.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index e967a05..b10658b 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -11,7 +11,6 @@ static const char * const fmt_merge_msg_usage[] = {
 	NULL
 };
 
-static int merge_summary;
 static int log_limit = 0;
 
 static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
@@ -27,7 +26,6 @@ static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 
 	if (is_bool && log_limit)
 		log_limit = 20;
-	merge_summary = log_limit ? 1 : 0;
 
 	return 0;
 }
@@ -262,7 +260,7 @@ static void do_fmt_merge_msg_title(struct strbuf *out,
 		strbuf_addf(out, " into %s\n", current_branch);
 }
 
-static int do_fmt_merge_msg(int merge_title, int merge_summary,
+static int do_fmt_merge_msg(int merge_title, int log_limit,
 	struct strbuf *in, struct strbuf *out) {
 	int i = 0, pos = 0;
 	unsigned char head_sha1[20];
@@ -295,7 +293,7 @@ static int do_fmt_merge_msg(int merge_title, int merge_summary,
 	if (merge_title)
 		do_fmt_merge_msg_title(out, current_branch);
 
-	if (merge_summary) {
+	if (log_limit) {
 		struct commit *head;
 		struct rev_info rev;
 
@@ -315,8 +313,8 @@ static int do_fmt_merge_msg(int merge_title, int merge_summary,
 	return 0;
 }
 
-int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
-	return do_fmt_merge_msg(1, merge_summary, in, out);
+int fmt_merge_msg(int log_limit, struct strbuf *in, struct strbuf *out) {
+	return do_fmt_merge_msg(1, log_limit, in, out);
 }
 
 int fmt_merge_msg_shortlog(struct strbuf *in, struct strbuf *out) {
@@ -328,10 +326,12 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	const char *inpath = NULL;
 	const char *message = NULL;
 	struct option options[] = {
-		OPT_BOOLEAN(0, "log",     &merge_summary, "populate log with the shortlog"),
-		{ OPTION_BOOLEAN, 0, "summary", &merge_summary, NULL,
+		{ OPTION_INTEGER, 0, "log", &log_limit, "n",
+		  "populate log with <n> entries from shortlog",
+		  PARSE_OPT_NOARG, NULL, 20 },
+		{ OPTION_INTEGER, 0, "summary", &log_limit, "n",
 		  "alias for --log (deprecated)",
-		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 20 },
 		OPT_STRING('m', "message", &message, "text",
 			"use <text> as start of message"),
 		OPT_FILENAME('F', "file", &inpath, "file to read from"),
@@ -347,7 +347,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 			     0);
 	if (argc > 0)
 		usage_with_options(fmt_merge_msg_usage, options);
-	if (message && !merge_summary) {
+	if (message && !log_limit) {
 		char nl = '\n';
 		write_in_full(STDOUT_FILENO, message, strlen(message));
 		write_in_full(STDOUT_FILENO, &nl, 1);
@@ -366,7 +366,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		strbuf_addstr(&output, message);
 		ret = fmt_merge_msg_shortlog(&input, &output);
 	} else {
-		ret = fmt_merge_msg(merge_summary, &input, &output);
+		ret = fmt_merge_msg(log_limit, &input, &output);
 	}
 	if (ret)
 		return ret;
-- 
1.7.2.2.408.g7357

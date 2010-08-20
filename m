From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 3/5] fmt-merge-msg: Update command line options to sync with config options
Date: Sat, 21 Aug 2010 00:45:00 +0530
Message-ID: <1282331702-5115-4-git-send-email-artagnon@gmail.com>
References: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 21:17:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmX6F-000787-Al
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 21:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab0HTTRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 15:17:34 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:64833 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab0HTTRc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 15:17:32 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1329950pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 12:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BYOVmSkg5UedxlQiWAi30t8mwUovnhaJExBLWOFA22s=;
        b=lSsVhhA5p4TcjPKAnofWkByfOu2bhD5xjTk7kL4uxS0FNSgFogiwUAsI3Y2nlf8iLh
         kOdgqn+UZQ6NPSn9nQw5zKufbRZB7IgXSPEPSDD48FIPb3jl+/z4hnqtXlgHG3XoKpNp
         l3o/vReF4Wikub6c9+hqw24guo8Bt+Z+xt+qA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BF5u3GHzN8FLB6EGwdpoKwozYURE83e37mYTA9dqaMgZikKCFDe6upJ3Sg+vIeMB0i
         TyeiYF28eMjb3sqYNhXtqLEgkoXWmuxCYoP9dn5ao6tEGAy5Ni729pxjRszVfxubbRnY
         3g82j+Yq8lYF4aNoWxjs2sjew+DV7KdZX4tac=
Received: by 10.143.29.8 with SMTP id g8mr1323493wfj.273.1282331852410;
        Fri, 20 Aug 2010 12:17:32 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id b19sm3610572wff.7.2010.08.20.12.17.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 12:17:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154072>

Update the `--log` and `--summary` command line options to be integers
and have the same effect as the `merge.log` and `merge.summary`
configuration options.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/fmt-merge-msg.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index e967a05..64c52bd 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -7,11 +7,10 @@
 #include "string-list.h"
 
 static const char * const fmt_merge_msg_usage[] = {
-	"git fmt-merge-msg [-m <message>] [--log|--no-log] [--file <file>]",
+	"git fmt-merge-msg [-m <message>] [--log=[<n>]|--no-log] [--file <file>]",
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
1.7.2.2.409.gdbb11.dirty

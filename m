From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/4] fmt-merge-msg: Update command line options to sync with config options
Date: Fri, 20 Aug 2010 17:53:59 +0530
Message-ID: <1282307041-19681-3-git-send-email-artagnon@gmail.com>
References: <1282307041-19681-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 14:26:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmQg6-0001lu-N0
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 14:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab0HTM0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 08:26:12 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50662 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab0HTM0G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 08:26:06 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so1199710pzk.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hgIHUMWVzxEUpg7sEKVS5f15fwk1qT30yrJ81CCdTuE=;
        b=ZwTj0CJi2mKSArCjVwyoXG2+sSCnhga0bbS3XVaBKeerwDsmf/5CYkxd/PUPA/zAUx
         MVa11NTBquae8lrwp5itnyoHnomkhFifWqs7zoAS0lIXxOSo1xbSxka1sAjC5zil8w3S
         Z0dKDcjro6GF5zqM/IsOQrIDtF+tz+LZxd8jo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TGpRuCxDfv/k8O/qpJ+Hr5S0n8K3zEfU8W+dsQGAO6lq+4Jh1EDsfO2l+XBFJJ7u2D
         hjXjjSK/lhZcjy+JYH7xzToRpvRmaiHle1jDmSOkJTDByFIHWSAv/S5oFCqnnP5ByHhR
         G+o91nA25YUIaoLg+919eH6JB75YKcRXe0Kdo=
Received: by 10.114.112.15 with SMTP id k15mr1393276wac.183.1282307166079;
        Fri, 20 Aug 2010 05:26:06 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d35sm4770439waa.21.2010.08.20.05.26.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 05:26:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1282307041-19681-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154020>

Update the `--log` and `--summary` command line options to be integers
and have the same effect as the `merge.log` and `merge.summary`
configuration options.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/fmt-merge-msg.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 66b1cbd..67f24f8 100644
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
@@ -328,8 +326,9 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	const char *inpath = NULL;
 	const char *message = NULL;
 	struct option options[] = {
-		OPT_BOOLEAN(0, "log",     &merge_summary, "populate log with the shortlog"),
-		{ OPTION_BOOLEAN, 0, "summary", &merge_summary, NULL,
+		OPT_INTEGER(0, "log", &log_limit,
+			    "populate log with <n> entries from shortlog"),
+		{ OPTION_BOOLEAN, 0, "summary", &log_limit, NULL,
 		  "alias for --log (deprecated)",
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
 		OPT_STRING('m', "message", &message, "text",
@@ -347,7 +346,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 			     0);
 	if (argc > 0)
 		usage_with_options(fmt_merge_msg_usage, options);
-	if (message && !merge_summary) {
+	if (message && !log_limit) {
 		char nl = '\n';
 		write_in_full(STDOUT_FILENO, message, strlen(message));
 		write_in_full(STDOUT_FILENO, &nl, 1);
@@ -366,7 +365,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		strbuf_addstr(&output, message);
 		ret = fmt_merge_msg_shortlog(&input, &output);
 	} else {
-		ret = fmt_merge_msg(merge_summary, &input, &output);
+		ret = fmt_merge_msg(log_limit, &input, &output);
 	}
 	if (ret)
 		return ret;
-- 
1.7.1

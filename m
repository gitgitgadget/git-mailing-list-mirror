From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 4/5] fmt-merge-msg: Remove deprecated --summary option
Date: Sat, 21 Aug 2010 15:28:18 +0530
Message-ID: <1282384699-16477-5-git-send-email-artagnon@gmail.com>
References: <1282384699-16477-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 12:00:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omksd-0004zP-D3
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 12:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822Ab0HUKAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 06:00:38 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39425 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab0HUKAh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 06:00:37 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so1588171pzk.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 03:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2R9m3AMy2UvZEN7qLRxz7UjTcjc6yXLlaGL6sNRvtXg=;
        b=cEWH/UbCyIpdMy+M0MHq6SDEpGqEiGsyQAdf4cP89YlO/juue4KLPgT9GSnTtqzLFY
         T25SCIRhaUfLSNLzy0RuHXFjtXUYga4nM8bfZgdiYuTGHho/QApCHo7gEuApLDZJpiEU
         7wddY/sY6B7mVlZHCSwjRf3vRmtzCc7OXr97w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gqgyC+cE670aWX1kHbe00J77ne8wYac3CH7Ml8d4YaVCtXOImIoIgqzuXYSfkE3lX2
         CBnySZ2IsyAEe5cOnjLZpr1Voq4sFkpuUieReMwA53v0LpYKKO3tsxonB+RJBEuOacyP
         CMroeRgQU1A+VxwEJ94JKY3cFAjBCVp0oRECM=
Received: by 10.142.185.7 with SMTP id i7mr2124206wff.68.1282384836830;
        Sat, 21 Aug 2010 03:00:36 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id b19sm4641270wff.7.2010.08.21.03.00.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 03:00:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282384699-16477-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154133>

Remove the deprecated --summary option that served as a syonym to the
--log option.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-fmt-merge-msg.txt |    9 ---------
 builtin/fmt-merge-msg.c             |   13 ++-----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 9499322..5a5c318 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -33,11 +33,6 @@ OPTIONS
 	Do not list one-line descriptions from the actual commits being
 	merged.
 
---summary::
---no-summary::
-	Synonyms to --log and --no-log; these are deprecated and will be
-	removed in the future.
-
 -m <message>::
 --message <message>::
 	Use <message> instead of the branch names for the first line
@@ -58,10 +53,6 @@ merge.log::
 	maxmium) in the merge message. Specifying "true" is equivalent
 	to specifying 20. Defaults to false.
 
-merge.summary::
-	Synonym to `merge.log`; this is deprecated and will be removed in
-	the future.
-
 SEE ALSO
 --------
 linkgit:git-merge[1]
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index cad9ed4..1e969f2 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -15,18 +15,12 @@ static int log_limit = 0;
 
 static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
-	static int found_merge_log = 0;
 	int is_bool;
 	if (!strcmp("merge.log", key)) {
-		found_merge_log = 1;
 		log_limit = git_config_bool_or_int(key, value, &is_bool);
+		if (is_bool && log_limit)
+			log_limit = 20;
 	}
-	if (!found_merge_log && !strcmp("merge.summary", key))
-		log_limit = git_config_bool_or_int(key, value, &is_bool);
-
-	if (is_bool && log_limit)
-		log_limit = 20;
-
 	return 0;
 }
 
@@ -329,9 +323,6 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		{ OPTION_INTEGER, 0, "log", &log_limit, "n",
 		  "populate log with <n> entries from shortlog",
 		  PARSE_OPT_OPTARG, NULL, 20 },
-		{ OPTION_INTEGER, 0, "summary", &log_limit, "n",
-		  "alias for --log (deprecated)",
-		  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, NULL, 20 },
 		OPT_STRING('m', "message", &message, "text",
 			"use <text> as start of message"),
 		OPT_FILENAME('F', "file", &inpath, "file to read from"),
-- 
1.7.2.2.409.gdbb11.dirty

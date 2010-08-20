From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 4/5] fmt-merge-msg: Remove deprecated --summary option
Date: Sat, 21 Aug 2010 00:45:01 +0530
Message-ID: <1282331702-5115-5-git-send-email-artagnon@gmail.com>
References: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 21:18:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmX6F-000787-Rc
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 21:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567Ab0HTTRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 15:17:38 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:64833 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab0HTTRh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 15:17:37 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1329950pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 12:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Mb4raXB4x/sFI+59xKjAFtJ8fWIV0Wk6vcM4yot9Pxc=;
        b=fXS9h+tshsy86HJzBADKsV3q67L1uu34+6OsJWT7G60ma+K71ULSO7APPGt97c4y+c
         h4l9U670qO09tL6i4/OTmnf/+5z9+Dsiy24ZsnO22xmQwLqK8a/6j8lEhl34q3iWXDNp
         1kIjbiRIgjR/niVsdvg4HDToeIUC8yYNvDrUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FjSYlHc6+kiGqdNXF5WjgBff3k1kdFgkITCNyP+T5SjwnbClhebg0GD2/tU7GBKl1T
         odfF6WvHwLhCHk/G0Ah5DrYxYuy8I88Ysus3+tnwRdxenDQ36a0+rujS64+pW5qq1u8E
         YJhY2MJrw4GPYhCxVWK4UtAueJmajAjGbfQMM=
Received: by 10.142.147.8 with SMTP id u8mr1453521wfd.129.1282331857048;
        Fri, 20 Aug 2010 12:17:37 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id b19sm3610572wff.7.2010.08.20.12.17.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 12:17:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154073>

Remove the deprecated --summary option that served as a syonym to the
--log option.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-fmt-merge-msg.txt |    4 ----
 builtin/fmt-merge-msg.c             |   13 ++-----------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 302f56b..78c8a6d 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -55,10 +55,6 @@ merge.log::
 	Whether to include summaries of merged commits in newly
 	merge commit messages. False by default.
 
-merge.summary::
-	Synonym to `merge.log`; this is deprecated and will be removed in
-	the future.
-
 SEE ALSO
 --------
 linkgit:git-merge[1]
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 64c52bd..adab21e 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -15,18 +15,12 @@ static int log_limit = 0;
 
 static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
-	static int found_merge_log = 0;
 	int is_bool = 0;
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
 		  PARSE_OPT_NOARG, NULL, 20 },
-		{ OPTION_INTEGER, 0, "summary", &log_limit, "n",
-		  "alias for --log (deprecated)",
-		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 20 },
 		OPT_STRING('m', "message", &message, "text",
 			"use <text> as start of message"),
 		OPT_FILENAME('F', "file", &inpath, "file to read from"),
-- 
1.7.2.2.409.gdbb11.dirty

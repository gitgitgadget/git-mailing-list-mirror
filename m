From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 3/4] fmt-merge-msg: Remove deprecated --summary option
Date: Fri, 20 Aug 2010 22:24:51 +0530
Message-ID: <1282323292-11412-4-git-send-email-artagnon@gmail.com>
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
	id 1OmUuO-0004cf-30
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 18:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab0HTQ5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 12:57:18 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53675 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab0HTQ5R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 12:57:17 -0400
Received: by mail-gy0-f174.google.com with SMTP id 8so1331630gyd.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 09:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9KgDynKmmqJe02pTvenuDpBV/eQKMzlXIFZ1ro24BEk=;
        b=G8YzTRfo9qzvximUnRyOMc3ugtvn5Guuoso3jByfMVljx7BzIxwa+fCSSdq5nGen17
         E4uJbq2cne35HpYTMUpAY4X9rJg0s3tJGfjM0mnX+Q1IKIIgJox+8S2QRZMJVltNBmiW
         APwW1ZCvKQLfw6apchp47B9s5941vUt8aJdRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NypXu4O1sqDddsh3s8rLNoOFFsWWvXkTbEjaR/2qvLKxwHEGokxV038SbTQfVZ3R1Y
         NAdakiBiHgpKsAzc4Zy6jnilMDBci8Vd8VyTDvX/N+FcCExkfhrvOryfpKI75fFdfSF3
         M5FoZs3v47T7GJzFZUiKOcErEVPBZluqjs39c=
Received: by 10.150.72.6 with SMTP id u6mr2291266yba.187.1282323436772;
        Fri, 20 Aug 2010 09:57:16 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id e8sm2761091ibb.20.2010.08.20.09.57.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 09:57:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.408.g7357
In-Reply-To: <1282323292-11412-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154054>

Remove the deprecated --summary option that served as a syonym to the
--log option.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>
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
index b10658b..d45a706 100644
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
1.7.2.2.408.g7357

From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/4] fmt-merge-msg: Remove deprecated --summary option
Date: Fri, 20 Aug 2010 17:54:01 +0530
Message-ID: <1282307041-19681-5-git-send-email-artagnon@gmail.com>
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
	id 1OmQg7-0001lu-Ns
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 14:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446Ab0HTM0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 08:26:18 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:50268 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab0HTM0N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 08:26:13 -0400
Received: by pxi10 with SMTP id 10so1180699pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=krkFcOmSm53ZvNkBUfKMnMpVnBl/fIx6pXPp6Nb1d9w=;
        b=M9y5BgDgbIZ3wYtGbixootGfsz8B7PV01sxfsi+KLRzFOQMiKQwU2WEOulctwXBKjT
         8IT7PD3oIzbr2eHg26guLnumO7cJnbBtxXIVYVyuTsFI0yaFy9UOJZgIrK0gF5m9bzYV
         8rwu5ERPzGf4jeVTtrDWsmXfTT9c7rjdUGyIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=i9GLhcNI8Ig13P44wDzcdPx8mBot7/TOumnVgPDUXq8NEYlmdmVQvl8kh4Lay2OSRb
         A802yH4k7GWtNB78CToOHwuVpA4S/SqTzpHN5/z3l6CVwJmExFwqU+jkD6odPar2Mx7F
         TzA8WHOm9mhX51G5XmQ8pRJDa2h9TNbHLHfPc=
Received: by 10.114.39.2 with SMTP id m2mr1462925wam.45.1282307172997;
        Fri, 20 Aug 2010 05:26:12 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d35sm4770439waa.21.2010.08.20.05.26.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 05:26:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1282307041-19681-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154019>

Remove the deprecated --summary option that served as a syonym to the
--log option.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-fmt-merge-msg.txt |    4 ----
 builtin/fmt-merge-msg.c             |   13 ++-----------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index a930eeb..e3be3a3 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -49,10 +49,6 @@ merge.log::
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
index 67f24f8..966647a 100644
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
 
@@ -328,9 +322,6 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_INTEGER(0, "log", &log_limit,
 			    "populate log with <n> entries from shortlog"),
-		{ OPTION_BOOLEAN, 0, "summary", &log_limit, NULL,
-		  "alias for --log (deprecated)",
-		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
 		OPT_STRING('m', "message", &message, "text",
 			"use <text> as start of message"),
 		OPT_FILENAME('F', "file", &inpath, "file to read from"),
-- 
1.7.1

From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] merge: Make 'merge.log' an integer or boolean option
Date: Tue, 31 Aug 2010 09:23:20 +0530
Message-ID: <1283226800-28980-2-git-send-email-artagnon@gmail.com>
References: <1282991734-3368-1-git-send-email-artagnon@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 05:55:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqHww-0007Hi-5Y
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 05:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102Ab0HaDzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 23:55:50 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43639 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086Ab0HaDzt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 23:55:49 -0400
Received: by mail-gy0-f174.google.com with SMTP id 8so2296638gyd.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 20:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=e6PmuGRw6X0hJ4HtC8pqwCjH6b+zjv2OOWdEq9+hfNE=;
        b=S8flFvZPtDz6vX043nACO01LepuTjdYT+EjWtK+Ax10YmDm92z5sr+0Vx6LPTe/AmK
         Dq60jo4NzFOEPlxTemTX8F5sRb7Nzu6KxQOrz2femD9VnL5TyjJaq2fNx1Qche3W7/gA
         F3qSjki1l4yU/eS873a6HCP9KYZpoHRlqRupI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nXHWc+lq+GOpgA2O7y3hRckStdhIK7eGmDd+X/ReP675Q6LyvTDScjxHQcsuhXdJBZ
         lXRDln/t8KJSv9tqyW53vFCHiIvz+k487Ht6wML4gqTsttoGCIVTOefYh/pJY9rMj8bD
         PEqmuc2rPPZiann9vCAeG1nA3GA5icvul4KHI=
Received: by 10.101.75.5 with SMTP id c5mr5757144anl.190.1283226949324;
        Mon, 30 Aug 2010 20:55:49 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id w10sm8825175ank.34.2010.08.30.20.55.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 20:55:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282991734-3368-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154880>

Make 'merge.log' an integer or boolean option to set the number of
shortlog entries to display in the merge commit. Note that it defaults
to false, and that true means a default value of 20. Also update
corresponding documentation.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
Thanks-to: Johannes Sixt <j.sixt@viscovery.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Replacement for afdcbdc.

 Documentation/git-fmt-merge-msg.txt |    6 ++++--
 Documentation/merge-config.txt      |    6 ++++--
 builtin/fmt-merge-msg.c             |   14 +++++---------
 builtin/merge.c                     |    5 ++++-
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index f04a9ff..40dba8c 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -54,8 +54,10 @@ CONFIGURATION
 -------------
 
 merge.log::
-	Whether to include summaries of merged commits in newly
-	merge commit messages. False by default.
+	In addition to branch names, populate the log message with at
+	most the specified number of one-line descriptions from the
+	actual commits that are being merged.  Defaults to false, and
+	true is a synoym for 20.
 
 merge.summary::
 	Synonym to `merge.log`; this is deprecated and will be removed in
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index a403155..acbe1e1 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -7,8 +7,10 @@ merge.conflictstyle::
 	marker and the original text before the `=======` marker.
 
 merge.log::
-	Whether to include summaries of merged commits in newly created
-	merge commit messages. False by default.
+	In addition to branch names, populate the log message with at
+	most the specified number of one-line descriptions from the
+	actual commits that are being merged.  Defaults to false, and
+	true is a synoym for 20.
 
 merge.renameLimit::
 	The number of files to consider when performing rename detection
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 0997c26..975ef6a 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -15,15 +15,11 @@ static int shortlog_len;
 
 static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
-	static int found_merge_log = 0;
-	if (!strcmp("merge.log", key)) {
-		found_merge_log = 1;
-		shortlog_len = git_config_bool(key, value) ? DEFAULT_MERGE_LOG_LEN : 0;
-		return 0;
-	}
-	if (!found_merge_log && !strcmp("merge.summary", key)) {
-		shortlog_len = git_config_bool(key, value) ? DEFAULT_MERGE_LOG_LEN : 0;
-		return 0;
+	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
+		int is_bool;
+		shortlog_len = git_config_bool_or_int(key, value, &is_bool);
+		if (is_bool && shortlog_len || shortlog_len < 0)
+			shortlog_len = DEFAULT_MERGE_LOG_LEN;
 	}
 	return 0;
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index 9e4733d..57ea8d7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -503,7 +503,10 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	else if (!strcmp(k, "pull.octopus"))
 		return git_config_string(&pull_octopus, k, v);
 	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary")) {
-		shortlog_len = git_config_bool(k, v) ? DEFAULT_MERGE_LOG_LEN : 0;
+		int is_bool;
+		shortlog_len = git_config_bool_or_int(k, v, &is_bool);
+		if (is_bool && shortlog_len || shortlog_len < 0)
+			shortlog_len = DEFAULT_MERGE_LOG_LEN;
 		return 0;
 	}
 	return git_diff_ui_config(k, v, cb);
-- 
1.7.2.2.409.gdbb11.dirty

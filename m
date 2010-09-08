From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/5] merge: Make 'merge.log' an integer or boolean option
Date: Wed,  8 Sep 2010 23:29:55 +0530
Message-ID: <1283968797-31793-4-git-send-email-artagnon@gmail.com>
References: <1283968797-31793-1-git-send-email-artagnon@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 20:03:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtOz4-0001BB-6h
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 20:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388Ab0IHSCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 14:02:19 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44818 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab0IHSCR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 14:02:17 -0400
Received: by yxp4 with SMTP id 4so177905yxp.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 11:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=F8StHfrZqO4wEErZIyU/8phhYCazMUOo1gKVsm+cJsk=;
        b=G34/OXlAbONNRqqzclkKt8pkVk1AZ9ZvpJPyOQgAjMwvM+ku4dSXyKRahe5o9aACy5
         0bRER8Lxi/hxO80g44cqRorKXWBHJgLBqEC2wNcXt6y2QC8DW4swUdykEq6scmZBdKpk
         XzXhIdagqbhvLNYVVbSJP5bnZYs8XPU7evHMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PGFkoBKJVzLHZ6Chzft13GF5ZpiK1byQpYO69rz/mszVIVmzm8JxrxK5rG53J+SHVl
         F6PFwX9wIelpt4T6rXqOcy7jE78h2Nb5uzizto4JQbBGpwSX4mnSzm5xGhXYYG4V1r17
         PHeSNJwi7hgeOB3tBxgDJT8ZvI4mbfvuHTjq4=
Received: by 10.151.122.8 with SMTP id z8mr247606ybm.376.1283968936492;
        Wed, 08 Sep 2010 11:02:16 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id z6sm199616ibc.12.2010.09.08.11.02.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 11:02:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1283968797-31793-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155807>

Make 'merge.log' an integer or boolean option to set the number of
shortlog entries to display in the merge commit. Note that it defaults
to false, and that true means a default value of 20. Also update
corresponding documentation.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
Thanks-to: Johannes Sixt <j.sixt@viscovery.net>
---
 Documentation/git-fmt-merge-msg.txt |    6 ++++--
 Documentation/merge-config.txt      |    6 ++++--
 builtin/fmt-merge-msg.c             |   16 +++++++---------
 builtin/merge.c                     |    7 ++++++-
 4 files changed, 21 insertions(+), 14 deletions(-)

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
index 455e7c6..5deba65 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -15,15 +15,13 @@ static int shortlog_len;
 
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
+		if (!is_bool && shortlog_len < 0)
+			return error("%s: negative length %s", key, value);
+		if (is_bool && shortlog_len)
+			shortlog_len = DEFAULT_MERGE_LOG_LEN;
 	}
 	return 0;
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index 9e4733d..1e9c898 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -503,7 +503,12 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	else if (!strcmp(k, "pull.octopus"))
 		return git_config_string(&pull_octopus, k, v);
 	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary")) {
-		shortlog_len = git_config_bool(k, v) ? DEFAULT_MERGE_LOG_LEN : 0;
+		int is_bool;
+		shortlog_len = git_config_bool_or_int(k, v, &is_bool);
+		if (!is_bool && shortlog_len < 0)
+			return error("%s: negative length %s", k, v);
+		if (is_bool && shortlog_len)
+			shortlog_len = DEFAULT_MERGE_LOG_LEN;
 		return 0;
 	}
 	return git_diff_ui_config(k, v, cb);
-- 
1.7.2.2.409.gdbb11.dirty

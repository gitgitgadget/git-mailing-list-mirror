From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v5 3/5] merge: Make 'merge.log' an integer or boolean option
Date: Sun, 22 Aug 2010 21:56:36 +0530
Message-ID: <1282494398-20542-4-git-send-email-artagnon@gmail.com>
References: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 22 18:30:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnDR7-00047i-89
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 18:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653Ab0HVQ3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 12:29:24 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:48844 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab0HVQ3G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 12:29:06 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1976160pxi.19
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 09:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YJ5419WvNL1SPthTR8agUrvGh0fnQBu/LHbKsle93eI=;
        b=spOAVX0X80Pd49mbkP0IyfiJK2DimRWglzTNOoehOgX5eqvK7a4ChTxCUCpQ9SF8LE
         M55kLU5RC6SC2Y4mGP7gdn8wj9inM/rYP7PrFV5TirNR/WFYo/vviBvCDSfz7Hd+LQC2
         T7A79Sd7amDkuYhaXCcoMMsDZjBC5C29HJDh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F3xozIbBjnr8UPsUQG+AREyIuEK77RpSggebYWQN4lWV+QGpFWq5YGmXcKr0KBtBIR
         /MN5qfoaUBEh6+I8B3RIJL3rNGajcrCV7HRgM5HfyJQmLuC1GlE3dPacGHVQLRwbZUCH
         9kKhkiYQU/w1ouOmO/u9RuZ0IXb7ZhstXcMSw=
Received: by 10.142.241.7 with SMTP id o7mr3464670wfh.72.1282494546293;
        Sun, 22 Aug 2010 09:29:06 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id y16sm7089065wff.14.2010.08.22.09.29.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Aug 2010 09:29:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154188>

Make 'merge.log' an integer or boolean option to set the number of
shortlog entries to display in the merge commit. Note that it defaults
to false, and that true means a default value of 20. Also update
corresponding documentation.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
Thanks-to: Johannes Sixt <j.sixt@viscovery.net>
---
 Documentation/git-fmt-merge-msg.txt |    8 +++++---
 Documentation/merge-config.txt      |    8 ++++++--
 builtin/fmt-merge-msg.c             |   11 +++++------
 builtin/merge.c                     |    8 ++++++--
 4 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 14ac466..5954a53 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -25,9 +25,11 @@ OPTIONS
 -------
 
 --log[=<n>]::
-	In addition to branch names, populate the log message with
-	one-line descriptions from at most <n> actual commits that are
-	being merged. If omitted, <n> defaults to 20.
+	Whether to include summaries of merged commits in newly
+	created merge commit messages.  Optionally, an integer can be
+	used to specify how many merged commits to summarize (at
+	maxmium) in the merge message.  Specifying "true" is
+	equivalent to specifying 20.  Defaults to false.
 
 --no-log::
 	Do not list one-line descriptions from the actual commits being
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index b72f533..510c0ad 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -7,8 +7,12 @@ merge.conflictstyle::
 	marker and the original text before the `=======` marker.
 
 merge.log::
-	Whether to include summaries of merged commits in newly created
-	merge commit messages. False by default.
+	Whether to include summaries of merged commits in newly
+	created merge commit messages.  Optionally, an integer can be
+	used to specify how many merged commits to summarize (at
+	maxmium) in the merge message.  Specifying "true" is
+	equivalent to specifying 20.  Defaults to false. See also
+	linkgit:git-fmt-merge-msg[1].
 
 merge.renameLimit::
 	The number of files to consider when performing rename detection
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 1c5da95..6a2c9c8 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -15,13 +15,12 @@ static int shortlog_len;
 
 static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
-	static int found_merge_log = 0;
-	if (!strcmp("merge.log", key)) {
-		found_merge_log = 1;
-		shortlog_len = git_config_bool(key, value);
+	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
+		int is_bool;
+		shortlog_len = git_config_bool_or_int(key, value, &is_bool);
+		if (is_bool && shortlog_len)
+			shortlog_len = 20;
 	}
-	if (!found_merge_log && !strcmp("merge.summary", key))
-		shortlog_len = git_config_bool(key, value);
 	return 0;
 }
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 994b0c5..78d6c69 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -505,8 +505,12 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return git_config_string(&pull_twohead, k, v);
 	else if (!strcmp(k, "pull.octopus"))
 		return git_config_string(&pull_octopus, k, v);
-	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary"))
-		shortlog_len = git_config_bool(k, v);
+	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary")) {
+		int is_bool;
+		shortlog_len = git_config_bool_or_int(k, v, &is_bool);
+		if (is_bool && shortlog_len)
+			shortlog_len = 20;
+	}
 	else if (!strcmp(k, "merge.renormalize"))
 		option_renormalize = git_config_bool(k, v);
 	return git_diff_ui_config(k, v, cb);
-- 
1.7.2.2.409.gdbb11.dirty

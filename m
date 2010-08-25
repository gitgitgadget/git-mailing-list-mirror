From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v6 3/3] merge: Make 'merge.log' an integer or boolean option
Date: Wed, 25 Aug 2010 16:18:50 +0530
Message-ID: <1282733330-32334-4-git-send-email-artagnon@gmail.com>
References: <1282733330-32334-1-git-send-email-artagnon@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 12:51:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoDZr-0001SO-1X
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 12:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab0HYKvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 06:51:16 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55399 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab0HYKvP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 06:51:15 -0400
Received: by pwi7 with SMTP id 7so221879pwi.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 03:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Wd6M+7A+vHEsI5R1bfgSAeuX2PKkpMWz+9GNbthYJc4=;
        b=nNdbeqeXWmnKPLQuFvW1lo+P5nT2AzlaJH5Q64sQTH0E+0Rn865detMTbtYVaWqD/A
         BwdMBJIMEbdYbHAgF1O/nGtg6TIMyOziHOxf+CBLantZj6gobfND/zz6vG4m0p+H/f7u
         GGTnnDN0vkKjykgPl82TJhTqOjz4ZsCdm/pEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pIHVq7tQx3ldVkZBI1UlfyFfcAIs/mZ1KSG0iNDX8IP3UiB2MMSsXlVVzhmVUt2ODB
         Kg/gW50OPV3DGewdzcaKoX/YTMHDPXAbUPcfeBjXz53zDW3nuyGW19NKYzKAh800M5Q3
         Xm2dzVp9hK4XO3Pdd/o7xBYVPUYh43QddnmMU=
Received: by 10.114.203.10 with SMTP id a10mr9292792wag.42.1282733474913;
        Wed, 25 Aug 2010 03:51:14 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d38sm2037882wam.20.2010.08.25.03.51.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 03:51:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282733330-32334-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154442>

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
 builtin/fmt-merge-msg.c             |   14 +++++---------
 builtin/merge.c                     |    8 ++++++--
 4 files changed, 19 insertions(+), 15 deletions(-)

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
index b72f533..92772e7 100644
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
index ec933df..b61416e 100644
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
+		if (is_bool && shortlog_len)
+			shortlog_len = DEFAULT_MERGE_LOG_LEN;
 	}
 	return 0;
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index b067b84..45ff6d6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -507,8 +507,12 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return git_config_string(&pull_twohead, k, v);
 	else if (!strcmp(k, "pull.octopus"))
 		return git_config_string(&pull_octopus, k, v);
-	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary"))
-		shortlog_len = git_config_bool(k, v) ? DEFAULT_MERGE_LOG_LEN : 0;
+	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary")) {
+		int is_bool;
+		shortlog_len = git_config_bool_or_int(k, v, &is_bool);
+		if (is_bool && shortlog_len)
+			shortlog_len = DEFAULT_MERGE_LOG_LEN;
+	}
 	else if (!strcmp(k, "merge.renormalize"))
 		option_renormalize = git_config_bool(k, v);
 	return git_diff_ui_config(k, v, cb);
-- 
1.7.2.2.409.gdbb11.dirty

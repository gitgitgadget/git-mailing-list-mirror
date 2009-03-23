From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 5/6] format-patch: --attach/inline uses filename instead of SHA1
Date: Sun, 22 Mar 2009 19:14:05 -0700
Message-ID: <bb1484f1a621238d8689e471cc6affd8590cd382.1237773604.git.bebarino@gmail.com>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
 <cover.1237773604.git.bebarino@gmail.com>
 <baa327d88b54efae40b6d9df09a2fe482672101e.1237773604.git.bebarino@gmail.com>
 <616420f398701fafc45b5d5cebb1371534f88caa.1237773604.git.bebarino@gmail.com>
 <00c4e51c2ff7786be6aedb4a451b8d1ff269d7b3.1237773604.git.bebarino@gmail.com>
 <e8e0dcc738decb5f70dbc8e835263d7dc2834407.1237773604.git.bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 03:16:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlZhx-0000lE-Ow
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 03:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164AbZCWCOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 22:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754881AbZCWCOa
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 22:14:30 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:7533 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785AbZCWCO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 22:14:26 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2572989wff.4
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 19:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=9apBVaqx3HDfKeTtXIUONFC9EGG9NDfsCc6YrMSHUyA=;
        b=wHZh1VKUbU0ZOpueZUqThojFG+WZVc2pGzkDPV5hBeu7k+KqYWabF/Cu1woULi5kmP
         NgoAnWXWGw+S6Z4305eE79cw1OBUgfsAretT+Gp7qRtRMCaTh8bwY+QNMYpcZOuA9R7B
         URK0ytJn0B61U31mgcgudoAhiTw5BqDE94f+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AWBUaN0CRvyAUwFYcspCvdtgCoeGVtT+WyNhQ12S+nHBHUOfNsKTalzSjFrMhVZhpS
         qZtpbtWSMlxYDK9lro6dKmvQlBvwXry1I8HPTcP9P12DhbP2jnchbHutIJUV61lMP5D7
         6y6V0ZzZZHNzzJwBr/BF9MFqNJYD03rkoAQlQ=
Received: by 10.143.28.8 with SMTP id f8mr2613090wfj.204.1237774464316;
        Sun, 22 Mar 2009 19:14:24 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 27sm3045802wfa.30.2009.03.22.19.14.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 22 Mar 2009 19:14:23 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 22 Mar 2009 19:14:21 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <e8e0dcc738decb5f70dbc8e835263d7dc2834407.1237773604.git.bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114232>

Currently when format-patch is used with --attach or --inline the patch
attachment has the SHA1 of the commit for its filename.  This replaces
the SHA1 with the filename used by format-patch when outputting to
files.

Fix tests relying on the SHA1 output and add a test showing how the
--suffix option affects the attachment filename output.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-log.c                                      |    8 +-
 log-tree.c                                         |   18 ++++--
 log-tree.h                                         |    2 +-
 revision.h                                         |    2 +
 t/t4013-diff-various.sh                            |    1 +
 ..._--attach_--stdout_--suffix=.diff_initial..side |   61 ++++++++++++++++++++
 ....format-patch_--attach_--stdout_initial..master |   12 ++--
 ...format-patch_--attach_--stdout_initial..master^ |    8 +-
 ...ff.format-patch_--attach_--stdout_initial..side |    4 +-
 ...tdout_--subject-prefix=TESTCASE_initial..master |   12 ++--
 ....format-patch_--inline_--stdout_initial..master |   12 ++--
 ...format-patch_--inline_--stdout_initial..master^ |    8 +-
 ...ormat-patch_--inline_--stdout_initial..master^^ |    4 +-
 ...ff.format-patch_--inline_--stdout_initial..side |    4 +-
 14 files changed, 112 insertions(+), 44 deletions(-)
 create mode 100644 t/t4013/diff.format-patch_--attach_--stdout_--suffix=.diff_initial..side

diff --git a/builtin-log.c b/builtin-log.c
index a8d6037..83d8c03 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -607,7 +607,6 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      int nr, struct commit **list, struct commit *head)
 {
 	const char *committer;
-	char *head_sha1;
 	const char *subject_start = NULL;
 	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
 	const char *msg;
@@ -624,7 +623,6 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 		die("Cover letter needs email format");
 
 	committer = git_committer_info(0);
-	head_sha1 = sha1_to_hex(head->object.sha1);
 
 	if (!numbered_files)
 	{
@@ -640,7 +638,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			"author %s\n"
 			"committer %s\n\n"
 			"cover letter\n",
-			head_sha1, committer, committer);
+			sha1_to_hex(head->object.sha1), committer, committer);
 	}
 
 	if (!use_stdout && reopen_stdout(commit, rev))
@@ -652,7 +650,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 		free(commit);
 	}
 
-	log_write_email_headers(rev, head_sha1, &subject_start, &extra_headers,
+	log_write_email_headers(rev, head, &subject_start, &extra_headers,
 				&need_8bit_cte);
 
 	msg = body;
@@ -1012,6 +1010,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		const char *msgid = clean_message_id(in_reply_to);
 		string_list_append(msgid, rev.ref_message_ids);
 	}
+	rev.numbered_files = numbered_files;
+	rev.patch_suffix = fmt_patch_suffix;
 	if (cover_letter) {
 		if (thread)
 			gen_message_id(&rev, "cover");
diff --git a/log-tree.c b/log-tree.c
index 9a790ab..5c9e2cf 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -202,13 +202,14 @@ void get_patch_filename(struct commit *commit, int nr, const char *suffix,
 	}
 }
 
-void log_write_email_headers(struct rev_info *opt, const char *name,
+void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **subject_p,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p)
 {
 	const char *subject = NULL;
 	const char *extra_headers = opt->extra_headers;
+	const char *name = sha1_to_hex(commit->object.sha1);
 
 	*need_8bit_cte_p = 0; /* unknown */
 	if (opt->total > 0) {
@@ -247,6 +248,7 @@ void log_write_email_headers(struct rev_info *opt, const char *name,
 	if (opt->mime_boundary) {
 		static char subject_buffer[1024];
 		static char buffer[1024];
+		struct strbuf filename =  STRBUF_INIT;
 		*need_8bit_cte_p = -1; /* NEVER */
 		snprintf(subject_buffer, sizeof(subject_buffer) - 1,
 			 "%s"
@@ -265,18 +267,21 @@ void log_write_email_headers(struct rev_info *opt, const char *name,
 			 mime_boundary_leader, opt->mime_boundary);
 		extra_headers = subject_buffer;
 
+		get_patch_filename(opt->numbered_files ? NULL : commit, opt->nr,
+				    opt->patch_suffix, &filename);
 		snprintf(buffer, sizeof(buffer) - 1,
 			 "\n--%s%s\n"
 			 "Content-Type: text/x-patch;"
-			 " name=\"%s.diff\"\n"
+			 " name=\"%s\"\n"
 			 "Content-Transfer-Encoding: 8bit\n"
 			 "Content-Disposition: %s;"
-			 " filename=\"%s.diff\"\n\n",
+			 " filename=\"%s\"\n\n",
 			 mime_boundary_leader, opt->mime_boundary,
-			 name,
+			 filename.buf,
 			 opt->no_inline ? "attachment" : "inline",
-			 name);
+			 filename.buf);
 		opt->diffopt.stat_sep = buffer;
+		strbuf_release(&filename);
 	}
 	*subject_p = subject;
 	*extra_headers_p = extra_headers;
@@ -356,8 +361,7 @@ void show_log(struct rev_info *opt)
 	 */
 
 	if (opt->commit_format == CMIT_FMT_EMAIL) {
-		log_write_email_headers(opt, sha1_to_hex(commit->object.sha1),
-					&subject, &extra_headers,
+		log_write_email_headers(opt, commit, &subject, &extra_headers,
 					&need_8bit_cte);
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_COMMIT), stdout);
diff --git a/log-tree.h b/log-tree.h
index 78dc5be..20b5caf 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -13,7 +13,7 @@ int log_tree_commit(struct rev_info *, struct commit *);
 int log_tree_opt_parse(struct rev_info *, const char **, int);
 void show_log(struct rev_info *opt);
 void show_decorations(struct rev_info *opt, struct commit *commit);
-void log_write_email_headers(struct rev_info *opt, const char *name,
+void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **subject_p,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p);
diff --git a/revision.h b/revision.h
index ad123d7..5259ed5 100644
--- a/revision.h
+++ b/revision.h
@@ -86,6 +86,8 @@ struct rev_info {
 	struct log_info *loginfo;
 	int		nr, total;
 	const char	*mime_boundary;
+	const char	*patch_suffix;
+	int		numbered_files;
 	char		*message_id;
 	struct string_list *ref_message_ids;
 	const char	*add_signoff;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 426e64e..6592a4f 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -246,6 +246,7 @@ format-patch --stdout initial..master
 format-patch --stdout --no-numbered initial..master
 format-patch --stdout --numbered initial..master
 format-patch --attach --stdout initial..side
+format-patch --attach --stdout --suffix=.diff initial..side
 format-patch --attach --stdout initial..master^
 format-patch --attach --stdout initial..master
 format-patch --inline --stdout initial..side
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_--suffix=.diff_initial..side b/t/t4013/diff.format-patch_--attach_--stdout_--suffix=.diff_initial..side
new file mode 100644
index 0000000..52116d3
--- /dev/null
+++ b/t/t4013/diff.format-patch_--attach_--stdout_--suffix=.diff_initial..side
@@ -0,0 +1,61 @@
+$ git format-patch --attach --stdout --suffix=.diff initial..side
+From c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Mon, 26 Jun 2006 00:03:00 +0000
+Subject: [PATCH] Side
+MIME-Version: 1.0
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
+
+This is a multi-part message in MIME format.
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/plain; charset=UTF-8; format=fixed
+Content-Transfer-Encoding: 8bit
+
+---
+ dir/sub |    2 ++
+ file0   |    3 +++
+ file3   |    4 ++++
+ 3 files changed, 9 insertions(+), 0 deletions(-)
+ create mode 100644 file3
+
+
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/x-patch; name="0001-Side.diff"
+Content-Transfer-Encoding: 8bit
+Content-Disposition: attachment; filename="0001-Side.diff"
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+
+--------------g-i-t--v-e-r-s-i-o-n--
+
+
+$
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
index e5ab744..ce49bd6 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
@@ -22,9 +22,9 @@ This is the second commit.
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: attachment; filename="0001-Second.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -80,9 +80,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="0002-Third.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment; filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: attachment; filename="0002-Third.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -129,9 +129,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="0003-Side.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment; filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: attachment; filename="0003-Side.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
index 2c71d20..5f1b238 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
@@ -22,9 +22,9 @@ This is the second commit.
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: attachment; filename="0001-Second.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -80,9 +80,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="0002-Third.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment; filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: attachment; filename="0002-Third.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..side b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
index 38f7902..4a2364a 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
@@ -20,9 +20,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="0001-Side.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment; filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: attachment; filename="0001-Side.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
index 58f8a7b..ca3f60b 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
@@ -22,9 +22,9 @@ This is the second commit.
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: inline; filename="0001-Second.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -80,9 +80,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="0002-Third.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: inline; filename="0002-Third.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -129,9 +129,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="0003-Side.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: inline; filename="0003-Side.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
index 9e7bbdf..08f2301 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
@@ -22,9 +22,9 @@ This is the second commit.
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: inline; filename="0001-Second.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -80,9 +80,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="0002-Third.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: inline; filename="0002-Third.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -129,9 +129,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="0003-Side.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: inline; filename="0003-Side.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
index f881f64..07f1230 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
@@ -22,9 +22,9 @@ This is the second commit.
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: inline; filename="0001-Second.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -80,9 +80,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="0002-Third.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: inline; filename="0002-Third.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
index 4f258b8..29e00ab 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
@@ -22,9 +22,9 @@ This is the second commit.
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: inline; filename="0001-Second.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..side b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
index e86dce6..67633d4 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
@@ -20,9 +20,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="0001-Side.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: inline; filename="0001-Side.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
-- 
1.6.2

From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/3] builtin/grep: rename use_index to no_index
Date: Mon, 11 Jan 2016 18:00:47 +0100
Message-ID: <1452531648-16575-3-git-send-email-t.gummerer@gmail.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
 <1452531648-16575-1-git-send-email-t.gummerer@gmail.com>
Cc: pclouds@gmail.com, sunshine@sunshineco.com, gitster@pobox.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 18:00:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIfpn-0001OJ-04
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 18:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933226AbcAKRAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 12:00:43 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34476 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421AbcAKRAm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 12:00:42 -0500
Received: by mail-wm0-f66.google.com with SMTP id b14so27205143wmb.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 09:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1+Cx2JPObpdWUjrgCyQfJ2vuKK4vCWKjpAJL0N98hVo=;
        b=wtkmInROKXV/yZ3bEdh5cJIkCvUEVQ2sSUe3X8LLohLQm9iGkydAkwqY5lvOLlDtW1
         faWdrwe5lUq+cKRkktOJ0oSmava9Zl30ZLNU6DNA1fxX/iRINQxYtb5sg2Vi/m73SrMf
         Am6zK5r88VtAmj5Q4r3BjdLvcEaMBFXmwjVvsn7ihP8mV386caz9XI9TCtGYgJGxCYgC
         R0u/ZEsfBtqhu2XAy82/oPoFx79q+uNaduW1jdBuoJ8A8uK2yZ7GRah7GoM+RRNB8MyS
         OtmXRj14ROm0QmnE+v5owXb7RMGjerehEOhwWzSCZKXrcSbNlAoA8T5H+0JsEWFKBZI4
         CfEw==
X-Received: by 10.194.157.165 with SMTP id wn5mr118727230wjb.41.1452531640921;
        Mon, 11 Jan 2016 09:00:40 -0800 (PST)
Received: from localhost (host143-106-dynamic.248-95-r.retail.telecomitalia.it. [95.248.106.143])
        by smtp.gmail.com with ESMTPSA id gl10sm120356216wjb.30.2016.01.11.09.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 09:00:39 -0800 (PST)
X-Mailer: git-send-email 2.6.0.rc0.160.g9ddbed8
In-Reply-To: <1452531648-16575-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283672>

Switch the OPT_NEGBIT argument to a OPT_BIT argument, and rename the
corresponding use_index variable to a no_index variable.  This will make
the following step easier to follow.  No functional changes intended.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/grep.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 4229cae..3a27bd5 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -625,14 +625,14 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct string_list path_list = STRING_LIST_INIT_NODUP;
 	int i;
 	int dummy;
-	int use_index = 1;
+	int no_index = 0;
 	int pattern_type_arg = GREP_PATTERN_TYPE_UNSPECIFIED;
 
 	struct option options[] = {
 		OPT_BOOL(0, "cached", &cached,
 			N_("search in index instead of in the work tree")),
-		OPT_NEGBIT(0, "no-index", &use_index,
-			 N_("find in contents not managed by git"), 1),
+		OPT_BIT(0, "no-index", &no_index,
+			N_("find in contents not managed by git"), 1),
 		OPT_BOOL(0, "untracked", &untracked,
 			N_("search in both tracked and untracked files")),
 		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
@@ -755,7 +755,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	grep_commit_pattern_type(pattern_type_arg, &opt);
 
-	if (use_index && !startup_info->have_repository)
+	if (!no_index && !startup_info->have_repository)
 		/* die the same way as if we did it at the beginning */
 		setup_git_directory();
 
@@ -873,11 +873,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (!show_in_pager && !opt.status_only)
 		setup_pager();
 
-	if (!use_index && (untracked || cached))
+	if (no_index && (untracked || cached))
 		die(_("--cached or --untracked cannot be used with --no-index."));
 
-	if (!use_index || untracked) {
-		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
+	if (no_index || untracked) {
+		int use_exclude = (opt_exclude < 0) ? !no_index : !!opt_exclude;
 		if (list.nr)
 			die(_("--no-index or --untracked cannot be used with revs."));
 		hit = grep_directory(&opt, &pathspec, use_exclude);
-- 
2.7.0.3.g214d8d0.dirty

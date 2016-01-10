From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/3] builtin/grep: rename use_index to no_index
Date: Sun, 10 Jan 2016 15:19:56 +0100
Message-ID: <1452435597-12099-3-git-send-email-t.gummerer@gmail.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
Cc: Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 10 15:26:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIGwz-00019D-UO
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jan 2016 15:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757835AbcAJO0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2016 09:26:30 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36536 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757608AbcAJOTr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2016 09:19:47 -0500
Received: by mail-wm0-f67.google.com with SMTP id l65so22635590wmf.3
        for <git@vger.kernel.org>; Sun, 10 Jan 2016 06:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QjxBTSLGVUKCGdM0BvDlRTn2C/KsOPspKLpkJoOPgJQ=;
        b=bEkP2Dw5LvBohrVtMm03c6bBSWcn/oBb8UOL8wFPg4dXiY3ihLhIT1D4M398Lq6Kla
         vFFXAyUIzfQjXJzKNdxxdt98Ex0XuPtMt3yisYV/hkbGDgYlnXJ9JQn9CU+hVpHbYEoA
         CPLzbL1ZvbuL12jexMpdqkTBXEgPRkt6/RjCRLKK+8lo1Ss16zCNeN+N7Nd369Bijslo
         2yYq7z5KRTaT1N1uppeUtpKoXDKMf9TtoBbmjzMpG4byEZTpVCdHqM5cL8C4bWDqpiIN
         HA4chWbPLy58ZvTo75Y1Xm7j0H/zYVOhNDYNWfQSkhTSJcX6ZjO7IDBczO2FAqh1/TNE
         wdzg==
X-Received: by 10.28.59.136 with SMTP id i130mr9110571wma.12.1452435586768;
        Sun, 10 Jan 2016 06:19:46 -0800 (PST)
Received: from localhost (host251-54-dynamic.20-79-r.retail.telecomitalia.it. [79.20.54.251])
        by smtp.gmail.com with ESMTPSA id c203sm8456597wmd.5.2016.01.10.06.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2016 06:19:45 -0800 (PST)
X-Mailer: git-send-email 2.6.3.387.g749a69c.dirty
In-Reply-To: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283621>

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
2.6.3.387.g749a69c.dirty

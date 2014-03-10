From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 2/2] fix status_printf_ln calls "zero-length format" warnings
Date: Mon, 10 Mar 2014 20:27:27 +0100
Message-ID: <1394479647-22361-3-git-send-email-benoit.pierre@gmail.com>
References: <1394479647-22361-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 20:27:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN5rb-0003T4-O8
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 20:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbaCJT1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 15:27:43 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:40735 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbaCJT1m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 15:27:42 -0400
Received: by mail-we0-f180.google.com with SMTP id p61so9052715wes.25
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=5GpqJA5iUlIMej92pu1BgohOeUZwhkp79gsxH/lrSo4=;
        b=vXe/4oO+SiyanjgKnYx9hzgdBjMpMLc1y+IBVwsbg/dQEoXsym3EK3YbT1NSktg4Pg
         cv2Xht+ZXwSCdvlB2w5pDpM+vzzSjESYW1E7lBmdrJxgKwh4/8c+YRgNandQaju6fIqV
         0SnVXN5A2sAeckcKsnWEXanAQGbkTXQnFRwh1//ruqalGA0EAuaaUB+7yT3iGmwuRBbm
         nvcOcVq0/SynlUj0YUKXureJQpnN3Sfl3jm+/1f9O6eQakfxdB45xiNfdraxAFtxrTb4
         coAOPAgbRpzM7wEFWijphdITj2r6mYO7CW3k6vW26G6f0QR+03qr8XFUV4F/8z/7kNBl
         t7Gg==
X-Received: by 10.194.188.41 with SMTP id fx9mr3536349wjc.56.1394479661041;
        Mon, 10 Mar 2014 12:27:41 -0700 (PDT)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id ci4sm54910808wjc.21.2014.03.10.12.27.39
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Mar 2014 12:27:40 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394479647-22361-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243797>

Those happens with "gcc -Wformat-zero-length".

Change empty strings to NULL now that it's allowed.

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 builtin/commit.c |  2 +-
 wt-status.c      | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3767478..6d19439 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -805,7 +805,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				committer_ident.buf);
 
 		if (ident_shown)
-			status_printf_ln(s, GIT_COLOR_NORMAL, "");
+			status_printf_ln(s, GIT_COLOR_NORMAL, NULL);
 
 		saved_color_setting = s->use_color;
 		s->use_color = 0;
diff --git a/wt-status.c b/wt-status.c
index 17f63a4..d9b1d00 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -189,7 +189,7 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
 	} else {
 		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
 	}
-	status_printf_ln(s, c, "");
+	status_printf_ln(s, c, NULL);
 }
 
 static void wt_status_print_cached_header(struct wt_status *s)
@@ -205,7 +205,7 @@ static void wt_status_print_cached_header(struct wt_status *s)
 		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
 	else
 		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
-	status_printf_ln(s, c, "");
+	status_printf_ln(s, c, NULL);
 }
 
 static void wt_status_print_dirty_header(struct wt_status *s,
@@ -224,7 +224,7 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 	status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" to discard changes in working directory)"));
 	if (has_dirty_submodules)
 		status_printf_ln(s, c, _("  (commit or discard the untracked or modified content in submodules)"));
-	status_printf_ln(s, c, "");
+	status_printf_ln(s, c, NULL);
 }
 
 static void wt_status_print_other_header(struct wt_status *s,
@@ -236,12 +236,12 @@ static void wt_status_print_other_header(struct wt_status *s,
 	if (!s->hints)
 		return;
 	status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in what will be committed)"), how);
-	status_printf_ln(s, c, "");
+	status_printf_ln(s, c, NULL);
 }
 
 static void wt_status_print_trailer(struct wt_status *s)
 {
-	status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
+	status_printf_ln(s, color(WT_STATUS_HEADER, s), NULL);
 }
 
 #define quote_path quote_path_relative
@@ -794,7 +794,7 @@ static void wt_status_print_other(struct wt_status *s,
 	string_list_clear(&output, 0);
 	strbuf_release(&buf);
 conclude:
-	status_printf_ln(s, GIT_COLOR_NORMAL, "");
+	status_printf_ln(s, GIT_COLOR_NORMAL, NULL);
 }
 
 void wt_status_truncate_message_at_cut_line(struct strbuf *buf)
@@ -1292,7 +1292,7 @@ void wt_status_print(struct wt_status *s)
 				on_what = _("Not currently on any branch.");
 			}
 		}
-		status_printf(s, color(WT_STATUS_HEADER, s), "");
+		status_printf(s, color(WT_STATUS_HEADER, s), NULL);
 		status_printf_more(s, branch_status_color, "%s", on_what);
 		status_printf_more(s, branch_color, "%s\n", branch_name);
 		if (!s->is_initial)
@@ -1305,9 +1305,9 @@ void wt_status_print(struct wt_status *s)
 	free(state.detached_from);
 
 	if (s->is_initial) {
-		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
+		status_printf_ln(s, color(WT_STATUS_HEADER, s), NULL);
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
-		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
+		status_printf_ln(s, color(WT_STATUS_HEADER, s), NULL);
 	}
 
 	wt_status_print_updated(s);
@@ -1324,7 +1324,7 @@ void wt_status_print(struct wt_status *s)
 		if (s->show_ignored_files)
 			wt_status_print_other(s, &s->ignored, _("Ignored files"), "add -f");
 		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
-			status_printf_ln(s, GIT_COLOR_NORMAL, "");
+			status_printf_ln(s, GIT_COLOR_NORMAL, NULL);
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 					 _("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
 					   "may speed it up, but you have to be careful not to forget to add\n"
-- 
1.9.0

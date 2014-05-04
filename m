From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/3] Silence a bunch of format-zero-length warnings
Date: Sun,  4 May 2014 01:12:55 -0500
Message-ID: <1399183975-2346-4-git-send-email-felipe.contreras@gmail.com>
References: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 08:23:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgpq2-0000vm-TB
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 08:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbaEDGXs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2014 02:23:48 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:64088 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbaEDGXp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 02:23:45 -0400
Received: by mail-oa0-f44.google.com with SMTP id i11so575017oag.17
        for <git@vger.kernel.org>; Sat, 03 May 2014 23:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=X8nftihG++PU8TbDg5LHsJp/nNNL/h0lclogNCpIgNI=;
        b=OkUf4pbGG4uo1b61lrFUq4zRqQVW1DcqoffjPvbG1dgWYMGEJ27YW3yVgdPqIrNzWZ
         wT8Xkk8wpLKOaPoL39rPh/ElDlO0wPcXjghLqiQ0JiKjEJKoBvka9XUJrqy9dnjqW+eR
         3XVyJ9+fPOxt0KjgUV75tJ8pyg7o3riEJVCxPb+xKh80+PP2B+MwpiWKScGGWjqGos1E
         oKLjcfEUwpzXQ8tAGWAeHqWCTryguhrpAPGcd4sMEVIT+2Wvs8XrtZ/iAQD0g2uG/L86
         242QkU0smSbzzBDzzzDCfqplW6jH8a8rQXKpORz+VsIqs/odVpuclmTsbYM3FCP+RWJg
         ogsA==
X-Received: by 10.60.144.200 with SMTP id so8mr25842534oeb.31.1399184625202;
        Sat, 03 May 2014 23:23:45 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f1sm19783873oej.5.2014.05.03.23.23.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 May 2014 23:23:44 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.20.g204a630
In-Reply-To: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248077>

This is in gcc 4.9.0:

  wt-status.c: In function =E2=80=98wt_status_print_unmerged_header=E2=80=
=99:
  wt-status.c:191:2: warning: zero-length gnu_printf format string [-Wf=
ormat-zero-length]
    status_printf_ln(s, c, "");
    ^

We could pass -Wno-format-zero-length, but it seems compiler-specific
flags are frowned upon, so let's just avoid the warning altogether.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/commit.c |  2 +-
 wt-status.c      | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9cfef6c..13b84e4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -812,7 +812,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 				committer_ident.buf);
=20
 		if (ident_shown)
-			status_printf_ln(s, GIT_COLOR_NORMAL, "");
+			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
=20
 		saved_color_setting =3D s->use_color;
 		s->use_color =3D 0;
diff --git a/wt-status.c b/wt-status.c
index ec7344e..b8841e1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -188,7 +188,7 @@ static void wt_status_print_unmerged_header(struct =
wt_status *s)
 	} else {
 		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropr=
iate to mark resolution)"));
 	}
-	status_printf_ln(s, c, "");
+	status_printf_ln(s, c, "%s", "");
 }
=20
 static void wt_status_print_cached_header(struct wt_status *s)
@@ -204,7 +204,7 @@ static void wt_status_print_cached_header(struct wt=
_status *s)
 		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unsta=
ge)"), s->reference);
 	else
 		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to un=
stage)"));
-	status_printf_ln(s, c, "");
+	status_printf_ln(s, c, "%s", "");
 }
=20
 static void wt_status_print_dirty_header(struct wt_status *s,
@@ -223,7 +223,7 @@ static void wt_status_print_dirty_header(struct wt_=
status *s,
 	status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" to dis=
card changes in working directory)"));
 	if (has_dirty_submodules)
 		status_printf_ln(s, c, _("  (commit or discard the untracked or modi=
fied content in submodules)"));
-	status_printf_ln(s, c, "");
+	status_printf_ln(s, c, "%s", "");
 }
=20
 static void wt_status_print_other_header(struct wt_status *s,
@@ -235,12 +235,12 @@ static void wt_status_print_other_header(struct w=
t_status *s,
 	if (!s->hints)
 		return;
 	status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in w=
hat will be committed)"), how);
-	status_printf_ln(s, c, "");
+	status_printf_ln(s, c, "%s", "");
 }
=20
 static void wt_status_print_trailer(struct wt_status *s)
 {
-	status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
+	status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 }
=20
 #define quote_path quote_path_relative
@@ -826,7 +826,7 @@ static void wt_status_print_other(struct wt_status =
*s,
 	string_list_clear(&output, 0);
 	strbuf_release(&buf);
 conclude:
-	status_printf_ln(s, GIT_COLOR_NORMAL, "");
+	status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
 }
=20
 void wt_status_truncate_message_at_cut_line(struct strbuf *buf)
@@ -913,7 +913,7 @@ static void wt_status_print_tracking(struct wt_stat=
us *s)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%c",
 				 comment_line_char);
 	else
-		fprintf_ln(s->fp, "");
+		fputs("", s->fp);
 }
=20
 static int has_unmerged(struct wt_status *s)
@@ -1329,7 +1329,7 @@ void wt_status_print(struct wt_status *s)
 				on_what =3D _("Not currently on any branch.");
 			}
 		}
-		status_printf(s, color(WT_STATUS_HEADER, s), "");
+		status_printf(s, color(WT_STATUS_HEADER, s), "%s", "");
 		status_printf_more(s, branch_status_color, "%s", on_what);
 		status_printf_more(s, branch_color, "%s\n", branch_name);
 		if (!s->is_initial)
@@ -1342,9 +1342,9 @@ void wt_status_print(struct wt_status *s)
 	free(state.detached_from);
=20
 	if (s->is_initial) {
-		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
+		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"))=
;
-		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
+		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 	}
=20
 	wt_status_print_updated(s);
@@ -1361,7 +1361,7 @@ void wt_status_print(struct wt_status *s)
 		if (s->show_ignored_files)
 			wt_status_print_other(s, &s->ignored, _("Ignored files"), "add -f")=
;
 		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
-			status_printf_ln(s, GIT_COLOR_NORMAL, "");
+			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 					 _("It took %.2f seconds to enumerate untracked files. 'status -u=
no'\n"
 					   "may speed it up, but you have to be careful not to forget to =
add\n"
--=20
1.9.2+fc1.20.g204a630

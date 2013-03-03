From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] wt-status: move wt_status_get_state() out to wt_status_print()
Date: Sun,  3 Mar 2013 16:41:19 +0700
Message-ID: <1362303681-6585-4-git-send-email-pclouds@gmail.com>
References: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 03 10:41:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UC5Q9-000115-6D
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 10:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937Ab3CCJkv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Mar 2013 04:40:51 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:38985 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab3CCJku (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 04:40:50 -0500
Received: by mail-pa0-f48.google.com with SMTP id hz10so2594719pad.7
        for <git@vger.kernel.org>; Sun, 03 Mar 2013 01:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=c1hOFYFzc9wgHOe18flitw9qnuaOeZVCEvTrJHJYBoU=;
        b=grkKmW+H47YD/0IycfBxgXot07mek6rUF2v2sydaZmby4HaP/ObHNglnIFmL4hVmwP
         zFUPctdu93d7PUobHLMZ5O8bI1ote3caUx4Rdo9E/4GeixVsKWC7qoS7Ce7QK7ueu307
         d3x8WKSsANhng7QfekxxPoIyV+KtcWOps62XuHTq1S+kg/8ksZd+dUMy4TPsF7Je+qjo
         kLb4tHUV3dS0fhGXrWRMMT3fkJCpQq3hqmfaeYsggKipwLJlQ4wqxj9V/Fmz1eAhk+US
         7KCBurVMgZNNTSHZjAiXWSBzqDgxmA+UbimGFW6Lf9MzHYxBpdQ7tRlqQXhs6V/kzBKU
         4WAw==
X-Received: by 10.68.204.68 with SMTP id kw4mr11153425pbc.76.1362303649929;
        Sun, 03 Mar 2013 01:40:49 -0800 (PST)
Received: from lanh ([115.74.33.184])
        by mx.google.com with ESMTPS id i10sm18320125pbd.1.2013.03.03.01.40.46
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 03 Mar 2013 01:40:49 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 03 Mar 2013 16:41:54 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217343>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 183aafe..6a3566b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1044,31 +1044,29 @@ void wt_status_get_state(struct wt_status_state=
 *state)
 	strbuf_release(&onto);
 }
=20
-static void wt_status_print_state(struct wt_status *s)
+static void wt_status_print_state(struct wt_status *s,
+				  struct wt_status_state *state)
 {
 	const char *state_color =3D color(WT_STATUS_HEADER, s);
-	struct wt_status_state state;
-
-	wt_status_get_state(&state);
-
-	if (state.merge_in_progress)
-		show_merge_in_progress(s, &state, state_color);
-	else if (state.am_in_progress)
-		show_am_in_progress(s, &state, state_color);
-	else if (state.rebase_in_progress || state.rebase_interactive_in_prog=
ress)
-		show_rebase_in_progress(s, &state, state_color);
-	else if (state.cherry_pick_in_progress)
-		show_cherry_pick_in_progress(s, &state, state_color);
-	if (state.bisect_in_progress)
-		show_bisect_in_progress(s, &state, state_color);
-	free(state.branch);
-	free(state.onto);
+	if (state->merge_in_progress)
+		show_merge_in_progress(s, state, state_color);
+	else if (state->am_in_progress)
+		show_am_in_progress(s, state, state_color);
+	else if (state->rebase_in_progress || state->rebase_interactive_in_pr=
ogress)
+		show_rebase_in_progress(s, state, state_color);
+	else if (state->cherry_pick_in_progress)
+		show_cherry_pick_in_progress(s, state, state_color);
+	if (state->bisect_in_progress)
+		show_bisect_in_progress(s, state, state_color);
 }
=20
 void wt_status_print(struct wt_status *s)
 {
 	const char *branch_color =3D color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color =3D color(WT_STATUS_HEADER, s);
+	struct wt_status_state state;
+
+	wt_status_get_state(&state);
=20
 	if (s->branch) {
 		const char *on_what =3D _("On branch ");
@@ -1087,7 +1085,10 @@ void wt_status_print(struct wt_status *s)
 			wt_status_print_tracking(s);
 	}
=20
-	wt_status_print_state(s);
+	wt_status_print_state(s, &state);
+	free(state.branch);
+	free(state.onto);
+
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"))=
;
--=20
1.8.1.2.536.gf441e6d

From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 02/83] builtin/apply: avoid parameter shadowing 'p_value' global
Date: Sun, 24 Apr 2016 15:33:02 +0200
Message-ID: <1461504863-15946-3-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:34:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKBd-0007do-E8
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbcDXNeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:34:50 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37428 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbcDXNes (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:34:48 -0400
Received: by mail-wm0-f47.google.com with SMTP id n3so90192476wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5wKi7OxB3NzqxjR/9uSe7fEZnpRdh/lPanqYxqZuQzE=;
        b=0TmR2FkHK9RbBjOSDao2creXhxnm8rmC3N4Tpd8x8jkbvVcZEkXhLVMlixkAZrJEUR
         g/dsrpoI1oIF4cNZtugrNXQhTK8P2/M1i97rouRBTXYqJJR1+xwyVBfvUH9fdy9dESno
         MJdtAyQVXPJcZDRhXZ7O0vebIHS1aLH1abFTIQbermOI7t6I6smPtu9KxOWyICKwPmKZ
         5usY1ng93HLadeTHEyg/JMhitAfwm/nSO4Mu5N79hhE7fZT+JvTaivmaOslrPEFgJOoT
         053RNgbPU6r5XvyynfmOu0PwDoQVQFLjIUFZW9d2v9YUzsaoMIEE1UCF26qU5MDwbJr/
         iPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5wKi7OxB3NzqxjR/9uSe7fEZnpRdh/lPanqYxqZuQzE=;
        b=R1GAdvmBdo+Rmzi5pp8O9Qqc/pUPpdZSRDKLRxRFyUi90L8Ik4Taou1rVibgTBTBSo
         1giiRcM2tXasq4mzoMipr+715B+TO3RYrnFM7DwasYlx6yfYSV6waRJof0XEKlwP09vb
         GXLQreqBRqSNUSzRh7VXnhjVdUxzN+28FQuMSEkelhQFJeqMM/dyiktVDDpt/rrUkFtE
         81PkBUPGT4Pm4NSntZR54Knq57Z0VLISOLWxHB/r02hvbqo8PcoJHq3ctuYHb3o/1eFU
         5WHfTEbpVJGYpQ++ZLaR6IkFyech+XVMZR20Ys4Y27B5Nt2+GKzcV0ijdundCk2joZ4+
         h5Rw==
X-Gm-Message-State: AOPr4FV/BQtOLpJF2lv7KGbkyyI8bPGg9wMHB5lRrvuf54xMeZhb/ozKYRUxREGmyFO24Q==
X-Received: by 10.194.59.108 with SMTP id y12mr28305722wjq.63.1461504886545;
        Sun, 24 Apr 2016 06:34:46 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:34:45 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292325>

Let's just rename the global 'state_p_value' as it will become
'state->p_value' in a following patch.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index fe5aebd..e133b38 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -35,7 +35,7 @@ static int prefix_length = -1;
 static int newfd = -1;
 
 static int unidiff_zero;
-static int p_value = 1;
+static int state_p_value = 1;
 static int p_value_known;
 static int check_index;
 static int update_index;
@@ -872,24 +872,24 @@ static void parse_traditional_patch(const char *first, const char *second, struc
 		q = guess_p_value(second);
 		if (p < 0) p = q;
 		if (0 <= p && p == q) {
-			p_value = p;
+			state_p_value = p;
 			p_value_known = 1;
 		}
 	}
 	if (is_dev_null(first)) {
 		patch->is_new = 1;
 		patch->is_delete = 0;
-		name = find_name_traditional(second, NULL, p_value);
+		name = find_name_traditional(second, NULL, state_p_value);
 		patch->new_name = name;
 	} else if (is_dev_null(second)) {
 		patch->is_new = 0;
 		patch->is_delete = 1;
-		name = find_name_traditional(first, NULL, p_value);
+		name = find_name_traditional(first, NULL, state_p_value);
 		patch->old_name = name;
 	} else {
 		char *first_name;
-		first_name = find_name_traditional(first, NULL, p_value);
-		name = find_name_traditional(second, first_name, p_value);
+		first_name = find_name_traditional(first, NULL, state_p_value);
+		name = find_name_traditional(second, first_name, state_p_value);
 		free(first_name);
 		if (has_epoch_timestamp(first)) {
 			patch->is_new = 1;
@@ -928,7 +928,7 @@ static int gitdiff_hdrend(const char *line, struct patch *patch)
 static void gitdiff_verify_name(const char *line, int isnull, char **name, int side)
 {
 	if (!*name && !isnull) {
-		*name = find_name(line, NULL, p_value, TERM_TAB);
+		*name = find_name(line, NULL, state_p_value, TERM_TAB);
 		return;
 	}
 
@@ -938,7 +938,7 @@ static void gitdiff_verify_name(const char *line, int isnull, char **name, int s
 		if (isnull)
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
 			    *name, linenr);
-		another = find_name(line, NULL, p_value, TERM_TAB);
+		another = find_name(line, NULL, state_p_value, TERM_TAB);
 		if (!another || memcmp(another, *name, len + 1))
 			die((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
@@ -997,7 +997,7 @@ static int gitdiff_copysrc(const char *line, struct patch *patch)
 {
 	patch->is_copy = 1;
 	free(patch->old_name);
-	patch->old_name = find_name(line, NULL, p_value ? p_value - 1 : 0, 0);
+	patch->old_name = find_name(line, NULL, state_p_value ? state_p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1005,7 +1005,7 @@ static int gitdiff_copydst(const char *line, struct patch *patch)
 {
 	patch->is_copy = 1;
 	free(patch->new_name);
-	patch->new_name = find_name(line, NULL, p_value ? p_value - 1 : 0, 0);
+	patch->new_name = find_name(line, NULL, state_p_value ? state_p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1013,7 +1013,7 @@ static int gitdiff_renamesrc(const char *line, struct patch *patch)
 {
 	patch->is_rename = 1;
 	free(patch->old_name);
-	patch->old_name = find_name(line, NULL, p_value ? p_value - 1 : 0, 0);
+	patch->old_name = find_name(line, NULL, state_p_value ? state_p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1021,7 +1021,7 @@ static int gitdiff_renamedst(const char *line, struct patch *patch)
 {
 	patch->is_rename = 1;
 	free(patch->new_name);
-	patch->new_name = find_name(line, NULL, p_value ? p_value - 1 : 0, 0);
+	patch->new_name = find_name(line, NULL, state_p_value ? state_p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1092,10 +1092,10 @@ static const char *skip_tree_prefix(const char *line, int llen)
 	int nslash;
 	int i;
 
-	if (!p_value)
+	if (!state_p_value)
 		return (llen && line[0] == '/') ? NULL : line;
 
-	nslash = p_value;
+	nslash = state_p_value;
 	for (i = 0; i < llen; i++) {
 		int ch = line[i];
 		if (ch == '/' && --nslash <= 0)
@@ -1481,8 +1481,8 @@ static int find_header(const char *line, unsigned long size, int *hdrsize, struc
 					       "%d leading pathname component (line %d)",
 					       "git diff header lacks filename information when removing "
 					       "%d leading pathname components (line %d)",
-					       p_value),
-					    p_value, linenr);
+					       state_p_value),
+					    state_p_value, linenr);
 				patch->old_name = xstrdup(patch->def_name);
 				patch->new_name = xstrdup(patch->def_name);
 			}
@@ -4461,7 +4461,7 @@ static int option_parse_include(const struct option *opt,
 static int option_parse_p(const struct option *opt,
 			  const char *arg, int unset)
 {
-	p_value = atoi(arg);
+	state_p_value = atoi(arg);
 	p_value_known = 1;
 	return 0;
 }
-- 
2.8.1.300.g5fed0c0

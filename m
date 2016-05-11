From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 25/94] builtin/apply: move 'line_termination' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:36 +0200
Message-ID: <20160511131745.2914-26-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:19:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3D-0002jQ-TM
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbcEKNT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32791 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbcEKNTS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id r12so9408017wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qmKbmfiq5ERX+mM35dpicvKcHZ/Qcsj9/YQbyqDzM/g=;
        b=RbjZwneOJmNrlFhMru2Vuu8fyDHRV7OPErLBKwylutv18aWCqjO6UqTH32wTK+p01n
         q+u2XMZ54GzDjg1cEb4ACdnWX0AVr+vBQPMu3TNWm1yQJGpFTcJbSR6iQShUWdurF1VP
         xq4rzhSTInYY8qc6NkSQAoiuFzdifSQpTjvHLOX3S/cD3cKOq2aOj5ebi9SGaxjZDK/B
         wok8ZR+4RLE7gX/DuCWB0ODRE4oZHU2iWAGDXAjLmdaXJKY2syygyqVY1+EE5svaVP44
         tq+feVeW0+YnGKHoVaIsZnGZ5Cmi4Iq+9uHoyQN4hPXuHbqCTtsIZRHafHOCjXga3P3O
         0law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qmKbmfiq5ERX+mM35dpicvKcHZ/Qcsj9/YQbyqDzM/g=;
        b=Kg9ON9lBDFbMbVzwXN/HerV4CGfYkKMMCnSDItFi542ynOntj04nvcCa/YMVJf2IKF
         WxtVjhg9RCeX7E/8JRNNCbH3XmiX6JrCnbnIP+a21bQITTC6/HmuAcjxGkUYNb0ZgV3s
         q/RVGiiiPnsiTRRvQumXVWVhgfgZCtePXZ69zZz23/dX5wA3xg254NdboQxUDqGmp+ro
         Et/i30B5h5LuNN7E2Qv2XxZZAbSvNibAZhsQFoQRYuyhWIPBRwv2Dq30u1YR6MCji1Xl
         0sWOXY/hAivAxsLdCZfJ4TdRq5oE+vt8meB1iUtWPdkD9phPiSUHGlEH117Ms2SU+sr+
         l7Og==
X-Gm-Message-State: AOPr4FUVHP74QiZQpIJS3NkGzah10DzuKTVrIAU2ItQD2uvPE3PEBD24PKLQUYTHApa3/Q==
X-Received: by 10.28.62.15 with SMTP id l15mr81766wma.30.1462972756752;
        Wed, 11 May 2016 06:19:16 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:15 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294262>

To libify the apply functionality the 'line_termination' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 9209af4..d699d1e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -55,6 +55,7 @@ struct apply_state {
 	int unidiff_zero;
 	int update_index;
 	int unsafe_paths;
+	int line_termination;
 };
 
 /*
@@ -66,7 +67,6 @@ static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
 static const char *fake_ancestor;
-static int line_termination = '\n';
 static unsigned int p_context = UINT_MAX;
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
@@ -3987,7 +3987,8 @@ static void stat_patch_list(struct patch *patch)
 	print_stat_summary(stdout, files, adds, dels);
 }
 
-static void numstat_patch_list(struct patch *patch)
+static void numstat_patch_list(struct apply_state *state,
+			       struct patch *patch)
 {
 	for ( ; patch; patch = patch->next) {
 		const char *name;
@@ -3996,7 +3997,7 @@ static void numstat_patch_list(struct patch *patch)
 			printf("-\t-\t");
 		else
 			printf("%d\t%d\t", patch->lines_added, patch->lines_deleted);
-		write_name_quoted(name, stdout, line_termination);
+		write_name_quoted(name, stdout, state->line_termination);
 	}
 }
 
@@ -4500,7 +4501,7 @@ static int apply_patch(struct apply_state *state,
 		stat_patch_list(list);
 
 	if (state->numstat)
-		numstat_patch_list(list);
+		numstat_patch_list(state, list);
 
 	if (state->summary)
 		summary_patch_list(list);
@@ -4575,6 +4576,7 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
 	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
+	state->line_termination = '\n';
 
 	git_apply_config();
 	if (apply_default_whitespace)
@@ -4630,7 +4632,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
 		/* Think twice before adding "--nul" synonym to this */
-		OPT_SET_INT('z', NULL, &line_termination,
+		OPT_SET_INT('z', NULL, &state.line_termination,
 			N_("paths are separated with NUL character"), '\0'),
 		OPT_INTEGER('C', NULL, &p_context,
 				N_("ensure at least <n> lines of context match")),
-- 
2.8.2.490.g3dabe57

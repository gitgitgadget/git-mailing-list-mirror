From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 23/83] builtin/apply: move 'line_termination' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:23 +0200
Message-ID: <1461504863-15946-24-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:35:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKCF-0007z6-Bd
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbcDXNfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:21 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37610 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbcDXNfS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:18 -0400
Received: by mail-wm0-f50.google.com with SMTP id n3so90204168wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q/PjLvX/aV3OKahrkO3hbyT6knqGnk++VWID8Rg6iAw=;
        b=ICzbeRUJgnFKsk7j9M5OrZKoFaZY5tDv+sdsuFr/YVBoPSRo8Iurr7msTN1tbvFiEg
         TUcKwgSN1f38sKluRgnrZ28Migrx5L9XPdRXSfMn++yIFNwn4lW2yPP5nVCwpglsccV+
         bSlk3WrYNbty+CetO22OsWUQPo1lG1WAyCgLyF7uJsuv4dtonEgSwwhFJywpE4WIsXHP
         y6Uw3GPhPrPY3ZDj43HxLonLpkStbv/XUQsnt2QFHZNCfhOYrCLp7nBV9L4VCsrDMdkt
         N2x/L/OIkjJ+q/gFA5Gx1G0zOvkWTxOpOypysCLy4XlB823I1Ukt4aAibOi26emNe7g/
         tchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q/PjLvX/aV3OKahrkO3hbyT6knqGnk++VWID8Rg6iAw=;
        b=m2wrkwdxsowVyr+9FZIfXE8zwdDoyQZelXxkEqePXozxf+ChpB4YHZ3yxYKaDleeS+
         GaZIv+zJEadMl6pcCYIqwB0GbL7N1TCnmVZDW9uxUFk8/Pw1mIuWUKvX6lhokCPiiV65
         W8aKyUxdBFih6JWFCH+7ICLNXzHYUO6/lD5OVt17eT+AQLYcvpOI909aVPqspIlfVOsW
         UAs9rIleDPkxiMKIzxfO2erkNzsrUkRvsCSAZwgRjmzfCXs2dBRzkj8AKJNuO8uWkPO3
         hVxqPHcYmejjEfsYWcl21/fu+5qIJdIDwpFAG/cI8/uqtotm48U6TUnDfTueHlGWzhk1
         GeNQ==
X-Gm-Message-State: AOPr4FWuFLwCoVt+oFKPGacrU0KgLoXXUrJXAAxxW81pDYsnT1BjWk36j8uv1/B2lWMORQ==
X-Received: by 10.28.236.88 with SMTP id k85mr7193963wmh.53.1461504917483;
        Sun, 24 Apr 2016 06:35:17 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:16 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292336>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c45e481..228595d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -59,6 +59,8 @@ struct apply_state {
 	int update_index;
 
 	int unsafe_paths;
+
+	int line_termination;
 };
 
 /*
@@ -70,7 +72,6 @@ static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
 static const char *fake_ancestor;
-static int line_termination = '\n';
 static unsigned int p_context = UINT_MAX;
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
@@ -3993,7 +3994,8 @@ static void stat_patch_list(struct patch *patch)
 	print_stat_summary(stdout, files, adds, dels);
 }
 
-static void numstat_patch_list(struct patch *patch)
+static void numstat_patch_list(struct apply_state *state,
+			       struct patch *patch)
 {
 	for ( ; patch; patch = patch->next) {
 		const char *name;
@@ -4002,7 +4004,7 @@ static void numstat_patch_list(struct patch *patch)
 			printf("-\t-\t");
 		else
 			printf("%d\t%d\t", patch->lines_added, patch->lines_deleted);
-		write_name_quoted(name, stdout, line_termination);
+		write_name_quoted(name, stdout, state->line_termination);
 	}
 }
 
@@ -4506,7 +4508,7 @@ static int apply_patch(struct apply_state *state,
 		stat_patch_list(list);
 
 	if (state->numstat)
-		numstat_patch_list(list);
+		numstat_patch_list(state, list);
 
 	if (state->summary)
 		summary_patch_list(list);
@@ -4622,7 +4624,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
 		/* Think twice before adding "--nul" synonym to this */
-		OPT_SET_INT('z', NULL, &line_termination,
+		OPT_SET_INT('z', NULL, &state.line_termination,
 			N_("paths are separated with NUL character"), '\0'),
 		OPT_INTEGER('C', NULL, &p_context,
 				N_("ensure at least <n> lines of context match")),
@@ -4659,6 +4661,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	memset(&state, 0, sizeof(state));
 	state.prefix = prefix_;
 	state.prefix_length = state.prefix ? strlen(state.prefix) : 0;
+	state.line_termination = '\n';
 
 	git_apply_config();
 	if (apply_default_whitespace)
-- 
2.8.1.300.g5fed0c0

From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 23/48] builtin/apply: move 'line_termination' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:51 +0100
Message-ID: <1457545756-20616-24-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:53:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiIO-0008AZ-RG
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933734AbcCIRxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:12 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33204 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933710AbcCIRxB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:01 -0500
Received: by mail-wm0-f46.google.com with SMTP id l68so203680722wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0cmejiZbswHqG/PNx+IhbsJS8VvBApM6mQRjodbgcjo=;
        b=wvPa5JYUH25v+c/XNHRPSS/uODczKAF//0q6v53AUzCCwxRNcrmjj54UeJA33PTvcD
         Qy7nyn6ghHLnyreIy7YnVJul/gxGU1V3tR2LXYj+fUJy3po+6y8j3KzkTZwiUR1oYuBU
         H+1bQUax9/0+uYNTU4TSJ2GVniD008NiYLBMmoNb8sNNPFZ6dIuXcag+EcVP4QlZioc+
         LCo5JDo+SIZb2BDMcbTV5fs5ly41sQ1W9gM2pVax7QTIvo1m57v03Kp04Oej00iyEL1+
         eGaCR55NfQnJQ/Tt9XQ+SVib8fjRHXpP6pkYWOgs9H9KrI5GiRhTeHVUbmlTbvFIQcBo
         hHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0cmejiZbswHqG/PNx+IhbsJS8VvBApM6mQRjodbgcjo=;
        b=FMA/SZ0ltt7OwYO5sHvGNgCiLm1E/Ve6r1jRUpnF4+AsqvWe9StopZAKAjcdxSN0dI
         LmQ2ao3G/cuuR3oOlPvTYn81rdtdIoQKnQsmLVd3JEM5r+WzLDqbN/sdVd5Pvuczg0Ua
         7eYpQ8wjmODBeNAjE0Iw6MWFa+fuZeRiYk1YfxAcYdE+wTKctxNPEGlaO+BxKF6xA2qZ
         xiTJ8nWGVImvEW9+FEgkgJ99CTJ0bAGHBg0SSze8n5GcDKtqW8CZNDnqQzV6O0AsOmIa
         ypBNLQYt1vS8f+5cOCDVTaulrA6jn0qckjjpUcrewd70Gqmp2bIVcuP3gxCGV5l7MhV/
         sgHA==
X-Gm-Message-State: AD7BkJLwys19C2RkqLJsueDpisuW+ZUjRVH89NcZgiDoVTbX+hwgbUx7RdUKdXRDzbmUCA==
X-Received: by 10.194.186.170 with SMTP id fl10mr42240729wjc.29.1457545980360;
        Wed, 09 Mar 2016 09:53:00 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:59 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288512>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 0c2fa2e..cc90773 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -60,6 +60,8 @@ struct apply_state {
 	int update_index;
 
 	int unsafe_paths;
+
+	int line_termination;
 };
 
 /*
@@ -70,7 +72,6 @@ static int p_value = 1;
 static int p_value_known;
 static int apply = 1;
 static const char *fake_ancestor;
-static int line_termination = '\n';
 static unsigned int p_context = UINT_MAX;
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
@@ -3995,7 +3996,8 @@ static void stat_patch_list(struct patch *patch)
 	print_stat_summary(stdout, files, adds, dels);
 }
 
-static void numstat_patch_list(struct patch *patch)
+static void numstat_patch_list(struct apply_state *state,
+			       struct patch *patch)
 {
 	for ( ; patch; patch = patch->next) {
 		const char *name;
@@ -4004,7 +4006,7 @@ static void numstat_patch_list(struct patch *patch)
 			printf("-\t-\t");
 		else
 			printf("%d\t%d\t", patch->lines_added, patch->lines_deleted);
-		write_name_quoted(name, stdout, line_termination);
+		write_name_quoted(name, stdout, state->line_termination);
 	}
 }
 
@@ -4504,7 +4506,7 @@ static int apply_patch(struct apply_state *state,
 		stat_patch_list(list);
 
 	if (state->numstat)
-		numstat_patch_list(list);
+		numstat_patch_list(state, list);
 
 	if (state->summary)
 		summary_patch_list(list);
@@ -4620,7 +4622,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
 		/* Think twice before adding "--nul" synonym to this */
-		OPT_SET_INT('z', NULL, &line_termination,
+		OPT_SET_INT('z', NULL, &state.line_termination,
 			N_("paths are separated with NUL character"), '\0'),
 		OPT_INTEGER('C', NULL, &p_context,
 				N_("ensure at least <n> lines of context match")),
@@ -4658,6 +4660,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	state.prefix = prefix_;
 	state.prefix_length = state.prefix ? strlen(state.prefix) : 0;
 	state.newfd = -1;
+	state.line_termination = '\n';
 
 	git_apply_config();
 	if (apply_default_whitespace)
-- 
2.8.0.rc1.49.gca61272

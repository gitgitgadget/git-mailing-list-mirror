From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 19/48] builtin/apply: move 'summary' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:47 +0100
Message-ID: <1457545756-20616-20-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:53:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiID-00080C-MG
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933720AbcCIRw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:57 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35966 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933551AbcCIRwv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:51 -0500
Received: by mail-wm0-f48.google.com with SMTP id n186so190595114wmn.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PIJLzb1a3OIyaszq2SOhd4fqqAY5flka2QZ/KV2dBm0=;
        b=gr3yGmG9DVb1nSfnb1QNe4sSKTCMIIF2yxg4PG5wJHybUbKerR7ywGBLwUlV9YRmK/
         35pZpTf0B0Kl/lXYeZzRZri61fx7hsI5Y3WjPkUMAcsb7yKjmmyi6zAO5fNIol8j7jc9
         6V+d4SlLhDEyy0C81XD7hfTpj+xJSIIGpNdTmF/lGWk8ZIoBBrPcKtPCtiXtwznejEEg
         jEHUi9mEwC/KIaJWyLbIAkGnWOp8xjEBw2tXmCnV24zMiy3J/jDlfYmylWLW730JBtLJ
         ZXV3eBVeKA2NmqXRhpIFaM3eaD6HfTd5Wl3mo3NtCkonxzE6+tWsZ4tt1DYZvo6dymXX
         qZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PIJLzb1a3OIyaszq2SOhd4fqqAY5flka2QZ/KV2dBm0=;
        b=gtuBCsFAeYB7rT/GJmpEx95b7FuYfZEq+NCrAeNILdslAWMORC7hVfxJwJnmE+g6VL
         RMaIv2Prcr3Tu8E9CGne8JddUzwW/lJiyRpTqAXpIUttS+6PKp5yy8Jkwz/+ghwvFZ6n
         xkSSll7VdeGLxxhUAH/WcpzSPN3UgreUiih11XY6NQJXYcTPpZbFuXkdyk7ZsqAAX0gM
         UQyuwKMV8UZfYhf/RKG2gypSJ//uQ8AmiY7frqYQzjKtOgZbDorNSFwM/k6BQqvWEnIo
         B4k3W5qw2WbFnawv5Wgxo5xDMNEU7tE1C6DgvQnZZVFG8ufX47cn+FptAfzOsV0D4q0V
         H5rg==
X-Gm-Message-State: AD7BkJLdiIjWeH6OTdLEjWa3JFgGuSkB65g9XFytErQnHniznlcfLhDb4DT60QiZKp23/A==
X-Received: by 10.194.172.3 with SMTP id ay3mr22376741wjc.155.1457545970296;
        Wed, 09 Mar 2016 09:52:50 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:49 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288508>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 0378465..1542dcf 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -40,6 +40,8 @@ struct apply_state {
 	/* --numstat does numeric diffstat, and doesn't actually apply */
 	int numstat;
 
+	int summary;
+
 	/*
 	 *  --check turns on checking that the working tree matches the
 	 *    files that are being modified, but doesn't apply the patch
@@ -60,7 +62,6 @@ struct apply_state {
 
 static int p_value = 1;
 static int p_value_known;
-static int summary;
 static int apply = 1;
 static int no_add;
 static int threeway;
@@ -4502,7 +4503,7 @@ static int apply_patch(struct apply_state *state,
 	if (state->numstat)
 		numstat_patch_list(list);
 
-	if (summary)
+	if (state->summary)
 		summary_patch_list(list);
 
 	free_patch_list(list);
@@ -4599,7 +4600,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		OPT_NOOP_NOARG(0, "binary"),
 		OPT_BOOL(0, "numstat", &state.numstat,
 			N_("show number of added and deleted lines in decimal notation")),
-		OPT_BOOL(0, "summary", &summary,
+		OPT_BOOL(0, "summary", &state.summary,
 			N_("instead of applying the patch, output a summary for the input")),
 		OPT_BOOL(0, "check", &state.check,
 			N_("instead of applying the patch, see if the patch is applicable")),
@@ -4675,7 +4676,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	}
 	if (state.apply_with_reject)
 		apply = state.apply_verbosely = 1;
-	if (!force_apply && (state.diffstat || state.numstat || summary || state.check || fake_ancestor))
+	if (!force_apply && (state.diffstat || state.numstat || state.summary || state.check || fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.0.rc1.49.gca61272

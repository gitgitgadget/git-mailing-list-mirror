From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 24/48] builtin/apply: move 'fake_ancestor' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:52 +0100
Message-ID: <1457545756-20616-25-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:53:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiIS-0008D5-Ez
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933736AbcCIRxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:15 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33239 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933725AbcCIRxE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:04 -0500
Received: by mail-wm0-f54.google.com with SMTP id l68so203682085wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9n5y/P3Im24gUmEJCwpuNcRJKnJoMT2bhhKK5IfOwTw=;
        b=jvY486+KVjN4t/7D/hMDRFhf7vnNCyvaoV5m4qQNrPQcEJ98beJqx6JylxcxCE/PeX
         /XdvPTApZIoqb7YSWhn39dGMmFb/SXMCHdDyRrN/GzWQVN+9IpAeyz5VPGFIQmrQeML3
         Sy9mVZESRaYKn546E4J9LACCtejoQA77Jq5NviZwq8P1eaxayAJsIfhfSyynhrv04ux9
         fMtaZuv/wjPpBxUYoOrL0IKXkY1N/M6q6Gw0MnbZboh6IqXIld3erk9IEmxjb7ZbVPrl
         cefdoQDrpCWhN3lMkr/thOPVqxQnTG0RrfeTgsbQ7xJTEnkNJFLOj+frz+hYKRGir0ZI
         FHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9n5y/P3Im24gUmEJCwpuNcRJKnJoMT2bhhKK5IfOwTw=;
        b=CI+CQIZOOJ60S8VeoGqG6nb9qEMglapTk+qnXs+QnKfgrh9kTQ+GTneDCoXqSg0IHn
         kLVs4iCFxK5QZf1cHOcBLKa33hCzegnnRhR6WHJw1PwHBVZ/lNNeO0hhPx0r5z6NHVjb
         un3+OqwcSYc7xcWVjXoH5NrKl4QovOd+18CurcAWNquB9t/4EL2A7eLCSNuSMbrUvhv0
         eHPo3WC3rMx7AxBKXk5Wl3YyDSTur1mBYSNcu7XKyYuN7RO/4KbT6UPEbqTtKiYxDP3u
         074wFH637RZ1XeYaQXQap9F29Sq/3JJ7jCu4H5q3MiLvJRcw1q2GIbSHpcf8Hvc/D3TS
         MgQw==
X-Gm-Message-State: AD7BkJLabO6UU+GcKoBWkGgOamr/dd+fIz9wUBH6Yava4P52Q6L7VTrYHkPF5/8sOb6yzQ==
X-Received: by 10.194.71.70 with SMTP id s6mr36586822wju.1.1457545982797;
        Wed, 09 Mar 2016 09:53:02 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:01 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288513>

By the way remove comment about '--index-info' that was renamed
'--build-fake-ancestor' in commit 26b28007689d27a921ea90e5a29fc8eb74b0d297
(apply: get rid of --index-info in favor of --build-fake-ancestor,
Sep 17 2007).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index cc90773..5a2f0f4 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -40,6 +40,8 @@ struct apply_state {
 	/* --numstat does numeric diffstat, and doesn't actually apply */
 	int numstat;
 
+	const char *fake_ancestor;
+
 	int summary;
 
 	int threeway;
@@ -64,14 +66,9 @@ struct apply_state {
 	int line_termination;
 };
 
-/*
- *  --index-info shows the old and new index info for paths if available.
- */
-
 static int p_value = 1;
 static int p_value_known;
 static int apply = 1;
-static const char *fake_ancestor;
 static unsigned int p_context = UINT_MAX;
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
@@ -4499,8 +4496,8 @@ static int apply_patch(struct apply_state *state,
 		return 1;
 	}
 
-	if (fake_ancestor)
-		build_fake_ancestor(list, fake_ancestor);
+	if (state->fake_ancestor)
+		build_fake_ancestor(list, state->fake_ancestor);
 
 	if (state->diffstat)
 		stat_patch_list(list);
@@ -4619,7 +4616,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("also apply the patch (use with --stat/--summary/--check)")),
 		OPT_BOOL('3', "3way", &state.threeway,
 			 N_( "attempt three-way merge if a patch does not apply")),
-		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
+		OPT_FILENAME(0, "build-fake-ancestor", &state.fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
 		/* Think twice before adding "--nul" synonym to this */
 		OPT_SET_INT('z', NULL, &state.line_termination,
@@ -4682,7 +4679,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	}
 	if (state.apply_with_reject)
 		apply = state.apply_verbosely = 1;
-	if (!force_apply && (state.diffstat || state.numstat || state.summary || state.check || fake_ancestor))
+	if (!force_apply && (state.diffstat || state.numstat || state.summary || state.check || state.fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.0.rc1.49.gca61272

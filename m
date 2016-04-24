From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 20/83] builtin/apply: move 'threeway' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:20 +0200
Message-ID: <1461504863-15946-21-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:38:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKFS-0001Ek-8H
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbcDXNis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:38:48 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38281 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbcDXNfO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:14 -0400
Received: by mail-wm0-f52.google.com with SMTP id u206so89927814wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZBHOnehDBkAJDZCElDUdnd6mGySbRi2LEJpUYxJbd3s=;
        b=WkhwsinynImpbjEkNxp1kspMyG+y3SEuYHHbLc8LKhPEKStcIrJzxppfrfRpQwQeAI
         7IVUbi9uCWROjIt1jQ/tBTf8pOTHwP2im1qXQOY9134/o7BpOxv1KSnIiOmRmorLnJes
         XUknvyol0a5nthShNk9GCSSZKGvxIGnKqEAKk8R8eml7G6mqdQJffCiSsxDDaC02v9rQ
         hDE8TB5UQp0r3M6WGQ+RlwFncxWLpOnhZ0lsKsv1qelJdhGMhmhPfe4de7eLcxOwfNGJ
         dNPf7ItSd/zT19E95z0CJ96862WINboaIqA/CDWv3Qkg1CUSp6aPHTgaJjf5c54014k9
         pKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZBHOnehDBkAJDZCElDUdnd6mGySbRi2LEJpUYxJbd3s=;
        b=Y578taEshQoSza7HXHQJIHyK/JIPWOPnB5nHQOOy9plLOsre4ApvoHG/bn3Ld99YgG
         k1mHhqbYIqqf7ebFYGGJeaMuFfSrdCvXx/2TGa91xwZk0eqVXqmR5VXVhDoUIAt4Be4m
         kaFudYSs6ZYDqzLyTfYPfyuyu3K0A/RcDJwkaX2Wx/eGx8seCAuceAv+z6lDo2+8a5mx
         LovWdyY0wdmvCc1mRQLoxFLIhduJccjafoKb4NcfZ3p81B/VZkHu9mX5oQv1y3lqQbk9
         hylrcLOw9zdHcCiNVVoQ3vcsyDLp6xm93dJwmqSrQ/C2aukZz3JxHa5Ga1OYSCuzgsEC
         GLeQ==
X-Gm-Message-State: AOPr4FUnoZUmBiIhpnUGFHP4X6xyZW1VhtCK3KYgUIsdgd47gakGC5H/zHecixu+3iTwBQ==
X-Received: by 10.194.48.7 with SMTP id h7mr32848715wjn.81.1461504913378;
        Sun, 24 Apr 2016 06:35:13 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:12 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292393>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e488879..33a1f8f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -41,6 +41,8 @@ struct apply_state {
 
 	int summary;
 
+	int threeway;
+
 	/*
 	 *  --check turns on checking that the working tree matches the
 	 *    files that are being modified, but doesn't apply the patch
@@ -64,7 +66,6 @@ static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
 static int no_add;
-static int threeway;
 static int unsafe_paths;
 static const char *fake_ancestor;
 static int line_termination = '\n';
@@ -3504,7 +3505,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 	if (patch->direct_to_threeway ||
 	    apply_fragments(state, &image, patch) < 0) {
 		/* Note: with --reject, apply_fragments() returns 0 */
-		if (!threeway || try_threeway(state, &image, patch, st, ce) < 0)
+		if (!state->threeway || try_threeway(state, &image, patch, st, ce) < 0)
 			return -1;
 	}
 	patch->result = image.buf;
@@ -3799,7 +3800,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 	    ((0 < patch->is_new) || patch->is_rename || patch->is_copy)) {
 		int err = check_to_create(state, new_name, ok_if_exists);
 
-		if (err && threeway) {
+		if (err && state->threeway) {
 			patch->direct_to_threeway = 1;
 		} else switch (err) {
 		case 0:
@@ -4614,7 +4615,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("accept a patch that touches outside the working area")),
 		OPT_BOOL(0, "apply", &force_apply,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
-		OPT_BOOL('3', "3way", &threeway,
+		OPT_BOOL('3', "3way", &state.threeway,
 			 N_( "attempt three-way merge if a patch does not apply")),
 		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
@@ -4666,11 +4667,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
 
-	if (state.apply_with_reject && threeway)
+	if (state.apply_with_reject && state.threeway)
 		die("--reject and --3way cannot be used together.");
-	if (state.cached && threeway)
+	if (state.cached && state.threeway)
 		die("--cached and --3way cannot be used together.");
-	if (threeway) {
+	if (state.threeway) {
 		if (is_not_gitdir)
 			die(_("--3way outside a repository"));
 		state.check_index = 1;
-- 
2.8.1.300.g5fed0c0

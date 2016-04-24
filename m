From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 24/83] builtin/apply: move 'fake_ancestor' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:24 +0200
Message-ID: <1461504863-15946-25-git-send-email-chriscool@tuxfamily.org>
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
	id 1auKCF-0007z6-UY
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbcDXNfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:23 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38313 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbcDXNfU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:20 -0400
Received: by mail-wm0-f51.google.com with SMTP id u206so89929844wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7r8HY4X7Nd+BIV/LUxPgYDGRJ4WaOxjGfBqq9X/Aax0=;
        b=bmoIPhPkea+0c0YfrlUoNAUD2Kl0loRJhc0a2/ENA1bOAQHmXcrGQguNHP0akxqb4y
         LBnj7bQznpOeCyaBbUfaR9yhOngMPboo5iQMYy/4PI1lKSKuzaTu61MxDK7t4lnxFCd3
         FAGN7xSepT48giFwyV3vYNLD7nBuBi5mZXVrU+ltO/h6ONqdqXBeUMDM6KLBju1AEy4K
         3ABvIgQcWu2ryhszn/7/VIfbfWvz+tAB1Lhe/3uf+Qoqmfb2BC5xvmHkPuCGuPNckOsB
         19hhhOruqZ0rZq819e1wTOzBMIDPL0xT7LtHLlu08iWbCkULFZqSTilFZhlAO6I4+xiU
         VtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7r8HY4X7Nd+BIV/LUxPgYDGRJ4WaOxjGfBqq9X/Aax0=;
        b=JVSarbcbEDL+ZozlCQoXsgPZsm8TqN4rvg5jXyLdCGvqApzlNIZ7O08dJxUEivHTrA
         HzI2IC14v7JUCAjQVxbAxIL/7P3LvUBc4bXNkH226I/7VbEPa97v5erE/xQXYAYz8kej
         evoEfyQPSC1iZ9IYqQuiZ2Fs7EOPz88riu1/Gjhan1M08hbauZTqbVfbm+vxA0zoEGG4
         FxkZiwWns2vgpWigf3g1X+TxsH2J+5nPp9JbMyrFFw97RXLiV4mthSwnrds02OB1R4AT
         +I0ikcF2UVYot83qCXx8y5RLGz2NZNv2SWsi/TjPqswFpO3Atk/2EIqIiOUjyv28W+Vx
         4T3w==
X-Gm-Message-State: AOPr4FWqPCpv5oCL2pDA0LXX5hcqincQwnXma2Y+dNXSD4B4oRk/Bb8abvnhMcvzihLaZw==
X-Received: by 10.194.62.145 with SMTP id y17mr31686416wjr.109.1461504918668;
        Sun, 24 Apr 2016 06:35:18 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:17 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292335>

By the way remove a comment about '--index-info' that was renamed
'--build-fake-ancestor' in commit 26b28007689d27a921ea90e5a29fc8eb74b0d297
(apply: get rid of --index-info in favor of --build-fake-ancestor,
Sep 17 2007).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 228595d..f69f982 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -39,6 +39,8 @@ struct apply_state {
 	/* --numstat does numeric diffstat, and doesn't actually apply */
 	int numstat;
 
+	const char *fake_ancestor;
+
 	int summary;
 
 	int threeway;
@@ -63,15 +65,11 @@ struct apply_state {
 	int line_termination;
 };
 
-/*
- *  --index-info shows the old and new index info for paths if available.
- */
 static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
-static const char *fake_ancestor;
 static unsigned int p_context = UINT_MAX;
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
@@ -4501,8 +4499,8 @@ static int apply_patch(struct apply_state *state,
 		return 1;
 	}
 
-	if (fake_ancestor)
-		build_fake_ancestor(list, fake_ancestor);
+	if (state->fake_ancestor)
+		build_fake_ancestor(list, state->fake_ancestor);
 
 	if (state->diffstat)
 		stat_patch_list(list);
@@ -4621,7 +4619,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("also apply the patch (use with --stat/--summary/--check)")),
 		OPT_BOOL('3', "3way", &state.threeway,
 			 N_( "attempt three-way merge if a patch does not apply")),
-		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
+		OPT_FILENAME(0, "build-fake-ancestor", &state.fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
 		/* Think twice before adding "--nul" synonym to this */
 		OPT_SET_INT('z', NULL, &state.line_termination,
@@ -4683,7 +4681,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	}
 	if (state.apply_with_reject)
 		apply = state.apply_verbosely = 1;
-	if (!force_apply && (state.diffstat || state.numstat || state.summary || state.check || fake_ancestor))
+	if (!force_apply && (state.diffstat || state.numstat || state.summary || state.check || state.fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.1.300.g5fed0c0

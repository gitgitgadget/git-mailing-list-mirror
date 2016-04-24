From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 17/83] builtin/apply: move 'diffstat' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:17 +0200
Message-ID: <1461504863-15946-18-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:35:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKBx-0007ok-LG
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbcDXNfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:12 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37562 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbcDXNfK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:10 -0400
Received: by mail-wm0-f42.google.com with SMTP id n3so90201113wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gOJ+kRd4Gbchs6Fvm90bg/YjTYUAIP0x470aNyRgMPI=;
        b=L5FWZNWi7weltvc+nrB/rqBFXufo3VFi83DQtkIH3miPUYVtJfQ9ZDGlYSRJhZxNrk
         yw4EC9QdGJEV1PpTxJCUuBgqxiFrMBUOfJAzCEajTNWedUsUFH9VQ/AHHqEcNrnG39aW
         RBGHNDbdcYlzeakIBB4omAbr5K3MylhdNapjySSMnCYXdCsQuN+yXNzBNlrmAgiwBhLA
         TFXKuvun7AuIUR6VfcuKokAOVhKfilcdU8kuHY5A6nAfJtLKS9mRSWIrPvM5yQh1YSfl
         ZizIbdZdBH/yDeYgIFyd3ZqrMFaptDshSJiQkp+wR6cqIgBcCnC7vZOoW4j9AS5EL7uJ
         UX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gOJ+kRd4Gbchs6Fvm90bg/YjTYUAIP0x470aNyRgMPI=;
        b=FoWcvsvDsXO9Vnf/ciwGf1gC6KLY7lCloIASPfKXoK5AvSw9Ibne1LoX6vy6xVpUda
         6yABjZF+slWLCOCpY+e475gKj7hT46eMXvJZhu4YtTd5mJaa2ymc2PQ+BVBYsfh1yQEB
         VKLvb6xqffF0Ypp5dh6wckKu6tms8A5Vby0mPcISiR3P2/Ner8mL8D0VR8zMB912i63x
         FmVsAHqkAuguod6S1urXlfHyZsMvbv8+B9eoIJ1QtoO9NH9K40G3NBqGFVURL2OxlPNl
         8SFyciAmkTLDAaMd65HyO01wAFALju+huy6UwTx7dt2LIUWlNpTOmCH9Z0cdXLAjRJ6n
         r/dg==
X-Gm-Message-State: AOPr4FVvw2sReY8cLn3udzW3NHl7ntvk70OCEaKGRMiVXqwA18plzsLyJseB9RAyqvZ8gg==
X-Received: by 10.28.135.200 with SMTP id j191mr7269991wmd.54.1461504909450;
        Sun, 24 Apr 2016 06:35:09 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:08 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292330>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ba828df..d90948a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -33,6 +33,9 @@ struct apply_state {
 	/* --cached updates only the cache without ever touching the working tree. */
 	int cached;
 
+	/* --stat does just a diffstat, and doesn't actually apply */
+	int diffstat;
+
 	/*
 	 *  --check turns on checking that the working tree matches the
 	 *    files that are being modified, but doesn't apply the patch
@@ -48,7 +51,6 @@ struct apply_state {
 };
 
 /*
- *  --stat does just a diffstat, and doesn't actually apply
  *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
  */
@@ -56,7 +58,6 @@ static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int diffstat;
 static int numstat;
 static int summary;
 static int apply = 1;
@@ -4496,7 +4497,7 @@ static int apply_patch(struct apply_state *state,
 	if (fake_ancestor)
 		build_fake_ancestor(list, fake_ancestor);
 
-	if (diffstat)
+	if (state->diffstat)
 		stat_patch_list(list);
 
 	if (numstat)
@@ -4593,7 +4594,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			0, option_parse_p },
 		OPT_BOOL(0, "no-add", &no_add,
 			N_("ignore additions made by the patch")),
-		OPT_BOOL(0, "stat", &diffstat,
+		OPT_BOOL(0, "stat", &state.diffstat,
 			N_("instead of applying the patch, output diffstat for the input")),
 		OPT_NOOP_NOARG(0, "allow-binary-replacement"),
 		OPT_NOOP_NOARG(0, "binary"),
@@ -4674,7 +4675,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	}
 	if (state.apply_with_reject)
 		apply = state.apply_verbosely = 1;
-	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
+	if (!force_apply && (state.diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.1.300.g5fed0c0

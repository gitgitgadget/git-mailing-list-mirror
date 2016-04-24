From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 62/83] builtin/apply: move check_apply_state() to apply.c
Date: Sun, 24 Apr 2016 15:34:02 +0200
Message-ID: <1461504863-15946-63-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKD7-0008S1-AN
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbcDXNgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:21 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34616 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbcDXNgO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:14 -0400
Received: by mail-wm0-f44.google.com with SMTP id v200so10012154wmv.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qGdhVhVzU6AY5Z7BKcYMdVVHGmqAqjihAkLsUaok5V4=;
        b=o0UzM3HFsckVR0fO9CGUwM4UG+Kz+eSWWeHLFNy88wTNi7keDLuw+I7SJX8G1qraPc
         u6A4u1YiscSzmLQp86M8zDyycNEUwwC3FHTYW9/a6fmtRRXBf3l3IwFpnF1sJlL+CX1n
         aeWZ/I4ZvfRx81qR39u/hw1IOLoyu9ht8cgF2p9YiocJYrmlku3BYehX9EdbHSrauWEY
         3DgT3PwYWyvSEXe5kdpVytKL2G96W2aSHaBJqH/lwm0kulwIjZucWYiZLazIrHcrkA7R
         OuIpRi6F/xU3Ni7PYN8NQFuB6e6iQq8GxHtO5V3FOnMtVA1VEDpeyPdRGLNtSLsNmyN1
         SrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qGdhVhVzU6AY5Z7BKcYMdVVHGmqAqjihAkLsUaok5V4=;
        b=KwTSz/w4dT1LdKkH2UKMHvDg17grtIw9bGDcn14Ye9p7rJn7vmbtu7/SM8slJwkH1u
         qfCUxT5ZPo5QSd20zuLSA9c3E3Zd4IcBNousri6XAbsWdQHDqaYlwf6OvbHt29xPJZ/5
         GdV0rHJRv+5FI+29RUoQS1H04++xxg5K7dNlpa7gkrr+YnRw3GKbSjQlVTnOShWlQHsm
         KEvYUpfIkGp0Ak7Hicvb6Hnlr6w+xXiPtIFzbbnBRC/bA3I07LWQDVaNLX7CQ4lxlbMr
         xLMUD2C1BmOb4BJGK8SPjT4weDunvY3LaV465DiqfWkF64lQMe8K+tYlQVBMGgOknjZw
         iiEw==
X-Gm-Message-State: AOPr4FXepoyMJr7tgmDaC0nnO26c4ZDrLdSNWhHx8x+7oxO3op3ePfr5b4f5v5f8DvcdhQ==
X-Received: by 10.28.181.74 with SMTP id e71mr6616862wmf.38.1461504972961;
        Sun, 24 Apr 2016 06:36:12 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:11 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292356>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c         | 29 +++++++++++++++++++++++++++++
 apply.h         |  2 +-
 builtin/apply.c | 29 -----------------------------
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/apply.c b/apply.c
index 11bec48..b29cc64 100644
--- a/apply.c
+++ b/apply.c
@@ -79,3 +79,32 @@ int init_apply_state(struct apply_state *state, const char *prefix)
 	return 0;
 }
 
+int check_apply_state(struct apply_state *state, int force_apply)
+{
+	int is_not_gitdir = !startup_info->have_repository;
+
+	if (state->apply_with_reject && state->threeway)
+		return error("--reject and --3way cannot be used together.");
+	if (state->cached && state->threeway)
+		return error("--cached and --3way cannot be used together.");
+	if (state->threeway) {
+		if (is_not_gitdir)
+			return error(_("--3way outside a repository"));
+		state->check_index = 1;
+	}
+	if (state->apply_with_reject)
+		state->apply = state->apply_verbosely = 1;
+	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
+		state->apply = 0;
+	if (state->check_index && is_not_gitdir)
+		return error(_("--index outside a repository"));
+	if (state->cached) {
+		if (is_not_gitdir)
+			return error(_("--cached outside a repository"));
+		state->check_index = 1;
+	}
+	if (state->check_index)
+		state->unsafe_paths = 0;
+	return 0;
+}
+
diff --git a/apply.h b/apply.h
index 021e9e3..35d4d15 100644
--- a/apply.h
+++ b/apply.h
@@ -127,6 +127,6 @@ extern int parse_ignorewhitespace_option(struct apply_state *state,
 					 const char *option);
 
 extern int init_apply_state(struct apply_state *state, const char *prefix);
-
+extern int check_apply_state(struct apply_state *state, int force_apply);
 
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index 7576ec5..eab5ae1 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4534,35 +4534,6 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static int check_apply_state(struct apply_state *state, int force_apply)
-{
-	int is_not_gitdir = !startup_info->have_repository;
-
-	if (state->apply_with_reject && state->threeway)
-		return error("--reject and --3way cannot be used together.");
-	if (state->cached && state->threeway)
-		return error("--cached and --3way cannot be used together.");
-	if (state->threeway) {
-		if (is_not_gitdir)
-			return error(_("--3way outside a repository"));
-		state->check_index = 1;
-	}
-	if (state->apply_with_reject)
-		state->apply = state->apply_verbosely = 1;
-	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
-		state->apply = 0;
-	if (state->check_index && is_not_gitdir)
-		return error(_("--index outside a repository"));
-	if (state->cached) {
-		if (is_not_gitdir)
-			return error(_("--cached outside a repository"));
-		state->check_index = 1;
-	}
-	if (state->check_index)
-		state->unsafe_paths = 0;
-	return 0;
-}
-
 static int apply_all_patches(struct apply_state *state,
 			     int argc,
 			     const char **argv,
-- 
2.8.1.300.g5fed0c0

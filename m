From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 11/44] builtin/apply: make check_apply_state() return -1 instead of die()ing
Date: Fri, 10 Jun 2016 22:10:45 +0200
Message-ID: <20160610201118.13813-12-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSoN-0004WW-9H
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbcFJUMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:00 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34158 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138AbcFJUL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:11:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id n184so1054584wmn.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ink4lpxRcw5lgiGe9+xK/yIbrqt/kZVGBgpbuZPzx+A=;
        b=R3i4qksTFPgT3NMtkC8xBd0vSz+uRnF/ztW8YyIGVh3ZkCb69qbQ7BG3maDW5k9CVy
         lArQTqR8q626yv4HhRs2YJLvOZZ0QxKjBgQww0AFViKc0onFvjpCNAMPCjwXrWC+QSK0
         JhDcE+Xe3F+tV2FAcYSc7Qi9cg0peDxYbTUcVBc9CmfWkUK5LcnxO5fdy/kcpYo12Oza
         DKuAAVseeZn5EvIyijaNy5xvDo6GieNRilqMne3jRH4hHxW6vFaAPm+Tij34/kV6XcRm
         3sA9HRwQt2VSbb2SNngJF9OOkHavNdgqe2lrXG0wTzAThqkQKiVZQ/iOwT1xx/ui5Wni
         PW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ink4lpxRcw5lgiGe9+xK/yIbrqt/kZVGBgpbuZPzx+A=;
        b=hfi6n7U8aKYRrfVUx8VijG4ZZkCnecMfsdeoQI3kso83TkHplXGTQTAqLjT24icquv
         DAEspqVzUn8XWFzJsxPiC+htRlB2c2YofBSqjA9zm5Onm3NgA3Aqu9a8a2x90GJM6zYU
         KYqYq8IgdR8eGqneqycxSh1ut6ur9vOzhBpLFrwV2dnAJJxmIvMslulg1XYJtTniYY4R
         So86YoWUjiPJgh6VKJSD5tkl8pdUU5ESLe8xSPYlvjA0/HjlJ08bs61CZsGM83Wij3mz
         l7/CGhUqPbWm6XyljV6vaaoVxRZUcES3wYXrAMu9IUXb42u7l9mGZ2nwsVRgrdyJEE0h
         +11A==
X-Gm-Message-State: ALyK8tKJBmK1CECA6ckV/TmQ1ixf6J9QjywiSmMkWC8ijzS4DXjzAFNi9g55IDcYIKnigQ==
X-Received: by 10.28.22.77 with SMTP id 74mr705123wmw.36.1465589515009;
        Fri, 10 Jun 2016 13:11:55 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:11:54 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297062>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", check_apply_state() should return -1 instead of
calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 2ae1243..d60ffce 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4541,17 +4541,17 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static void check_apply_state(struct apply_state *state, int force_apply)
+static int check_apply_state(struct apply_state *state, int force_apply)
 {
 	int is_not_gitdir = !startup_info->have_repository;
 
 	if (state->apply_with_reject && state->threeway)
-		die("--reject and --3way cannot be used together.");
+		return error("--reject and --3way cannot be used together.");
 	if (state->cached && state->threeway)
-		die("--cached and --3way cannot be used together.");
+		return error("--cached and --3way cannot be used together.");
 	if (state->threeway) {
 		if (is_not_gitdir)
-			die(_("--3way outside a repository"));
+			return error(_("--3way outside a repository"));
 		state->check_index = 1;
 	}
 	if (state->apply_with_reject)
@@ -4559,16 +4559,18 @@ static void check_apply_state(struct apply_state *state, int force_apply)
 	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
 		state->apply = 0;
 	if (state->check_index && is_not_gitdir)
-		die(_("--index outside a repository"));
+		return error(_("--index outside a repository"));
 	if (state->cached) {
 		if (is_not_gitdir)
-			die(_("--cached outside a repository"));
+			return error(_("--cached outside a repository"));
 		state->check_index = 1;
 	}
 	if (state->check_index)
 		state->unsafe_paths = 0;
 	if (!state->lock_file)
-		die("BUG: state->lock_file should not be NULL");
+		return error("BUG: state->lock_file should not be NULL");
+
+	return 0;
 }
 
 static int apply_all_patches(struct apply_state *state,
@@ -4734,7 +4736,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
 
-	check_apply_state(&state, force_apply);
+	if (check_apply_state(&state, force_apply))
+		exit(1);
 
 	ret = apply_all_patches(&state, argc, argv, options);
 
-- 
2.9.0.rc2.362.g3cd93d0

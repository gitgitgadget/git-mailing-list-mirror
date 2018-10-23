Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E78B1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 19:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbeJXD3S (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 23:29:18 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42516 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbeJXD3R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 23:29:17 -0400
Received: by mail-vs1-f65.google.com with SMTP id e126so1575197vsc.9
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7RdQgjGqr6GRmzkGt1gaarS6qqA/xxmaBTO5WaTZrOw=;
        b=Fr5uD10mmyNdAQRYvToMSvetOZRm+ccLLFA3c1S7V3XEqEud4Iq8vJigUKxi99HQxx
         r/sCdkL9Y401DG8LtVxFCZ/ILvvZlJ23nTVI7Azz8IzYq/+93zRxpjgN8E97seLzXWgO
         z8U7YljRA7eHKkUHKZhbFi6WKUXt3/EJ7wpqxoaRo+/MmoSyjXj5sIJvXWtrmafSxqD0
         NDpdJSqGhgf/HqaXKyEAKyNTgzVDpxn7YrYfOKU3soqbe7NdNrahO4/Zp4wMCdHuPI+b
         QIonOl+MS0hPfMb7M1cGsVXbLuAXnX7iRipOMcSzCKV7KxuRi4k1kw5yNEjIJX9HAqgy
         fO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7RdQgjGqr6GRmzkGt1gaarS6qqA/xxmaBTO5WaTZrOw=;
        b=to14J4XqF3JcclBM5CIXMz06c6AGnbJjZI0HznXnGCoX3VGEz+z/LEQbsN5eYCHKBc
         3Bd4BwKYcvirUQGZWrA737I1lUlWJdy3tyVcuZhq+9lshPwR2Moh1Aon0n1COa7K3Ivv
         fWtVj0QhrLlcGhX2yDaLZcpqWOpd8K4HWdstz9ZH6PyneR03A9FI+pNrguAx0GKkSW4+
         5WH49tO0YQCBwlMUWjuyuf2fn5J0MibS3qfgzes9q9M4muvb+MWKp9zu8YgWhXe9JjnI
         CmCHppYrDRS9gm1pRqNAQm3pJm+fR/nz3moBJTohILLoYUV1yij2o56f6uTechUdchAa
         Z1+w==
X-Gm-Message-State: ABuFfogwEXspY4NwLuR1Gv1x7L4hvSPxRrCCL5lIx87wKUeiFDxDOQ7u
        bCZZcK1PNHCAkLg1XMuDIC4XYvkMzcU=
X-Google-Smtp-Source: ACcGV61+bfKUK3n8qq5phiUgttxkH8g2zawhdM6utsGyFQJosJ0xCwQkJ3HVFaDjWY1aJ2zD1jfRMw==
X-Received: by 2002:a67:f04e:: with SMTP id q14mr2172160vsm.173.1540321476553;
        Tue, 23 Oct 2018 12:04:36 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id e79sm473284vsd.1.2018.10.23.12.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:04:35 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, peartben@gmail.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v4 3/3] reset: warn when refresh_index() takes more than 2 seconds
Date:   Tue, 23 Oct 2018 15:04:23 -0400
Message-Id: <20181023190423.5772-4-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181023190423.5772-1-peartben@gmail.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181023190423.5772-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

refresh_index() is done after a reset command as an optimization.  Because
it can be an expensive call, warn the user if it takes more than 2 seconds
and tell them how to avoid it using the --quiet command line option or
reset.quiet config setting.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/config.txt |  4 ++++
 advice.c                 |  2 ++
 advice.h                 |  1 +
 builtin/reset.c          | 14 +++++++++++++-
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a2d1b8b116..415db31def 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -333,6 +333,10 @@ advice.*::
 	commitBeforeMerge::
 		Advice shown when linkgit:git-merge[1] refuses to
 		merge to avoid overwriting local changes.
+	resetQuiet::
+		Advice to consider using the `--quiet` option to linkgit:git-reset[1]
+		when the command takes more than 2 seconds to enumerate unstaged
+		changes after reset.
 	resolveConflict::
 		Advice shown by various commands when conflicts
 		prevent the operation from being performed.
diff --git a/advice.c b/advice.c
index 3561cd64e9..5f35656409 100644
--- a/advice.c
+++ b/advice.c
@@ -12,6 +12,7 @@ int advice_push_needs_force = 1;
 int advice_status_hints = 1;
 int advice_status_u_option = 1;
 int advice_commit_before_merge = 1;
+int advice_reset_quiet_warning = 1;
 int advice_resolve_conflict = 1;
 int advice_implicit_identity = 1;
 int advice_detached_head = 1;
@@ -65,6 +66,7 @@ static struct {
 	{ "statusHints", &advice_status_hints },
 	{ "statusUoption", &advice_status_u_option },
 	{ "commitBeforeMerge", &advice_commit_before_merge },
+	{ "resetQuiet", &advice_reset_quiet_warning },
 	{ "resolveConflict", &advice_resolve_conflict },
 	{ "implicitIdentity", &advice_implicit_identity },
 	{ "detachedHead", &advice_detached_head },
diff --git a/advice.h b/advice.h
index ab24df0fd0..696bf0e7d2 100644
--- a/advice.h
+++ b/advice.h
@@ -12,6 +12,7 @@ extern int advice_push_needs_force;
 extern int advice_status_hints;
 extern int advice_status_u_option;
 extern int advice_commit_before_merge;
+extern int advice_reset_quiet_warning;
 extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
 extern int advice_detached_head;
diff --git a/builtin/reset.c b/builtin/reset.c
index 3b43aee544..b31a0eae8a 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -25,6 +25,8 @@
 #include "submodule.h"
 #include "submodule-config.h"
 
+#define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
+
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
 	N_("git reset [-q] [<tree-ish>] [--] <paths>..."),
@@ -376,9 +378,19 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
 				return 1;
-			if (!quiet && get_git_work_tree())
+			if (!quiet && get_git_work_tree()) {
+				uint64_t t_begin, t_delta_in_ms;
+
+				t_begin = getnanotime();
 				refresh_index(&the_index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
+				t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
+				if (advice_reset_quiet_warning && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
+					printf(_("\nIt took %.2f seconds to enumerate unstaged changes after reset.  You can\n"
+						"use '--quiet' to avoid this.  Set the config setting reset.quiet to true\n"
+						"to make this the default.\n"), t_delta_in_ms / 1000.0);
+				}
+			}
 		} else {
 			int err = reset_index(&oid, reset_type, quiet);
 			if (reset_type == KEEP && !err)
-- 
2.18.0.windows.1


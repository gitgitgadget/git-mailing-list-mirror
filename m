Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F03C11D05
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 14:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9DD206E2
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 14:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6joEyGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgBTOP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:15:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51225 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTOP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 09:15:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id t23so2176419wmi.1
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 06:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LbDNoMGWO1PgF1MKJSZ+f7ov0mSDUOuG6Jlbh2q87CI=;
        b=h6joEyGA3Abr6OQGeqYMcaj8X+lhILk+dYzgAPzS48dola4gyG4IlgyZ3rSllWYZnu
         WGpwoFHcqpnMT7FZWqxkrJEVvrvRXNu3vIG6JjijjTFd/5ckHnvfWhyVpRwDDYgDEmo2
         Bya1mpzcT/VhXi8OjQxG0bhHBOjpeiFWq9uuXHUUCC3YY9RqhJafNl9aU3w5C2k2bPWK
         pghss2nJzs9l0uwQQueL52iQgmBgy2Td4/d+rC1GULf0Ke10uQr5oO1hSyHGyItNfCjP
         D8kQwD+BUZDmWunF43KuYWNDzEycEAyk3dbaKKi2gPEiH0U+JmkrNdaqS7roAC7BnqYt
         WwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LbDNoMGWO1PgF1MKJSZ+f7ov0mSDUOuG6Jlbh2q87CI=;
        b=HnnHdoYB0aJXJ6YzIuQ+OyhYy6jdmu3w3raTTgaweG7gZGRhRQEwFO+Oynh1hCVAtx
         Usf3EDfRfjCSeXT+uiWcOTvLYbTds/gZzsaymstC88EPeiQ4/1n91l8IxjIi1ZcEGDcX
         0lpEdjBPfWPYecXRV8IjDLZ/jW5xv8VIRu/bsXm++Of4KrJNs2nCEV9z5W0JM819Qol/
         pnyVO2e2BIYjzcaUQpXkm70KOXLBElzHJ+qHWUGz1ZicBjOigX5bKlKTIqhD519EwixI
         m6asQLcgX3JvwHv9XigXtsJFz+4O3++QopAnD+4vUXzaobjTMvjvV9wuCBhEkGE6GHzO
         be8A==
X-Gm-Message-State: APjAAAWkfoGDE1h1jSgKHOsQhxusXuYav99Mxzb7csZJlb+xmdy34pYA
        dLP5igmgN1yRGof2ZJQD9lMz3aUg
X-Google-Smtp-Source: APXvYqxUJVGpvx9UYdxs5dkzDoiNgrLH5onWSNj+zyspOg385N+NgnQzbvw5pecDpwyCB5XhroVY0A==
X-Received: by 2002:a1c:960c:: with SMTP id y12mr4817375wmd.9.1582208124601;
        Thu, 20 Feb 2020 06:15:24 -0800 (PST)
Received: from donizetti.redhat.com (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id v15sm4933614wrf.7.2020.02.20.06.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 06:15:23 -0800 (PST)
From:   pbonzini@redhat.com
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com
Subject: [PATCH v2 3/5] am: convert "resume" variable to a struct
Date:   Thu, 20 Feb 2020 15:15:17 +0100
Message-Id: <20200220141519.28315-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220141519.28315-1-pbonzini@redhat.com>
References: <20200220141519.28315-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

This will allow stashing the submode of --show-current-patch from a
callback function.  Using a struct will allow accessing both fields from
outside cmd_am (through container_of).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
v1->v2: - fix spacing in designated initializer [Junio]

 builtin/am.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 8181c2aef3..bd3cda8bec 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2118,7 +2118,7 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 	return 0;
 }
 
-enum resume_mode {
+enum resume_type {
 	RESUME_FALSE = 0,
 	RESUME_APPLY,
 	RESUME_RESOLVED,
@@ -2128,6 +2128,10 @@ enum resume_mode {
 	RESUME_SHOW_PATCH
 };
 
+struct resume_mode {
+	enum resume_type mode;
+};
+
 static int git_am_config(const char *k, const char *v, void *cb)
 {
 	int status;
@@ -2145,7 +2149,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	int binary = -1;
 	int keep_cr = -1;
 	int patch_format = PATCH_FORMAT_UNKNOWN;
-	enum resume_mode resume = RESUME_FALSE;
+	struct resume_mode resume = { .mode = RESUME_FALSE };
 	int in_progress;
 	int ret = 0;
 
@@ -2214,22 +2218,22 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG),
 		OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
 			N_("override error message when patch failure occurs")),
-		OPT_CMDMODE(0, "continue", &resume,
+		OPT_CMDMODE(0, "continue", &resume.mode,
 			N_("continue applying patches after resolving a conflict"),
 			RESUME_RESOLVED),
-		OPT_CMDMODE('r', "resolved", &resume,
+		OPT_CMDMODE('r', "resolved", &resume.mode,
 			N_("synonyms for --continue"),
 			RESUME_RESOLVED),
-		OPT_CMDMODE(0, "skip", &resume,
+		OPT_CMDMODE(0, "skip", &resume.mode,
 			N_("skip the current patch"),
 			RESUME_SKIP),
-		OPT_CMDMODE(0, "abort", &resume,
+		OPT_CMDMODE(0, "abort", &resume.mode,
 			N_("restore the original branch and abort the patching operation."),
 			RESUME_ABORT),
-		OPT_CMDMODE(0, "quit", &resume,
+		OPT_CMDMODE(0, "quit", &resume.mode,
 			N_("abort the patching operation but keep HEAD where it is."),
 			RESUME_QUIT),
-		OPT_CMDMODE(0, "show-current-patch", &resume,
+		OPT_CMDMODE(0, "show-current-patch", &resume.mode,
 			N_("show the patch being applied."),
 			RESUME_SHOW_PATCH),
 		OPT_BOOL(0, "committer-date-is-author-date",
@@ -2281,12 +2285,12 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		 *    intend to feed us a patch but wanted to continue
 		 *    unattended.
 		 */
-		if (argc || (resume == RESUME_FALSE && !isatty(0)))
+		if (argc || (resume.mode == RESUME_FALSE && !isatty(0)))
 			die(_("previous rebase directory %s still exists but mbox given."),
 				state.dir);
 
-		if (resume == RESUME_FALSE)
-			resume = RESUME_APPLY;
+		if (resume.mode == RESUME_FALSE)
+			resume.mode = RESUME_APPLY;
 
 		if (state.signoff == SIGNOFF_EXPLICIT)
 			am_append_signoff(&state);
@@ -2300,7 +2304,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		 * stray directories.
 		 */
 		if (file_exists(state.dir) && !state.rebasing) {
-			if (resume == RESUME_ABORT || resume == RESUME_QUIT) {
+			if (resume.mode == RESUME_ABORT || resume.mode == RESUME_QUIT) {
 				am_destroy(&state);
 				am_state_release(&state);
 				return 0;
@@ -2311,7 +2315,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 				state.dir);
 		}
 
-		if (resume)
+		if (resume.mode)
 			die(_("Resolve operation not in progress, we are not resuming."));
 
 		for (i = 0; i < argc; i++) {
@@ -2329,7 +2333,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		argv_array_clear(&paths);
 	}
 
-	switch (resume) {
+	switch (resume.mode) {
 	case RESUME_FALSE:
 		am_run(&state, 0);
 		break;
-- 
2.21.1



Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85592C34050
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DECD2464E
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu18vTy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgBSQOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:14:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32901 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBSQOF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 11:14:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so1267641wrt.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 08:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1HeNBGTCHLBFXDlEWBx2/w5BRA6WwEkqzTU7qxxx2Nk=;
        b=hu18vTy1myVTXoLIN6mfAtsLZk/DGbYt8n5OUKGH93iPuNFyYUzrs6U7EmD+KDKdjZ
         cwKxlUkkZfjH3cOlJ1WQbPv7IBaWaM+U047lSyTvmfGuIT1awdK7P4XEPgpJ8I5mIjkA
         OGpmVdh1GAedfBk8mXbE2YTz2J5z5anlmN6jQMKTz086Pf1FZFfNn0p1GOUYa0nZtWdu
         aVWZlGWCij2BjDwszlZQy16YOWueQIkph+AjD7Sehavu7DbvqNQiFUtLhGdhrziQyPUA
         jwA65adKyKgISaTKAEk3C7WdeK42bdXFgDD6hDCN+ZCj1oOAHzrp9lef+S3gq75SlBxd
         qaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1HeNBGTCHLBFXDlEWBx2/w5BRA6WwEkqzTU7qxxx2Nk=;
        b=U9nT232mKfww7rGPxELlHd+9rdTNK6FoxDbmzbnaj0OsCygHqGxohXpEcQi1QXYFbS
         9G/RZ4YiBiaVrC+huiXQEw3nZCQ8bBngcpGgROIaqSSaDqEiGsFFygcOaoo9+yMrLF4B
         8udZt/XNw7Gs3Y6r90OcaNoyr51csp6pFtmS0rKG03iolSRg+3KMAP9hIgqCWjhoZJ1W
         8lmJXYya7lkBStvDE5gXt+TyvBkDwE2+AXEYYY7LYaQbGVijqIeKuf+6IMb8gd0qZLu5
         KbE7+s4qEJgr0ZKX50Qmlp1NIyfsuulFDKB0MLTf4IN6HlTMlpmPurs766B1UfjJWCZR
         HTuw==
X-Gm-Message-State: APjAAAUWaETruZoUvmfIKfJ0WR1Fg3+6KdhFJrrEXL0sRSoztJYz1vBd
        nlhlyK13pLj3KgilaOdkAxUAhpyo
X-Google-Smtp-Source: APXvYqyYjYvv/JEGtH9dI48LCOjvO/zuhkYL3beHURLufVMHb4dUlJL9kXytxUTIifQ8zfGx6Mg/fA==
X-Received: by 2002:a5d:4052:: with SMTP id w18mr36232897wrp.112.1582128843034;
        Wed, 19 Feb 2020 08:14:03 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
        by smtp.gmail.com with ESMTPSA id w7sm376771wmi.9.2020.02.19.08.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 08:14:02 -0800 (PST)
From:   pbonzini@redhat.com
To:     git@vger.kernel.org
Cc:     bfields@redhat.com
Subject: [PATCH 2/4] am: convert "resume" variable to a struct
Date:   Wed, 19 Feb 2020 17:13:50 +0100
Message-Id: <20200219161352.13562-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200219161352.13562-1-pbonzini@redhat.com>
References: <20200219161352.13562-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

This will allow stashing the submode of --show-current-patch.  Using
a struct will allow accessing both fields from outside cmd_am (through
container_of).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 builtin/am.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 8181c2aef3..a89e1a96ed 100644
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
+	struct resume_mode resume = { . mode = RESUME_FALSE };
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



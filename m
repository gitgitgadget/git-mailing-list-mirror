Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B74C1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 16:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeJTATZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 20:19:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36355 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeJTATZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 20:19:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34-v6so38886904qth.3
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 09:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6D5+K4t8sFxhqIQs+qBh5g4cvApQtN6xL37vXF3JCkk=;
        b=G5bBUPwHB6tVSBdYuo/F4EjPsaaBcF8UHx6QaKKhDRVVTlI9SjCfJ3IIRsdHnTeepH
         QZSJEBTuI5yKcrxTD0V+ZfaNXlHAUbM5MJDan87JX2PCpd9QPSMcApbNSR+Vc04W+eTC
         JdAFEFjSnwQV9n5jL+qf8tcFMHdzlt+wjuekAe1FaBc4s5ZXwDlbLTnxe0C1zxUD3dXZ
         VxLfaeNg9HcolEuxpgPNHoZ1ZrBGZ0A7llkFMI6/QW0MtGbA7MfCv8srkbXze7HiwtDq
         IPH0vW+S1m1X8Z7pmh9GGpjkfiJoghum3kU/HVFdhc/m+LdjexJb54ng5Nrktt6JY26F
         tMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6D5+K4t8sFxhqIQs+qBh5g4cvApQtN6xL37vXF3JCkk=;
        b=mUbtrNyHTtLW+/b4ilt2v+RslXveYgrCg1LBQMeS1maJiSTWgET9k3HoaSGxuokl5V
         eGr7NvcQ7HV1hDeKlTfEKROgnER7vN4U1gmaXdHUHkMCl7HAgC8KxPZJTOcDNce3nXh4
         qLLTffuj4LvcH0ev1b4y08UkNzK2yRLlWcwIRRM45NSnFLMb0ut/c6h67dNdW67wbDIY
         GbWcHCDZceos6Vz8J/x+7ftwV2lYrsBw0YEfW0h/A9g9/glYAGPDyqvPkGwYWGMOIAzF
         04Uiy9fF2X+EyiyqDMWUdClVlYNFPzjzD/N5XsAxmnGrREN/A89cSgDgyXfVcJeADVUx
         5B/Q==
X-Gm-Message-State: ABuFfoh7khlCmHOJE0ghLe94ydGkoa6UfYB4Zvm/du3mi1Q7KGtSxuVN
        RrTGIAVmfE7GaKKdcmdcWDWs+n1us1w=
X-Google-Smtp-Source: ACcGV62GFcGLYg3YerofSsjA0KFhNvxfmJNwSlKZOK11lSXQ10cUPA8lvaDPomxSNXXB1XWq14Z+lA==
X-Received: by 2002:ac8:6784:: with SMTP id b4-v6mr34161982qtp.373.1539965558246;
        Fri, 19 Oct 2018 09:12:38 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id l27-v6sm3666485qkj.79.2018.10.19.09.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 09:12:37 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, peartben@gmail.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v2 0/3] speed up git reset
Date:   Fri, 19 Oct 2018 12:12:25 -0400
Message-Id: <20181019161228.17196-1-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181017164021.15204-1-peartben@gmail.com>
References: <20181017164021.15204-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

This itteration avoids the refresh_index() call completely if 'quiet'.
The advantage of this is that "git refresh" without any pathspec is also
significantly sped up.

Also added a notification if finding unstaged changes after reset takes
longer than 2 seconds to make users aware of the option to speed it up if
they don't need the unstaged changes after reset to be output.

It also renames the new config setting reset.quietDefault to reset.quiet.

Base Ref: 
Web-Diff: https://github.com/benpeart/git/commit/50d3415ef1
Checkout: git fetch https://github.com/benpeart/git reset-refresh-index-v2 && git checkout 50d3415ef1


### Interdiff (v1..v2):

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a5cf4c019b..a2d1b8b116 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2728,11 +2728,8 @@ rerere.enabled::
 	`$GIT_DIR`, e.g. if "rerere" was previously used in the
 	repository.
 
-reset.quietDefault::
-	Sets the default value of the "quiet" option for the reset command.
-	Choosing "quiet" can optimize the performance of the reset command
-	by avoiding the scan of all files in the repo looking for additional
-	unstaged changes. Defaults to false.
+reset.quiet::
+	When set to true, 'git reset' will default to the '--quiet' option.
 
 include::sendemail-config.txt[]
 
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 8610309b55..1d697d9962 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -95,9 +95,7 @@ OPTIONS
 
 -q::
 --quiet::
-	Be quiet, only report errors.  Can optimize the performance of reset
-	by avoiding scaning all files in the repo looking for additional
-	unstaged changes.
+	Be quiet, only report errors.
 
 
 EXAMPLES
diff --git a/builtin/reset.c b/builtin/reset.c
index 7d151d48a0..d95a27d52e 100644
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
@@ -306,7 +308,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_reset_config, NULL);
-	git_config_get_bool("reset.quietDefault", &quiet);
+	git_config_get_bool("reset.quiet", &quiet);
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
@@ -376,9 +378,19 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
 				return 1;
-			if (get_git_work_tree())
-				refresh_index(&the_index, flags, quiet ? &pathspec : NULL, NULL,
+			if (!quiet && get_git_work_tree()) {
+				uint64_t t_begin, t_delta_in_ms;
+
+				t_begin = getnanotime();
+				refresh_index(&the_index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
+				t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
+				if (t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
+					printf(_("\nIt took %.2f seconds to enumerate unstaged changes after reset.  You can\n"
+						"use '--quiet' to avoid this.  Set the config setting reset.quiet to true\n"
+						"to make this the default."), t_delta_in_ms / 1000.0);
+				}
+			}
 		} else {
 			int err = reset_index(&oid, reset_type, quiet);
 			if (reset_type == KEEP && !err)


### Patches

Ben Peart (3):
  reset: don't compute unstaged changes after reset when --quiet
  reset: add new reset.quiet config setting
  reset: warn when refresh_index() takes more than 2 seconds

 Documentation/config.txt |  3 +++
 builtin/reset.c          | 15 ++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)


base-commit: ca63497355222acefcca02b9cbb540a4768f3286
-- 
2.18.0.windows.1



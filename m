Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C0D2208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbeHHR6d (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:58:33 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:37655 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeHHR6d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:58:33 -0400
Received: by mail-ed1-f54.google.com with SMTP id b10-v6so1483082eds.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8capz1jA4oT1K0CUPp0FKV4ZJ9kGvuCDac5lIfN7ZHY=;
        b=euMOrw6ZZyTRvoBHu8B24CpITLeYC2tD8jk5q6u5B2YEgmhh5NG8zV3OpdT+CEOPgQ
         5STNEQUGKyfvcLiEx9sY52065nVmMls/XsGMgVJvdpBrI96wEOQ7L840tfO890G/JPMb
         PQ0lVemVvDLCH94BZPOuefGCQkeHhYlTaA+ecUck6UiW4UqZdeFYMLfyQIQvCubfsMNX
         qdl4M7eJY3cWfuNnVDDa4mC6XUQ3dDjbk6cnrD1RsGpIdczMdoLfCShNM0gzQlGut+Zg
         56fgNpTyuOy4hGDXhtv/suZcIgEmRxraft3bM7dUCfTeeOwJYshyo6hxF7cwjE3wPc3p
         nusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8capz1jA4oT1K0CUPp0FKV4ZJ9kGvuCDac5lIfN7ZHY=;
        b=MlL8c9hXQyhCaP0CrwI4cwQ+7g03cAkR8FOHnzoGh3V440EdNZ/LKsryLLW2eO9nER
         S6SZdAECvZT+418eqJBQyzIzJzgrrJzwWcxQpQdrV9Z3lN1efKo3ttdMnmFM1sf9anYI
         JEW7UxnASqyGR1jDCyIM9LphpyAiJv7nKHr7T193Tmx2xZvJ8esjRVxViVC2ZCLDQ4Pi
         +SIZmtTMdogO+7GBB03jG9bjhz671OFh93gW4pHArvydclkuzvbMn0fKZUt9+X7yI5Aj
         XHtUMMTs04BWD2SGBYmtChwEOi2c5BfFk9PTEuyADdpnWN4/B5ftjFXkA5bcWTUVbM6m
         mI4A==
X-Gm-Message-State: AOUpUlECyovMKY5EuREUS3nurQnFo0MdOETS59la3Sadcvq4m2PTuzdz
        yKsY7rqG2WvaFETGUeWQV8G3h0yb
X-Google-Smtp-Source: AA+uWPyhnqL7lU1GYTJEVQTQvTSgtlI9lCPh2dMUU0qCDahxU4CpHezQiow3gP4ln6NPYoGwz0p8kA==
X-Received: by 2002:a50:9fe9:: with SMTP id c96-v6mr2827927edf.17.1533742699577;
        Wed, 08 Aug 2018 08:38:19 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1904876edo.39.2018.08.08.08.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:38:18 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 1/6] builtin rebase: optionally auto-detect the upstream
Date:   Wed,  8 Aug 2018 21:21:30 +0545
Message-Id: <20180808153635.19944-2-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153635.19944-1-predatoramigo@gmail.com>
References: <20180808153635.19944-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git rebase` command, when called without the `<upstream>`
command-line argument, automatically looks for the upstream
branch configured for the current branch.

With this commit, the builtin rebase learned that trick, too.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 94abaaa890..c5b2534717 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -622,6 +622,36 @@ static int parse_opt_interactive(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static void NORETURN error_on_missing_default_upstream(void)
+{
+	struct branch *current_branch = branch_get(NULL);
+
+	printf(_("%s\n"
+		 "Please specify which branch you want to rebase against.\n"
+		 "See git-rebase(1) for details.\n"
+		 "\n"
+		 "    git rebase '<branch>'\n"
+		 "\n"),
+		current_branch ? _("There is no tracking information for "
+			"the current branch.") :
+			_("You are not currently on a branch."));
+
+	if (current_branch) {
+		const char *remote = current_branch->remote_name;
+
+		if (!remote)
+			remote = _("<remote>");
+
+		printf(_("If you wish to set tracking information for this "
+			 "branch you can do so with:\n"
+			 "\n"
+			 "    git branch --set-upstream-to=%s/<branch> %s\n"
+			 "\n"),
+		       remote, current_branch->name);
+	}
+	exit(1);
+}
+
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options = {
@@ -1056,9 +1086,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!options.root) {
-		if (argc < 1)
-			die("TODO: handle @{upstream}");
-		else {
+		if (argc < 1) {
+			struct branch *branch;
+
+			branch = branch_get(NULL);
+			options.upstream_name = branch_get_upstream(branch,
+								    NULL);
+			if (!options.upstream_name)
+				error_on_missing_default_upstream();
+			if (fork_point < 0)
+				fork_point = 1;
+		} else {
 			options.upstream_name = argv[0];
 			argc--;
 			argv++;
-- 
2.18.0


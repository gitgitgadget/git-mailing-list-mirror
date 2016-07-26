Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6515E203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 15:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675AbcGZP0k (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 11:26:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35648 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980AbcGZP0i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 11:26:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so2214844wmg.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 08:26:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IOU0wWxKVhKRB835WQvymodvCotv1T28XyuKIA6wZS8=;
        b=O+pK0C/85FVZrACvIuf+e2M+8fmlNgAEozofbT+Hf8iRrRmKeudr07CVQHruS1btGp
         b301F5m2jQY+4sdVclE7T6jxh8mj2DfVevXwN2fuvoCbythgdZe5UooTos5WHMGIeGhd
         flNJYaBvnseVv4JL0Q/oOMliAV1cOnkp0fcIOOM3M6gXOM+0/jDEgDue659SndAl+8z5
         5y+tbbqwXe5QMFnRbnWMAMVor1ExcBH9n2GckO8EQh8t0GL2QqTB7AMZjP9BLjxmjL2T
         bHhau/RnP9DzrpwYFYfhzHglatvtmWpzHxz8xzkjegeaEvXEF0lM7C9vzPgRm+AotAmX
         Fcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IOU0wWxKVhKRB835WQvymodvCotv1T28XyuKIA6wZS8=;
        b=Gfcvns63EJatTmxjqtjn/djN429rgV3jvQwSVLCEyqnUvgWwr+VfucpYfqN4GAaOOK
         B9I4WYWNZCPAMg39b3hzwwSNVii3lx8sWTDsBCkobRSeJead8iXxpb6HuGcGXDJl1Ife
         l7YNu2yglC28W5IwfnTyB4tXKBGagLWz8PxP7wE/Wh4/CjaI+E7EjxU/I9fXtbTaF51j
         tpSQGrvM7m5Mg/Tiv3ys6Go+ToIqPbIdpx3Y1hP5iVvyUKqyzIGNjHYaC6aT9WCsyYbw
         qdqV0954Kf2o7rtJBRbEuxJhJtsUcFq80P6f4msMfcC5KWfFFC7eSmTZytq/tDb7Z5XU
         lWbA==
X-Gm-Message-State: AEkoouvo2VMw4lBrQQ2MSRViJCCpOxld6mBrxICAJU+e2wBEFsSEZMHVPWKa3WzS9MwBWQ==
X-Received: by 10.194.221.232 with SMTP id qh8mr21440967wjc.117.1469546791641;
        Tue, 26 Jul 2016 08:26:31 -0700 (PDT)
Received: from localhost.localdomain ([95.86.71.62])
        by smtp.gmail.com with ESMTPSA id us9sm1488005wjb.43.2016.07.26.08.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jul 2016 08:26:30 -0700 (PDT)
From:	orgads@gmail.com
To:	git@vger.kernel.org
Cc:	Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH v2] merge: Run commit-msg hook
Date:	Tue, 26 Jul 2016 18:26:25 +0300
Message-Id: <1469546785-23325-1-git-send-email-orgads@gmail.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <alpine.DEB.2.20.1607261614020.14111>
References: <alpine.DEB.2.20.1607261614020.14111>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

commit-msg is needed to either validate the commit message or edit it.

Gerrit for instance uses this hook to append its Change-Id footer. The
hook is installed on the user's machine, and it is expected to append
the footer for each commit that the user creates.

This is relevant to merge commit just like any other commit. Currently
this hook is only called for simple commits, so Gerrit user that tries
to push a merge commit has to amend it first in order to execute the
hook that appends the footer.

prepare-commit-msg hook is already called on merge, but commit-msg isn't.
It looks like unlike pre-commit not being executed, which was a conscious
decision[1], commit-msg was never considered.

[1] http://thread.gmane.org/gmane.comp.version-control.git/151297/focus=151435

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 Documentation/git-merge.txt | 6 +++++-
 builtin/merge.c             | 7 ++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index b758d55..59508aa 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
 	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
-	[--[no-]allow-unrelated-histories]
+	[--[no-]allow-unrelated-histories] [--no-verify]
 	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
 'git merge' <msg> HEAD <commit>...
 'git merge' --abort
@@ -87,6 +87,10 @@ invocations. The automated message can include the branch description.
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
+--no-verify::
+	This option bypasses the commit-msg hook.
+	See also linkgit:githooks[5].
+
 --abort::
 	Abort the current conflict resolution process, and
 	try to reconstruct the pre-merge state.
diff --git a/builtin/merge.c b/builtin/merge.c
index b555a1b..30c03c8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -51,7 +51,7 @@ static const char * const builtin_merge_usage[] = {
 static int show_diffstat = 1, shortlog_len = -1, squash;
 static int option_commit = 1;
 static int option_edit = -1;
-static int allow_trivial = 1, have_message, verify_signatures;
+static int allow_trivial = 1, have_message, verify_signatures, no_verify;
 static int overwrite_ignore = 1;
 static struct strbuf merge_msg = STRBUF_INIT;
 static struct strategy **use_strategies;
@@ -228,6 +228,7 @@ static struct option builtin_merge_options[] = {
 	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
+	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass commit-msg hook")),
 	OPT_END()
 };
 
@@ -809,6 +810,10 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		if (launch_editor(git_path_merge_msg(), NULL, NULL))
 			abort_commit(remoteheads, NULL);
 	}
+	if (!no_verify &&
+	    run_commit_hook(0 < option_edit, get_index_file(), "commit-msg",
+			    git_path_merge_msg(), NULL))
+		abort_commit(remoteheads, NULL);
 	read_merge_msg(&msg);
 	strbuf_stripspace(&msg, 0 < option_edit);
 	if (!msg.len)
-- 
2.8.1


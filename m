Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0311C20323
	for <e@80x24.org>; Thu, 16 Mar 2017 20:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbdCPUqt (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 16:46:49 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35354 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbdCPUqs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 16:46:48 -0400
Received: by mail-pf0-f180.google.com with SMTP id x63so24182770pfx.2
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 13:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1lRrxIDlSMM9fnEHKADnMl45vtDhxczde65j9eEwR8E=;
        b=q7JcQgUkxKnLudAGmZeBt0YeA70L1Tr2RnyTjtTYhOXyqusCaco+hb4lFsbIYEaaIB
         o9PuKbEbLqBjcYAjy91teSCB4AEXX8TGrbe91A1MiHvLFN80pAaWXW8JHa6LC+dfWLeh
         nXVvKPP+DRZ9WYG0EmHAmSkvrmh6mcsFE2yEBzgDgcjcHNZFmjJ3WBxCe49yMhxxUZTL
         mZP+4OEjd0kiHMZ1hMh8TuUTk2zGOSmTgjVHvlYaabz6ByFQ04erjofsgDxnvLzCIoGc
         MCZVdyUQihHvegN8+5voYjFibfEDPDaR9PI02hE5tsX9ht8HPa4aTuYNqIA/tBD4y7WZ
         UiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1lRrxIDlSMM9fnEHKADnMl45vtDhxczde65j9eEwR8E=;
        b=BK+yrCms/U1T1eQYaR9Q1WTr9sLnKMlikajI8VdyRh0CZ+xKsQLv8WDp2Gq0p+lZad
         1x6tnMgFq/k7LdKKIkRHrzNmFKx3mZjsyo1KGadn9PHNck1qDOaUJdngcG7A7R2zC9Qe
         H/B8EsDfiYdrmpUw1zg0rGXPojJlUzOMQOM7dADUbQryS5m1XKkPixFHBWbjpWs+IFOn
         QysRlQK/ciG6/HmnAvCVsJuuYxQ2UV6Jr4mPP3RRz1Ch9K7i8QigfxuXxgM4xkPmTnI8
         WBuvEAalF7ZFWvOd3H0kmfYeKA3YnAz8yeIcdp/2YbUjuDBFdE10YS1XayOU6ntgnbW8
         StXw==
X-Gm-Message-State: AFeK/H1iiDHPQ8wN63g/JfrKCFeUJeRgLBSssgK9KrR+NqvVxgpFPXrVwj86KzWYgBBE1oIW
X-Received: by 10.84.130.67 with SMTP id 61mr14906868plc.115.1489697206746;
        Thu, 16 Mar 2017 13:46:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:29bb:161:bf0d:8070])
        by smtp.gmail.com with ESMTPSA id x21sm12346858pgf.15.2017.03.16.13.46.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 13:46:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2] short status: improve reporting for submodule changes
Date:   Thu, 16 Mar 2017 13:46:44 -0700
Message-Id: <20170316204644.11616-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.269.g1a05a5734c.dirty
In-Reply-To: <CAGZ79kZ7rWw=q6a2AomTw20DsU1h+7ou4i8A14a2bcg+asRwLA@mail.gmail.com>
References: <CAGZ79kZ7rWw=q6a2AomTw20DsU1h+7ou4i8A14a2bcg+asRwLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While we already have a porcelain2 layer for git-status, that is accurate
for submodules, users still like the way they are are used to of
'status -s'.

As a submodule has more state than a file potentially, we need more letters
indicating these states, we'll go with lower 'm' and single '?' for now.

When there the recorded commit doesn't differ from the submodule HEAD
(which we still want to treat as "M", because that can be dealt with
in the superproject), we can have different types of change in the
submodule. The lower case 'm' indicates that there are changes to tracked
files in the submodule. It signals that the --recurse-submodules option
is needed for e.g. adding or committing these changes. The " ?" also
differentiates an untracked file in the submodule from a regular
untracked file.

While making these changes, we need to make sure to not break porcelain
level 1, which uses the same code as the short printing function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-status.txt |  8 ++++++++
 t/t7506-status-submodule.sh  | 24 ++++++++++++++++++++++++
 wt-status.c                  | 15 +++++++++++++--
 wt-status.h                  |  1 +
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index ba873657cf..b182b16c48 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -181,6 +181,12 @@ in which case `XY` are `!!`.
     !           !    ignored
     -------------------------------------------------
 
+Submodules have more state to it, such that it reports instead:
+		M    the submodule has a different HEAD than recorded
+		m    the submodule has modified content
+		?    the submodule has untracked files
+
+
 If -b is used the short-format status is preceded by a line
 
     ## branchname tracking info
@@ -210,6 +216,8 @@ field from the first filename).  Third, filenames containing special
 characters are not specially formatted; no quoting or
 backslash-escaping is performed.
 
+Any submodule changes are reported as modified `M` instead of `m` or single `?`.
+
 Porcelain Format Version 2
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index d31b34da83..98dff01947 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -50,6 +50,15 @@ test_expect_success 'status with modified file in submodule (porcelain)' '
 	EOF
 '
 
+test_expect_success 'status with modified file in submodule (short)' '
+	(cd sub && git reset --hard) &&
+	echo "changed" >sub/foo &&
+	git status --short >output &&
+	diff output - <<-\EOF
+	 m sub
+	EOF
+'
+
 test_expect_success 'status with added file in submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	git status >output &&
@@ -64,6 +73,14 @@ test_expect_success 'status with added file in submodule (porcelain)' '
 	EOF
 '
 
+test_expect_success 'status with added file in submodule (short)' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	git status --short >output &&
+	diff output - <<-\EOF
+	 m sub
+	EOF
+'
+
 test_expect_success 'status with untracked file in submodule' '
 	(cd sub && git reset --hard) &&
 	echo "content" >sub/new-file &&
@@ -83,6 +100,13 @@ test_expect_success 'status with untracked file in submodule (porcelain)' '
 	EOF
 '
 
+test_expect_success 'status with untracked file in submodule (short)' '
+	git status --short >output &&
+	diff output - <<-\EOF
+	 ? sub
+	EOF
+'
+
 test_expect_success 'status with added and untracked file in submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	echo "content" >sub/new-file &&
diff --git a/wt-status.c b/wt-status.c
index a52d342695..080d97f272 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1664,9 +1664,19 @@ static void wt_shortstatus_status(struct string_list_item *it,
 		color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%c", d->index_status);
 	else
 		putchar(' ');
-	if (d->worktree_status)
+	if (d->worktree_status) {
+		if (!s->submodule_porcelain1 &&
+		    (d->dirty_submodule || d->new_submodule_commits)) {
+			/* It is a submodule, and we're not in plumbing mode. */
+			if (d->new_submodule_commits)
+				d->worktree_status = 'M';
+			else if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
+				d->worktree_status = 'm';
+			else if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
+				d->worktree_status = '?';
+		}
 		color_fprintf(s->fp, color(WT_STATUS_CHANGED, s), "%c", d->worktree_status);
-	else
+	} else
 		putchar(' ');
 	putchar(' ');
 	if (s->null_termination) {
@@ -1811,6 +1821,7 @@ static void wt_porcelain_print(struct wt_status *s)
 	s->relative_paths = 0;
 	s->prefix = NULL;
 	s->no_gettext = 1;
+	s->submodule_porcelain1 = 1;
 	wt_shortstatus_print(s);
 }
 
diff --git a/wt-status.h b/wt-status.h
index 54fec77032..620e4d2ae4 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -70,6 +70,7 @@ struct wt_status {
 	int display_comment_prefix;
 	int relative_paths;
 	int submodule_summary;
+	int submodule_porcelain1;
 	int show_ignored_files;
 	enum untracked_status_type show_untracked_files;
 	const char *ignore_submodule_arg;
-- 
2.12.0.269.g1a05a5734c.dirty


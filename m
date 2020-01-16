Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3009DC35240
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E7B207E0
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6k4GnAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgAPGOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37854 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbgAPGOp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so17909285wru.4
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6KTcnz2yO7FyI7mQxHYVWOz2BdGyTzg7flPN6q6lp7w=;
        b=o6k4GnAltHMnc/16bYILnA9ckDyuSsAi/DOiUJuXMySV9qM96OkdZCHd99w3aPf8RX
         f3UM6qJrmjUnDetdEDiXsAoR12MbHGhDoXhajDVAicYXNsSo/pQvY4a+IXedK9FsX7ta
         +HGDuWi+Y+LTleUFu+c4TQ2HK8cIPS2fDAavE+KgviXTD7P+LzrJzP5Uaqe9DKcDfvwW
         vAD/rW/37IWL/g4MO9s4pXYxuluXcmBywmmueQcgE9NY/pA9AL2UMdqNPe6QOUpCMbaM
         BWQCUYqNAGLPVER9KgkPE1FaA7QWvp0SKnN1fCh08i/6Ti40fwK/6c3lHk9tpXJ/anTL
         RATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6KTcnz2yO7FyI7mQxHYVWOz2BdGyTzg7flPN6q6lp7w=;
        b=D4//fMZpHe/oaiztq/w4fqCd7DZV0S2GiqyvSU+GU6TMOUq/R18ZOcbcv7RcBW5iFg
         hYsZph5fUiFYeJd+fJT80s8TjMhA9aLyWgZGiHiQpknIAFC89vJVy+Em8ohdn8DhfsNy
         TTqicNqhtG0iS3pqLqHW2xFIzvcKzGgcISIza1ik0XvPeFHmLtDrG9oK2aCnCFhw3W+i
         Bp0tmpMf2mjhRmF9UVFRhTA+169VaQIe8vcDUbn8C6762WVt4EAau0lF+ARSQFn3xwBf
         loZ3hSXOv0kM8Y5glNZjmRtm6ZNJ1N/wl8g1ctSqMPjntB3aH5MoWcApe9uy22arWbB+
         WVAg==
X-Gm-Message-State: APjAAAUGg6u1HTsVfh+vHbnhrzdfq/etw3D6oZ6C94PK6aQiVt/3b9zk
        ECpt1jLMZhQjm0ZnecgxNsJ1Iveh
X-Google-Smtp-Source: APXvYqwmTJSnUluZxY1870O+Om/7o8GgTh68MhvhtGcty1ETq59bGAMm+fs/EzTZCMB+dAtb4Aq++g==
X-Received: by 2002:adf:82f3:: with SMTP id 106mr1340121wrc.69.1579155283117;
        Wed, 15 Jan 2020 22:14:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3sm27730427wrs.94.2020.01.15.22.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:42 -0800 (PST)
Message-Id: <b8c087d6fb12f7ca06848d04a75c29430183b4aa.1579155273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:24 +0000
Subject: [PATCH v4 10/19] rebase: allow more types of rebases to fast-forward
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In the past, we dis-allowed rebases using the interactive backend from
performing a fast-forward to short-circuit the rebase operation.  This
made sense for explicitly interactive rebases and some implicitly
interactive rebases, but certainly became overly stringent when the
merge backend was re-implemented via the interactive backend.

Just as the am-based rebase has always had to disable the fast-forward
based on a variety of conditions or flags (e.g. --signoff, --whitespace,
etc.), we need to do the same but now with a few more options.  However,
continuing to use REBASE_FORCE for tracking this is problematic because
the interactive backend used it for a different purpose.  (When
REBASE_FORCE wasn't set, the interactive backend would not fast-forward
the whole series but would fast-forward individual "pick" commits at the
beginning of the todo list, and then a squash or something would cause
it to start generating new commits.)  So, introduce a new
allow_preemptive_ff flag contained within cmd_rebase() and use it to
track whether we are going to allow a pre-emptive fast-forward that
short-circuits the whole rebase.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c               | 18 ++++++++++++++----
 t/t3432-rebase-fast-forward.sh |  2 ++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index fe1175af32..4b7d8fc908 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1467,6 +1467,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
 	int reschedule_failed_exec = -1;
+	int allow_preemptive_ff = 1;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -1774,13 +1775,20 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		    state_dir_base, cmd_live_rebase, buf.buf);
 	}
 
+	if ((options.flags & REBASE_INTERACTIVE_EXPLICIT) ||
+	    (action != ACTION_NONE) ||
+	    (exec.nr > 0) ||
+	    options.autosquash) {
+		allow_preemptive_ff = 0;
+	}
+
 	for (i = 0; i < options.git_am_opts.argc; i++) {
 		const char *option = options.git_am_opts.argv[i], *p;
 		if (!strcmp(option, "--committer-date-is-author-date") ||
 		    !strcmp(option, "--ignore-date") ||
 		    !strcmp(option, "--whitespace=fix") ||
 		    !strcmp(option, "--whitespace=strip"))
-			options.flags |= REBASE_FORCE;
+			allow_preemptive_ff = 0;
 		else if (skip_prefix(option, "-C", &p)) {
 			while (*p)
 				if (!isdigit(*(p++)))
@@ -2116,12 +2124,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	/*
 	 * Check if we are already based on onto with linear history,
 	 * in which case we could fast-forward without replacing the commits
-	 * with new commits recreated by replaying their changes. This
-	 * optimization must not be done if this is an interactive rebase.
+	 * with new commits recreated by replaying their changes.
+	 *
+	 * Note that can_fast_forward() initializes merge_base, so we have to
+	 * call it before checking allow_preemptive_ff.
 	 */
 	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
 		    &options.orig_head, &merge_base) &&
-	    !is_interactive(&options)) {
+	    allow_preemptive_ff) {
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 7432c0e241..40388ccf9f 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -30,6 +30,8 @@ test_rebase_same_head () {
 	shift &&
 	test_rebase_same_head_ $status_n $what_n $cmp_n "" "$*" &&
 	test_rebase_same_head_ $status_f $what_f $cmp_f " --no-ff" "$*"
+	test_rebase_same_head_ $status_n $what_n $cmp_n " --merge" "$*" &&
+	test_rebase_same_head_ $status_f $what_f $cmp_f " --merge --no-ff" "$*"
 }
 
 test_rebase_same_head_ () {
-- 
gitgitgadget


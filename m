Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A1AC2D0D4
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504B121D7E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhgCEbrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfLTRKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:10:00 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40013 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfLTRJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:09:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id b8so8932190edx.7
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 09:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jo5b/Q7DfXWd7kPKZgbR5K0YKULNIodOCBlnoUrwzRk=;
        b=DhgCEbrJApYFj1e8C+IRD7ox741q1zR7NCXwaVqYWBdHAKIAmOscw8aEAZjLD00Qh+
         W3MIe7uPEkugAJbpFITgYgUSq+aidmyFH83EVUVbBK5KtOdsirgbS5c06PmuZaywqOnN
         0RZBKPVt8PIYIweWEdGtTOcsUqKbQcfomMHlDHjlrz7WVhwH5AeAQ15bjYzpKe7+GRtm
         F15nH3lE6RvHTimEbmU5wxRxUJkDV60fCk+tNcyP/BXvTYaNKMq1ba9NQ9CHdR6cUFiC
         OROUhCDv/VeYc5g+WADBqrFMQha6gL4hPAx+6KgntSm0B7XSVYT1FiWaQh3o81OZJOhn
         qugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Jo5b/Q7DfXWd7kPKZgbR5K0YKULNIodOCBlnoUrwzRk=;
        b=WkI7yOt8q8EGaqAdZ/NZeFH3RFvsAONs9+BwS8fRk72QSBEqmuH43CetRTCnKtZ0ba
         Vj3oOxk08F/121mnILjMTTLD5PyMa339pPtSBAmlxBWuw2jRgf+p4bwv7MsQ6RJ+KUQb
         zwnrU00fxDh7DCWNQLAgviCvPSvalPN5ZCwMcS2I69kCGtmC1rJQV1yujbhZkR4FuD4d
         vo8c8LaJinY0hZhWrdLEIvHcwQyFqKdMMonvrpX+xPbIDCQhjCOQx0XaQSRhAp3nW5gJ
         5iGqvucpKlkaEszN61zpmWIsjP/Trgm8SzNzIAhcgT9FuKJhlu1PNvi5HtlDR+kjLklF
         iU/A==
X-Gm-Message-State: APjAAAUFJbMiSv4AeUWauUdo6O60BufFGC6Zgl6XBxgzCemLpIjIoDcE
        CVbkEuAF3Kx0jmYS9hLtIGFj9i1P
X-Google-Smtp-Source: APXvYqwseB5Qo3nfKQJLhB4YqVkU7GMkWpcZA8tV1G1SrcSYYmLA35zoRZwLvovDhB0qkow1knaPKw==
X-Received: by 2002:a17:906:2db1:: with SMTP id g17mr17238103eji.240.1576861795421;
        Fri, 20 Dec 2019 09:09:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e1sm1029849edn.86.2019.12.20.09.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 09:09:55 -0800 (PST)
Message-Id: <a4073df9108b7e9a825371f5925d1841463aedb4.1576861788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 17:09:40 +0000
Subject: [PATCH 07/15] rebase: allow more types of rebases to fast-forward
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
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
index b320bb3a30..67bccd876f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1497,6 +1497,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
 	int reschedule_failed_exec = -1;
+	int allow_preemptive_ff = 1;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -1808,11 +1809,18 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	    options.ignore_date)
 		options.flags |= REBASE_FORCE;
 
+	if ((options.flags & REBASE_INTERACTIVE_EXPLICIT) ||
+	    (action != ACTION_NONE) ||
+	    (exec.nr > 0) ||
+	    options.autosquash) {
+		allow_preemptive_ff = 0;
+	}
+
 	for (i = 0; i < options.git_am_opts.argc; i++) {
 		const char *option = options.git_am_opts.argv[i], *p;
 		if (!strcmp(option, "--whitespace=fix") ||
 		    !strcmp(option, "--whitespace=strip"))
-			options.flags |= REBASE_FORCE;
+			allow_preemptive_ff = 0;
 		else if (skip_prefix(option, "-C", &p)) {
 			while (*p)
 				if (!isdigit(*(p++)))
@@ -2148,12 +2156,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
index 3879a43fa0..58c91c6899 100755
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


Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766A2C76196
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4712086A
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL7Llmyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgBOVg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:36:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51680 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgBOVgz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:36:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so13523394wmi.1
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vSjxleNuT5B/HNpvTx0t4k8iXCyVFTyx5cByvh4fou4=;
        b=RL7Llmyy90X3CKewbvtuGD/OHReI2ahQ59hlyNABjDDVTOK2MhGLrXrnzf0j2n1LEK
         7N6EJ0ujG6e43Xu3vZlBxCeWsqvHWJC7aks5FOWJ/AEaqCfaq8bDZXYG41rhE30o9vJe
         eK63+MLxJfdVVqCS3g0lHBz+dcOtbkMXRDehVAp+YKLOEcLaFnr6lklHsrTM8iNypbFu
         dHf1gREqKQViZf643N6L2qfe02RCHmsbiyMYCTqv3Azugo5DK46SIdS8+5VBizAAjDRL
         yELO1BP2941DNKJT+BcMWB1r4Co/glTpkKJmVp0iz71P7sSFdDlUl5zKF26jA/7DdKsn
         oipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vSjxleNuT5B/HNpvTx0t4k8iXCyVFTyx5cByvh4fou4=;
        b=DEArA7YJn6k9cRD+STX1oNQaxADqBB6u9k11mSh9w26mwZM0McwKo3QqVSxri1WAHi
         f5E99XhIxzR8sCwqkvxrZ6S9Z0pULrUoYzqFY4MbpZtYRq6qvDb821eM1XyO/pVxJjRE
         GjtsyCloADP8e1iOSoSvnbW/QnIpCWQ5ZW2F95liOZ4Hc4ij1b8ZmsysLMJdYIxLEjO8
         xe35PUgMGGYpwerXX5qSdAOV8jyCfyva48HRw/JATxU0bpaBNnops07pQ/z2r5axyVY3
         98KXwGIh34FW+gZ0hPbKQtSjwLUGk0p7x4Y8XGW5BTXnuFm+MVYGT1SI1RWlQAHqhREq
         swaA==
X-Gm-Message-State: APjAAAVWbkW4Q4CRFePMU6OJUzDJ6C6vJsf/7WkyeabiC+euCBmjNfFk
        9ryqrIEd3dpmOutm341auf608txw
X-Google-Smtp-Source: APXvYqzHtdzJ7xvLKhElPOwYCtaXi3IkQBRtPPoW2jjdufBek6pVp9tj92FpmsPbKXUK9QrWSLH2iQ==
X-Received: by 2002:a05:600c:295d:: with SMTP id n29mr12298061wmd.101.1581802610826;
        Sat, 15 Feb 2020 13:36:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b67sm13611622wmc.38.2020.02.15.13.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:50 -0800 (PST)
Message-Id: <45eb87b36b0dc93385a774b691da6eb185be1920.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:31 +0000
Subject: [PATCH v5 10/20] rebase: allow more types of rebases to fast-forward
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
index 8264a9243f1..6e9a2fedc7f 100644
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
index 7432c0e2415..40388ccf9f3 100755
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


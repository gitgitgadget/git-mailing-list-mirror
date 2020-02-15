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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5653BC7114E
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2E320718
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVikvf6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgBOVhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:37:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37893 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgBOVg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:36:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so15115046wrh.5
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t9gEZ3+Y6NXQh5fb85RzqcUJjWRClOqZL/HMoN9HXA0=;
        b=YVikvf6kv+9H+gqbmM+Aq3sEZagQ26BYw/ynSyST1M1KGSWQyYk52YtKd6ajdLvYJK
         Lc2NHoWxg9W8al6abrSDWv+MnkX5cLElZ4h93UekHVmCP60yGcHuBv4JCce3qaoJprJi
         5SQ4i0UBhx67SAWmJN+Ers+lLDP6UeXAYqIwHDAPCOEyBEbMWqhSkWE8V6QvOwVnYEu0
         4uA4rDVGnfVznp8oEGjZgFiVaMHRge2YjDaoi3fORiUoxDT+mtnjtVTze3vawAaDR/76
         NjtaqmhbVh1MpbS2WoB2LX/hgnswNQmmgp2Uo+zqnRcUaJrpgTJNMZURbbU8h+HIBYkW
         JzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t9gEZ3+Y6NXQh5fb85RzqcUJjWRClOqZL/HMoN9HXA0=;
        b=odtFzo4cuFiXz/Om38BcKcKoVqOAtkqtgk2S2O3/nRptxbqsQ8FAWuoEJNv/lwAZLN
         Sii9k0WhxKwT3/Vt8NAD5GY00sWNaGIbC8E2J7XS+kTtiupG1gf1UnVeM/6xLnm+z9IU
         W0E1P1okq0pjp2GQZHgG8sZHI04UntSakxgf9c5xaMgtXApDJPYbMSbR/XtxZDRjaNsf
         zPV5yMlLSRy2LBHXMCHw/bZpQyRX1nloPNwso/gwsFvMGIdktrKqAsdye6tH/0A7mfYG
         Pt9Gks8X8lK9gLmHJsdxLDNNohezNO9PMtSDMLOIjQycz2Dlt6AZm14j0rjwOGQAo8ct
         TWhQ==
X-Gm-Message-State: APjAAAX18W+ep8mMKSci9OOJfMGltm6r9qdwpk9SBPM0I8XHTRVC9dDe
        k9tGWQmiYSW6ZRDjgZZFKzhAnE/c
X-Google-Smtp-Source: APXvYqyOs/pjY5UP/+2GcOLcwkeQja0d2mYrKQoux0OR8JUpi/lUk3+Fm8o7DpoNO4rYaVysNf/tjg==
X-Received: by 2002:a5d:510f:: with SMTP id s15mr11545477wrt.408.1581802614426;
        Sat, 15 Feb 2020 13:36:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d204sm13496971wmd.30.2020.02.15.13.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:53 -0800 (PST)
Message-Id: <f0f00c1e7fdecaa159848b6c51dea3d7180e1283.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:36 +0000
Subject: [PATCH v5 15/20] rebase: drop '-i' from the reflog for
 interactive-based rebases
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

A large variety of rebase types are supported by the interactive
machinery, not just the explicitly interactive ones.  These all share
the same code and write the same reflog messages, but the "-i" moniker
in those messages doesn't really have much meaning.  It also becomes
somewhat distracting once we switch the default from the am-backend to
the interactive one.  Just remove the "-i" from these messages.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c              |  2 +-
 sequencer.c                   |  8 ++++----
 t/t3404-rebase-interactive.sh | 10 +++++-----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 77abe674cb9..ffaa7935240 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1441,7 +1441,7 @@ static void set_reflog_action(struct rebase_options *options)
 	if (env && strcmp("rebase", env))
 		return; /* only override it if it is "rebase" */
 
-	strbuf_addf(&buf, "rebase -i (%s)", options->action);
+	strbuf_addf(&buf, "rebase (%s)", options->action);
 	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, buf.buf, 1);
 	strbuf_release(&buf);
 }
diff --git a/sequencer.c b/sequencer.c
index f475d2a3b1c..f8e242b6695 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -290,7 +290,7 @@ int sequencer_remove_state(struct replay_opts *opts)
 			char *eol = strchr(p, '\n');
 			if (eol)
 				*eol = '\0';
-			if (delete_ref("(rebase -i) cleanup", p, NULL, 0) < 0) {
+			if (delete_ref("(rebase) cleanup", p, NULL, 0) < 0) {
 				warning(_("could not delete '%s'"), p);
 				ret = -1;
 			}
@@ -324,7 +324,7 @@ static const char *action_name(const struct replay_opts *opts)
 	case REPLAY_PICK:
 		return N_("cherry-pick");
 	case REPLAY_INTERACTIVE_REBASE:
-		return N_("rebase -i");
+		return N_("rebase");
 	}
 	die(_("unknown action: %d"), opts->action);
 }
@@ -628,7 +628,7 @@ static int do_recursive_merge(struct repository *r,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		/*
 		 * TRANSLATORS: %s will be "revert", "cherry-pick" or
-		 * "rebase -i".
+		 * "rebase".
 		 */
 		return error(_("%s: Unable to write new index file"),
 			_(action_name(opts)));
@@ -3199,7 +3199,7 @@ static int do_label(struct repository *r, const char *name, int len)
 		return error(_("illegal label name: '%.*s'"), len, name);
 
 	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
-	strbuf_addf(&msg, "rebase -i (label) '%.*s'", len, name);
+	strbuf_addf(&msg, "rebase (label) '%.*s'", len, name);
 
 	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction) {
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c41531f3490..a31583eb2fd 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -223,7 +223,7 @@ test_expect_success 'reflog for the branch shows state before rebase' '
 '
 
 test_expect_success 'reflog for the branch shows correct finish message' '
-	printf "rebase -i (finish): refs/heads/branch1 onto %s\n" \
+	printf "rebase (finish): refs/heads/branch1 onto %s\n" \
 		"$(git rev-parse branch2)" >expected &&
 	git log -g --pretty=%gs -1 refs/heads/branch1 >actual &&
 	test_cmp expected actual
@@ -1162,10 +1162,10 @@ test_expect_success 'rebase -i produces readable reflog' '
 	git branch -f branch-reflog-test H &&
 	git rebase -i --onto I F branch-reflog-test &&
 	cat >expect <<-\EOF &&
-	rebase -i (finish): returning to refs/heads/branch-reflog-test
-	rebase -i (pick): H
-	rebase -i (pick): G
-	rebase -i (start): checkout I
+	rebase (finish): returning to refs/heads/branch-reflog-test
+	rebase (pick): H
+	rebase (pick): G
+	rebase (start): checkout I
 	EOF
 	git reflog -n4 HEAD |
 	sed "s/[^:]*: //" >actual &&
-- 
gitgitgadget


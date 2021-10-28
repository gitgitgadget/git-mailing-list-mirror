Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65B9C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 15:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BED24610CA
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 15:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhJ1PtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 11:49:05 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJ1PtE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 11:49:04 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MvrRB-1myKqY2tSp-00suQJ; Thu, 28 Oct 2021 17:46:21 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 7E7A61E01E7;
        Thu, 28 Oct 2021 15:46:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uqkJMew5G2nm; Thu, 28 Oct 2021 17:46:20 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (24-usr-pf-main.vpn.it.cetitec.com [10.8.5.24])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 284F61E01E6;
        Thu, 28 Oct 2021 17:46:20 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Thu, 28 Oct 2021 17:46:19 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/2] Fix "commit-msg" hook unexpectedly called for "git pull
 --no-verify"
Message-ID: <YXrFy9I1KPz3IZyp@pflmari>
References: <YXfwanz3MynCLDmn@pflmari>
 <YXhwGQOTfD+ypbo8@coredump.intra.peff.net>
 <YXlBhmfXl3wFQ5Bj@pflmari>
 <YXlD5ecNSdeBSMoS@coredump.intra.peff.net>
 <YXlTpzrY7KFqRlno@pflmari>
 <xmqq4k92w7do.fsf@gitster.g>
 <YXpFTJTo0pKhM7xG@pflmari>
 <YXpZddOixrJDd//s@pflmari>
 <edca7f6b-e89c-7efa-c6f5-2c3aaaea54f9@gmail.com>
 <YXrFaJXbuSuwfhQ7@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXrFaJXbuSuwfhQ7@pflmari>
X-Provags-ID: V03:K1:OBKvShtbMFlfshM7/QAfeFMIS79nOgAXJV2/VAvud6UaiXYZ7F/
 PP7/Re9F6NDdGZulNKF4dQRQVd5aiTnDwkQ7kAfdSmEsviBvIFsdq83FelGbJurStlO1HH8
 q9OZPKtVJW6L8fDCnPbW/c00ErGu7vDayPreHMlS6mgIMK9tRy5CAx8pHl10NfSfm5gChLZ
 5KRsToT9HMRzYbF+Y7JeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ndlGPei8E80=:BqAjYfF+4wuLamldcGUkmN
 ajTNa1JG1l88bOKYwIkyNgaTRnK/JyuvkrbjXMtAtLfdqGOB7vYefM+i3lCTGuT05ffV6YF9q
 SqIymEiIO0qXmomwCxPmFs2PnyhFvZjmF0Z3/nKCeGoESTUpv5SVvi6Qv/fo5vfxUplJg4k4r
 2jcsoarineHPJph/5qKtNvX6yNXNRN+jWUoghKCW67Zh5uHpV0S/rYIRTcXR52BAIdRRhF/VT
 5XfaBML7vdXC98bdH5qeL3siq8/X3i5wjhbDHu1QbRplHkUlL+qYwhKcxQbbVw8P63isAI4e5
 +Rp0JkSQvWIQHqNYVAiSa1hR9EkmBAKxy+3iUqtpJ9P/RXbmBkpGvH3UGY8Q0/ilLfZBtLHFz
 SkrUylGRzT/cpZtc6Oo4ephLcyVby8uV/t7qxrqsGY0OSpudZ0ONpPPrhpqrOQGqvCKd6DerA
 jbczkLVQUUT3y3n3TiBEeroH7nTzmnrjaiD5++p6jamlfVMQ7sJVjuWVhvezVVHZBpwJRiz1+
 6hxy3WrjZ0ZHB06OjHJhq2THzIGw+lvajloVIOFaEyymdZbW8bt1JuDMmNGPhSElBUq7X4ZYw
 iTyRRvp3c4BvYSaRT/wBxhPorY/G0riE2han95iu8ptXG8Jpjbv8sjv/9dV8YBrhpXI6AA/US
 bFmgeB0nqnoHjw83bh6kFxEplYQTaR0XxlILtoT0LwrFqapxaJA7F7s4qBqou1d7rOWIBymI8
 xCyHiyv+cE7sAjfy
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Riesen <raa.lkml@gmail.com>

The option was incorrectly auto-translated to "--no-verify-signatures",
which causes the unexpected effect of the hook being called.
And an even more unexpected effect of disabling verification of signatures.

The manual page describes the option to behave same as the similarly
named option of "git merge", which seems to be the original intention
of this option in the "pull" command.

Signed-off-by: Alexander Riesen <raa.lkml@gmail.com>
---
 builtin/pull.c          |  6 ++++++
 t/t5521-pull-options.sh | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 425950f469..e783da10b2 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -84,6 +84,7 @@ static char *opt_edit;
 static char *cleanup_arg;
 static char *opt_ff;
 static char *opt_verify_signatures;
+static char *opt_verify;
 static int opt_autostash = -1;
 static int config_autostash;
 static int check_trust_level = 1;
@@ -160,6 +161,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
 		N_("abort if fast-forward is not possible"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+	OPT_PASSTHRU(0, "verify", &opt_verify, NULL,
+		N_("control use of pre-merge-commit and commit-msg hooks"),
+		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
@@ -688,6 +692,8 @@ static int run_merge(void)
 		strvec_pushf(&args, "--cleanup=%s", cleanup_arg);
 	if (opt_ff)
 		strvec_push(&args, opt_ff);
+	if (opt_verify)
+		strvec_push(&args, opt_verify);
 	if (opt_verify_signatures)
 		strvec_push(&args, opt_verify_signatures);
 	strvec_pushv(&args, opt_strategies.v);
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index db1a381cd9..22cf1b2cf7 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -225,4 +225,28 @@ test_expect_success 'git pull --no-signoff flag cancels --signoff flag' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'git pull --no-verify flag passed to merge' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src one &&
+	git clone src dst &&
+	write_script dst/.git/hooks/commit-msg <<-\EOF &&
+	false
+	EOF
+	test_commit -C src two &&
+	git -C dst pull --no-ff --no-verify
+'
+
+test_expect_success 'git pull --no-verify --verify passed to merge' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src one &&
+	git clone src dst &&
+	write_script dst/.git/hooks/commit-msg <<-\EOF &&
+	false
+	EOF
+	test_commit -C src two &&
+	test_must_fail git -C dst pull --no-ff --no-verify --verify
+'
+
 test_done
-- 
2.33.0.22.g8cd9218530


Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78D5C433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 23:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A87121582
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 23:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="PQw55p3E";
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="PQw55p3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439936AbgJQXQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 19:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439929AbgJQXQH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 19:16:07 -0400
Received: from lithium.sammserver.com (lithium.sammserver.com [IPv6:2a01:4f8:c2c:b7df::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2075C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 16:16:06 -0700 (PDT)
Received: from mail.sammserver.com (sammserver.wg [10.32.40.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by lithium.sammserver.com (Postfix) with ESMTPS id 69A90312B5AE;
        Sun, 18 Oct 2020 01:16:05 +0200 (CEST)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id 2C1F61120A09; Sun, 18 Oct 2020 01:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602976565; bh=7QNB61HXXKIL1KQAHXjHPiYq9NjlksGH5yiqpPrxm2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQw55p3EqtUSuK7P4c41/JBao/3UW5jCn7363+AI3hTYUoGzv/lRGUVSySFnipun4
         px5291ObCXc4lrpsjsl6M4plCgIPKP0iknChe3PoFdH2fpvTFvZb3K2TBla7BeOvw6
         ORlBF8paS6wsP5luALYk6mUpGWT+rvCFxMkAlYQ8=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id C5EC511209FB;
        Sun, 18 Oct 2020 01:16:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602976565; bh=7QNB61HXXKIL1KQAHXjHPiYq9NjlksGH5yiqpPrxm2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQw55p3EqtUSuK7P4c41/JBao/3UW5jCn7363+AI3hTYUoGzv/lRGUVSySFnipun4
         px5291ObCXc4lrpsjsl6M4plCgIPKP0iknChe3PoFdH2fpvTFvZb3K2TBla7BeOvw6
         ORlBF8paS6wsP5luALYk6mUpGWT+rvCFxMkAlYQ8=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id B34231420A8F; Sun, 18 Oct 2020 01:16:04 +0200 (CEST)
From:   =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
Subject: [PATCH v4 2/3] sequencer: pass explicit --no-gpg-sign to merge
Date:   Sun, 18 Oct 2020 01:15:56 +0200
Message-Id: <20201017231557.1001728-2-samuel@cavoj.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017231557.1001728-1-samuel@cavoj.net>
References: <20201017231557.1001728-1-samuel@cavoj.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The merge subcommand launched for merges with non-default strategy would
use its own default behaviour to decide how to sign commits, regardless
of what opts->gpg_sign was set to. For example the --no-gpg-sign flag
given to rebase explicitly would get ignored, if commit.gpgsign was set
to true.

Fix the issue and add a test case excercising this behaviour.

Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
---
 sequencer.c                | 2 ++
 t/t3435-rebase-gpg-sign.sh | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 88ccff4838..043d606829 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3678,6 +3678,8 @@ static int do_merge(struct repository *r,
 		strvec_push(&cmd.args, git_path_merge_msg(r));
 		if (opts->gpg_sign)
 			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
+		else
+			strvec_push(&cmd.args, "--no-gpg-sign");
 
 		/* Add the tips to be merged */
 		for (j = to_merge; j; j = j->next)
diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
index a2b7625707..2fba21f77a 100755
--- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -89,4 +89,11 @@ test_expect_success 'rebase -r, merge strategy, commit.gpgsign=false --gpg-sign
 	git verify-commit HEAD
 '
 
+test_expect_success "rebase -r, merge strategy, commit.gpgsign=true --no-gpg-sign won't sign commit" '
+	git reset --hard merged &&
+	git config commit.gpgsign true &&
+	git rebase -fr --no-gpg-sign -s resolve --root &&
+	test_must_fail git verify-commit HEAD
+'
+
 test_done
-- 
2.28.0


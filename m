Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21A8C2D0C3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7785F206CB
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuH/M/RY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLXTzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:55:06 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45626 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfLXTzG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:55:06 -0500
Received: by mail-ed1-f67.google.com with SMTP id v28so18624112edw.12
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 11:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qn1fi0por3x0HTg6UJQb4898IQuTlhoQdD5bPS1bny4=;
        b=kuH/M/RYx3gmmgxA5qqN5/RhC/reo8MdHz/sWBlpZLnde/K9XzB/tCSLqxL8xVrZCE
         yGoYbutWwBIsIEx06ch/iVw2go+sv5Ww5SH4sxlU1PLMjnRazJjBnB4LTNTrqksePQkg
         1L1bKPonPcIqLfgijBFkT28tu5/T3eOtUHYHU/C9E2IkfTh+VmV4xc2+yj12IRqgbGIZ
         ESxMQVNLyd5lKiNksaOvsVusvg2f6vS12H5hgkCNZB9qd92MV2wyeqXkweY9r3+Lu/lJ
         iSBGvEOVmo8BtBXBMQuLQRzxuuZl5h2WmDbRlqz9JrLNB+0nMpugdZtRh29oxJvNdGFJ
         hHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qn1fi0por3x0HTg6UJQb4898IQuTlhoQdD5bPS1bny4=;
        b=AntkHI/P1/E9GBsMClJM2iSF2P+rfBFm3eyeY6t3dIg2vDpuZ8N1D9OmWC+YOfFtDr
         2jPVwGnAHyVmEPDz2CWtPke3tvFTGVHbSTJAfNwkBqk61ga2LEBYgsh0Fs/K3ycr6U7e
         eXjff/93RpSWjAKnGT0osAYwT8BLx1NuK1rwzW+yC66h8rVf21EJFYUDobrOrvSz71Vy
         66WIFjnmSDzaEo1KeuztXmFzUbrqzYPLAwFFk9e67xWncnwPyota9gPL3aBd7Gj4+0bX
         UOgkmg0xp0DI6n6qZLsh4wkfSg/fSs5uNjra1ih8fiEoZNPaaoop0WVGwWriO4Y9LWGa
         ZJEw==
X-Gm-Message-State: APjAAAVBRDqVLjQWE3YQjrGdvDgkFqh+zn9o/O2UoxJ21twBM7s2p+nh
        cmaVor6ceHlkWjzGVFQa1y9zQch9
X-Google-Smtp-Source: APXvYqyOHyqBQP8F1UOqZNvOVUvH5zzUqk+JdpjlOuz14sdBvnSuAbhddEH449/cOoIhEs65eT8gPA==
X-Received: by 2002:a05:6402:1351:: with SMTP id y17mr40556824edw.130.1577217304159;
        Tue, 24 Dec 2019 11:55:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11sm2745630edw.73.2019.12.24.11.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 11:55:03 -0800 (PST)
Message-Id: <478479358ff21afe6b8374f076d2ed5e139ae6c0.1577217299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Dec 2019 19:54:48 +0000
Subject: [PATCH v3 04/15] rebase: make sure to pass along the quiet flag to
 the sequencer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c  | 3 ++-
 t/t3400-rebase.sh | 8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 32026a62e8..5014c9a437 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -126,6 +126,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.keep_redundant_commits = (opts->empty == EMPTY_KEEP);
 	replay.ask_on_initially_empty = (opts->empty == EMPTY_ASK &&
 					 !(opts->flags & REBASE_INTERACTIVE_EXPLICIT));
+	replay.quiet = !(opts->flags & REBASE_NO_QUIET);
 	replay.verbose = opts->flags & REBASE_VERBOSE;
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.committer_date_is_author_date =
@@ -1502,7 +1503,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 N_("allow pre-rebase hook to run")),
 		OPT_NEGBIT('q', "quiet", &options.flags,
 			   N_("be quiet. implies --no-stat"),
-			   REBASE_NO_QUIET| REBASE_VERBOSE | REBASE_DIFFSTAT),
+			   REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
 		OPT_BIT('v', "verbose", &options.flags,
 			N_("display a diffstat of what changed upstream"),
 			REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 221b35f2df..79762b989a 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -206,12 +206,18 @@ test_expect_success 'cherry-picked commits and fork-point work together' '
 	test_cmp expect D
 '
 
-test_expect_success 'rebase -q is quiet' '
+test_expect_success 'rebase --am -q is quiet' '
 	git checkout -b quiet topic &&
 	git rebase -q master >output.out 2>&1 &&
 	test_must_be_empty output.out
 '
 
+test_expect_success 'rebase --merge -q is quiet' '
+	git checkout -B quiet topic &&
+	git rebase --merge -q master >output.out 2>&1 &&
+	test_must_be_empty output.out
+'
+
 test_expect_success 'Rebase a commit that sprinkles CRs in' '
 	(
 		echo "One" &&
-- 
gitgitgadget


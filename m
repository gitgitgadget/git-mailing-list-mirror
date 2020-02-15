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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC001C76197
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C362820718
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3t6Qj/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBOVg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:36:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50832 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgBOVgu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:36:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so13508298wmb.0
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oeAaq7XlkNBPKiqt31AgJ3ysPNcuHyyS8Eorjb4EBR8=;
        b=Z3t6Qj/1/qFO2bF0b5i98vbdhu5SBrLRMjXgx1I5VMFB7dRGcem0oz9mSWzZ+H2Qw1
         lyxaIRW6kMqDOIaVab4VCUEdQ8lvaA+Vl4UfOCw2EcZG2NxDPzV872pUhnCeZ0rt1b2B
         y6khlwDpQ/fczhI3D9nGYUobeuFOKKBAktFI3Uoz/ZFNv2NXo5D9BX2Hp9Vdfjuk5e86
         ib/Dtk/C+P/+0gznv85yru7lPjBDpLEZB5Tp1Fk+03HmSUw6UiRWnm4FRQofsJ2YsXjp
         Z8ckf2B7V5Xl7FCgF9Zj66UZDlIzvIcih+ZXed7X1R1QzC78KEkNQUgjFmgbwHQNC/ha
         I0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oeAaq7XlkNBPKiqt31AgJ3ysPNcuHyyS8Eorjb4EBR8=;
        b=c3/Q/VDGuMRD0o3NYBZBdHDU+kPA+ViAymp1GvIww7tmxMhrlaJd9ldOVa/+ucDgjj
         g2OUHFmtars31mE4fTjL/qVBbtIPxj2yf/iguidUV9CMXDJPFiBt6sWQuOha2AdBDDN0
         ISFNvtsV/R2rYDRCZlJ4rrV3g3RUSrKy1ZcsYQt31+iitk8u5EoVJsIbc6JwSm5VMprc
         jmfJrko99g1Sj2n03obeS4p9m8aGH+we1a4o390P3PjomPiRJ+c1Dll4Mnr3QhB5KXK5
         9vazX1AgahfZSxgWVVnAWriHxcAzAxo7Lkd2syw/aWAOovKSidgcvIMzGvtFJId5JmcZ
         Nk/A==
X-Gm-Message-State: APjAAAUcrl6BQlxg3fvjF9S/nuXyRm8ReWQr8cWsMGA0FFnVj66XqqLm
        LPhF5pMUvtTXH1aXaEJZr4/DfBgu
X-Google-Smtp-Source: APXvYqyzZCjczKgRIg2XQ73Ishk2I9ZQJ0KePwuTMXjsB7/G1I5Q5HR+rirqqk5TtT5gf4l45BmEdA==
X-Received: by 2002:a05:600c:291d:: with SMTP id i29mr12816593wmd.39.1581802608753;
        Sat, 15 Feb 2020 13:36:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm12567329wrt.91.2020.02.15.13.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:48 -0800 (PST)
Message-Id: <3dccb58d0660de8ab931e1540f5fd0c0083954e9.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:28 +0000
Subject: [PATCH v5 07/20] rebase: make sure to pass along the quiet flag to
 the sequencer
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c  | 3 ++-
 t/t3400-rebase.sh | 8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7551f950593..1a664137d29 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -120,6 +120,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.allow_empty_message = opts->allow_empty_message;
 	replay.drop_redundant_commits = (opts->empty == EMPTY_DROP);
 	replay.keep_redundant_commits = (opts->empty == EMPTY_KEEP);
+	replay.quiet = !(opts->flags & REBASE_NO_QUIET);
 	replay.verbose = opts->flags & REBASE_VERBOSE;
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
@@ -1476,7 +1477,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 N_("allow pre-rebase hook to run")),
 		OPT_NEGBIT('q', "quiet", &options.flags,
 			   N_("be quiet. implies --no-stat"),
-			   REBASE_NO_QUIET| REBASE_VERBOSE | REBASE_DIFFSTAT),
+			   REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
 		OPT_BIT('v', "verbose", &options.flags,
 			N_("display a diffstat of what changed upstream"),
 			REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 221b35f2df3..79762b989a4 100755
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


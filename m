Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C3381FAF4
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbdBCCt3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:29 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33303 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbdBCCt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:26 -0500
Received: by mail-wm0-f66.google.com with SMTP id v77so1189483wmv.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H39ZukjBhDawEFcc4+28MDPacziIkIrw59N8TdmVBJs=;
        b=lR7DK61avDLps8qkz0u/JLU1p9Z7RpC4sND9Uho8uX9z1FEbFW76qFOFN6YYL0Tymn
         Gka9ptBXcZbHKSm0RLzgoEaRCf+OAW4zdv6nySlQ7id/kHr18WXyimtPMCOjqD6EMZR8
         /HUyNdlop+8z0ODNwjFMn3yf1ZqPYQKUWIcA/TrqW8QJ7mBM2QayC3Ap9TobGcxUpbAx
         izHZMxiGy0g3o6fSZ6jQQshu3+gi9oGmu7m3sngnRMsIl2zLooBmVFd+Qua6ard8Yrn8
         RhFqfPmcl6hPpcDYQBnIgz2WNRE6wkMO3kqtATv2lTQGdcyi7tRpImGvmcP9ueVxY/8l
         7gmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H39ZukjBhDawEFcc4+28MDPacziIkIrw59N8TdmVBJs=;
        b=Ix3e72vvqwGHxZWIiYcdxKlrVdIidnCpW410QEMshFOES4kpf7IWQ5mfduJcfu26k2
         ME+sy0cb8hutWi1qFbZNaoF55TMot54lfkavKpSduWdbZK0pxBUoF7azhEhmIm8dKIf3
         xFeVobOGpl7BOMezVANWZwv1JKTPDRrYpvUY2OnOmcQKjl/WqkBc8ZjnLkDauem6Ewj9
         3/Q2jkyuOiSqBmRQP3iBRNX2zUQOkettg0+DvPRNSStuJ32NuEFn/eqc1ekf4XWvLDIP
         2AegwDS9yYlOl1WwKnQ6Lu0YFoF7W0s3QjDpqqTvggewxtGa7RG8Z6AZOqSKA2qGjO5k
         +kVw==
X-Gm-Message-State: AIkVDXLTspTBn9MI5pSJe3Ko7khA+WirElAeg2f6a2xRbZtu4QdPTgLMJaAPOZ56/WHc0g==
X-Received: by 10.223.170.221 with SMTP id i29mr12312039wrc.131.1486090159964;
        Thu, 02 Feb 2017 18:49:19 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:19 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 07/21] completion: ensure that the repository path given on the command line exists
Date:   Fri,  3 Feb 2017 03:48:15 +0100
Message-Id: <20170203024829.8071-8-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The __gitdir() helper function prints the path to the git repository
to its stdout or stays silent and returns with error when it can't
find a repository or when the repository given via $GIT_DIR doesn't
exist.

This is not the case, however, when the path in $__git_dir, i.e. the
path to the repository specified on the command line via 'git
--git-dir=<path>', doesn't exist: __gitdir() still outputs it as if it
were a real existing repository, making some completion functions
believe that they operate on an existing repository.

Check that the path in $__git_dir exists and return with error without
printing anything to stdout if it doesn't.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 t/t9902-completion.sh                  | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ee6fb2259..5b2bd6721 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -40,6 +40,7 @@ __gitdir ()
 {
 	if [ -z "${1-}" ]; then
 		if [ -n "${__git_dir-}" ]; then
+			test -d "$__git_dir" || return 1
 			echo "$__git_dir"
 		elif [ -n "${GIT_DIR-}" ]; then
 			test -d "${GIT_DIR-}" || return 1
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7956cb9b1..7667baabf 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -211,6 +211,14 @@ test_expect_success '__gitdir - $GIT_DIR set while .git directory in parent' '
 	test_cmp expected "$actual"
 '
 
+test_expect_success '__gitdir - non-existing path in $__git_dir' '
+	(
+		__git_dir="non-existing" &&
+		test_must_fail __gitdir >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
 test_expect_success '__gitdir - non-existing $GIT_DIR' '
 	(
 		GIT_DIR="$ROOT/non-existing" &&
-- 
2.11.0.555.g967c1bcb3


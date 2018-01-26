Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B2A1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 12:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeAZMhv (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 07:37:51 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41211 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbeAZMhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 07:37:25 -0500
Received: by mail-wr0-f196.google.com with SMTP id v15so398654wrb.8
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 04:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yS2J1ucZofAptrc9k63mB5pxYpGk6zIvPd+9f3j54zM=;
        b=jWZuKq98KjkA3cyuOnD4TqX12CeZsPhvaJRDaJyna+WjiL/yUTVb3WU6ftSNpBJ8TB
         Ut9/09wTSj2l0d0c+yW5sjCoL4XzbB3mZ5+FLOhyLw+BKnvsYVkRHMOgLC+o9D6eHmIO
         tfGBdlgZwPVujk3t7sgwj1GUxTf1ivs9GpHm4642HuFb0T4EGjnbr30S4goDnpu0ahaB
         VYu110Zse2g3Om64u8tu4rTxw2P+7M3BCzYHhA/tOa+Dea2mf5LcE8ImApluMDjDEt+r
         bQ8DGTrK2MnYRqc0NwCDjXH8ncbuk2HOijumifYtT2WWEYwZR4hpW0KNzfybfHJjANWn
         BFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yS2J1ucZofAptrc9k63mB5pxYpGk6zIvPd+9f3j54zM=;
        b=Ujwo/cGt8Dv7E44sMB0ifO/mTO4ieINXeDnoc4fggKHPblc5IQk2/owbpPm4oIpYez
         CXEpN9G+r+IXsDSJF43j5F8tqPzcDF8J5FDYRvjhdoKa+QHRuIh2BWNlc7Q7rALu3tgU
         AYx5c47ypiTNWY6MyQcdZI24pJCFSzqUreRAeVwpqEjHbIkH/eBTqpJqOO8CiwX2L39W
         IAOgtjEUf8hd7hJiSAUJ97Nkkn3+9JQGIpYeiMmpc+86K/yESMmRVyCUW7/6i7+JLg7b
         3fM8oSePnJOKtcnXDWnpL5d+iF0gmz1pv0cq52vxpGlhDqS73uhqyUtSkOdXXwoORYXj
         y3Qw==
X-Gm-Message-State: AKwxytfvtU8t1SlfCMVuloJVlA4Casya8YDWj+5/q0rfxGdmFwtPqHFn
        sdhZ7d4rMgRvUi1m9Ix6sT9YRA==
X-Google-Smtp-Source: AH8x224e1Y4OopuQdhsD/6NmnH4Rzk7wgubmRBLtWQMkAzAZNksZV1myW/kxZC019p9ITEPHveQ65w==
X-Received: by 10.223.135.18 with SMTP id a18mr11713350wra.122.1516970243980;
        Fri, 26 Jan 2018 04:37:23 -0800 (PST)
Received: from localhost.localdomain (x590dab0e.dyn.telefonica.de. [89.13.171.14])
        by smtp.gmail.com with ESMTPSA id d17sm4756626wrd.50.2018.01.26.04.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 04:37:23 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 03/10] t6022: don't run 'git merge' upstream of a pipe
Date:   Fri, 26 Jan 2018 13:37:01 +0100
Message-Id: <20180126123708.21722-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.155.g5159265b1
In-Reply-To: <20180126123708.21722-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The primary purpose of 't6022-merge-rename.sh' is to test 'git merge',
but one of the tests runs it upstream of a pipe, hiding its exit code.
Consequently, the test could continue even if 'git merge' exited with
error.

Use an intermediate file between 'git merge' and 'test_i18ngrep' to
catch a potential failure of the former.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t6022-merge-rename.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 05ebba7af..c01f721f1 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -242,10 +242,12 @@ test_expect_success 'merge of identical changes in a renamed file' '
 	rm -f A M N &&
 	git reset --hard &&
 	git checkout change+rename &&
-	GIT_MERGE_VERBOSITY=3 git merge change | test_i18ngrep "^Skipped B" &&
+	GIT_MERGE_VERBOSITY=3 git merge change >out &&
+	test_i18ngrep "^Skipped B" out &&
 	git reset --hard HEAD^ &&
 	git checkout change &&
-	GIT_MERGE_VERBOSITY=3 git merge change+rename | test_i18ngrep "^Skipped B"
+	GIT_MERGE_VERBOSITY=3 git merge change+rename >out &&
+	test_i18ngrep "^Skipped B" out
 '
 
 test_expect_success 'setup for rename + d/f conflicts' '
-- 
2.16.1.155.g5159265b1


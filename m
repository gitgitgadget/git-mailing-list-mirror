Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B7451F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeFZHbC (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:31:02 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40650 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752697AbeFZHa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:30:59 -0400
Received: by mail-it0-f67.google.com with SMTP id 188-v6so856566ita.5
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VZ70KeSHs8KwzWP2lIgGq01njn/edrEs2ezZFZj2o6Q=;
        b=WnYMzFYmeFtMCw2oxDa6ySy/cxtrq9PHjJhN/IKyXbMd/wgMmCj+LNzLKCdJXs0M3X
         Qq3zmqNd3lQhWxENZLUHFo4BuVrSWduyXBSXQC6JWsI0MYB7YkocHCzbzv+WLZnAJ94T
         2alYsVuNYu9pupnfnb4PJsh1njd1X9cCYsICj1KJMMiO1QP8UrcyhMlNLWQXZZQjEbVi
         w4GqVDM8+2qLZ7DR2baKAcmyBcfyP/Ry/5bSyfQ9apLqK5AV28Lrm4Bio6Y61PTpa4AB
         NVCFp3e5t5es8tgYt9348/MahwIH2gihBxB+fd+jTR939mcLACw6P5+MKv38q2LZyRUc
         owAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=VZ70KeSHs8KwzWP2lIgGq01njn/edrEs2ezZFZj2o6Q=;
        b=Bt2i+3vFPNSNWy60HSIa8vd2Q8tkUGD7LDIh6NJMiHjwLZsHZLjHwxhT5pZGhAiQmC
         2JUNVR9S6GQcmrP0ftU/7jHeuQbmD2FENt9nfp4K6MxuwKnSrMjtSD6l8nwfTjniCI5x
         A+NT5kXHuA9AJf2Iv+L62piDvpNRSuMLXx2kwc2yMdTs4QJJM6mqsspPiyrE8ljLgGZI
         SzQSqhS+Conej3JVBn8rTG/RRutHXxKmpmKzILdw1SEU1jD8arQxMaiYAanuSCvv/NbF
         pke0pdbGboCc924X4roFCbM4aR1lwKHU3nqwi+OrjLVV8jko1MhK/GvkDpBViHisv/Yh
         vXBg==
X-Gm-Message-State: APt69E2zx9dd6EUY4bo1iTP09mcDN6CEyO9VHQzWBDfNbevCXbMcZ9v+
        Ij3MigurO+ssiqVbeTrO4fMINg==
X-Google-Smtp-Source: AAOMgpcClfoals1eCOrbQNudhzH8USZUfI9g03JrZ63MixKP0od2gCSYEZ0SEIDB7D/DY88gdfGs+Q==
X-Received: by 2002:a24:fc83:: with SMTP id b125-v6mr518755ith.13.1529998258596;
        Tue, 26 Jun 2018 00:30:58 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.30.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:30:58 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 09/29] t7810: use test_expect_code() instead of hand-rolled comparison
Date:   Tue, 26 Jun 2018 03:29:41 -0400
Message-Id: <20180626073001.6555-10-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test manually checks the exit code of git-grep for a particular
value. In doing so, it breaks the &&-chain. An upcoming change will
teach --chain-lint to check the &&-chain inside subshells, so this
manual exit code handling will run afoul of the &&-chain check.
Therefore, replace the manual handling with test_expect_code() and a
normal &&-chain.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t7810-grep.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1797f632a3..fecee602c1 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -845,10 +845,9 @@ test_expect_success 'grep from a subdirectory to search wider area (1)' '
 test_expect_success 'grep from a subdirectory to search wider area (2)' '
 	mkdir -p s &&
 	(
-		cd s || exit 1
-		( git grep xxyyzz .. >out ; echo $? >status )
-		! test -s out &&
-		test 1 = $(cat status)
+		cd s &&
+		test_expect_code 1 git grep xxyyzz .. >out &&
+		! test -s out
 	)
 '
 
-- 
2.18.0.419.gfe4b301394


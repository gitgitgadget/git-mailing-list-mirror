Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB7E1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeFZHdG (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:33:06 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43918 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752694AbeFZHa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:30:58 -0400
Received: by mail-io0-f196.google.com with SMTP id i23-v6so12102470iog.10
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g/cqaRkthqUc+BmAv3MpwmQ2smqxAlHZKQFKoknq02c=;
        b=hOwpeRM/sMHVW81kSG2EDlP3HHFORnEUCgAracezl9lAtWX5kDJCUQkofAlIH0vzg4
         AOifR692vjgmcZmui39nF4+dsdnr/Zl3G4uxowh3aFuqdlDH4QaKExrVIFRpLvhuWVIT
         c4muyZamjsMklonN59oicwHDdOfaqq7PO+V0P60xIh2HaTFLMQ52yxTLbiBTVicjjGvV
         pUBbHoF37xM06v80vc/JnC/U9prNy9Oj9lNoab3w/tp+uy7ozv09yn6GSdhcHb45/MX2
         EmSc5ONNEoE9G5o0GU/D1eq6j2tNflEA51Erd2GlSQkioRw9iEQ9bbpGaQi4xG62UZQ2
         6HAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=g/cqaRkthqUc+BmAv3MpwmQ2smqxAlHZKQFKoknq02c=;
        b=ueb2eh0mjzYab5v93DUeB5zA+RrTlC45vsIZK+l4h67T8ZBzEDVviEwmTVAL8XvLFk
         fXWcQnlFNPeylUva9by7CTwzxdY5kV8yVMG9mRpuWOM4DKsaljObcGZknFi6qvJf3Gu8
         4ob55lLYKZ/5X85OXEmB8p23i9De9E4+0ijm7Isw0uTDd8GDvem/2DjNyOgndBfaDvu7
         vS7z/+g5rUK7LtFHurCOWdlCBQuL6zhcqqTvaZ2uY1mudF7F8MJHb+ENQgU16gEN5nyP
         CzL/vfZOKpAyzObFZCsWyuTXhM0IG502/LNH3h9DqeBYfqL+k4QZTD2DRSP0MdgOn13A
         +qmg==
X-Gm-Message-State: APt69E1uhhoPFH+uVleTY0/wPc/6AFwDGwAB165kR3c/MOPk2NBW+0wQ
        QdeBS5Og7J2wYUL0+t6g55N0JA==
X-Google-Smtp-Source: AAOMgpe1bdMpjWJWwF5D5DRvSa7PUqISrIlvczLjwbfqOX+PrPJW2HOc8DRNShB+k/r5qPrEbXsn9g==
X-Received: by 2002:a6b:17c7:: with SMTP id 190-v6mr277888iox.17.1529998257734;
        Tue, 26 Jun 2018 00:30:57 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.30.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:30:57 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 08/29] t7400: fix broken "submodule add/reconfigure --force" test
Date:   Tue, 26 Jun 2018 03:29:40 -0400
Message-Id: <20180626073001.6555-9-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test has been dysfunctional since it was added by 619acfc78c
(submodule add: extend force flag to add existing repos, 2016-10-06),
however, two problems early in the test went unnoticed due to a broken
&&-chain later in the test.

First, it tries configuring the submodule with repository "bogus-url",
however, "git submodule add" insists that the repository be either an
absolute URL or a relative pathname requiring prefix "./" or "../" (this
is true even with --force), but "bogus-url" does not meet those
criteria, thus the command fails.

Second, it then tries configuring a submodule with a path which is
.gitignore'd, which is disallowed. This restriction can be overridden
with --force, but the test neglects to use that option.

Fix both problems, as well as the broken &&-chain behind which they hid.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t7400-submodule-basic.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 812db137b8..401adaed32 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -171,12 +171,12 @@ test_expect_success 'submodule add to .gitignored path with --force' '
 test_expect_success 'submodule add to reconfigure existing submodule with --force' '
 	(
 		cd addtest-ignore &&
-		git submodule add --force bogus-url submod &&
-		git submodule add -b initial "$submodurl" submod-branch &&
-		test "bogus-url" = "$(git config -f .gitmodules submodule.submod.url)" &&
-		test "bogus-url" = "$(git config submodule.submod.url)" &&
+		git submodule add --force /bogus-url submod &&
+		git submodule add --force -b initial "$submodurl" submod-branch &&
+		test "/bogus-url" = "$(git config -f .gitmodules submodule.submod.url)" &&
+		test "/bogus-url" = "$(git config submodule.submod.url)" &&
 		# Restore the url
-		git submodule add --force "$submodurl" submod
+		git submodule add --force "$submodurl" submod &&
 		test "$submodurl" = "$(git config -f .gitmodules submodule.submod.url)" &&
 		test "$submodurl" = "$(git config submodule.submod.url)"
 	)
-- 
2.18.0.419.gfe4b301394


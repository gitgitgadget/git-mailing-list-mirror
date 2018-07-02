Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3F11F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbeGBAZO (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:14 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46766 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbeGBAZA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:25:00 -0400
Received: by mail-io0-f194.google.com with SMTP id p7-v6so860583ioh.13
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DNSu2YyWmvJNu/bh5jZHnB0kvhMvHguMfmIEYX+0iHE=;
        b=TlFPQKYk2C+DM4dTeuSCOSUNq5EBmokE3fwNLgUOjsWCmv2GvnPKluyvyLoKLpzFRt
         a8AMjuX2bSLY9qeroEf1P3hyGwH8GufpWEJ0eZhLKGdU+UZE12JBYx4oK5TO9q5FxmKI
         fHutUwsopnFY/e/CDwNjf4V/n/ezaGH+ZpvAWqZwQJ50AGlYfmiGSjq/0q+VYSbjK9E8
         i9oVSHFtDV5aPeH/IwUd5ERtKELsVwbHmGNvj+OFu62Pn8myt5XtHE6PUo3kzLbl6biv
         xiJgMLkyzYdEYOB+rva+mWBmR5V7f9jb8IJuBQBrl2k8WjvmvF+WuvFtialhEh8f64s0
         WYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=DNSu2YyWmvJNu/bh5jZHnB0kvhMvHguMfmIEYX+0iHE=;
        b=EkZSCoX6Hrkjg9kbgA19i+CEIiza8Nw3Rf2Sk7Ael8IEO5tWxp+m6COgqYGLE1skOt
         XBq++yUvLut/IZjD4pvPe78n6/xoq25E3EU1oGZMJtujxR4/8I6IJJw2pOfUY4WdivTw
         rpP9Zxuvjpk2cvxIotLvZXj0HCcRnibkyI4PbNxghXI0UrTFUZ1sxnwfYc033Rcn8Dsi
         chQNBmjgVe/CBQ0UdNG9pCy6LW5A/KjY98VhlTw3Co9V58ni7pjkl9fT2ztQYXauEwZ8
         3KtKny+LZQ+KEbOlFOYmYomPAbcpNBCAjf+WJfxNhaMvO7+7Sy3WJkxZVnWiXgqPMhgG
         zmbQ==
X-Gm-Message-State: APt69E1lYX2vY6MlZ+CZ+etnMrzSChXVLR56RslUtfElNtdho1JPvODX
        cmjOJUUVVt8q6ypm7+t2ECaUvg==
X-Google-Smtp-Source: AAOMgpdItVGvU6sEJFiYVq3xF/j+QJk4u6ryQF1QCARuM1Osks7lG0CS/1lKNWGglEKl6B7Xl76wYg==
X-Received: by 2002:a6b:ea05:: with SMTP id m5-v6mr1487453ioc.33.1530491099955;
        Sun, 01 Jul 2018 17:24:59 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.24.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:24:59 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 11/25] t7400: fix broken "submodule add/reconfigure --force" test
Date:   Sun,  1 Jul 2018 20:23:51 -0400
Message-Id: <20180702002405.3042-12-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
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

Reviewed-by: Stefan Beller <sbeller@google.com>
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
2.18.0.203.gfac676dfb9


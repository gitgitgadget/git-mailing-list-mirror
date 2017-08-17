Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47E82208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 10:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbdHQKeV (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 06:34:21 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.101]:8000 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbdHQKeV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 06:34:21 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1diI7z-0006wJ-Vo; Thu, 17 Aug 2017 12:34:16 +0200
Date:   Thu, 17 Aug 2017 12:34:13 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] add test for bug in git-mv with nested submodules
Message-ID: <20170817103413.GA52233@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using git-mv with a submodule it will detect that and update the
paths for its configurations (.gitmodules, worktree and gitfile). This
does not work for nested submodules where a user renames the root
submodule.

We discovered this fact when working on on-demand fetch for renamed
submodules. Lets add a test to document.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 t/t7001-mv.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index e365d1f..39f8aed 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -491,4 +491,13 @@ test_expect_success 'moving a submodule in nested directories' '
 	test_cmp actual expect
 '
 
+test_expect_failure 'moving nested submodules' '
+	git commit -am "cleanup commit" &&
+	git submodule add ./. sub_nested &&
+	git commit -m "add sub_nested" &&
+	git submodule update --init --recursive &&
+	git mv sub_nested sub_nested_moved &&
+	git status
+'
+
 test_done
-- 
2.0.0.274.g6b2cd91


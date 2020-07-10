Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE079C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B816620663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="V/oVi6mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGJCsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40392 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbgGJCsa (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:30 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0395760A62;
        Fri, 10 Jul 2020 02:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349308;
        bh=vM3TI4/RbUP1dFvpkiIgLxj2UZc7pmERZjdUoWlLhOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=V/oVi6mhSYinwwocLTYnVuXtNwK8kXpVra7pD9wqHd5APFMJcLOtNzAn9U/Gm/MTz
         EjdNPjSYuwG+p2q5wscIVvy82kd13/vwZZYxa8pFhpf+auRoGe1KYXUzngVf6lU+SJ
         HdSOrBH74lnX+FpR4szcSSxqgrUoZV2UVZNzMV/NFvYGVkJSojL9x1W26yxESsCLaN
         rYih5ZGozQmxLQePJSqi/j/omV8pp0n0FGyqel9OmBbYz25d6NMHrogNbDKVC5HfE9
         W+8GSUcbVXhBhqsTgg7wnDy3QZdzcxl/mEjW8T+j+lsoCOvvnTnAiJR8O0aPHTNPeO
         flWQMB5ZIcavmAsik2WTd5o9jSytbIcx5excbDqd0gagKkWye/7v/vRr/I+8R+HImO
         ok9XxG5ttrXiJbW1lPi+dIo/yDgym3Pz7fqLeX6OjTOliV8xHHfIY3F801ubrImvXP
         9/SzzFv28cMvNJHk+TLlj0ovW2ns6XI4JuWuLvswDcoCqQF5LpH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 10/38] t7003: compute appropriate length constant
Date:   Fri, 10 Jul 2020 02:47:00 +0000
Message-Id: <20200710024728.3100527-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using a specific invalid hard-coded object ID, look one
up from the translation table.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7003-filter-branch.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index e23de7d0b5..beeb2b855a 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -5,6 +5,7 @@ test_description='git filter-branch'
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
 test_expect_success 'setup' '
+	test_oid_init &&
 	test_commit A &&
 	GIT_COMMITTER_DATE="@0 +0000" GIT_AUTHOR_DATE="@0 +0000" &&
 	test_commit --notick B &&
@@ -463,10 +464,11 @@ test_expect_success 'rewrite submodule with another content' '
 '
 
 test_expect_success 'replace submodule revision' '
+	invalid=$(test_oid numeric) &&
 	git reset --hard original &&
 	git filter-branch -f --tree-filter \
 	    "if git ls-files --error-unmatch -- submod > /dev/null 2>&1
-	     then git update-index --cacheinfo 160000 0123456789012345678901234567890123456789 submod
+	     then git update-index --cacheinfo 160000 $invalid submod
 	     fi" HEAD &&
 	test $orig_head != $(git show-ref --hash --head HEAD)
 '

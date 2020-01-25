Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042F0C35242
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2382071E
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="X94u0wK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgAYXBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:01:12 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46820 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728842AbgAYXAs (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:48 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0015460FCD;
        Sat, 25 Jan 2020 23:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993248;
        bh=mXQc93j+2SH/6N2HARZnAnerIvvUrujqI/qP3IHZwoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=X94u0wK0DiZHRu6QzNeajnrZiy8aPC/EMSXcXUf6UKTQd92IVDYryYvzFW8rXW6OX
         E089eC0QfZ7iD2gCyUaJGKN2bD3UtWvTgWhcQDa9JiLE7bn3YHN1MDLcN77c2o8KrQ
         phSCyaqTLUd9FLXPJlFqGRiiAVqOPMR8zTvPJIvti7DzhAXvl7naxE/9yX4Fzg0cQK
         Ks2AqH69+c/2kVH2BXjGFMKi3wka+PgWXUGYvM4NPrUUNS2KsK4AO0oUatzpn6j5aq
         R0x4pzEYDkn9qBLS+mDaMCVmXTsQw5+ttwQ47NroMMtRhVjV6MgSJCs2KPLDlJZRRU
         +6mo3BYApG1LTCHzesRc1L/OwHziopsRjAvSBZd+3K0mQLxImHuIfx3ts+OJN7eZvb
         PycRex0VEiVmndN2fYokTV0QqEF/Cr+7zoy+P+ztWq94n9XlEykjUV69+DkSL72CSJ
         c+1k249OUGwmiCuPQ0fxHHpFYxwJXqzPa9nNshmXn//kB/NqMga
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 16/22] t5318: update for SHA-256
Date:   Sat, 25 Jan 2020 23:00:22 +0000
Message-Id: <20200125230035.136348-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch two tests to use $ZERO_OID to represent the all-zeros object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5318-commit-graph.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 3f03de6018..55a94072b1 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -629,7 +629,7 @@ test_expect_success 'corrupt commit-graph write (broken parent)' '
 		empty="$(git mktree </dev/null)" &&
 		cat >broken <<-EOF &&
 		tree $empty
-		parent 0000000000000000000000000000000000000000
+		parent $ZERO_OID
 		author whatever <whatever@example.com> 1234 -0000
 		committer whatever <whatever@example.com> 1234 -0000
 
@@ -650,7 +650,7 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
 		cd repo &&
 		tree="$(git mktree </dev/null)" &&
 		cat >broken <<-EOF &&
-		parent 0000000000000000000000000000000000000000
+		parent $ZERO_OID
 		author whatever <whatever@example.com> 1234 -0000
 		committer whatever <whatever@example.com> 1234 -0000
 

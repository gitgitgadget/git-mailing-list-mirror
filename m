Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8BCC433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D8B20663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mVgTqlAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGJCta (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:49:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40368 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726913AbgGJCse (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:34 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2116A60A68;
        Fri, 10 Jul 2020 02:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349310;
        bh=bkn6gRdFc3a7Wl1a2vTHql6/IoBndbcv3M9Ug3dmdYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mVgTqlAFQO5AIr4zICr+9WiTEdMzsbyGTx7pCk42BflwKpkUtnKbt+X2w2y/+3y42
         /hdsD+bMA5MQ9V1M97brqYARt0lfuqjLaDiYTi024hUnrSQzrCESqmB9L+iIqTP6o5
         qLp3aE/eb7xPzjy24o/eZIsC5hXuzlgSOOrff7H+VFCxUoDwtIwUyu/Ru8lnt+XxsI
         4oRKizZmWRBvrH91Uk9BD3e66Vnu7tiQbgXrXwE7U8gY5zAyGm1elQD2dZFKlr97h8
         ZJ9aoLcDGQSlKeYKGb1VsL41DZsPb0Ac9xaJu4YYPGdlJhbNFmApMqOUFz7clSYDdD
         RXv3CXr6N/9GZAFk2xlrlLqFSuAMl3+bLuV1EP9TslBZZDx7WvFC4xjTe4jLbRG1AS
         J0/yFWB3T+uSgl65V3ZWisK62QAsKXB6pbzRcbWcJXV5fr3sKc3M7+AxmmDtaVWy57
         hKTe5iCNhn6Q1f35sR886d40k4ZmfT//hmcOFjiqAwowDgrsuvx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 15/38] t7405: make hash size independent
Date:   Fri, 10 Jul 2020 02:47:05 +0000
Message-Id: <20200710024728.3100527-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $ZERO_OID instead of hard-coding a fixed size all-zeros object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7405-submodule-merge.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index aa33978ed2..6a1e5f8232 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -195,7 +195,7 @@ test_expect_success 'git submodule status should display the merge conflict prop
        url = $TRASH_DIRECTORY/sub
 EOF
        cat >expect <<EOF &&
-U0000000000000000000000000000000000000000 sub
+U$ZERO_OID sub
 EOF
        git submodule status > actual &&
        test_cmp expect actual &&
@@ -214,7 +214,7 @@ test_expect_success 'git submodule status should display the merge conflict prop
        url = $TRASH_DIRECTORY/sub
 EOF
        cat >expect <<EOF &&
-U0000000000000000000000000000000000000000 sub
+U$ZERO_OID sub
 EOF
        git submodule status > actual &&
        test_cmp expect actual &&

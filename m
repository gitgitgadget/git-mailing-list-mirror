Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A4EC433E2
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B9F20708
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="e/nC61vL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGJCtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:49:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40478 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727826AbgGJCs5 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:57 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 40915607F6;
        Fri, 10 Jul 2020 02:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349306;
        bh=YnqhRm5cXPRi/ZkOai5UFwRTufPby2S7+lcAS3bYyKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=e/nC61vLt69Eqy6ExVYu+49CYafuwOPriWD3Bi7IjKh6+lztb59lhF1StQENpkiiS
         l1jvMH+DqbTQFKTKJcK7rvzI86xLvBIpSvTLdMWZyPzvnYB02dNqlG2zlEJgUVn7rS
         eZoicyTTQfpwR40i/2BtNNCfWxPHQWxvfzgoa6pCoX4oV9Bw1NJ5NUyi0IlCnYtR8N
         2hctrtnFaAhoJXVQEKAFY5iertt4a94YHtLpc/oFddrtFhD1gm4Vg8EOCbIELu82+E
         Rlxb2B/pXC+xjusvjTgPyJyUavSud58C0iLMP2oPtZEORcZcZmzYwUDJCijTxsQ61g
         nzKsANAK5pgVb08pgaLq86R7rJpfeZGR3VWp5YkH2WQwyhgX50leb2iGoGXIkmmkBQ
         qTqL2sP7A5BIpLDbymEZZGhyLim+xqMeaizPcETxIRK7RW6I551qhWKle/G/zly4dN
         jX4DpvB9jZpFz3907m9P4tTJaPSP/hHE3EzLHp/emZVNYdZnVQ3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 06/38] t6101: make hash size independent
Date:   Fri, 10 Jul 2020 02:46:56 +0000
Message-Id: <20200710024728.3100527-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $OID_REGEX instead of a hard-coded regular expression.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6101-rev-parse-parents.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 7683e4a114..7531262a5e 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -34,7 +34,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'start is valid' '
-	git rev-parse start | grep "^[0-9a-f]\{40\}$"
+	git rev-parse start | grep "^$OID_REGEX$"
 '
 
 test_expect_success 'start^0' '

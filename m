Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B16C433E6
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68615206F4
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dKjrfPU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgGMCt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:49:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40618 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgGMCt0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:49:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 630FD60A60;
        Mon, 13 Jul 2020 02:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608565;
        bh=YnqhRm5cXPRi/ZkOai5UFwRTufPby2S7+lcAS3bYyKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=dKjrfPU/KHyNbD3MkMRmUYGCfsIMGoKyzE6HNimL4yTL3KHd2arMob/YdtFKUQnWX
         RLiLfVfgtGP8GjbY4XzBcy78s36EdAk6ulnEqXtNAnJfLHr7ict68zo1UQCkPl88rE
         AeZ55WgkyWC/V7jMxi/zym6GkGtOTjVdB2akOt0KXuaEXhqCEGv47+1x7FQrETFuW3
         D9sd72eWViOzcYykmtCYcfRRvxOWgPpl/iVCEn0lb8hnw+vhXAdZRrZBhbc/0SUMoC
         mDCKBt0gHTKYfG+rlA8HsFcMMTuL0QfJSjnb4iUgrooHHs+FzrpYJ0DzUv92C9eSjf
         y+1WXL3EBJukEboggssLb+AOL70yYAu2xMZPz0k8TV0cXTlwB6vyU53xKvpHrXhd8Q
         3VMkprYKz05pDFPj632P8SAkmt0Rr+BGAiCM+FQMOlxwXXzsqxUbq7+6ouhoO91PQj
         ZI/+8LIrJQz8mf2hSUcb4RjHTyEVynKSLO4TDsrVD0zY1rtJPyM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 06/39] t6101: make hash size independent
Date:   Mon, 13 Jul 2020 02:48:36 +0000
Message-Id: <20200713024909.3714837-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
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

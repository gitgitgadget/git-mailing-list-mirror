Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B95C433FE
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F6256138D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhKRQwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:52:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57598 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbhKRQwt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7556B1FD3B
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5u0gR8S2YhsGDhIzIgdL+6Z5zuuzGq1jMQ8S4UfHUaE=;
        b=BzAJ9/w0011BdChO7sf3e2/h7WXiNLTHcL8lkW7CyB0r5g76IykFHABfZf4DQUnk9NGCyz
        YwRq4ZBJsi294oZTdUcsiIa/BR6yY8CfiQQ57byZ9QnkRzhMdjRM2NBm+JtokRB2986Tha
        tCLfO8k6UFNlFTdMY7qLK5u8SFvYak4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5u0gR8S2YhsGDhIzIgdL+6Z5zuuzGq1jMQ8S4UfHUaE=;
        b=aLdFhNkTlea4HbxHyOcuO+BYLiRiAqFzD5CN49IsHr/qQBlSLQ7dxcP96kG+85xVMOJMSP
        I2+TRV1r6Trz/ECA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 69C22A3B94;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9260C1F2CA9; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 10/27] bisect: Fixup bisect-porcelain/58
Date:   Thu, 18 Nov 2021 17:49:23 +0100
Message-Id: <20211118164940.8818-11-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 58 from t6030-bisect-porcelain.sh assumes that bisection algorithm
suggests HASH6 as the last bisection step when HASH5 is an equivalent
choice. Fix the test to work in both cases.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 t/t6030-bisect-porcelain.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 46d67929e1e5..3363dc765b9d 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -811,7 +811,8 @@ test_expect_success '"git bisect bad HEAD" behaves as "git bisect bad"' '
 	git bisect start HEAD $HASH1 &&
 	git bisect good HEAD &&
 	git bisect bad HEAD &&
-	test "$HASH6" = $(git rev-parse --verify HEAD) &&
+	rev=$(git rev-parse --verify HEAD) &&
+	test "$HASH5" = "$rev" -o "$HASH6" = "$rev" &&
 	git bisect reset
 '
 
-- 
2.26.2


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C28C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267016138D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhKRQxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57646 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhKRQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7CBF71FD3E
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1pyOw1MAjgaQTX2QSTF+ebbWNKx+ZrqnpMJuQb6wcHQ=;
        b=rCp6INoRpB6CdjaM1lQPwjTw4NBk94kwmPdaVc10akR5hzX/TPFJN2QckNjJUnvBRRE2fF
        w2G1ecOmsQ3EbUPOQ8CubqSJb8OZG5NLwh82ja3hvwd4VsPOj5BPtUMCZPgmXXBSjGoNFR
        F/zsJQzIiv7UtYyiTCfzQV40EgRUd3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1pyOw1MAjgaQTX2QSTF+ebbWNKx+ZrqnpMJuQb6wcHQ=;
        b=flkMddKO7W1LI6tTJmRTgFFhAcmPjIKm67SKPWXiJd/QkMyiMjRgXRfLTcumwtO7zc3n27
        IfPrwHPKgQjbntDg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 62110A3B90;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8852E1F2CA5; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 07/27] bisect: Remove duplicated bisect-porcelain/48
Date:   Thu, 18 Nov 2021 17:49:20 +0100
Message-Id: <20211118164940.8818-8-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 48 from t6030-bisect-porcelain.sh claims it tests whether bisection
fails if tree is broken on start commit. However that actually does not
happen because the bisection really only fails because the first trial
point we choose happens to be broken. Furthermore there is another
equivalent trial point which is not broken so the test is not reliable.
Remove it as test 49 tests the same behavior is a more reliable setting.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 t/t6030-bisect-porcelain.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 0f2a91996393..4ec7b5b5a72e 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -675,12 +675,6 @@ cat > expected.missing-tree.default <<EOF
 fatal: unable to read tree $deleted
 EOF
 
-test_expect_success 'bisect fails if tree is broken on start commit' '
-	git bisect reset &&
-	test_must_fail git bisect start BROKEN_HASH7 BROKEN_HASH4 2>error.txt &&
-	test_cmp expected.missing-tree.default error.txt
-'
-
 test_expect_success 'bisect fails if tree is broken on trial commit' '
 	git bisect reset &&
 	test_must_fail git bisect start BROKEN_HASH9 BROKEN_HASH4 2>error.txt &&
-- 
2.26.2


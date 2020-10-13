Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C931C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 09:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2EAD206F4
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 09:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="ZkS37RPw";
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="ZkS37RPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbgJNJYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731170AbgJNJV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 05:21:56 -0400
Received: from mail.sammserver.com (sammserver.com [IPv6:2001:470:5a5b:1::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F928C0613E6
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 14:31:28 -0700 (PDT)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id BB091110A4C0; Tue, 13 Oct 2020 23:31:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602624686; bh=vRAfSqMkuCoQOkGhAtvMRsi33OyBUxDS+welrA0/Xa0=;
        h=From:To:Cc:Subject:Date:From;
        b=ZkS37RPwzNzT6afmqiFp+U7hi3qS3xknxtdxPPd5NG4s3FO6Lr7qVE0xynVPW9U/w
         R3xl81qbppD3a+JcJ1u43wVsJ2dxmuDVE4EQg2G7xjOq+GWGTgfzzg2l/Nl1lC5p3Z
         VZqga2Lu64EA8pZ7jHELWWyxQZzCb7AtY34OqSyE=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id 373F5110A4B9;
        Tue, 13 Oct 2020 23:31:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602624686; bh=vRAfSqMkuCoQOkGhAtvMRsi33OyBUxDS+welrA0/Xa0=;
        h=From:To:Cc:Subject:Date:From;
        b=ZkS37RPwzNzT6afmqiFp+U7hi3qS3xknxtdxPPd5NG4s3FO6Lr7qVE0xynVPW9U/w
         R3xl81qbppD3a+JcJ1u43wVsJ2dxmuDVE4EQg2G7xjOq+GWGTgfzzg2l/Nl1lC5p3Z
         VZqga2Lu64EA8pZ7jHELWWyxQZzCb7AtY34OqSyE=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id 1E7A91420A8F; Tue, 13 Oct 2020 23:31:24 +0200 (CEST)
From:   =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
Subject: [PATCH v3 1/3] t3435: use `test_config` instead of `git config`
Date:   Tue, 13 Oct 2020 23:30:22 +0200
Message-Id: <20201013213021.3671432-1-samuel@cavoj.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace usages of `git config` with `test_config` in t3435 to prevent
side-effects between tests.

Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
---
changed v2 -> v3:
    - added this patch
---
 t/t3435-rebase-gpg-sign.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
index b47c59c190..696cb6b6a4 100755
--- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -27,7 +27,7 @@ test_rebase_gpg_sign () {
 	shift
 	test_expect_success "rebase $* with commit.gpgsign=$conf $will sign commit" "
 		git reset two &&
-		git config commit.gpgsign $conf &&
+		test_config commit.gpgsign $conf &&
 		set_fake_editor &&
 		FAKE_LINES='r 1 p 2' git rebase --force-rebase --root $* &&
 		$must_fail git verify-commit HEAD^ &&
@@ -63,7 +63,7 @@ test_rebase_gpg_sign   false -i --no-gpg-sign --gpg-sign
 
 test_expect_failure 'rebase -p --no-gpg-sign override commit.gpgsign' '
 	git reset --hard merged &&
-	git config commit.gpgsign true &&
+	test_config commit.gpgsign true &&
 	git rebase -p --no-gpg-sign --onto=one fork-point master &&
 	test_must_fail git verify-commit HEAD
 '
-- 
2.28.0


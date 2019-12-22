Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B78C2D0C0
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 15:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02182070A
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 15:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfLVPD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 10:03:57 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:16713 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfLVPD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Dec 2019 10:03:57 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47gm2z13dSz5tlD
        for <git@vger.kernel.org>; Sun, 22 Dec 2019 16:03:54 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 4A80C239
        for <git@vger.kernel.org>; Sun, 22 Dec 2019 16:03:54 +0100 (CET)
From:   Johannes Sixt <j6t@kdbg.org>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] t3008: find test-tool through path lookup
Message-ID: <2dc0b0f3-19ce-62ab-5af9-fdb2d05b00bd@kdbg.org>
Date:   Sun, 22 Dec 2019 16:03:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do not use $GIT_BUILD_DIR without quotes; it may contain spaces and be
split into fields. But it is not necessary to access test-tool with an
absolute path in the first place as it can be found via path lookup.
Remove the explicit path.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Found this today coincidentally when I happened to look at the terminal
 with test output at the right time and saw a suspicous error message
 that included just one half of the build directory path.

 -- Hannes

 t/t3008-ls-files-lazy-init-name-hash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
index 64f047332b..85f3704958 100755
--- a/t/t3008-ls-files-lazy-init-name-hash.sh
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -4,7 +4,7 @@ test_description='Test the lazy init name hash with various folder structures'
 
 . ./test-lib.sh
 
-if test 1 -eq $($GIT_BUILD_DIR/t/helper/test-tool online-cpus)
+if test 1 -eq $(test-tool online-cpus)
 then
 	skip_all='skipping lazy-init tests, single cpu'
 	test_done
-- 
2.24.1.524.gae569673ff


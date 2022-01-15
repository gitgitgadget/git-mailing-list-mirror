Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8C6C433F5
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 14:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiAOO6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 09:58:44 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:33184 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbiAOO6o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 09:58:44 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4JbhBV20ZRz5tl9;
        Sat, 15 Jan 2022 15:58:42 +0100 (CET)
Message-ID: <df42170b-8659-d496-3454-a4a3ac2827eb@kdbg.org>
Date:   Sat, 15 Jan 2022 15:58:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: [PATCH] t3705-add-sparse-checkout: ignore a LF->CRLF warning on
 Windows
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <7ed402e0-63cd-2875-b3ac-71c967ccf80a@kdbg.org>
In-Reply-To: <7ed402e0-63cd-2875-b3ac-71c967ccf80a@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are checks that certain `git add` invocations do not produce
output on stderr. One of them, the original one, uses
"-c core.autocrlf=input" to ensure that `git add` does not write a
hint about LF to CRLF conversion to stderr on Windows. A second
`git add` was added in later patch, but it was forgotten to add
the same protection. Add it now to let the test pass on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 13.01.22 um 22:12 schrieb Johannes Sixt:
> is there a reason we don't do this in the test case that you added in
> 63b60b3add75 ("add: update --chmod to skip sparse paths", 2021-09-24).
> Notice that the similar git add earlier also sets core.autocrlf.

Here's a proper patch.

 t/t3705-add-sparse-checkout.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 81f3384eee..4fb663e3b4 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -184,7 +184,7 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 	git ls-files --stage >actual &&
 	grep "^100644 .*sparse_entry\$" actual &&
 
-	git add --sparse --chmod=+x sparse_entry 2>stderr &&
+	git -c core.autocrlf=input add --sparse --chmod=+x sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
 	git ls-files --stage >actual &&
 	grep "^100755 .*sparse_entry\$" actual &&
-- 
2.34.1.141.g867d0e9267

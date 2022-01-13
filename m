Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3D7C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 21:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbiAMVMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 16:12:12 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:32020 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbiAMVMK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 16:12:10 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4JZcZJ4nSjz5tlK;
        Thu, 13 Jan 2022 22:12:08 +0100 (CET)
Message-ID: <7ed402e0-63cd-2875-b3ac-71c967ccf80a@kdbg.org>
Date:   Thu, 13 Jan 2022 22:12:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
X-Mozilla-News-Host: news://nntp.gmane.org:119
Content-Language: en-US
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: Test failure on Windows in t3705-add-sparse-checkout.sh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

is there a reason we don't do this in the test case that you added in
63b60b3add75 ("add: update --chmod to skip sparse paths", 2021-09-24).
Notice that the similar git add earlier also sets core.autocrlf. As the
comment indicates, stderr indeed contains a warning about LF->CRLF
conversion in my Windows build and fails test_must_be_empty.

diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 81f3384eee..4fb663e3b4 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -181,13 +181,13 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 	# Avoid munging CRLFs to avoid an error message
 	git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
 	git ls-files --stage >actual &&
 	grep "^100644 .*sparse_entry\$" actual &&
 
-	git add --sparse --chmod=+x sparse_entry 2>stderr &&
+	git -c core.autocrlf=input add --sparse --chmod=+x sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
 	git ls-files --stage >actual &&
 	grep "^100755 .*sparse_entry\$" actual &&
 
 	git reset &&
 


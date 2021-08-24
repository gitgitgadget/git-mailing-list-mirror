Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5FAC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D39A3610F7
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbhHXSC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 14:02:27 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:50125 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239802AbhHXSCR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 14:02:17 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4GvH3t3Lq8z5tl9;
        Tue, 24 Aug 2021 20:01:30 +0200 (CEST)
To:     Gregory Anders <greg@gpanders.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t9001: PATH must not use Windows-style paths
Message-ID: <4f5c5633-f5a2-3c99-329e-3057b8d447d2@kdbg.org>
Date:   Tue, 24 Aug 2021 20:01:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, $(pwd) returns a drive-letter style path C:/foo, while $PWD
contains a POSIX style /c/foo path. When we want to interpolate the
current directory in the PATH variable, we must not use the C:/foo style,
because the meaning of the colon is ambiguous. Use the POSIX style.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This belongs on top of branch ga/send-email-sendmail-cmd.

 t/t9001-send-email.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 57fc10e7f8..595cbad372 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2198,7 +2198,7 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 
 test_expect_success $PREREQ 'test using command name with --sendmail-cmd' '
 	clean_fake_sendmail &&
-	PATH="$(pwd):$PATH" \
+	PATH="$PWD:$PATH" \
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-- 
2.33.0.129.g739793498e


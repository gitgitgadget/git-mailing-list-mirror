Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73027C433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 16:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B1364DF5
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 16:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhA3QYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 11:24:05 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:24442 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231968AbhA3QXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 11:23:16 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4DSfcd5mJfz5tl9;
        Sat, 30 Jan 2021 17:22:25 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 39FCA2137;
        Sat, 30 Jan 2021 17:22:25 +0100 (CET)
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] annotate-tests: quote variable expansions containing path
 names
Message-ID: <cec4f442-03ea-e846-2613-f390b1e4d31b@kdbg.org>
Date:   Sat, 30 Jan 2021 17:22:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test case added by 9466e3809d ("blame: enable funcname blaming with
userdiff driver", 2020-11-01) forgot to quote variable expansions. This
causes failures when the current directory contains blanks.

On variable that the test case introduces will not have IFS characters
and could remain without quotes, but let's quote all expansions for
consistency, not just the one that has the path name.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/annotate-tests.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index ee5d2d4cf8..29ce89090d 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -483,12 +483,12 @@ test_expect_success 'setup -L :funcname with userdiff driver' '
 	echo "fortran-* diff=fortran" >.gitattributes &&
 	fortran_file=fortran-external-function &&
 	orig_file="$TEST_DIRECTORY/t4018/$fortran_file" &&
-	cp $orig_file . &&
-	git add $fortran_file &&
+	cp "$orig_file" . &&
+	git add "$fortran_file" &&
 	GIT_AUTHOR_NAME="A" GIT_AUTHOR_EMAIL="A@test.git" \
 	git commit -m "add fortran file" &&
-	sed -e "s/ChangeMe/IWasChanged/" <"$orig_file" >$fortran_file &&
-	git add $fortran_file &&
+	sed -e "s/ChangeMe/IWasChanged/" <"$orig_file" >"$fortran_file" &&
+	git add "$fortran_file" &&
 	GIT_AUTHOR_NAME="B" GIT_AUTHOR_EMAIL="B@test.git" \
 	git commit -m "change fortran file"
 '
-- 
2.30.0.119.g680bcb97f5

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33DB520279
	for <e@80x24.org>; Fri,  3 Mar 2017 17:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbdCCRcv (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 12:32:51 -0500
Received: from mout.gmx.net ([212.227.15.19]:54212 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751637AbdCCRcu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 12:32:50 -0500
Received: from virtualbox ([89.204.154.17]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LZzKf-1c0J6M2Kcv-00ljIK; Fri, 03
 Mar 2017 18:32:43 +0100
Date:   Fri, 3 Mar 2017 18:32:42 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v3 2/9] setup_git_directory(): use is_dir_sep() helper
In-Reply-To: <cover.1488562287.git.johannes.schindelin@gmx.de>
Message-ID: <6211def3f876aaed0aabf479ef048e6d52135b97.1488562287.git.johannes.schindelin@gmx.de>
References: <cover.1488506615.git.johannes.schindelin@gmx.de> <cover.1488562287.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dhqSAt8ATyUm9TvMvUmFTXXG5Tap5Nv5lrnW4tStcOkb6EqVeTC
 XDdV9JBBro7+1Ucmkks1kDD/blmdjsNAJUoI65Ph95/7l4gxHONHzteTfJptGphei0jYAEr
 r/c/9kZyv1fFhFezPsIr5xwCmRCH3UEt0Jw3rHfpmZl7Gtu2f1k9sGThDDHdbdv0CCPIhUg
 yTLzp/kh2PaGyMSBJ/gNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k5getteU5aU=:7UFLwyAV/mNc4U7l+ACeqY
 uVyrQ9j698KZsGbHZub8cRoZW5wTAn2M5P3iBqu0SlhINQ8ZULXM37ePLPrY/g2MVPdRDUPus
 1ZpE9GBmbPYELyIxiuIbVqlXgDd/CjS0gD2cUMmuu7lBYQQaqBtj3SCNJYqfPEl6DQtviUAH+
 QQ/a1JMoj05y4/67juWwwstB/Duvl9XGkn7eFldnKoGO/JqM9kFE10vEnNbmGU05wVZUIdaVD
 jQu+eUfg+oRk4t47cvQO0L26uz4on4KDwV0QgJS5IcGR1dUepTMfrwlsxWieRaogaaykL2Gnh
 dGVXVbjd9oU4Ki4Ee8qgYeaU668hu7fpu4bLbvfyOOMvSqBYXZRfdI6175wrUG5zgNT7DDDtk
 7I6cFz67deCONNwBVf8Ch+iFUggrHULT4JL8H+bLxUZr5CAw30jirfHbdz7xhfOsrxaDonNaN
 cQ/hI+Oz7fXlB3gcDJRAlGaeqvPdId0MuH4s0FIuSLQE0rr/ZUVTDhzNqX3+oflGxRaMuiVkQ
 UCOV05XVdOiTIk0R/sTrHSU708nmIvZXzPmU637vFv+QUq/tjjhUuT3Lz+8NQbvlr1g78kyKh
 tYuaTP8pZyAz1QfG2ZrMoLz/RymZakC80qyNdtDIlc0hADSdAdrFyDXn81gvr4NJ1F7xcDCBc
 hElV3aqAMvv78Hljv+xBhlrOCIBFQrheVjDLvrQ5hBsAx5a8WW0MVtEDx7L5VyIHOpKrbSGTU
 yHkPGFtCz/DIwq3DsFBND2ZodaONZVqEYUNZd99k0cnFruDHy97zSJOOCr4NAauQWu/3NvPn3
 nwGDxwr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is okay in practice to test for forward slashes in the output of
getcwd(), because we go out of our way to convert backslashes to forward
slashes in getcwd()'s output on Windows.

Still, the correct way to test for a dir separator is by using the
helper function we introduced for that very purpose. It also serves as a
good documentation what the code tries to do (not "how").

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 967f289f1ef..c47619605fb 100644
--- a/setup.c
+++ b/setup.c
@@ -910,7 +910,8 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 			return setup_bare_git_dir(&cwd, offset, nongit_ok);
 
 		offset_parent = offset;
-		while (--offset_parent > ceil_offset && cwd.buf[offset_parent] != '/');
+		while (--offset_parent > ceil_offset &&
+		       !is_dir_sep(cwd.buf[offset_parent]));
 		if (offset_parent <= ceil_offset)
 			return setup_nongit(cwd.buf, nongit_ok);
 		if (one_filesystem) {
-- 
2.12.0.windows.1.7.g94dafc3b124



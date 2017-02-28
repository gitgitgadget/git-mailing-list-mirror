Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E571F5FB
	for <e@80x24.org>; Tue, 28 Feb 2017 01:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbdB1BYn (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 20:24:43 -0500
Received: from avasout04.plus.net ([212.159.14.19]:48336 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbdB1BYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 20:24:25 -0500
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout04 with smtp
        id q1QA1u00122aPyA011QBMW; Tue, 28 Feb 2017 01:24:11 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Groywg9C c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=-gPJ9X2i7AZDkWNTCYkA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/2] wrapper.c: remove unused git_mkstemp() function
Message-ID: <976c40d1-42dc-1fc5-45d5-05bdcf04d97e@ramsayjones.plus.com>
Date:   Tue, 28 Feb 2017 01:24:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The last caller of git_mkstemp() was removed in commit 6fec0a89
("verify_signed_buffer: use tempfile object", 16-06-2016). Since
the introduction of the 'tempfile' APIs, along with git_mkstemp_mode,
it is unlikely that new callers will materialize. Remove the dead
code.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 cache.h   |  3 ---
 wrapper.c | 17 -----------------
 2 files changed, 20 deletions(-)

diff --git a/cache.h b/cache.h
index 61fc86e6d..a575684a9 100644
--- a/cache.h
+++ b/cache.h
@@ -1045,9 +1045,6 @@ static inline int is_empty_tree_oid(const struct object_id *oid)
 	return !hashcmp(oid->hash, EMPTY_TREE_SHA1_BIN);
 }
 
-
-int git_mkstemp(char *path, size_t n, const char *template);
-
 /* set default permissions by passing mode arguments to open(2) */
 int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
 int git_mkstemp_mode(char *pattern, int mode);
diff --git a/wrapper.c b/wrapper.c
index e7f197996..1a140639f 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -440,23 +440,6 @@ int xmkstemp(char *template)
 	return fd;
 }
 
-/* git_mkstemp() - create tmp file honoring TMPDIR variable */
-int git_mkstemp(char *path, size_t len, const char *template)
-{
-	const char *tmp;
-	size_t n;
-
-	tmp = getenv("TMPDIR");
-	if (!tmp)
-		tmp = "/tmp";
-	n = snprintf(path, len, "%s/%s", tmp, template);
-	if (len <= n) {
-		errno = ENAMETOOLONG;
-		return -1;
-	}
-	return mkstemp(path);
-}
-
 /* Adapted from libiberty's mkstemp.c. */
 
 #undef TMP_MAX
-- 
2.12.0

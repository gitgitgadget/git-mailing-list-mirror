Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBDFC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 19:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjEHTBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 15:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEHTBs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 15:01:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B9430D0
        for <git@vger.kernel.org>; Mon,  8 May 2023 12:01:47 -0700 (PDT)
Received: (qmail 13885 invoked by uid 109); 8 May 2023 19:01:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 May 2023 19:01:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3627 invoked by uid 111); 8 May 2023 19:01:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 May 2023 15:01:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 8 May 2023 15:01:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] t7001: use "ls-files --format" instead of "cut"
Message-ID: <20230508190146.GB2366490@coredump.intra.peff.net>
References: <20230508185953.GA2108869@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230508185953.GA2108869@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since ls-files recently learned a "--format" option, we can use that
rather than asking for all of "--stage" and then pulling out the bits we
want with "cut". That's simpler and avoids two extra processes (one for
cut, and one for the subshell to hold the intermediate result).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7001-mv.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index ea70419928..2e6a3c0a54 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -5,8 +5,7 @@ test_description='git mv in subdirs'
 . "$TEST_DIRECTORY"/lib-diff-data.sh
 
 index_at_path () {
-	entry=$(git ls-files --stage "$@") &&
-	echo "$entry" | cut -f 1
+	git ls-files --format='%(objectmode) %(objectname) %(stage)' "$@"
 }
 
 test_expect_success 'mv -f refreshes updated index entry' '
-- 
2.40.1.802.gdef2a8734a


Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3064BC4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56672071E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgI3MfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:35:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:45340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgI3MfB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 08:35:01 -0400
Received: (qmail 24050 invoked by uid 109); 30 Sep 2020 12:35:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 12:35:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28138 invoked by uid 111); 30 Sep 2020 12:35:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 08:35:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 08:35:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/10] dir.c: drop unused "untracked" from treat_path_fast()
Message-ID: <20200930123500.GJ1901279@coredump.intra.peff.net>
References: <20200930122732.GA1901036@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930122732.GA1901036@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't use the untracked_cache_dir parameter that is passed in, but
instead look at the untracked_cache_dir inside the cached_dir struct we
are passed. It's been this way since the introduction of
treat_path_fast() in 91a2288b5f (untracked cache: record/validate dir
mtime and reuse cached output, 2015-03-08).

Signed-off-by: Jeff King <peff@peff.net>
---
This is the one I'm least sure of (not that it makes anything worse, but
that it might be hiding a bug; I'm pretty sure I just don't understand
how the untracked-cache code works, though).

 dir.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 3018a657b0..78387110e6 100644
--- a/dir.c
+++ b/dir.c
@@ -2105,7 +2105,6 @@ static int resolve_dtype(int dtype, struct index_state *istate,
 }
 
 static enum path_treatment treat_path_fast(struct dir_struct *dir,
-					   struct untracked_cache_dir *untracked,
 					   struct cached_dir *cdir,
 					   struct index_state *istate,
 					   struct strbuf *path,
@@ -2153,7 +2152,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 	int has_path_in_index, dtype, excluded;
 
 	if (!cdir->d_name)
-		return treat_path_fast(dir, untracked, cdir, istate, path,
+		return treat_path_fast(dir, cdir, istate, path,
 				       baselen, pathspec);
 	if (is_dot_or_dotdot(cdir->d_name) || !fspathcmp(cdir->d_name, ".git"))
 		return path_none;
-- 
2.28.0.1173.gad90222cf0

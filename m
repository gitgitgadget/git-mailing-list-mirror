Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D22F71FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966185AbdCXS7R (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:59:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:51291 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965753AbdCXS7P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:59:15 -0400
Received: (qmail 24623 invoked by uid 109); 24 Mar 2017 18:59:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 18:59:14 +0000
Received: (qmail 24019 invoked by uid 111); 24 Mar 2017 18:59:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 14:59:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 14:59:12 -0400
Date:   Fri, 24 Mar 2017 14:59:12 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: [PATCH] pager_in_use: use git_env_bool()
Message-ID: <20170324185912.rvzi46kr5ldxnehm@sigill.intra.peff.net>
References: <20170321055203.26488-1-alexhenrie24@gmail.com>
 <xmqqinn2sfdw.fsf@gitster.mtv.corp.google.com>
 <xmqqzigemfij.fsf@gitster.mtv.corp.google.com>
 <CAMMLpeQZXzPtN+mmtRS33vbT6hFz8p0qqjFMhz9tUHk747=Z3Q@mail.gmail.com>
 <xmqqmvcdmeuv.fsf@gitster.mtv.corp.google.com>
 <CAMMLpeR-zCpL5Gx=BoK8G9_wL2TBe-wD3VnsAShAuVVzS=Nirg@mail.gmail.com>
 <xmqqfui4f0pp.fsf@gitster.mtv.corp.google.com>
 <CAMMLpeRtzYM3a639DcNbhqAmz3dNkRebvQps-gusEKx+eQqPgQ@mail.gmail.com>
 <20170324185543.uq4clqyvbdkahbzo@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170324185543.uq4clqyvbdkahbzo@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 02:55:43PM -0400, Jeff King wrote:

> But I was concerned that there might be a bug in pager_in_use(), so I
> dug into it a little. I think the code there is correct; [...]

I did see this small cleanup opportunity, though.

-- >8 --
Subject: [PATCH] pager_in_use: use git_env_bool()

The pager_in_use() function predates git_env_bool(), but
ends up doing the same thing.  Let's make use of the latter,
which is shorter and less repetitive.

Signed-off-by: Jeff King <peff@peff.net>
---
 pager.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/pager.c b/pager.c
index 73ca8bc3b..c113d898a 100644
--- a/pager.c
+++ b/pager.c
@@ -135,9 +135,7 @@ void setup_pager(void)
 
 int pager_in_use(void)
 {
-	const char *env;
-	env = getenv("GIT_PAGER_IN_USE");
-	return env ? git_config_bool("GIT_PAGER_IN_USE", env) : 0;
+	return git_env_bool("GIT_PAGER_IN_USE", 0);
 }
 
 /*
-- 
2.12.1.843.g1937c56c2


Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CC3C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5FA21655
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507399AbgJ0HNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 03:13:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:38256 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507397AbgJ0HNK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 03:13:10 -0400
Received: (qmail 14237 invoked by uid 109); 27 Oct 2020 07:13:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2020 07:13:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15022 invoked by uid 111); 27 Oct 2020 07:13:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2020 03:13:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Oct 2020 03:13:09 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] sideband: diagnose more incoming packet anomalies
Message-ID: <20201027071309.GD3005508@coredump.intra.peff.net>
References: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
 <pull.753.v3.git.1603728555.gitgitgadget@gmail.com>
 <20201027065250.GB3005508@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027065250.GB3005508@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 27, 2020 at 02:52:50AM -0400, Jeff King wrote:

> On Mon, Oct 26, 2020 at 04:09:13PM +0000, Johannes Schindelin via GitGitGadget wrote:
> 
> > Changes since v2:
> > 
> >  * Dropped patch 3/3 because it was only intended to be defensive
> >    programming, but turned out to be too hard without layering violations.
> 
> It is a bit tricky, but here's a working replacement.

And one other small cleanup, worth doing with or without my patch.

-- >8 --
Subject: [PATCH] test-pkt-line: drop colon from sideband identity

We pass "sideband: " as our identity for errors to recv_sideband(). But
it already adds the trailing colon and space. This doesn't invalidate
any tests, but it looks funny when you examine the test output.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-pkt-line.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 0bf20642be..5e638f0b97 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -100,7 +100,7 @@ static int send_split_sideband(void)
 
 static int receive_sideband(void)
 {
-	return recv_sideband("sideband: ", 0, 1);
+	return recv_sideband("sideband", 0, 1);
 }
 
 int cmd__pkt_line(int argc, const char **argv)
-- 
2.29.1.634.g9e41dc1bf2


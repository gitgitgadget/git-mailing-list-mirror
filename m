Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83F0F1F859
	for <e@80x24.org>; Fri,  9 Sep 2016 09:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753805AbcIIJ5n (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 05:57:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:40581 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753778AbcIIJ5j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 05:57:39 -0400
Received: (qmail 31855 invoked by uid 109); 9 Sep 2016 09:57:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Sep 2016 09:57:38 +0000
Received: (qmail 22357 invoked by uid 111); 9 Sep 2016 09:57:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Sep 2016 05:57:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2016 05:57:35 -0400
Date:   Fri, 9 Sep 2016 05:57:35 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] Use the newly-introduced regexec_buf() function
Message-ID: <20160909095735.zen2ynpsn7azqfss@sigill.intra.peff.net>
References: <cover.1473319844.git.johannes.schindelin@gmx.de>
 <cover.1473321437.git.johannes.schindelin@gmx.de>
 <d0537819a3676fda6928e7ad3282aa71643f0755.1473321437.git.johannes.schindelin@gmx.de>
 <xmqq1t0ujp2f.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1609091151510.129229@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609091151510.129229@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 09, 2016 at 11:52:50AM +0200, Johannes Schindelin wrote:

> > Also I agree with Peff that a test with an embedded NUL would be a
> > good thing.
> 
> This is something I will leave to somebody else, as it was not my
> intention to fix this and I *really* have more pressing things to do right
> now... Sorry!

I think it is literally just squashing this into your final patch:

diff --git a/t/t4061-diff-pickaxe.sh b/t/t4061-diff-pickaxe.sh
index f0bf50b..37b8dde 100755
--- a/t/t4061-diff-pickaxe.sh
+++ b/t/t4061-diff-pickaxe.sh
@@ -19,4 +19,13 @@ test_expect_success '-G matches' '
 	test 4096-zeroes.txt = "$(cat out)"
 '
 
+test_expect_success '-G matches after embedded NUL' '
+	printf "one\0two" >file &&
+	git add file &&
+	git commit -m embedded &&
+	echo embedded >expect &&
+	git log -Gtwo --format=%s >actual &&
+	test_cmp expect actual
+'
+
 test_done

-Peff

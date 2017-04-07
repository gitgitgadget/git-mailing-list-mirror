Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2241FAFB
	for <e@80x24.org>; Fri,  7 Apr 2017 04:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752951AbdDGEs2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 00:48:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:57879 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752169AbdDGEs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 00:48:26 -0400
Received: (qmail 22178 invoked by uid 109); 7 Apr 2017 04:48:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 04:48:26 +0000
Received: (qmail 31918 invoked by uid 111); 7 Apr 2017 04:48:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 00:48:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Apr 2017 00:48:23 -0400
Date:   Fri, 7 Apr 2017 00:48:23 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v3] http.postbuffer: allow full range of ssize_t values
Message-ID: <20170407044823.cfqkd2xs2vxhgp4d@sigill.intra.peff.net>
References: <20170331172631.12024-1-dturner@twosigma.com>
 <20170401060116.b2v7tyoi7fcxwbvo@sigill.intra.peff.net>
 <34d444b673c64310baa275f821037b3e@exmbdft7.ad.twosigma.com>
 <20170404020130.76thbl5rum2gxgtn@sigill.intra.peff.net>
 <6488d78232be49a69260436d1c6ed44f@exmbdft7.ad.twosigma.com>
 <20170404204031.geh72k6yuiky4wsw@sigill.intra.peff.net>
 <CAP8UFD3r7C_OcQMmtOju636okqrTB-af6CDo2jw5vGsiWcLVrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3r7C_OcQMmtOju636okqrTB-af6CDo2jw5vGsiWcLVrg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 06, 2017 at 07:24:54PM +0200, Christian Couder wrote:

> > That would at least tell you if the problem is the chunked encoding, or
> > if it's related to the size.
> 
> The above commands work for me using gitlab.com and the log shows:
> 
> Send header, 0000000309 bytes (0x00000135)
> Send header: POST
> /chriscool/yet-another-test-project.git/git-receive-pack HTTP/1.1
> Send header: Authorization: Basic <redacted>
> Send header: User-Agent: git/2.12.2.625.g14da1346c9.dirty
> Send header: Host: gitlab.com
> Send header: Content-Type: application/x-git-receive-pack-request
> Send header: Accept: application/x-git-receive-pack-result
> Send header: Content-Length: 4
> 
> Send header, 0000000341 bytes (0x00000155)
> Send header: POST
> /chriscool/yet-another-test-project.git/git-receive-pack HTTP/1.1
> Send header: Authorization: Basic <redacted>
> Send header: User-Agent: git/2.12.2.625.g14da1346c9.dirty
> Send header: Host: gitlab.com
> Send header: Accept-Encoding: gzip
> Send header: Content-Type: application/x-git-receive-pack-request
> Send header: Accept: application/x-git-receive-pack-result
> Send header: Transfer-Encoding: chunked
> 
> Maybe the reverse proxy doesn't like it when the push is really big.

Interesting. So it is OK with the chunked encoding. It seems odd that it
would complain about a bigger chunked encoding, but then work correctly
with a single big buffer. But I guess it would all depend on what kind
of buffering logic the reverse proxy uses.

-Peff

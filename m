Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C96611F461
	for <e@80x24.org>; Mon,  1 Jul 2019 13:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfGANRP (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 09:17:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:55940 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727049AbfGANRP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 09:17:15 -0400
Received: (qmail 26088 invoked by uid 109); 1 Jul 2019 13:17:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 01 Jul 2019 13:17:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4522 invoked by uid 111); 1 Jul 2019 13:18:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 01 Jul 2019 09:18:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jul 2019 09:17:13 -0400
Date:   Mon, 1 Jul 2019 09:17:13 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] check_everything_connected: assume alternate ref tips
 are valid
Message-ID: <20190701131713.GA25349@sigill.intra.peff.net>
References: <20190628101131.GA22862@sigill.intra.peff.net>
 <601d8561-6e24-559c-6fbb-fa25a7389fa0@gmail.com>
 <20190629074348.GA5080@sigill.intra.peff.net>
 <418213f2-82d6-f7bd-7379-7f20f0e83084@gmail.com>
 <20190701125945.GB4704@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701125945.GB4704@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 01, 2019 at 08:59:45AM -0400, Jeff King wrote:

> Yes, this is weakening the ties of the feature to the transport code.
> Traditionally transport-oriented code was the only user, but it also
> used the upload-pack transport under the hood to access the alternate
> (that was changed a while ago to for-each-ref for speed).
> 
> I don't think there's any functional difference in having it there, but
> it could be moved to live alongside foreach_alt_odb() in sha1-file.c.

Looks like this hasn't quite hit 'next' yet, so perhaps we can
reorganize it as a preparatory patch.

  [1/2]: object-store.h: move for_each_alternate_ref() from transport.h
  [2/2]: check_everything_connected: assume alternate ref tips are valid

 Documentation/rev-list-options.txt |  8 +++
 builtin/receive-pack.c             |  1 -
 connected.c                        |  1 +
 object-store.h                     |  2 +
 revision.c                         | 29 +++++++++
 sha1-file.c                        | 97 ++++++++++++++++++++++++++++++
 t/perf/p5600-clone-reference.sh    | 27 +++++++++
 t/t5618-alternate-refs.sh          | 60 ++++++++++++++++++
 transport.c                        | 97 ------------------------------
 transport.h                        |  2 -
 10 files changed, 224 insertions(+), 100 deletions(-)
 create mode 100755 t/perf/p5600-clone-reference.sh
 create mode 100755 t/t5618-alternate-refs.sh

-Peff

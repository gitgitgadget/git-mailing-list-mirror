Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE71120964
	for <e@80x24.org>; Tue,  4 Apr 2017 20:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754744AbdDDUQG (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 16:16:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:56664 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753403AbdDDUQF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 16:16:05 -0400
Received: (qmail 30514 invoked by uid 109); 4 Apr 2017 20:16:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 20:16:04 +0000
Received: (qmail 9060 invoked by uid 111); 4 Apr 2017 20:16:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 16:16:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Apr 2017 16:16:01 -0400
Date:   Tue, 4 Apr 2017 16:16:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>, frank@gevaerts.be
Subject: Re: [RFC] dropping support for ancient versions of curl
Message-ID: <20170404201601.jhjq2x5qgcneroo4@sigill.intra.peff.net>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
 <CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com>
 <20170404083341.uajswm3qdzyvzxsp@sigill.intra.peff.net>
 <CACBZZX5D2cYf0-ob_Da0EsxRtZHfegezPtCGA10-sjfi0A+AoQ@mail.gmail.com>
 <alpine.DEB.2.20.1704041351350.4268@virtualbox>
 <CACBZZX6W+fbCg7xXKuM=iqnSYFENBYxYT1WJmoOvYYCBEkX=hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6W+fbCg7xXKuM=iqnSYFENBYxYT1WJmoOvYYCBEkX=hQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 04, 2017 at 04:06:46PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > But a couple of #ifdef's? C'mon, man, we can carry this *without sweat*
> > indefinitely ;-)
> 
> I don't really care about applying this patch, but I wouldn't mind
> seeing it applied.
> 
> I just wanted to clarify the counteractive point that it's not unusual
> for some (particularly corporate) environments to be compiling fresh
> upstream releases of some software against really ancient versions of
> other upstream libraries.
> 
> But as Frank Gevaerts's reply (thanks!) which came after your reply
> points out, this code has already been broken since v2.12.0, so it's
> rarely used enough that nobody's reported being unable to compile git
> 2.12.0 on e.g. CentOS 5 >2 months since release.

Yeah, this is exactly the kind of thing I was wondering about (but was
too lazy to actually build an ancient version of curl -- thank you,
Frank).

In this case it was a compile error, which was obvious. I'm much more
worried about subtle interactions, or the fact that some of the ifdefs
are around security features that get ignored. In some cases we at least
issue a warning, but not always. E.g., we silently ignore
http.sslcapath.  Depending what you're using it for that could fail
closed (if you were trying to add a CA) or open (if you were trying to
restrict to a specific CA).

-Peff

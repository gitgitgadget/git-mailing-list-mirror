Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE66720C32
	for <e@80x24.org>; Thu,  7 Dec 2017 00:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbdLGAYm (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 19:24:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:50410 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751815AbdLGAYl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 19:24:41 -0500
Received: (qmail 484 invoked by uid 109); 7 Dec 2017 00:24:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Dec 2017 00:24:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16319 invoked by uid 111); 7 Dec 2017 00:25:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 06 Dec 2017 19:25:02 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Dec 2017 19:24:39 -0500
Date:   Wed, 6 Dec 2017 19:24:39 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: git commit file completion recently broke
Message-ID: <20171207002439.GB21003@sigill.intra.peff.net>
References: <CA+P7+xotDPa+=G5ypfyD7gySp6r2SKRAjMSw_0BmvuyyfcjxBw@mail.gmail.com>
 <CA+P7+xouqMi4xo7psM-PmpqcpKre2X1YyYZBLfMDYSSZ8tD_VQ@mail.gmail.com>
 <20171207002234.GA21003@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171207002234.GA21003@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 06, 2017 at 07:22:35PM -0500, Jeff King wrote:

> On Wed, Dec 06, 2017 at 04:01:51PM -0800, Jacob Keller wrote:
> 
> > I think I narrowed this down to "git diff-index --name-only --relative
> > HEAD" producing a list of files *not* relative to the current
> > directory.
> 
> Hmm, my guess would have been something funny in the setup code
> forgetting our original prefix.
> 
> But nope, it looks like the culprit is f7923a5ece (diff: use
> skip_to_optional_val(), 2017-12-04), which switched over parsing of
> "--relative".

Oh, actually, I guess I was half-right. It feeds &options->prefix as the
"default", meaning that we overwrite it with the empty string. I don't
think "--relative" works for the semantics of skip_to_optional_value,
since it needs:

  --relative=foo: set prefix to "foo"

  --relative: leave prefix untouched

-Peff

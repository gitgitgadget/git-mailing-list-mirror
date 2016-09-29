Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F148620987
	for <e@80x24.org>; Thu, 29 Sep 2016 08:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755316AbcI2IdY (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 04:33:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:49772 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755200AbcI2IdU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 04:33:20 -0400
Received: (qmail 10081 invoked by uid 109); 29 Sep 2016 08:33:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 08:33:18 +0000
Received: (qmail 32017 invoked by uid 111); 29 Sep 2016 08:33:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 04:33:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 04:33:15 -0400
Date:   Thu, 29 Sep 2016 04:33:15 -0400
From:   Jeff King <peff@peff.net>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git log --oneline alternative with dates, times and
 initials
Message-ID: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
References: <git-log-times@mackyle-at-gmail-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <git-log-times@mackyle-at-gmail-com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2016 at 10:34:51PM -0700, Kyle J. McKay wrote:

> git log-times --graph --date-order --decorate --no-merges -n 5 v2.5.3
> 
>     === 2015-09-17 ===
>   * ee6ad5f4 12:16 jch (tag: v2.5.3) Git 2.5.3
>     === 2015-09-09 ===
>   * b9d66899 14:22 js  am --skip/--abort: merge HEAD/ORIG_HEAD tree into index
>   |   === 2015-09-04 ===
>   | * 27ea6f85 10:46 jch (tag: v2.5.2) Git 2.5.2
>   * 74b67638 10:36 jch (tag: v2.4.9) Git 2.4.9
>                        ..........
>   * ecad27cf 10:32 jch (tag: v2.3.9) Git 2.3.9

I was surprised to see this as a separate script, but it is true that we
cannot quite pull it off with --format. I think we are very close,
though.  With the patches below I think you can do:

  git log \
    --commit-header='%C(auto,bold blue)== %as ==%C(auto,reset)'
    --format='%C(auto)%h %C(auto,green)%ad %C(auto,red)%aS/%cS%C(auto)%d%C(auto,reset) %s' \
    --graph --no-merges --author-date-order --date=format:%H:%M

and get the same (or very similar) output.

  [1/5]: pretty: allow formatting DATE_SHORT
  [2/5]: pretty: allow formatting names as initials
  [3/5]: graph: fix extra spaces in graph_padding_line
  [4/5]: graph: helper functions for printing commit header
  [5/5]: log: add --commit-header option

Each of those commits[1] needs some minor polish, and as I'm not really
that interested in fancy log output myself, I don't plan on working on
them further. I was mostly curious just how close we were. But if you'd
like to pursue it, feel free to use them as a starting point.

-Peff

[1] Actually, I think patch 3 is a legitimate bug fix on its own but I
    do not think there is any way to actually trigger it in practice
    without the rest of this series.

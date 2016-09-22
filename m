Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22BB1F935
	for <e@80x24.org>; Thu, 22 Sep 2016 04:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbcIVES7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 00:18:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:46477 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751365AbcIVES6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 00:18:58 -0400
Received: (qmail 9534 invoked by uid 109); 22 Sep 2016 04:18:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 04:18:57 +0000
Received: (qmail 5580 invoked by uid 111); 22 Sep 2016 04:19:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 00:19:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2016 00:18:54 -0400
Date:   Thu, 22 Sep 2016 00:18:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
Message-ID: <20160922041854.7754ujcynhk7mdnh@sigill.intra.peff.net>
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
 <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
 <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com>
 <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
 <xmqqponw6e3x.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqponw6e3x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 04:13:22PM -0700, Junio C Hamano wrote:

> Brandon Williams <bmwill@google.com> writes:
> 
> > yes you mentioned this and I meant to change that before sending it out.
> > Looks like it slipped through have slipped through.
> 
> I already fixed it up locally when I sent the reply, but thanks for
> resending (which assures me that your local copy is up-to-date and I
> do not have to worry about having to repeat me in the future, if
> this ever needs further rerolling ;-).

While we are on the subject, the commit message also uses some past
tense:

  Allow ls-files to recognize submodules in order to retrieve a list of
  files from a repository's submodules.  This is done by forking off a
  process to recursively call ls-files on all submodules. Also added a
  submodule-prefix command in order to prepend paths to child processes.

The final sentence should be "Also add...".

Since this final bit of logic was sufficiently non-obvious that it only
came about in v2, maybe it is worth describing a little more fully:

  Also add a submodule-prefix option, which instructs the child
  processes to prepend the prefix to each path they output. This makes
  the output paths match what is on the filesystem (i.e., as if the
  submodule boundaries were not there at all).

Should this option just be "--prefix", or maybe "--output-prefix"?
Submodules are the obvious use case here, but I could see somebody
adapting this for other uses (alternatively, if we _do_ want to keep it
just as an implementation detail for submodules, we should probably
discourage people in the documentation from using it themselves).

-Peff

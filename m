Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB642022A
	for <e@80x24.org>; Tue, 25 Oct 2016 08:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758610AbcJYIL4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 04:11:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:33783 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758595AbcJYILx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 04:11:53 -0400
Received: (qmail 8665 invoked by uid 109); 25 Oct 2016 08:11:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Oct 2016 08:11:50 +0000
Received: (qmail 30778 invoked by uid 111); 25 Oct 2016 08:12:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Oct 2016 04:12:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Oct 2016 04:11:49 -0400
Date:   Tue, 25 Oct 2016 04:11:49 -0400
From:   Jeff King <peff@peff.net>
To:     Aaron M Watson <watsona4@gmail.com>
Cc:     git@vger.kernel.org, Jon Seymour <jon.seymour@gmail.com>,
        David Caldwell <david@porkrind.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] Allow stashes to be referenced by index only
Message-ID: <20161025081149.x5l5zcupva546ssf@sigill.intra.peff.net>
References: <1473378397-22453-1-git-send-email-watsona4@gmail.com>
 <1477352413-4628-1-git-send-email-watsona4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1477352413-4628-1-git-send-email-watsona4@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 24, 2016 at 07:40:13PM -0400, Aaron M Watson wrote:

> Instead of referencing "stash@{n}" explicitly, it can simply be
> referenced as "n".  Most users only reference stashes by their position
> in the stash stask (what I refer to as the "index"). The syntax for the
> typical stash (stash@{n}) is slightly annoying and easy to forget, and
> sometimes difficult to escape properly in a script. Because of this the
> capability to do things with the stash by simply referencing the index
> is desirable.
> 
> This patch includes the superior implementation provided by Øsse Walle
> (thanks for that), with a slight change to fix a broken test in the test
> suite. I also merged the test scripts as suggested by Jeff King, and
> un-wrapped the documentation as suggested by Junio Hamano.
> 
> Signed-off-by: Aaron M Watson <watsona4@gmail.com>
> ---

Thanks, this version looks good to me.

Oddly, it does not seem to apply. I get:

  $ git am -3 ~/patch
  Applying: Allow stashes to be referenced by index only
  Using index info to reconstruct a base tree...
  M       git-stash.sh
  error: patch failed: t/t3903-stash.sh:604
  error: t/t3903-stash.sh: patch does not apply
  error: Did you hand edit your patch?
  It does not apply to blobs recorded in its index.
  Patch failed at 0001 Allow stashes to be referenced by index only

The culprit seems to be the final hunk header:

> @@ -604,7 +624,21 @@ test_expect_success 'invalid ref of the form stash@{n}, n >= N' '

This should be "604,6", as there are 6 context lines, and your patch
does not remove any lines.

I suspect the maintainer can fix it up while applying, but for my
curiosity: did you hand-edit it, or is there a potential bug in git's
diff code?

-Peff

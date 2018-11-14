Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 756B61F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 07:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbeKNReC (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 12:34:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:38686 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727576AbeKNReC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 12:34:02 -0500
Received: (qmail 3600 invoked by uid 109); 14 Nov 2018 07:32:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Nov 2018 07:32:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31467 invoked by uid 111); 14 Nov 2018 07:31:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Nov 2018 02:31:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2018 02:31:58 -0500
Date:   Wed, 14 Nov 2018 02:31:58 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Some left-over add-on for bw/config-h
Message-ID: <20181114073158.GE19904@sigill.intra.peff.net>
References: <pull.78.git.gitgitgadget@gmail.com>
 <xmqqo9asnr3b.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9asnr3b.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 02:52:24PM +0900, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > Back when bw/config-h was developed (and backported to Git for Windows), I
> > came up with this patch. It seems to not be strictly necessary, but I like
> > the safety of falling back to the Git directory when no common directory is
> > configured (for whatever reason).
> 
> Shouldn't that be diagnosed as an error with BUG()?  That is, if we
> know there is the current repository, and if commondir is not set,
> isn't it a bug that we want to look into in the start-up sequence?
> 
> The phrase "for whatever reason" makes me wonder if this is truly
> "defensive programming", rather than just sweeping the bug under the
> rug.
> 
> FWIW, with this toy patch applied on top of this patch, all tests
> that I usually run seem to pass.

Heh, I independently made the same change after reading the patch and
came here to report similar results.

I think the key thing here is that git_dir is never meant to be used as
a source for config. It is there to let the "includeIf gitdir" directive
work. So it would indeed be surprising and a bug if we had one but not
the other.

-Peff

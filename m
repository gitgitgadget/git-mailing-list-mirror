Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 545291F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 18:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391231AbfJXSBM (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 14:01:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:57274 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388218AbfJXSBM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 14:01:12 -0400
Received: (qmail 17528 invoked by uid 109); 24 Oct 2019 18:01:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Oct 2019 18:01:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3401 invoked by uid 111); 24 Oct 2019 18:04:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Oct 2019 14:04:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Oct 2019 14:01:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/23] parse_commit_buffer(): treat lookup_commit()
 failure as parse error
Message-ID: <20191024180110.GB12892@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
 <20191018044212.GA17879@sigill.intra.peff.net>
 <xmqq1rv2hkzn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rv2hkzn.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 24, 2019 at 12:37:32PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ...
> > The "seen" variant for this test mistakenly parsed another commit
> > instead of the blob, meaning that we were actually just testing the
> > "lone" case again. Changing that reveals the breakage (and shows that
> > this fixes it).
> > ...
> > @@ -52,7 +52,7 @@ test_expect_success 'traverse unexpected non-commit parent (lone)' '
> >  '
> >  
> >  test_expect_success 'traverse unexpected non-commit parent (seen)' '
> > -	test_must_fail git rev-list --objects $commit $broken_commit \
> > +	test_must_fail git rev-list --objects $blob $broken_commit \
> >  		>output 2>&1 &&
> >  	test_i18ngrep "not a commit" output
> >  '
> 
> Yikes.  Thanks for spotting.

By the way, I shuffled this one to the front so that it could be taken
separately for "maint" if you want (but it has been this way for at
least a decade, so I don't think it's urgent for v2.24).

-Peff

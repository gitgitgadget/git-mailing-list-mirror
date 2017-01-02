Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46AC31FEB3
	for <e@80x24.org>; Mon,  2 Jan 2017 06:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754718AbdABGmS (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 01:42:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:33949 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbdABGmR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 01:42:17 -0500
Received: (qmail 16161 invoked by uid 109); 2 Jan 2017 06:42:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Jan 2017 06:42:16 +0000
Received: (qmail 12190 invoked by uid 111); 2 Jan 2017 06:43:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Jan 2017 01:43:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jan 2017 01:42:14 -0500
Date:   Mon, 2 Jan 2017 01:42:14 -0500
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: Rebasing multiple branches at once
Message-ID: <20170102064214.5fvjyv54c7wbrk2i@sigill.intra.peff.net>
References: <20161231081433.3zo6lrsjsu2qho4u@glandium.org>
 <xmqqmvfb4i5a.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmvfb4i5a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 31, 2016 at 06:40:33PM -0800, Junio C Hamano wrote:

> What people seem to do is to teach the branch that ends with F that
> its upstream is the local branch that ends with E, so that they can
> be lazy when rebasing a branch that knows its upstream.  I suspect
> that you would end up with
> 
> A---G---B'--C'--D'--E'--F'
> 
> instead if it is done naively, but if you really care that the
> branch that ends with F does not have E, you presumably want to have
> the branch that ends at D its own identity, so
> 
>  (1) 'master' or whatever that used to end at A and now its tip is
>      at G;
> 
>  (2) the branch that ends at D whose upstream is 'master';
> 
>  (3) the branch that ends at E whose upstream is (2); and
> 
>  (4) the branch that ends at F whose upstream is (2).
> 
> I personally do not do that, though, because you'd need to remember
> the order in which these three branches must be rebased (i.e. (2)
> must be done first before rebasing (3) and (4) in any order).

I do occasionally have dependent topics, and use a topological sort to
order my rebases, which solves the problem. The code I use is in:

  https://github.com/peff/git/blob/meta/rebase

-Peff

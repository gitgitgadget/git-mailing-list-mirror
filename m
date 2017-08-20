Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2919E208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 08:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbdHTIr2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 04:47:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:43908 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751549AbdHTIr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 04:47:27 -0400
Received: (qmail 24038 invoked by uid 109); 20 Aug 2017 08:47:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 08:47:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12746 invoked by uid 111); 20 Aug 2017 08:47:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 04:47:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Aug 2017 04:47:25 -0400
Date:   Sun, 20 Aug 2017 04:47:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Tom G. Christensen" <tgc@jupiterrise.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] http: handle curl with vendor backports
Message-ID: <20170820084725.ce5inn5jzkyor4zk@sigill.intra.peff.net>
References: <030356f8-0472-7400-c9f6-7492788dd2d0@jupiterrise.com>
 <cover.1502462884.git.tgc@jupiterrise.com>
 <xmqq1sohzr85.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1sohzr85.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 03:15:06PM -0700, Junio C Hamano wrote:

> "Tom G. Christensen" <tgc@jupiterrise.com> writes:
> 
> > The curl packages provided by Red Hat for RHEL contain several
> > backports of features from later curl releases.
> > This causes problems with current version based checks in http.c.
> >
> > Here is an overview of the features that have been backported:
> > 7.10.6 (el3) Backports CURLPROTO_*
> > 7.12.1 (el4) Backports CURLPROTO_*
> > 7.15.5 (el5) Backports GSSAPI_DELEGATION_*
> >              Backports CURLPROTO_*
> > 7.19.7 (el6) Backports GSSAPI_DELEGATION_*
> >              Backports CURL_SSL_VERSION_TLSv1_{0,1,2}
> > 7.29.0 (el7) Backports CURL_SSL_VERSION_TLSv1_{0,1,2}
> >
> > This patch series will update the current version based checks for
> > protocol restriction and GSSAPI delegation control support to ones
> > based on features to properly deal with the above listed backports.
> > The fine grained TLS version support does not seem to be
> > distinguishable via a preprocessor macro so I've left that alone.
> 
> Thanks; these feature macros ought to be more dependable, and I
> think this moves things in the right direction (regardless of which
> features we might later pick as mandatory and cut off supports for
> older versions).

Yes, I agree that these are an improvement regardless. If we follow
through on the cut-off to 7.19.4, then the CURLPROTO ones all go away.
But I don't mind rebasing any cut-off proposal on top of this work.

-Peff

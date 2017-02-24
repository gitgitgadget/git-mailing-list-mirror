Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7523201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 21:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751395AbdBXVU3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 16:20:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:33642 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751334AbdBXVU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 16:20:28 -0500
Received: (qmail 13629 invoked by uid 109); 24 Feb 2017 21:20:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 21:20:28 +0000
Received: (qmail 31246 invoked by uid 111); 24 Feb 2017 21:20:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 16:20:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 16:20:25 -0500
Date:   Fri, 24 Feb 2017 16:20:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] refs: parse_hide_refs_config to use parse_config_key
Message-ID: <20170224212025.hcxusnrxijzb5qox@sigill.intra.peff.net>
References: <20170224203335.3762-1-sbeller@google.com>
 <20170224203940.hbmfsouw5k67l3h3@sigill.intra.peff.net>
 <20170224210643.max6z2ykm3gbg7lw@sigill.intra.peff.net>
 <xmqq4lzj1e4n.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4lzj1e4n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 01:18:48PM -0800, Junio C Hamano wrote:

> > While I'm thinking about it, here are patches to do that. The third one
> > I'd probably squash into yours (after ordering it to the end).
> >
> >   [1/3]: parse_config_key: use skip_prefix instead of starts_with
> >   [2/3]: parse_config_key: allow matching single-level config
> >   [3/3]: parse_hide_refs_config: tell parse_config_key we don't want a subsection
> 
> While you were doing that, I was grepping the call sites for
> parse_config_key() and made sure that all of them are OK when fed
> two level names.  Most of them follow this pattern:
> 
> 	if (parse_config_key(k, "diff", &name, &namelen, &type) || !name)
> 		return -1;
> 
> and ones that do not immediately check !name does either eventually
> do so or have separate codepaths for handlihng two- and three-level
> names.

Yeah, I did that, too. :)

I don't think there are any other sites to convert. And I don't think we
can make the "!name" case easier (because some call-sites do want to
handle both types). And it's not like it gets much easier anyway (unlike
the opposite case, you _do_ need to declare the extra variables.

-Peff

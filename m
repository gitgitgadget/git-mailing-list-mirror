Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C817F20133
	for <e@80x24.org>; Fri,  3 Mar 2017 22:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbdCCWZB (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 17:25:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:38367 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752056AbdCCWZA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 17:25:00 -0500
Received: (qmail 14796 invoked by uid 109); 3 Mar 2017 22:24:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 22:24:59 +0000
Received: (qmail 1035 invoked by uid 111); 3 Mar 2017 22:25:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 17:25:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 17:24:57 -0500
Date:   Fri, 3 Mar 2017 17:24:57 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, sschuberth@gmail.com,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 3/3] config: add conditional include
Message-ID: <20170303222456.ouujfjwusk4l45n4@sigill.intra.peff.net>
References: <20170224131425.32409-1-pclouds@gmail.com>
 <20170301112631.16497-1-pclouds@gmail.com>
 <20170301112631.16497-4-pclouds@gmail.com>
 <xmqqo9xkhosj.fsf@gitster.mtv.corp.google.com>
 <20170303063052.xkjoipuaohcwdl4n@sigill.intra.peff.net>
 <xmqq4lza9o5r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4lza9o5r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 11:05:20AM -0800, Junio C Hamano wrote:

> I am not sure about "obviousness", but I agree that we do not know
> that "conditional include" would be the only thing we want for the
> second level for "include.path" directive.  "include-if.<cond>.path"
> is better for that reason.
> 
> I presume that you could still do
> 
> 	[include "if:gitdir=$path"]
> 		path = ...
> 
> i.e. design the second level to begin with a token that tells
> readers what it means (and assign "if:" token for "conditional
> include"), but I do not think it is worth it.

Yep, all true.

> I also imagine that
> 
> 	[include]
> 		condition = ...
> 		path = ...
> 
> is easier to read and write by end-users, but it probably is not
> feasible because it requires too invasive change to the current code
> to teach it to grok such construct.

I am against that as it introduces a dependency in the presence and
ordering between two config variables, which can yield some surprises.

> Between "include-if" and "includeIf", if people find the latter not
> too ugly, I'd prefer to keep it the way Duy posted.  Because of the
> way "include.path" and "include-if.<cond>.path" work, we can declare
> that they are not like ordinary configuration variable definition
> at all but are higher-level directives and that may be a sufficient
> justification to allow "-" in its name, though, if people find
> "includeIf" too ugly a name to live.

OK. I can live with includeIf.

-Peff

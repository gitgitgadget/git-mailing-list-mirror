Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4B7F2022D
	for <e@80x24.org>; Mon, 21 Nov 2016 18:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbcKUStf (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 13:49:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:45593 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752889AbcKUSte (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 13:49:34 -0500
Received: (qmail 24964 invoked by uid 109); 21 Nov 2016 18:49:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Nov 2016 18:49:34 +0000
Received: (qmail 20478 invoked by uid 111); 21 Nov 2016 18:50:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Nov 2016 13:50:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Nov 2016 13:49:32 -0500
Date:   Mon, 21 Nov 2016 13:49:32 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 1/3] rebase -i: identify problems with core.commentchar
Message-ID: <20161121184931.36nuhg2h7u6mjsld@sigill.intra.peff.net>
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
 <f47dce15719954d6d4d8a550856757366871143e.1479737858.git.johannes.schindelin@gmx.de>
 <xmqqbmx8k8c0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmx8k8c0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 10:15:43AM -0800, Junio C Hamano wrote:

> > +	test_cmp expect actual
> > +'
> > +
> 
> Is this a recent regression?  When applied on top of 'maint' or
> older, it seems to pass just fine.
> 
>     ... Goes and looks ...
> 
> Interesting.  Peff's b9605bc4f2 ("config: only read .git/config from
> configured repos", 2016-09-12) is where this starts failing, which
> is understandable given the code change to builtin/stripspace.c in
> [2/3]. 
> 
> The analysis of the log message in [2/3] is wrong and needs
> updating, though.  In the old world order it worked by accident to
> call git_config() without calling setup_git_directory(); after
> b9605bc4f2, that no longer is valid and is exposed as a bug.  

Yeah, I noticed that while reading the patch. My b9605bc4f2 did regress
this case, but called out the fact that "cd subdir && git stripspace"
would never have worked. So one step back, 2 steps forward, and Dscho's
patch is the right step forward.

-Peff

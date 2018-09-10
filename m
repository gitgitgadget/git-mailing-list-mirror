Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99DDA1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 18:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbeIJXls (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 19:41:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:45152 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726603AbeIJXlr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 19:41:47 -0400
Received: (qmail 18264 invoked by uid 109); 10 Sep 2018 18:46:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Sep 2018 18:46:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10595 invoked by uid 111); 10 Sep 2018 18:46:34 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 10 Sep 2018 14:46:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2018 14:46:19 -0400
Date:   Mon, 10 Sep 2018 14:46:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Max Kirillov <max@max630.net>, git@vger.kernel.org,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Re: [PATCH v4] http-backend: allow empty CONTENT_LENGTH
Message-ID: <20180910184619.GA20678@sigill.intra.peff.net>
References: <20180907033607.24604-1-max@max630.net>
 <20180909041016.23980-1-max@max630.net>
 <20180910052558.GB55941@aiede.svl.corp.google.com>
 <20180910131724.GA5233@sigill.intra.peff.net>
 <xmqqa7opux4v.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7opux4v.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 09:37:20AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But that couldn't have been what older versions were doing, since they
> > never looked at CONTENT_LENGTH at all, and instead always read to EOF.
> > So presumably the original problem wasn't that we tried to read a body,
> > but that the empty string caused git_parse_ssize_t to report failure,
> > and we called die(). Which probably should be explained by 574c513e8d
> > (http-backend: allow empty CONTENT_LENGTH, 2018-09-07), but it's too
> > late for that.
> >
> > So after that patch, we really do have the original behavior, and that's
> > enough for v2.19.
> 
> To recap to make sure I am following it correctly:
> 
>  - pay attention to content-length when it is clearly given with a
>    byte count, which is an improvement over v2.18
> 
>  - mimick what we have been doing until now when content-length is
>    missing or set to an empty string, so we are regression free and
>    bug-to-bug compatible relative to v2.18 in these two cases.

That (and what you wrote below) matches my current understanding, too.
Though I did already admit to being confused. ;)

-Peff

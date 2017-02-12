Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B7E1FCC7
	for <e@80x24.org>; Sun, 12 Feb 2017 02:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbdBLCMK (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 21:12:10 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60408 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751050AbdBLCMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 21:12:09 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 66D681FAF4;
        Sun, 12 Feb 2017 02:12:08 +0000 (UTC)
Date:   Sun, 12 Feb 2017 02:12:08 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [RFC] send-email: avoid duplicate In-Reply-To and References
 headers
Message-ID: <20170212021208.GA16358@starla>
References: <20170212003432.GA19519@starla>
 <xmqq60kggp8r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60kggp8r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> > When parsing an mbox, it is possible to get existing In-Reply-To
> > and References headers blindly appended into the headers of
> > message we generate.   This is probably the wrong thing to do
> > and we should prioritize what was given in the command-line,
> > cover letter, and previously-sent messages.
> >
> > One example I've noticed in the wild was:
> >
> > https://public-inbox.org/git/20161111124541.8216-17-vascomalmeida@sapo.pt/raw
> > ---
> >  I'm not completely sure this is what Vasco was doing in that
> >  message, so it's an RFC for now...
> 
> I think it is sensibleto give priority to the --in-reply-to option
> given from the command line over the in-file one.  I am not sure if
> we want to drop references, though.  Wouldn't it make more sense to
> just add what we got from the command line to what we read from the
> file?  I dunno.

You're right, existing References in the bodies should probably
be prepended to current ones, as their order should be
oldest-to-newest.

I'll wait on comments a bit and work on a better version w/ tests
next week.

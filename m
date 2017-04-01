Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D8A20966
	for <e@80x24.org>; Sat,  1 Apr 2017 09:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbdDAJDz (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 05:03:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:55353 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbdDAJDy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 05:03:54 -0400
Received: (qmail 392 invoked by uid 109); 1 Apr 2017 09:03:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 09:03:52 +0000
Received: (qmail 16793 invoked by uid 111); 1 Apr 2017 09:04:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 05:04:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Apr 2017 05:03:50 -0400
Date:   Sat, 1 Apr 2017 05:03:50 -0400
From:   Jeff King <peff@peff.net>
To:     "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 4/6] dir_iterator: add tests for dir_iterator API
Message-ID: <20170401090350.t2tlpul2hm55xt6b@sigill.intra.peff.net>
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
 <1490844730-47634-5-git-send-email-bnmvco@gmail.com>
 <ab7a326c-0189-4542-76e8-649eb6e804c9@alum.mit.edu>
 <CAEA2_RL18TarW6k5keP+ADFDv+VZE+gG3e6EkCmWby7GjG-T_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEA2_RL18TarW6k5keP+ADFDv+VZE+gG3e6EkCmWby7GjG-T_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 03:25:43PM -0300, Daniel Ferreira (theiostream) wrote:

> On Thu, Mar 30, 2017 at 4:46 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> > Is there a special reason to write the date to the file as opposed to, say
> >
> >     touch dir/b
> >
> > ? (Some people use `: >dir/b` for this purpose, though I've never found
> > out why.) If you write the date to the file, the reader will be
> > distracted unnecessarily wondering whether the contents are important to
> > the test.
> >
> 
> There's no reason. They will be `touch`ed instead of written in a next version.
> 
> `:` is a bash builtin that that returns an exit code of zero and
> produces no output. On my Mac at least:
> 
> bash-3.2$ type :
> : is a shell builtin
> bash-3.2$ type touch
> touch is /usr/bin/touch
> 
> I suppose there are reasons to try to keep the most of a shell
> script's logic within the shell itself, without involving external
> binaries.

I think we actually prefer just:

  >dir/b

in our tests. The advantages over touch are:

  1. It is clear that the output will be empty afterwards (whereas with
     touch, it might just update the timestamp on an existing file).

  2. It's faster, since it doesn't require an extra process.

It's equivalent to ": >dir/b". I think you'll find all three forms in
our test suite, but ">dir/b" is the most common.

-Peff

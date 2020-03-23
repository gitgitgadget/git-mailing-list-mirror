Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E9EC4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018562073E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCWVbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:31:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:48654 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725897AbgCWVbL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 17:31:11 -0400
Received: (qmail 12955 invoked by uid 109); 23 Mar 2020 21:31:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Mar 2020 21:31:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17838 invoked by uid 111); 23 Mar 2020 21:40:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2020 17:40:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Mar 2020 17:31:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] tests(gpg): increase verbosity to allow debugging
Message-ID: <20200323213109.GA44297@coredump.intra.peff.net>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
 <dd26cb05a37a54d9d245823772d33fe0daab8ffa.1584968990.git.gitgitgadget@gmail.com>
 <20200323173258.GA3977@coredump.intra.peff.net>
 <20200323180445.GA31401@coredump.intra.peff.net>
 <xmqq8sjq6fob.fsf@gitster.c.googlers.com>
 <20200323201547.GA35429@coredump.intra.peff.net>
 <xmqqzhc63gmd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhc63gmd.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 23, 2020 at 02:28:58PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Here's what I came up with that I think is suitable for applying (though
> > if you find the GNUPGHOME thing below too gross, I can rework it as
> > indicated):
> 
> I actually think it is perfectly fine to mkdir and set the
> environment even outside test_expect_success; that way, even
> GIT_SKIP_TESTS cannot omit the necessary initialization.  And as you
> said, leaving the environment pointing into the trash repository's
> working tree should be fine when we fail the GPG prereq.  We
> shouldn't be running GPG at all in such a case.

I have a slight preference to do it in an expect_success block, because
then we'd notice the error more readily (and it gets the benefit
verbosity and tracing, too!).

The thing I was more worried about is that it's technically a behavior
change to set up GNUPGHOME when we're not going to use it (as well as
create the directory). But I find it hard to imagine a test that would
be affected where my suggested solution wouldn't be "fix the test".

-Peff

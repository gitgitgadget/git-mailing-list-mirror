Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5588720960
	for <e@80x24.org>; Wed, 12 Apr 2017 09:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753679AbdDLJMB (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 05:12:01 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:59510 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753635AbdDLJL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 05:11:57 -0400
Received: from [10.100.4.232] (nat2.ableton.net [217.110.199.118])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id C449E30072F;
        Wed, 12 Apr 2017 11:11:50 +0200 (CEST)
To:     gitster@pobox.com (Junio C Hamano),
        jacob.keller@gmail.com (Jacob Keller)
Cc:     avarab@gmail.com (=?ISO-8859-1?Q?=C6var_Arnfj=F6r=3F_Bjarmason?=),
        peff@peff.net (Jeff King),
        matt@mattmccutchen.net (Matt McCutchen),
        git@vger.kernel.org (git)
In-Reply-To: <CAPc5daXVYA8MsseJxge6Qo6ASc=CL6ySt2K61LpOtZ=3H3gWuw@mail.gmail.com>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Wed, 12 Apr 2017 11:11:51 +0200
Message-ID: <1n4d5yz.1m3mxp91snnmzrM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.12.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> On Tue, Apr 11, 2017 at 8:33 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> >
> > If you're already copying sha1s around you could use those as the
> > --force-with-lease=branch:<commit>, no?
> >
> > That's better guarantee than just using --force-with-lease alone.
> 
> Absolutely. That was the _only_ way the feature was originally designed
> to be used sensibly. We really shouldn't have added that "lazy" option [...]
> 
> Perhaps we should deprecate that "lazy" feature and remove it over
> time, making sure that everybody feeds the explicit commit object name
> that was recorded by the user somewhere (e.g. the approach to tag the
> commit to record the expected remote tip, which Peff illustrated).

I agree that this is better than giving the user a false sense of
security.

The problem is that manually recording the lease is painful. Like I
illustrated, the assumption that you can "simply" do this:

  (... my working copy is in some ramdom state)

  (... now I decide I want to rewrite history)

  $ git tag lease origin/master
  $ git rebase -i
  $ git push --force-with-lease=master:lease

doesn't hold, because by the time you decide to rewrite the history it's
already too late.

To solve this, I'd have to record the lease every time I pull or push;
this is a lot of work, and easy to forget and error-prone. Hence my
suggestion to have git do this automatically. I'd be interested in your
thoughts about that proposal, Junio; you didn't say anything about that
at all yet.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/

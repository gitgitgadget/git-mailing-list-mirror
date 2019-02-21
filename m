Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE031F453
	for <e@80x24.org>; Thu, 21 Feb 2019 14:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbfBUOKp (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 09:10:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:52642 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726199AbfBUOKo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 09:10:44 -0500
Received: (qmail 20607 invoked by uid 109); 21 Feb 2019 14:10:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Feb 2019 14:10:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12882 invoked by uid 111); 21 Feb 2019 14:10:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Feb 2019 09:10:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2019 09:10:42 -0500
Date:   Thu, 21 Feb 2019 09:10:42 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: 2.11-era rebase regression when @{upstream} is implicitly
 used
Message-ID: <20190221141042.GA21737@sigill.intra.peff.net>
References: <877ee2jyh3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877ee2jyh3.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 02:23:04PM +0100, Ævar Arnfjörð Bjarmason wrote:

> This is not a 2.21 release issue, and pre-dates the built-in rebase.
> 
> When you clone any repository, e.g. git.git, and add one commit on top
> of the cloned branch, then run "git rebase" you'll get e.g.:
> 
>     $ git rebase
>     First, rewinding head to replay your work on top of it...
>     Applying: foo
> 
> Before 4f21454b55 ("merge-base: handle --fork-point without reflog",
> 2016-10-12) you'd get:
> 
>     $ git rebase
>     Current branch master is up to date.

I'm not entirely sure this is a regression, and not the patch bringing
the behavior into line with what would happen when you _do_ have a
reflog.

> The results are not the same for "git rebase @{u}" or "git rebase $(git
> rev-parse @{u})":

Those aren't using "--fork-point", so they're going to behave
differently. The default with no arguments is basically "--fork-point
@{u}".

-Peff

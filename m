Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764C01F597
	for <e@80x24.org>; Tue, 17 Jul 2018 19:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbeGQU01 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 16:26:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:50050 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729802AbeGQU00 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 16:26:26 -0400
Received: (qmail 15725 invoked by uid 109); 17 Jul 2018 19:52:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Jul 2018 19:52:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25083 invoked by uid 111); 17 Jul 2018 19:52:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 17 Jul 2018 15:52:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jul 2018 15:52:16 -0400
Date:   Tue, 17 Jul 2018 15:52:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "J. Paul Reed" <preed@sigkill.com>, git@vger.kernel.org
Subject: Re: Are clone/checkout operations deterministic?
Message-ID: <20180717195215.GA26218@sigill.intra.peff.net>
References: <20180717091429.GA31043@sigkill.com>
 <87bmb6chvm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bmb6chvm.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 11:48:45AM +0200, Ævar Arnfjörð Bjarmason wrote:

> In practice I think clone, checkout, reset etc. always work in the same
> order you see with `git ls-tree -r --name-only HEAD`, but as far as I
> know this has never been guaranteed or documented, and shouldn't be
> relied on.

I think this paragraph is correct in general (and I agree with the
sentiment that this is subject to change in future versions).

There is one concrete case I know that has non-deterministic order in
current versions: long-lived clean/smudge filters can defer their
response. The LFS filter uses this to tell Git "no, I'm still
downloading the content", at which point Git will proceed with checking
out other local files (or even other LFS files that happen to arrive
sooner).

Depending on what one wants to do with the determinism, it may be OK to
ignore that case. ;)

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05CA61F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 20:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757111AbcH3Uv7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 16:51:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:35636 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752830AbcH3Uv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 16:51:58 -0400
Received: (qmail 5424 invoked by uid 109); 30 Aug 2016 20:51:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Aug 2016 20:51:56 +0000
Received: (qmail 1025 invoked by uid 111); 30 Aug 2016 20:52:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Aug 2016 16:52:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Aug 2016 16:51:52 -0400
Date:   Tue, 30 Aug 2016 16:51:52 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed
 tests
Message-ID: <20160830205151.k6ufhfzl6gh4uuog@sigill.intra.peff.net>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
 <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
 <CACBZZX6iEmbb68tzRKNAryp5qmt=iU9FMuOe2ONV=2ojcazoEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6iEmbb68tzRKNAryp5qmt=iU9FMuOe2ONV=2ojcazoEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 30, 2016 at 10:48:19PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >  -failed: $(patsubst trash,,$(patsubst directory.%,%.sh,$(wildcard trash\ directory.t[0-9]*)))
> >  +failed:
> >  +      @failed=$$(cd '$(TEST_RESULTS_DIRECTORY_SQ)' && \
> >  +              grep -l '^failed [1-9]' $$(ls -t *.counts | \
> >  +                      sed 'G;h;/^\(t[^.]*\)-[0-9]*\..*\n\1-[0-9]*\./d;P;d') | \
> >  +              sed -n 's/-[0-9]*\.counts$$/.sh/p') && \
> >  +      test -z "$$failed" || $(MAKE) $$failed
> >
> >   prove: pre-clean $(TEST_LINT)
> >         @echo "*** prove ***"; $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
> 
> I don't at all mind this solution to the problem, if it works for that's cool.
> 
> But FWIW something you may have missed is that you can just use
> prove(1) for this, which is why I initially patched git.git to support
> TAP, so I didn't have to implement stuff like this.

Heh. I think each iteration of this patch will be destined to have
somebody[1] point Johannes at prove. ;)

(But I really do recommend prove if you can use it).

-Peff

[1] http://public-inbox.org/git/20160630063725.GC15380@sigill.intra.peff.net/

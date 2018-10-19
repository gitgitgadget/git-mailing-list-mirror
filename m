Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0371F453
	for <e@80x24.org>; Fri, 19 Oct 2018 22:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeJTGRo (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 02:17:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:47128 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726349AbeJTGRo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 02:17:44 -0400
Received: (qmail 6735 invoked by uid 109); 19 Oct 2018 22:09:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Oct 2018 22:09:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16579 invoked by uid 111); 19 Oct 2018 22:09:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Oct 2018 18:09:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2018 18:09:47 -0400
Date:   Fri, 19 Oct 2018 18:09:47 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tim Schumacher <timschumi@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] alias: detect loops in mixed execution mode
Message-ID: <20181019220946.GB31563@sigill.intra.peff.net>
References: <87o9dar9qc.fsf@evledraar.gmail.com>
 <20181018225739.28857-1-avarab@gmail.com>
 <87pnw6cpcp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnw6cpcp.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 10:28:22AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > -		string_list_append(&cmd_list, *argv[0]);
> > +		add_cmd_history(&env, &cmd_list, *argv[0]);
> >
> >  		/*
> >  		 * It could be an alias -- this works around the insanity
> 
> Just to sanity check an assumption of mine: One thing I didn't do is use
> sq_quote_buf() and sq_dequote_to_argv() like we do for
> CONFIG_DATA_ENVIRONMENT. This is because in the case of config we need
> to deal with:
> 
>     $ git config alias.cfgdump
>     !env
>     $ git -c x.y=z -c "foo.bar='baz'" cfgdump|grep baz
>     GIT_CONFIG_PARAMETERS='x.y=z' 'foo.bar='\''baz'\'''
> 
> But in this case I don't see how a command-name would ever contain
> whitespace. So we skip quoting and just delimit by space.

Alias names cannot currently contain whitespace, because it's not
allowed in the key. However, we've discussed making the syntax
alias.<name>.command, which would then make it possible.

Whether anyone would use that is a different question, but hey,
apparently some people think "My Documents" is a good name for a
directory. ;)

-Peff

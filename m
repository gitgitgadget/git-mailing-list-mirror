Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 813781F404
	for <e@80x24.org>; Fri,  6 Apr 2018 17:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbeDFRur (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 13:50:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:56058 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751435AbeDFRur (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 13:50:47 -0400
Received: (qmail 21114 invoked by uid 109); 6 Apr 2018 17:50:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 17:50:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27547 invoked by uid 111); 6 Apr 2018 17:51:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 13:51:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 13:50:44 -0400
Date:   Fri, 6 Apr 2018 13:50:44 -0400
From:   Jeff King <peff@peff.net>
To:     Rafael Ascensao <rafa.almas@gmail.com>
Cc:     Olaf Hering <olaf@aepfle.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: How to undo previously set configuration?
Message-ID: <20180406175044.GA32228@sigill.intra.peff.net>
References: <20180405092358.569e0315.olaf@aepfle.de>
 <874lkq11ug.fsf@evledraar.gmail.com>
 <20180405104948.276de0ca.olaf@aepfle.de>
 <8737092929.fsf@evledraar.gmail.com>
 <20180405152525.13d1c776.olaf@aepfle.de>
 <20180405163227.GA25224@sigill.intra.peff.net>
 <20180406175556.5b6e16f0.olaf@aepfle.de>
 <CACUQV5_E+MOHVD2rGjcQY=iK+tqB3wV9Lh1nwiEP+q+M-1iXzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACUQV5_E+MOHVD2rGjcQY=iK+tqB3wV9Lh1nwiEP+q+M-1iXzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 06, 2018 at 05:57:39PM +0100, Rafael Ascensao wrote:

> On Fri, Apr 6, 2018 at 4:55 PM, Olaf Hering <olaf@aepfle.de> wrote:
> >
> > This does not work. Initially I copied the global config into the
> > repo and set all unwanted values to <empty>, like 'smtpuser='.
> > Perhaps the config parser recognized that fact, but the consumer
> > does not?
> >
> 
> Today someone asked on #git for a way to disable diff.external for a
> single command.
> Without thinking much I suggested $git -c diff.external= diff; which fails with:
> `fatal: cannot run : No such file or directory`
> 
> In this particular case there was `--no-ext-diff` to get around this
> and the case was promptly resolved.
> Just another another example where setting configuration values to
> "empty" doesn't translate to "disable this option".

Yeah, I think it would make sense in that case to reset
external_diff_cmd_cfg to NULL. I'd almost say that git_config_string()
should recognize and handle this case, but I suspect there are some
callers who need special behavior (e.g., to set it back to some
particular string).

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E1FC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 02:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C08360C51
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 02:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243959AbhH0CLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 22:11:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:60342 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241128AbhH0CLr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 22:11:47 -0400
Received: (qmail 5428 invoked by uid 109); 27 Aug 2021 02:10:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Aug 2021 02:10:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11077 invoked by uid 111); 27 Aug 2021 02:10:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Aug 2021 22:10:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Aug 2021 22:10:57 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?B?RMOtYXo=?= <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/1] ci: new github-action for git-l10n code review
Message-ID: <YShJscwm/jMDOCx5@coredump.intra.peff.net>
References: <20210822161325.22038-1-worldhello.net@gmail.com>
 <20210822161325.22038-2-worldhello.net@gmail.com>
 <nycvar.QRO.7.76.6.2108232232460.55@tvgsbejvaqbjf.bet>
 <CANYiYbE6=+jbhea71r7Swqc012EOpaNiRequTeZQqfWnnB8gNw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2108251316540.55@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2108251316540.55@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 02:14:43PM +0200, Johannes Schindelin wrote:

> > Yes, this is a solution I also want to try at the very beginning. But
> > some l10n team leaders may fork their repositories directly from
> > git/git, and name their repo as "{OWNER}/git".  I want to try another
> > solution: check existence of file "ci/config/allow-l10n" in branch
> > "ci-config" using a GitHub API, instead of cloning the ci-config
> > branch and execute the shell script "ci/config/allow-l10n".
> 
> I understood that you were trying to imitate what git/git does.
> 
> The problem, in git/git as well as in your patch, is that this is highly
> cumbersome to use. Yes, it would be better if there was an easier UI to do
> what you want to do, but the current reality is: there isn't.
> 
> The main reason why it is so cumbersome to use is that your chosen
> strategy scatters the CI configuration so much that it puts a mental
> burden on the users. I, for one, have no idea what is currently in my
> `ci-config` branch. And new users will be forced to struggle to set up
> their fork in such a way that the configuration does what they want it to
> do.
> 
> And in this instance, there is not even any good reason to make it hard on
> the users because most will likely not need that new workflow at all. That
> workflow is primarily interesting for the l10n maintainers.

Just adding my two cents as the person who created the "ci-config"
mechanism: yes, it's absolutely horrible, and should be avoided if at
all possible. :)

Your repo-name solution seems like a quite reasonable alternative.

(I'd still love for there to be a way to selectively disable CI on
certain branches, but I didn't find another one, short of enforcing
branch-naming conventions that the whole project must agree on).

-Peff

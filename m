Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB75EC49EA3
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 09:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC38C611BD
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 09:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFUJfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 05:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhFUJfg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 05:35:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9C5C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 02:33:22 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rhi@pengutronix.de>)
        id 1lvGIr-0000Zy-NP; Mon, 21 Jun 2021 11:33:13 +0200
Received: from rhi by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <rhi@pengutronix.de>)
        id 1lvGIo-0001H9-S3; Mon, 21 Jun 2021 11:33:10 +0200
Date:   Mon, 21 Jun 2021 11:33:10 +0200
From:   Roland Hieber <rhi@pengutronix.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: allow to run from subdirectories
Message-ID: <20210621093310.eqt3ajic64pgag44@pengutronix.de>
References: <20210620213836.10771-1-rhi@pengutronix.de>
 <877dio3vg5.fsf@evledraar.gmail.com>
 <YM/yqPsRutV2mUbb@camp.crustytoothpaste.net>
 <CAPig+cQa3JC-YkGeB-NDy-iP=Mv8BRL6jyXTGXzaqpTLcxj8+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQa3JC-YkGeB-NDy-iP=Mv8BRL6jyXTGXzaqpTLcxj8+w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 20, 2021 at 10:10:10PM -0400, Eric Sunshine wrote:
> On Sun, Jun 20, 2021 at 10:00 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On 2021-06-21 at 00:35:49, Ævar Arnfjörð Bjarmason wrote:
> > > On Sun, Jun 20 2021, Roland Hieber wrote:
> > > > Currently, calling 'git bisect' from a directory other than the top
> > > > level of a repository only comes up with an error message:
> > > >
> > > >     You need to run this command from the toplevel of the working tree.
> > >
> > > How does this affect out-of-tree scripts that will be run with "git
> > > bisect run", is the cwd set to the root as they now might expect git to
> > > check, or whatever subdirectory you ran the "run" from?
> >
> > As for the idea itself, I think it's a good one assuming everything
> > continues to work.  It will certainly be more convenient for a lot of
> > people.
> 
> There have been multiple patches sent to the project over the years
> with the same purpose. One problem, I believe, which has never been
> fully addressed is what happens when the subdirectory from which
> git-bisect is run gets deleted as part of the bisection.
> 
> Here are a couple recent threads triggered by previous such patches
> (but there are probably several more):
> 
> https://lore.kernel.org/git/pull.765.git.1603271344522.gitgitgadget@gmail.com/
> https://lore.kernel.org/git/pull.736.git.git.1584868547682.gitgitgadget@gmail.com/

Ah, thanks for explaining the problem. Would a patch that adds a short
explanatory comment in git-bisect.sh on the matter help to prevent
people sending such patches?

 - Roland

-- 
Roland Hieber, Pengutronix e.K.          | r.hieber@pengutronix.de     |
Steuerwalder Str. 21                     | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686         | Fax:   +49-5121-206917-5555 |

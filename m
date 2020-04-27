Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FFAC81857
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 22:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E03E206D9
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 22:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD0WJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:09:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:41546 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726182AbgD0WJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 18:09:56 -0400
Received: (qmail 16446 invoked by uid 109); 27 Apr 2020 22:09:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Apr 2020 22:09:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28410 invoked by uid 111); 27 Apr 2020 22:21:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Apr 2020 18:21:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Apr 2020 18:09:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
Message-ID: <20200427220955.GA1747507@coredump.intra.peff.net>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com>
 <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
 <20200427200852.GC1728884@coredump.intra.peff.net>
 <xmqqlfmg7hn7.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfmg7hn7.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 02:17:32PM -0700, Junio C Hamano wrote:

> If we were to adopt it as an experiment, hoping to gain exposure,
> nothing above 'master' (or tagged releases) won't work.  And once a
> thing is in 'master', users will ignore the "this is merely an
> experiment" warning and expect it to be fully functional and usable.

Yeah, that is a problem. I wonder if the state would be more obvious if
it lived in contrib/. We already have contrib/buildsystems,
which seems like an earlier attempt at this exact problem?

> But in the meantime, those who are interested in building Git with
> cmake do not have to wait, doing nothing, I would imagine.  I wonder
> if they can work on a separate project (let's call it git-on-cmake)
> whose sole purpose is to develop and polish CMakeLists.txt, waiting
> for an advanced enough version of cmake becomes commonplace.  Then,
> anybody who are interested and has recent cmake can subtree-merge
> git-on-cmake project into their own clone of our project somewhere,
> and help developing git-on-cmake further.

I think there's actually a good reason to have it in your tree: people
use your tree as the basis to build (and submit!) changes.

I noticed the same thing with trying to play with CI changes. As a
contributor, yes I _can_ make my CI changes, and then base my branches
on that. But it gets rather awkward juggling branches that contain some
changes that should go upstream, and some which should not. And quite a
bit more difficult if people want to use tools like GitGitGadget to just
target a PR against git.git and send it to the mailing list.

If it lived in contrib/ that might strike a good balance between making
it available for people to experiment with, but not having people
confuse it for the official build system.

-Peff

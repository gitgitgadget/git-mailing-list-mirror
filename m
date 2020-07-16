Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0125DC433E1
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 10:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C73B7206C1
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 10:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgGPK4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:56:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:58926 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgGPK4b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 06:56:31 -0400
Received: (qmail 22633 invoked by uid 109); 16 Jul 2020 10:56:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jul 2020 10:56:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22791 invoked by uid 111); 16 Jul 2020 10:56:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jul 2020 06:56:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Jul 2020 06:56:29 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>
Subject: Re: [PATCH 1/2] Revert "check_repository_format_gently(): refuse
 extensions for old repositories"
Message-ID: <20200716105629.GC376357@coredump.intra.peff.net>
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
 <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
 <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
 <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
 <xmqqpn8wkben.fsf@gitster.c.googlers.com>
 <20200716062054.GA3242764@google.com>
 <20200716062429.GB3242764@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200716062429.GB3242764@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 15, 2020 at 11:24:29PM -0700, Jonathan Nieder wrote:

> The behavior introduced in 14c7fa269e4 might be a good behavior if we
> were traveling back in time to 2015, but we're far too late.  For some
> reason I thought that it was what had been originally implemented and
> that it had regressed.  Apologies for not doing my research when
> 14c7fa269e4 was under development.

Thanks for a good summary of the situation. I agree that the current
(well, pre-14c7fa269e4) behavior is a bug (mine) from 2015, and we
probably have to accept that state of affairs to some degree in order to
avoid breaking existing cases.

It is unfortunate that this means that somebody with version=0 and
extensions.preciousObjects is in danger of running a pre-2015 version of
Git and having that extension totally ignored, which could be a
data-safety issue. But the farther we get from 2015 the less likely that
is to be a problem (and the more likely somebody is to be depending on
the current behavior of v0+preciousObjects).

> Let's return to the behavior we've had since 2015: always act on
> extensions.* settings, regardless of repository format version.  While
> we're here, include some tests to describe the effect on the "upgrade
> repository version" code path.

So this makes sense to me as a first step.

-Peff

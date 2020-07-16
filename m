Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6BFC433E0
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 11:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4494F2074B
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 11:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgGPLAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:00:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:58954 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgGPLAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 07:00:09 -0400
Received: (qmail 22690 invoked by uid 109); 16 Jul 2020 11:00:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jul 2020 11:00:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22898 invoked by uid 111); 16 Jul 2020 11:00:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jul 2020 07:00:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Jul 2020 07:00:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] repository: allow repository format upgrade with
 extensions
Message-ID: <20200716110007.GD376357@coredump.intra.peff.net>
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
 <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
 <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
 <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
 <xmqqpn8wkben.fsf@gitster.c.googlers.com>
 <20200716062054.GA3242764@google.com>
 <20200716062818.GC3242764@google.com>
 <xmqqh7u8hrka.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7u8hrka.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 16, 2020 at 12:01:09AM -0700, Junio C Hamano wrote:

> > To avoid mistakes, continue to forbid repository format upgrades in v0
> > repositories with an unrecognized extension.  This way, a v0 user
> > using a misspelled extension field gets a chance to correct the
> > mistake before updating to the less forgiving v1 format.
> 
> This needs to be managed carefully.  When the next extension is
> added to the codebase, that extension may be "known" to Git, but I
> do not think it is a good idea to honor it in v0 repository, or
> allow upgrading v0 repository to v1 with such an extension that
> weren't "known" to Git.  For example, a topic in flight adds
> objectformat extension and I do not think it should be honored in v0
> repository.
> 
> Having said that, the approach is OK for now at the tip of tonight's
> master, but the point is "known" vs "unknown" must be fixed right
> with some means.  E.g. tell people to throw the "new" extensions to
> the list of "unknown extensions" in check_repo_format() when they
> add new ones, or something.

Yeah, I agree with this line of reasoning. I'd prefer to see it
addressed now, so that we don't have to remember to do anything later.
I.e., for this patch to put the existing known extensions into the
"good" list for v0, locking it into place forever, and leaving the
objectformat topic with nothing particular it needs to do.

But in the name of -rc1 expediency, I'm also OK moving forward with this
for now.

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD94C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 05:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AA360F70
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 05:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhKLF5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 00:57:24 -0500
Received: from verein.lst.de ([213.95.11.211]:60145 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232586AbhKLF5P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 00:57:15 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B25ED68AA6; Fri, 12 Nov 2021 06:54:21 +0100 (CET)
Date:   Fri, 12 Nov 2021 06:54:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Wong <e@80x24.org>, Christoph Hellwig <hch@lst.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: RFC: A configuration design for future-proofing fsync()
 configuration
Message-ID: <20211112055421.GA27823@lst.de>
References: <211110.86r1bogg27.gmgdl@evledraar.gmail.com> <20211111004724.GA839@neerajsi-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111004724.GA839@neerajsi-x1.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 10, 2021 at 04:47:24PM -0800, Neeraj Singh wrote:
> It would be nice to loop in some Linux fs developers to find out what can be
> done on current implementations to get the durability without terrible
> performance. From reading the docs and mailing threads it looks like the
> sync_file_range + bulk fsync approach should actually work on the current XFS
> implementation.

If you want more than just my advice linux-fsdevel@vger.kernel.org is
a good place to find a wide range of opinions.

Anyway, I think syncfs is the biggest band for the buck as it will give
you very efficient syncing with very little overhead in git, but it does
have a huge noisy neighbor problem that might make it unattractive
for multi-tenant file systems or git hosting.

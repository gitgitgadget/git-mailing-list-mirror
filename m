Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CBEC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 06:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B1E6113D
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 06:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242759AbhIHGvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 02:51:10 -0400
Received: from verein.lst.de ([213.95.11.211]:38107 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238910AbhIHGvI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 02:51:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F14467373; Wed,  8 Sep 2021 08:49:58 +0200 (CEST)
Date:   Wed, 8 Sep 2021 08:49:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 0/6] Implement a batched fsync option for
 core.fsyncObjectFiles
Message-ID: <20210908064958.GA29073@lst.de>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com> <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com> <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com> <CANQDOdeX-SoWnh5DJ9ZdNLfPdAW-wtp_fo99r0Rwe1DQqx4W5Q@mail.gmail.com> <xmqqmton7ehn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmton7ehn.fsf@gitster.g>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 11:44:52PM -0700, Junio C Hamano wrote:
> I doubt that fsyncObjectFiles is something we can reliably test in
> CI, either with the new batched thing or with the original "when we
> close one, make sure the changes hit the disk platter" approach.  So
> I am not sure what conclusion we should draw from such an experiment,
> other than "ok, it compiles cleanly."  After all, unless we cause
> system crashes, what we thought we have written and close(2) would
> be seen by another process that we spawn after that, with or without
> sync, no?

Basically yes.  XFS on Linux has shutdown ioctls that allow to simulate
that crash by shutting the file system down which really helps debugging
that kind of code.  A bunch of other file systems (ext4, f2fs) have
also picked this up now (grep for {XFS,EXT4,F2FS}_IOC_SHUTDOWN).

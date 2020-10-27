Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F48AC388F9
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 12:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52CA2245B
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 12:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899747AbgJ0MZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 08:25:52 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:36734 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440527AbgJ0MZv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 08:25:51 -0400
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id BD6273A995D
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 12:10:08 +0000 (UTC)
Received: from localhost (unknown [103.82.80.101])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 39E78200006;
        Tue, 27 Oct 2020 12:09:45 +0000 (UTC)
Date:   Tue, 27 Oct 2020 17:39:43 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Why does git diff-index show intent-to-add file as "Added"?
Message-ID: <20201027120943.skmx6c3crbtu335o@yadavpratyush.com>
References: <20201017162111.gvisfz2daqvhnjmb@yadavpratyush.com>
 <xmqqimb88v35.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimb88v35.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/10/20 01:18PM, Junio C Hamano wrote:
> Pratyush Yadav <me@yadavpratyush.com> writes:
> 
> > In this case, running diff-files gives:
> >
> >   :000000 100644 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 A	foo
> 
> Yes, it says "when comparing the index and the working tree, working
> tree side has it, and the index side does not, so it is an addition".
> 
> Of course, if it is truly a new file that the index does not even
> know about, we'd stay silent, but a path that are marked with i-t-a
> bit is what the user told us to keey an eye on, so that is what you
> would get.
> 
> > Running diff-index gives:
> >
> >   :000000 100644 0000000000000000000000000000000000000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 A	foo
> 
> If this is "diff-index HEAD", then I think it is expected.  "when
> comparing the HEAD and the working tree, working tree side has it,
> and the tree side does not, so it is an addition."  Exactly the same
> story as "diff-files".

It is `git diff-index --cached HEAD`.
 
> What should happen in "diff-index --cached HEAD", I offhand do not
> know.  "diff-index --cached HEAD" is a request to compare two trees,
> i.e. the tree that _would_ be produced if you wrote the index out as
> a tree (i.e. "git write-tree") right now, and the tree of HEAD.  So
> I think it may be sensible for the command to behave as if the i-t-a
> path does not even exist in the index when it is run with "--cached";
> I may be missing some subtleties that require us to do something
> different, but that is what I would think.

This is what I think too. Can we then treat this as a bug, and work on 
fixing it? Does any subsystem expert have any comments and/or provide 
extra context?

-- 
Regards,
Pratyush Yadav

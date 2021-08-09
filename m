Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B40C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 20:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4125E6101D
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 20:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbhHIULM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:11:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36738 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234637AbhHIULL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 16:11:11 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id F42071F8C6;
        Mon,  9 Aug 2021 20:10:50 +0000 (UTC)
Date:   Mon, 9 Aug 2021 20:10:50 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH/RFC 0/3] pedantic errors in next
Message-ID: <20210809201050.GA8077@dcvr>
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com>
 <xmqqtujyftzx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtujyftzx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:
> 
> > Building next with pedantic enabled shows the following 2 issues that
> > were originally in ew/many-alternate-optim, apologies for not catching
> > them earlier.
> 
> This of course affects 'master'.
> 
> The first two look trivially correct and I am tempted to take them
> in -rc2; the last one, from my cursory look, I didn't see anything
> wrong in it, but is not all that urgent, either.

Agreed on all counts.

I've been starting to think oidtree/cbtree would be better
done as BSD-style macro-defined functions (similar to how
khash.h is, or sys/{queue,tree}.h on *BSD systems).

I prefer Linux(kernel)-style container_of generics since I find
them easier-to-follow and have extra type-checking, but with a
flex-array it's not pedantically correct.

So I guess using CPP like khash does might be a better way to
go, here.

Thoughts?


Side note: I've also been considering Perl as a more powerful
CPP replacement so I could use the same code for a persistent
on-disk store (it would be easier to swap in pread/mmap use).
An on-disk format could make it good for refs and pre-packed
object storage (perhaps replacing loose objects).

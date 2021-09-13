Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E063C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1A560EB4
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbhIMTEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:04:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:46478 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241062AbhIMTEa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:04:30 -0400
Received: (qmail 20933 invoked by uid 109); 13 Sep 2021 19:03:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Sep 2021 19:03:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13016 invoked by uid 111); 13 Sep 2021 19:03:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Sep 2021 15:03:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Sep 2021 15:03:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] refs/files-backend: remove unused open mode parameter
Message-ID: <YT+gbhnKmd0nlpxG@coredump.intra.peff.net>
References: <ea424e3d-6269-f50d-1a4a-643bb95cfa12@web.de>
 <CAFQ2z_NAXsOzbWujpm=jGxODJi+xsC9iFYd-W+dTqn9j5DybjQ@mail.gmail.com>
 <xmqqilz4fi86.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqilz4fi86.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 11:22:49AM -0700, Junio C Hamano wrote:

> Han-Wen Nienhuys <hanwen@google.com> writes:
> 
> > On Thu, Sep 9, 2021 at 11:46 PM René Scharfe <l.s.r@web.de> wrote:
> >>
> >> We only need to provide a mode if we are willing to let open(2) create
> >> the file, which is not the case here, so drop the unnecessary parameter.
> >
> > I was #today years old when I learned that C supports (a limited form
> > of) function signature overloading.
> 
> I do not think it is that kind of magic.
> 
> Like printf(3) that allows its early parameter to affect the way how
> its later parameters are recognised, it just allows the flags word
> to decide if it needs to grab one extra mode_t out of va_list or
> not, which can be done as a plain vanilla varargs function, i.e.
> 
> 	extern int open(const char *path, int flags, ...);

Yes, you can see some examples (complete with interesting subtleties) in
wrapper.c:xopen() and compat/open.c:git_open_with_retry(). :)

-Peff

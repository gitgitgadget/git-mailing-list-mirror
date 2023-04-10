Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D1FC77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 20:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjDJUZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 16:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDJUZi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 16:25:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D575E1739
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 13:25:37 -0700 (PDT)
Received: (qmail 3016 invoked by uid 109); 10 Apr 2023 20:25:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 Apr 2023 20:25:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 728 invoked by uid 111); 10 Apr 2023 20:25:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Apr 2023 16:25:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Apr 2023 16:25:36 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] date: remove approxidate_relative()
Message-ID: <20230410202536.GE104097@coredump.intra.peff.net>
References: <f5b9a290-7cec-7a83-660b-e15494d2cdc8@web.de>
 <xmqqjzyjemji.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzyjemji.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2023 at 09:20:49AM -0700, Junio C Hamano wrote:

> Perhaps
> 
> 	$ git -c format-patch.date.c.context=16 format-patch -1
> 
> would be a workable idea?  I do not think it makes any sense to say
> "when taking a diff for this path, always use 16 lines of context"
> so it should not be stored in a file to be used every time, like
> 
> 	[format-patch "date.c"] context = 16
> 
> and it makes even less sense to say that all project participants
> should use this context, always, so making it an attribute would be
> even less appropriate.
> 
> But this was the easiest way to prototype ;-)  If this turns out to
> be useful, the real version should probably be done by:

Cute. It feels like this only goes half-way, though. You really want
per-hunk configurable context. This particular patch was just lucky that
there was only one hunk in the date.c file.

I'm not sure of the least-confusing way to address a single hunk, though
(by line number is one option, by hunk-number within the patch is
another). I suspect the best workflow for a user would be to
interactively say "show me more context for this hunk". Some viewers
have support for that (e.g., GitHub's web view of a diff). But handling
that for a one-shot CLI program is tricky, not to mention then feeding
it back to format-patch to generate the output you want to send. :)

-Peff

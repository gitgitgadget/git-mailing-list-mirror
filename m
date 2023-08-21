Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD47EE49A6
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 18:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjHUSgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 14:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjHUSgO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 14:36:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3744911E
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 11:36:12 -0700 (PDT)
Received: (qmail 17149 invoked by uid 109); 21 Aug 2023 18:36:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 18:36:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16560 invoked by uid 111); 21 Aug 2023 18:36:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 14:36:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 14:36:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: spell DIFF_INDEX_CACHED out when calling
 run_diff_index()
Message-ID: <20230821183611.GB2617193@coredump.intra.peff.net>
References: <CAHxTZ4AUxow1p7mNG0fuRtfhkaOu=Wpc7cYvM8wRaB80hPNf9Q@mail.gmail.com>
 <20230821003532.GA1113755@coredump.intra.peff.net>
 <xmqqlee4s82d.fsf@gitster.g>
 <xmqqfs4cqsbl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfs4cqsbl.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2023 at 09:21:50AM -0700, Junio C Hamano wrote:

> Many callers of run_diff_index() passed literal "1" for the option
> flag word, which should better be spelled out as DIFF_INDEX_CACHED
> for readablity.  Everybody else passes "0" that can stay as-is.
> 
> The other bit in the option flag word is DIFF_INDEX_MERGE_BASE, but
> curiously there is only one caller that can pass it, which is "git
> diff-index --merge-base" itself---no internal callers uses the
> feature.
> 
> A bit tricky call to the function is in builtin/submodule--helper.c
> where the .cached member in a private struct is set/reset as a plain
> Boolean flag, which happens to be "1" and happens to match the value
> of DIFF_INDEX_CACHED.

Good catch. I guess this is conversion that should have been done in
4c3fe82ef1 (diff-lib: accept option flags in run_diff_index(),
2020-09-20). That commit did fix up some callers, but missed these ones.

While this is conceptually orthogonal to what I'm looking at in the
other part of the thread, the textual conflicts are really annoying. I'm
going to float this to the front of my series and build on top.

-Peff

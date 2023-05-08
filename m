Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B35C7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 18:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjEHSzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 14:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEHSzt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 14:55:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD69C5FDC
        for <git@vger.kernel.org>; Mon,  8 May 2023 11:55:47 -0700 (PDT)
Received: (qmail 13807 invoked by uid 109); 8 May 2023 18:55:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 May 2023 18:55:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3575 invoked by uid 111); 8 May 2023 18:55:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 May 2023 14:55:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 8 May 2023 14:55:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t9800: correct misuse of 'show -s --raw' in a test
Message-ID: <20230508185545.GA1893355@coredump.intra.peff.net>
References: <xmqqild5rvvw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqild5rvvw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 06, 2023 at 02:29:55PM -0700, Junio C Hamano wrote:

> There is $(git show -s --raw --pretty=format:%at HEAD) in this test
> that is meant to grab the author time of the commit.  We used to
> have a bug in the command line option parser of the diff family of
> commands, where "show -s --raw" was identical to "show -s".
> 
> With the "-s" bug fixed, "show -s --raw" would mean the same thing
> as "show --raw", i.e. show the output from the diff machinery in the
> "raw" format.  And this test will start failing, so fix it before
> that happens.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
> * It appears pretty obvious that the original wanted to just grab
>   the %at timestamp of the HEAD, and with the fix to allow output
>   format options to take effect after "-s" is given, the existing
>   misuse of "--raw" after "-s" that ought to be a no-op breaks the
>   test.

Yes, I think this is matching what the original code was trying to do.
The patch looks good to me.

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F458C433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 17:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJCRkG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 13:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJCRjh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 13:39:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECD212AB5
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 10:39:32 -0700 (PDT)
Received: (qmail 32506 invoked by uid 109); 3 Oct 2022 17:39:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Oct 2022 17:39:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27241 invoked by uid 111); 3 Oct 2022 17:39:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Oct 2022 13:39:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Oct 2022 13:39:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Michael V. Scovetta" <michael.scovetta@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: detect author name errors in
 read_author_script()
Message-ID: <YzseUy8bRT0LN2Wp@coredump.intra.peff.net>
References: <CADG3Mza_QU+ceTUsMYxJ3PzsEqi8M98oOBAzzz0GHRJ-F7vkpA@mail.gmail.com>
 <YzqhEcTDwMwa8dQX@coredump.intra.peff.net>
 <221003.86k05htf84.gmgdl@evledraar.gmail.com>
 <YzsbiRcCEaJUGwdp@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzsbiRcCEaJUGwdp@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2022 at 01:27:37PM -0400, Jeff King wrote:

> -check_broken_author 'unknown key in author-script' '
> +test_expect_success 'unknown key in author-script' '
> +	create_conflict &&
> +
>  	echo "GIT_AUTHOR_BOGUS=${SQ}whatever${SQ}" \
> -		>>.git/rebase-merge/author-script'
> +		>>.git/rebase-merge/author-script &&
>  
> +	check_resolve_fails
> +'
>  
>  test_done
> 
> That makes the boilerplate shorter in the "-v" output but focuses on the
> actual modification that breaks the author-script.

Note that we do still keep the ${SQ} bits here. They're necessary for
the same reason: before and after a snippet is being passed through a
variable. Whereas in yours we'd use stdin. I _do_ like that approach in
general, but it is unlike the rest of the test suite. Maybe it's worth
resurrecting:

  https://lore.kernel.org/git/YHDUg6ZR5vu93kGm@coredump.intra.peff.net/

?

-Peff

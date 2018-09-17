Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDA5A1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 22:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeIRDzA (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:55:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:51416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727780AbeIRDzA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:55:00 -0400
Received: (qmail 31769 invoked by uid 109); 17 Sep 2018 22:25:42 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 17 Sep 2018 22:25:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Sep 2018 18:25:39 -0400
Date:   Mon, 17 Sep 2018 18:25:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Todd Zullinger <tmz@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t5551-http-fetch-smart.sh: sort cookies before comparing
Message-ID: <20180917221603.GA3621@sigill.intra.peff.net>
References: <20180907232205.31328-1-tmz@pobox.com>
 <20180907235508.GB32065@sigill.intra.peff.net>
 <20180908032841.GK7192@zaya.teonanacatl.net>
 <20180908161712.GA9016@sigill.intra.peff.net>
 <xmqqd0tb6bn0.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0tb6bn0.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 02:45:55PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yes, I think sorting the expect file would work fine. I'm OK with that,
> > or just leaving a comment. The comment has the bonus that it does not
> > cost an extra process at runtime. I'd probably use a sort if we expected
> > the list to be long and complicated, since it makes life easier on a
> > future developer. But since there are only 2 lines, I don't think it's a
> > big deal either way (or even just leaving it as-is without a comment is
> > probably OK).
> 
> Let's have "| sort" if only for its documentation value.  That way
> we do not have to remember the list must be sorted.

OK, though...

> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 771f36f9ff..d13b993201 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -206,7 +206,7 @@ test_expect_success 'dumb clone via http-backend respects namespace' '
>  cat >cookies.txt <<EOF
>  127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
>  EOF
> -cat >expect_cookies.txt <<EOF
> +cat <<EOF | sort >expect_cookies.txt

This can be spelled:

  sort >expect_cookies.txt <<EOF

can't it? Then we do not even incur the extra process. :)

-Peff

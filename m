Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04BEB1FAE2
	for <e@80x24.org>; Wed, 21 Mar 2018 08:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeCUIDv (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 04:03:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:37192 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751343AbeCUIDq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 04:03:46 -0400
Received: (qmail 2934 invoked by uid 109); 21 Mar 2018 08:03:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Mar 2018 08:03:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8263 invoked by uid 111); 21 Mar 2018 08:04:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Mar 2018 04:04:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2018 04:03:44 -0400
Date:   Wed, 21 Mar 2018 04:03:44 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v6 09/11] pack-objects: shrink size field in struct
 object_entry
Message-ID: <20180321080343.GA25537@sigill.intra.peff.net>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
 <20180318142526.9378-10-pclouds@gmail.com>
 <xmqqsh8wvwwn.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AkJJQ4XNszxBsESN_WGOSZ+ExWdcCtn6NA+gW9+-mAqQ@mail.gmail.com>
 <xmqqlgenvs07.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AbkaSLBYqtFiCwFoqRXguy1hTs=XriefZ3WQJjo_sy8Q@mail.gmail.com>
 <xmqqy3inu8qe.fsf@gitster-ct.c.googlers.com>
 <20180320180806.GA16521@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180320180806.GA16521@duynguyen.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 07:08:07PM +0100, Duy Nguyen wrote:

> BTW can you apply this patch? This broken && chain made me think the
> problem was in the next test. It would have saved me lots of time if I
> saw this "BUG" line coming from the previous test.
> 
> -- 8< --
> Subject: [PATCH] t9300: fix broken && chain
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  t/t9300-fast-import.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index e4d06accc4..e2a0ae4075 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -348,7 +348,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
>  	INPUT_END
>  
>  	test_when_finished "rm -f .git/TEMP_TAG
> -		git gc
> +		git gc &&
>  		git prune" &&

The &&-chain is broken from the first command, too. It's "rm -f", which
is not that big a deal, but...

> @@ -365,7 +365,7 @@ test_expect_success 'B: accept empty committer' '
>  	INPUT_END
>  
>  	test_when_finished "git update-ref -d refs/heads/empty-committer-1
> -		git gc
> +		git gc &&
>  		git prune" &&

Same here, but we probably care more about noticing update-ref failure.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A37B202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 15:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932226AbdCIPCk (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 10:02:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:41342 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754704AbdCIPCj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 10:02:39 -0500
Received: (qmail 25577 invoked by uid 109); 9 Mar 2017 14:55:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 14:55:57 +0000
Received: (qmail 1885 invoked by uid 111); 9 Mar 2017 14:56:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 09:56:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 09:55:55 -0500
Date:   Thu, 9 Mar 2017 09:55:55 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] branch & tag: Add a --no-contains option
Message-ID: <20170309145555.kzrttqya3bghdhe4@sigill.intra.peff.net>
References: <20170308202025.17900-1-avarab@gmail.com>
 <20170309100910.z4h7bwqzxw2xynyu@sigill.intra.peff.net>
 <CACBZZX53rMiB5-cA_7-SeU2Dt7d_Cr7_GgyC0rjQQPPf4qyCqw@mail.gmail.com>
 <20170309104657.7pwreyozxo2tdhk4@sigill.intra.peff.net>
 <CACBZZX5i+8bQLhLB4DnUAaUw1vA_KQjhtNBvm7drLepPAFFbAQ@mail.gmail.com>
 <20170309125132.tubwxtneffok4nrc@sigill.intra.peff.net>
 <CACBZZX4W7brFe5ecTvQPMmf4X5_zH+dw3cB5xeVg+2hWYps0Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4W7brFe5ecTvQPMmf4X5_zH+dw3cB5xeVg+2hWYps0Ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2017 at 03:52:09PM +0100, Ævar Arnfjörð Bjarmason wrote:

> -       filter->with_commit_tag_algo = 1;
> +       if ((filter->merge_commit + filter->with_commit +
> filter->no_commit) > 1)
> +               filter->with_commit_tag_algo = 0;
> +       else
> +               filter->with_commit_tag_algo = 1;
>         filter_refs(&array, filter, FILTER_REFS_TAGS);
>         ref_array_sort(sorting, &array);
> 
> I think I'll amend the tip of my WIP v2 to have something like that,
> and then we can follow-up with making these cases where you supply
> multiple options faster.

Yeah, that's another option.  I think you may find that it's unbearably
slow if you have a lot of tags.

> > Looking at this, I'm pretty sure that using "--contains" with "--merged"
> > has similar problems, as they both use the UNINTERESTING bit. So even
> > without your patch, there is a lurking bug.
> 
> I'm currently running this:
> https://gist.github.com/avar/45cf288ce7cdc43e7395c6cbf9a98d68

Cute. I'll be curious if it turns up anything.

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F6DC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BBD611CB
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhJUOrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:47:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:43652 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230283AbhJUOru (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:47:50 -0400
Received: (qmail 15873 invoked by uid 109); 21 Oct 2021 14:45:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Oct 2021 14:45:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7066 invoked by uid 111); 21 Oct 2021 14:45:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Oct 2021 10:45:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Oct 2021 10:45:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 7/8] Makefile: stop having command-list.h depend on a
 wildcard
Message-ID: <YXF9DQuj0541ULku@coredump.intra.peff.net>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
 <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <patch-7.8-0c6f9b80d3b-20211020T183533Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-7.8-0c6f9b80d3b-20211020T183533Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 20, 2021 at 08:39:58PM +0200, Ævar Arnfjörð Bjarmason wrote:

>  get_synopsis () {
> +	head -n 10 "Documentation/$1.txt" |
>  	sed -n '
>  		/^NAME/,/'"$1"'/H
>  		${
>  			x
>  			s/.*'"$1"' - \(.*\)/N_("\1")/
>  			p
> -		}' "Documentation/$1.txt"
> +		}'
>  }

By the way, I'm not sure about the utility of this change. It reduces
the number of lines that sed looks at, but at the cost of an extra
process. That's probably a net loss. And if we did want to limit the
data sed covers, doing "pq" after we matched would be simpler.

It also feels like it's orthogonal to what this patch is doing, but
maybe there's some subtle non-performance reason to want this.

-Peff

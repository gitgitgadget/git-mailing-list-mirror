Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C0932036B
	for <e@80x24.org>; Thu,  5 Oct 2017 09:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbdJEJa4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 05:30:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:33268 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751278AbdJEJaz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 05:30:55 -0400
Received: (qmail 15188 invoked by uid 109); 5 Oct 2017 09:30:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 09:30:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25669 invoked by uid 111); 5 Oct 2017 09:30:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 05:30:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Oct 2017 05:30:53 -0400
Date:   Thu, 5 Oct 2017 05:30:53 -0400
From:   Jeff King <peff@peff.net>
To:     Mason <slash.tmp@free.fr>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: Quoted-printable support in git am
Message-ID: <20171005093052.3uefgby6a57udoqy@sigill.intra.peff.net>
References: <165c9648-e7f0-66de-b3b9-023c48c49d95@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <165c9648-e7f0-66de-b3b9-023c48c49d95@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2017 at 11:15:08AM +0200, Mason wrote:

> Is there a magic option I should be passing to git am?

No, it's supposed to work out of the box.

> The patch header contains:
> 
> Content-Type: text/plain; charset=UTF-8; format=flowed
> Content-Transfer-Encoding: quoted-printable

That looks right. Though I wouldn't be surprised if whatever generated
the "flowed" also screwed up patch whitespace.

> The drivers/media/rc/Kconfig:469 part is
> 
> --- a/drivers/media/rc/Kconfig
> +++ b/drivers/media/rc/Kconfig
> @@ -469,6 +469,11 @@ config IR_SIR
>   =09   To compile this driver as a module, choose M here: the module will
>   =09   be called sir-ir.
>  =20
> +config IR_TANGO
> +=09tristate "Sigma Designs SMP86xx IR decoder"
> +=09depends on RC_CORE
> +=09depends on ARCH_TANGO || COMPILE_TEST
> +
>   config IR_ZX
>   =09tristate "ZTE ZX IR remote control"
>   =09depends on RC_CORE

After "git am" bails, what does .git/rebase-apply/patch look like?

It should have the quoted-printable bits decoded. If it doesn't, then we
need to figure out why the qp-decoding didn't kick in. It would help to
see the whole input mbox then.

If it does have the qp bits decoded, then I'd suspect that maybe there's
whitespace damage caused by the MUA.

-Peff

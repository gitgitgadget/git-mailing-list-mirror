Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F81C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C7420814
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgEUSfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 14:35:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:53764 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbgEUSfB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 14:35:01 -0400
Received: (qmail 14975 invoked by uid 109); 21 May 2020 18:35:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 May 2020 18:35:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29899 invoked by uid 111); 21 May 2020 18:35:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 May 2020 14:35:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 May 2020 14:34:59 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/4] lib-submodule-update: pass OVERWRITING_FAIL
Message-ID: <20200521183459.GB1308647@coredump.intra.peff.net>
References: <cover.1588162842.git.liu.denton@gmail.com>
 <cover.1590019226.git.liu.denton@gmail.com>
 <48598e3f9859dc525ec878cd7f3eaadee8bb61b1.1590019226.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48598e3f9859dc525ec878cd7f3eaadee8bb61b1.1590019226.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 08:24:18PM -0400, Denton Liu wrote:

>  test_submodule_switch () {
> -	test_submodule_switch_func "git $1"
> +	test_submodule_switch_func "eval \$OVERWRITING_FAIL git $1"
>  }
> [...]
>  test_submodule_forced_switch () {
>  	command="$1"
>  	KNOWN_FAILURE_FORCED_SWITCH_TESTS=1
> -	test_submodule_switch_common "git $command"
> +	test_submodule_switch_common "eval \$OVERWRITING_FAIL git $command"

These both subject $1 to an extra layer of shell eval. That may not
matter since we seem to only pass basic stuff. It could probably be
avoided with an extra variable (though since we're passing along the
eval to be eval'd, I think it gets tricky), so it may not be worth
addressing.

Though IMHO it is nicer still if we can avoid the eval altogether by
doing something like the prep/command split I suggested in a sibling
reply.

-Peff

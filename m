Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F6D1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 16:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbeGSR0w (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 13:26:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:52740 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731625AbeGSR0w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 13:26:52 -0400
Received: (qmail 32764 invoked by uid 109); 19 Jul 2018 16:42:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Jul 2018 16:42:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12349 invoked by uid 111); 19 Jul 2018 16:42:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 12:42:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 12:42:52 -0400
Date:   Thu, 19 Jul 2018 12:42:52 -0400
From:   Jeff King <peff@peff.net>
To:     Basin Ilya <basinilya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Use different ssh keys for different github repos (per-url
 sshCommand)
Message-ID: <20180719164251.GA4868@sigill.intra.peff.net>
References: <44d3c280-3fb2-2415-46b7-343983e76e0b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44d3c280-3fb2-2415-46b7-343983e76e0b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 03:24:54PM +0300, Basin Ilya wrote:

> I have two github accounts, one is for my organization and I want git
> to automatically choose the correct ssh `IdentityFile` based on the
> clone URL:
> 
>     git@github.com:other/publicrepo.git
>        ~/.ssh/id_rsa
>     git@github.com:theorganization/privaterepo.git
>        ~/.ssh/id_rsa.theorganization
> 
> Unfortunately, both URLs have same host name, therefore I can't
> configure this in the ssh client config. I could create a host alias
> there, but sometimes somebody else gives me the github URL and I want
> it to work out of the box.

I think you can hack around this using Git's URL rewriting.

For example, try this:

  git config --global \
    url.gh-other:other/.insteadOf \
    git@github.com:other/

  git config --global \
    url.gh-org:theorganization.insteadOf \
    git@github.com:theorganization/

And then:

  git clone git@github.com:other/publicrepo.git

will hit gh-other, which you can configure using an ssh host alias.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23FCC2021E
	for <e@80x24.org>; Fri, 11 Nov 2016 08:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755968AbcKKIgx (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 03:36:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:41627 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751821AbcKKIgw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 03:36:52 -0500
Received: (qmail 20076 invoked by uid 109); 11 Nov 2016 08:36:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Nov 2016 08:36:51 +0000
Received: (qmail 12057 invoked by uid 111); 11 Nov 2016 08:37:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Nov 2016 03:37:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Nov 2016 03:36:50 -0500
Date:   Fri, 11 Nov 2016 03:36:50 -0500
From:   Jeff King <peff@peff.net>
To:     Qi Nark <narcotics726@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [credential.helper] unexpectedly save credential to multiple
 credential files
Message-ID: <20161111083649.d5newszupwyq5j6w@sigill.intra.peff.net>
References: <CACNr1V_fRfqvHUN=AQC8-Dj7ZAE7KXRAt+5skL3ZrcKu7SCLgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACNr1V_fRfqvHUN=AQC8-Dj7ZAE7KXRAt+5skL3ZrcKu7SCLgA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 04:10:55PM +0800, Qi Nark wrote:

> 1. git config --global credential.helper store
> 2. cd to a local repository directory, git config credential.helper
> store --file ./my_cred
> 3. execute some git command which need credential like git ls-remote
> 4. input my username & password, command done.
> 
> As the result, **BOTH** the ./my_cred and ~/.git-credentials will save
> the credentials I just input. But, shouldn't the local config override
> the global ones, and only the ./my_cred should save it?

No, that's the expected result. The set of credential helpers form a
list, and each is run in turn. From "git help credentials":

  If there are multiple instances of the credential.helper configuration
  variable, each helper will be tried in turn, and may provide a
  username, password, or nothing. Once Git has acquired both a username
  and a password, no more helpers will be tried.

That's talking about lookup, but the same principle applies to storage.
But you may also find the paragraph below helpful:

  If credential.helper is configured to the empty string, this resets
  the helper list to empty (so you may override a helper set by a
  lower-priority config file by configuring the empty-string helper,
  followed by whatever set of helpers you would like).

Note that the "reset" behavior was introduced in git v2.9.0, so you'll
need at least that version.

-Peff

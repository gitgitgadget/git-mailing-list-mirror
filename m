Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7610F20989
	for <e@80x24.org>; Mon, 10 Oct 2016 20:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbcJJUre (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 16:47:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:55328 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751895AbcJJUrd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 16:47:33 -0400
Received: (qmail 16066 invoked by uid 109); 10 Oct 2016 20:46:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 20:46:56 +0000
Received: (qmail 1815 invoked by uid 111); 10 Oct 2016 20:47:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 16:47:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Oct 2016 16:46:54 -0400
Date:   Mon, 10 Oct 2016 16:46:54 -0400
From:   Jeff King <peff@peff.net>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] contrib: add credential helper for libsecret
Message-ID: <20161010204654.krj44nk6xbjh4t2v@sigill.intra.peff.net>
References: <20161009123417.147239-1-grawity@gmail.com>
 <1476130850.7457.8.camel@kaarsemaker.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1476130850.7457.8.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 10:20:50PM +0200, Dennis Kaarsemaker wrote:

> On Sun, 2016-10-09 at 15:34 +0300, Mantas Mikulėnas wrote:
> > This is based on the existing gnome-keyring helper, but instead of
> > libgnome-keyring (which was specific to GNOME and is deprecated), it
> > uses libsecret which can support other implementations of XDG Secret
> > Service API.
> > 
> > Passes t0303-credential-external.sh.
> 
> When setting credential.helper to this helper, I get the following output:
> 
> $ git clone https://private-repo-url-removed private
> Cloning into 'private'...
> /home/dennis/code/git/contrib/credential/libsecret/ get: 1: /home/dennis/code/git/contrib/credential/libsecret/ get: /home/dennis/code/git/contrib/credential/libsecret/: Permission denied
> 
> Looks suboptimal. Am I holding it wrong?

That looks like a directory name in your error message. How did you set
up credential.helper? I'd expect normal usage to be something like this:

  # do this once, or cp the binary into your $PATH
  PATH=$PATH:/home/dennis/code/git/contrib/credential/libsecret
  git config --global credential.helper libsecret

But if you don't want to put it in your PATH, then I think:

  git config --global credential.helper \
    '!/home/dennis/code/git/contrib/credential/git-credential-libsecret'

would work.

-Peff

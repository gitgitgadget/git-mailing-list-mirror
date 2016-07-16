Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 472CC20195
	for <e@80x24.org>; Sat, 16 Jul 2016 05:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbcGPFSG (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 01:18:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:45842 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750871AbcGPFSF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 01:18:05 -0400
Received: (qmail 1605 invoked by uid 102); 16 Jul 2016 05:18:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 16 Jul 2016 01:18:05 -0400
Received: (qmail 22095 invoked by uid 107); 16 Jul 2016 05:18:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 16 Jul 2016 01:18:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Jul 2016 01:18:01 -0400
Date:	Sat, 16 Jul 2016 01:18:01 -0400
From:	Jeff King <peff@peff.net>
To:	Parker Moore <parkrmoore@gmail.com>
Cc:	git@vger.kernel.org, cranger@google.com,
	Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] contrib/persistent-https: update ldflags syntax for Go
 1.7+
Message-ID: <20160716051800.GA2845@sigill.intra.peff.net>
References: <CAOiOGAcqsdMD0j_ZUdvvGiA9Bd6bUmfvxziN06Rw81f_pO7cgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOiOGAcqsdMD0j_ZUdvvGiA9Bd6bUmfvxziN06Rw81f_pO7cgg@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

[+cc Shawn, who participated in the original discussion, as I don't
  think Colby really works on git any more]

On Fri, Jul 15, 2016 at 01:44:14PM -0700, Parker Moore wrote:

> From: Parker Moore <parkrmoore@gmail.com>
> 
> This fixes contrib/persistent-https builds for Go v1.7+ and is
> compatible with Go v1.5+.
> 
> Running `make all` in `contrib/persistent-https` results in a failure
> on Go 1.7 and above.
> 
> Specifically, the error is:
> 
>     go build -o git-remote-persistent-https \
>    -ldflags "-X main._BUILD_EMBED_LABEL 1468613136"
>     # _/Users/parkr/github/git/contrib/persistent-https
>     /usr/local/Cellar/go/1.7rc1/libexec/pkg/tool/darwin_amd64/link: -X
> flag requires argument of the form importpath.name=value
>     make: *** [git-remote-persistent-https] Error 2
> 
> This `name=value` syntax for the -X flag was introduced in Go v1.5
> (released Aug 19, 2015):
> 
> - release notes: https://golang.org/doc/go1.5#link
> - commit: https://github.com/golang/go/commit/12795c02f3d6fc54ece09a86e70aaa40a94d5131
> 
> In Go v1.7, support for the old syntax was removed:
> 
> - release notes: https://tip.golang.org/doc/go1.7#compiler
> - commit: https://github.com/golang/go/commit/51b624e6a29b135ce0fadb22b678acf4998ff16f
> 
> This patch includes the `=` to fix builds with Go v1.7+.

With the disclaimer that I have very little experience with Go, this
seems like a good, well-explained change. My only question would be
whether people still use pre-v1.5 versions of Go, since it sounds like
this would adversely affect them if they do. (If it does, it seems the
Go people did not give a very good deprecation period for the syntax
change, if people are using both the pre-new-syntax and post-old-syntax
versions simultaneously). I'm not sure what the alternative is, beyond
perhaps checking the version of Go dynamically in the Makefile.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE022207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 15:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423842AbdD1Pex (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 11:34:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:41892 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938147AbdD1Pev (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 11:34:51 -0400
Received: (qmail 30935 invoked by uid 109); 28 Apr 2017 15:34:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 15:34:48 +0000
Received: (qmail 23277 invoked by uid 111); 28 Apr 2017 15:35:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 11:35:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Apr 2017 11:34:46 -0400
Date:   Fri, 28 Apr 2017 11:34:46 -0400
From:   Jeff King <peff@peff.net>
To:     Andrew Watson <andwatsresearch@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: push fails with return code 22
Message-ID: <20170428153446.z5pp55kdniubt5ia@sigill.intra.peff.net>
References: <CAH6sfJUn99ezs-uZuYVj15qOeMv79ji7r0Ldvoreef0z3LzG8Q@mail.gmail.com>
 <20170427201804.3abt5ht6dkwwqo4r@sigill.intra.peff.net>
 <CAH6sfJX338f=WyEbCBXX_bzq=homhMs=cjPtzmH9cSvtBKPnaw@mail.gmail.com>
 <20170428152025.7lgkirbhpsccupt3@sigill.intra.peff.net>
 <CAH6sfJUoCPVJz47U8wA306hkCo_Z+gv5s0XHjtkGH6fj8-hUZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH6sfJUoCPVJz47U8wA306hkCo_Z+gv5s0XHjtkGH6fj8-hUZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 11:28:14AM -0400, Andrew Watson wrote:

> $ GIT_CURL_VERBOSE=1 git clone http://git.site.domain.com/foo/gitrepo.git
> Cloning into 'gitrepo'...
> * Couldn't find host git.site.domain.com in the _netrc file; using defaults
> * timeout on name lookup is not supported
> *   Trying 192.168.16.138...
> * TCP_NODELAY set
> * Connected to git.site.domain.com (192.168.16.138) port 80 (#0)
> > GET /foo/gitrepo.git/info/refs?service=git-upload-pack HTTP/1.1
> Host: git.site.domain.com
> User-Agent: git/2.12.2.windows.2
> Accept: */*
> Accept-Encoding: gzip
> Pragma: no-cache
> 
> < HTTP/1.1 200 OK
> < Date: Fri, 28 Apr 2017 15:25:02 GMT
> < Server: Apache/2.4.6 (CentOS) PHP/5.4.16
> < Last-Modified: Tue, 25 Apr 2017 18:11:35 GMT
> < ETag: "0-54e01a77ac500"
> < Accept-Ranges: bytes
> < Content-Length: 0
> < Content-Type: text/plain; charset=UTF-8

OK, so this is not doing smart-http either (the content-type should be
application/x-git-upload-pack-advertisement when the CGI generates it).

Looking at your config again, I see:

  ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/

but your example output shows:

  GET /gitrepo.git/info/refs?service=git-receive-pack

I.e., not in the /git/ hierarchy. So that might explain why the CGI is
not kicking in.

-Peff

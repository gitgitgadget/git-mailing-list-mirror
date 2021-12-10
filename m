Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43740C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 09:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbhLJJvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:51:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:48586 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhLJJvE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 04:51:04 -0500
Received: (qmail 18147 invoked by uid 109); 10 Dec 2021 09:47:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 09:47:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28758 invoked by uid 111); 10 Dec 2021 09:47:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Dec 2021 04:47:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Dec 2021 04:47:23 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/2] t1510: remove need for "test_untraceable", retain
 coverage
Message-ID: <YbMiK1wHzBfYvK2a@coredump.intra.peff.net>
References: <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
 <patch-v2-1.2-91402624777-20211201T200801Z-avarab@gmail.com>
 <20211202191635.GB1991@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211202191635.GB1991@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 02, 2021 at 08:16:35PM +0100, SZEDER Gábor wrote:

> > @@ -62,7 +59,7 @@ test_repo () {
> >  			export GIT_WORK_TREE
> >  		fi &&
> >  		rm -f trace &&
> > -		GIT_TRACE_SETUP="$(pwd)/trace" git symbolic-ref HEAD >/dev/null &&
> > +		GIT_TRACE_SETUP="$(pwd)/trace" git symbolic-ref HEAD >/dev/null 2>>stderr &&
> 
> I suspect that it's lines like this that make Peff argue for
> BASH_XTRACEFD :)
> 
> While this is not a compound command, it does contain a command
> substitution, and the trace generated when executing the command in
> that command substitution goes to the command's stderr, and then,
> because of the redirection, to the 'stderr' file.

Better still, the behavior varies between shells:

  $ bash -c 'set -x; FOO=$(echo foo) echo main >stdout 2>stderr; set +x; grep . stdout stderr'
  ++ echo foo
  + FOO=foo
  + echo main
  + set +x
  stdout:main

  $ dash -c 'set -x; FOO=$(echo foo) echo main >stdout 2>stderr; set +x; grep . stdout stderr'
  + FOO=foo echo main
  + set +x
  stdout:main
  stderr:+ echo foo

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4441F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 18:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504035AbfJXSNq (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 14:13:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:57298 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2504015AbfJXSNq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 14:13:46 -0400
Received: (qmail 17652 invoked by uid 109); 24 Oct 2019 18:13:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Oct 2019 18:13:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3609 invoked by uid 111); 24 Oct 2019 18:16:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Oct 2019 14:16:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Oct 2019 14:13:45 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org
Subject: Re: [Outreachy][PATCH] abspath: reconcile `dir_exists()` and
 `is_directory()`
Message-ID: <20191024181344.GD12892@sigill.intra.peff.net>
References: <20191024092745.97035-1-mirucam@gmail.com>
 <20191024114148.GK4348@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191024114148.GK4348@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 24, 2019 at 01:41:48PM +0200, SZEDER Gábor wrote:

> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index c46ee29f0a..f89938bf94 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -899,12 +899,6 @@ static void dissociate_from_references(void)
> >  	free(alternates);
> >  }
> >  
> > -static int dir_exists(const char *path)
> > -{
> > -	struct stat sb;
> > -	return !stat(path, &sb);
> 
> But look at this, it only checks that the given path exists, but it
> could be a regular file or any other kind of path other than a
> directory as well!
> 
> So this function clearly doesn't do what it's name suggests.  That's
> bad.
> 
> Unfortunately, it gets worse: some of its callsites in
> 'builtin/clone.c' do expect it to check the existence of _any_ path,
> not just a directory.

Yes, that's the reason for the funny name (and the fact that it was
never re-factored to use is_directory() in the first place). There's
some more discussion in:

  https://public-inbox.org/git/xmqqbmi9dw55.fsf@gitster.mtv.corp.google.com/

and its subthread.

-Peff

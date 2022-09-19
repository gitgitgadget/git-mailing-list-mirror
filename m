Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE70ECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 19:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiISTGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 15:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiISTGC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 15:06:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591A942AC1
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:06:00 -0700 (PDT)
Received: (qmail 26542 invoked by uid 109); 19 Sep 2022 19:05:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Sep 2022 19:05:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4245 invoked by uid 111); 19 Sep 2022 19:05:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Sep 2022 15:05:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 19 Sep 2022 14:05:58 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] list-objects-filter: convert filter_spec to a strbuf
Message-ID: <Yyi9lkns3OgjiLl0@coredump.intra.peff.net>
References: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
 <Yx1sI8cjU/SWUKVy@coredump.intra.peff.net>
 <2c6fca96-6b7b-b4c4-526c-2497422d8b8f@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c6fca96-6b7b-b4c4-526c-2497422d8b8f@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2022 at 01:50:32PM -0400, Derrick Stolee wrote:

> On 9/11/2022 1:03 AM, Jeff King wrote:
> > -	if (!filter_options->filter_spec.strdup_strings)
> > +	if (!filter_options->filter_spec.buf)
> >  		BUG("filter_options not properly initialized");
> 
> I couldn't figure out why this would work until I dug into
> STRBUF_INIT and found this:
> 
> /*
>  * Used as the default ->buf value, so that people can always assume
>  * buf is non NULL and ->buf is NUL terminated even for a freshly
>  * initialized strbuf.
>  */
> char strbuf_slopbuf[1];
> 
> So, this makes sense now.

Yeah. It's a little intimate with the strbuf implementation, but I think
that's OK given the scope of things here. Ironically, if "buf" could be
NULL, then we'd actually be OK with the original zero-initialization. :)

-Peff

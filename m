Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D24EC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 16:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6B860241
	for <git@archiver.kernel.org>; Wed, 19 May 2021 16:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242797AbhESQaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 12:30:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:59194 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242169AbhESQaS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 12:30:18 -0400
Received: (qmail 23559 invoked by uid 109); 19 May 2021 16:28:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 May 2021 16:28:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21385 invoked by uid 111); 19 May 2021 16:28:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 May 2021 12:28:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 May 2021 12:28:56 -0400
From:   Jeff King <peff@peff.net>
To:     James Hughes <james@pyrosoftsolutions.co.uk>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Fw: Tabs vs Spaces - Handle like CLRF?
Message-ID: <YKU8yMIO8uSuIYZh@coredump.intra.peff.net>
References: <2AzjQ7QDayLsqCbYQzwoZhJvvWKVAlBXStsOtYN03i41hVJcbYou0Je8Sxqec8UB0j0ZAfhKosA_IymlTez2X1J-voxUfG65EA-Zm0YWU10=@pyrosoftsolutions.co.uk>
 <GJHGZLcAwaihWwWmzAt8bdOKWi8JiupQxVUXCs1FwKTOmn2yvWEjI8DDTmDaBA48lzz4pGQ-JmwmHKSrEU2NCpdyxXW-ExqZcgxKEmL-454=@pyrosoftsolutions.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <GJHGZLcAwaihWwWmzAt8bdOKWi8JiupQxVUXCs1FwKTOmn2yvWEjI8DDTmDaBA48lzz4pGQ-JmwmHKSrEU2NCpdyxXW-ExqZcgxKEmL-454=@pyrosoftsolutions.co.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 03:55:46PM +0000, James Hughes wrote:

> We have the ability to automagically handle CLRF issues when we commit
> and check-out to handle different dev environments.
> 
> A lot of us will also hold religious beliefs as to which is the
> correct way to indent, tabs or spaces.
> 
> Since it's simple a whitespacing issue, is there any reason we
> couldn't handle this in a similar way to CLRF? Give devs the choice to
> commit with tabs/spaces as per their organisations requirements and
> then convert to their preference on checkout?

You can. See clean/smudge filters in the gitattributes(5) manpage. You'd
declare one of them the canonical in-repo format (let's say tabs). Then
your "clean" filter would convert spaces-to-tabs, perhaps with something
like "perl -pe 's/ {8}/\t/g'". And your "smudge" filter would convert
tabs back to spaces.

And then you just mark the files you want converted with an attribute in
.gitattributes, and wire up that attribute to the filters in your
config.

-Peff

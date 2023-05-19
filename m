Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FA9C77B7A
	for <git@archiver.kernel.org>; Fri, 19 May 2023 20:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjESUmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 16:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjESUmL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 16:42:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0334116
        for <git@vger.kernel.org>; Fri, 19 May 2023 13:42:09 -0700 (PDT)
Received: (qmail 21356 invoked by uid 109); 19 May 2023 20:42:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 May 2023 20:42:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6144 invoked by uid 111); 19 May 2023 20:42:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 May 2023 16:42:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 May 2023 16:42:08 -0400
From:   Jeff King <peff@peff.net>
To:     Hanno =?utf-8?B?QsO2Y2s=?= <hanno@hboeck.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: git push --quiet is not quiet
Message-ID: <20230519204208.GA4001861@coredump.intra.peff.net>
References: <20230519101505.416d0963.hanno@hboeck.de>
 <20230519090559.GA3515410@coredump.intra.peff.net>
 <20230519110937.7df62fd7.hanno@hboeck.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519110937.7df62fd7.hanno@hboeck.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 19, 2023 at 11:09:37AM +0200, Hanno Böck wrote:

> > So I think this is a bug / lack of feature in GitHub's server
> > implementation.  It used to be a thin proxy around Git (and Git has
> > supported "quiet" since c207e34f7733 in 2012). But I suspect they may
> > have recently replaced it with something more custom (based on the
> > agent field).
> 
> Ok, interesting. Maybe add to this: it appears github sometimes uses
> this channel to send relevant messages, e.g. dependabot alerts. Which I
> guess is a good thing, but it probably shouldn't send status messages
> for normal commits when the user asks for "quiet".

Yeah, that makes sense. Hooks should respect the "quiet" flag, too, as
appropriate. But the problem here is that because the server does not
claim to support the "quiet" capability, the client is not even passing
along the message that the user asked for "--quiet".

Presumably once that is fixed, the custom messages from the server would
then respect the quiet flag. But it's possible there might be more work
needed there, too.

-Peff

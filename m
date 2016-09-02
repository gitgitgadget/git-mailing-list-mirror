Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7042A1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 23:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754378AbcIBXTc (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 19:19:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:37296 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754320AbcIBXTb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 19:19:31 -0400
Received: (qmail 534 invoked by uid 109); 2 Sep 2016 23:19:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 23:19:30 +0000
Received: (qmail 30038 invoked by uid 111); 2 Sep 2016 23:19:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 19:19:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2016 19:19:28 -0400
Date:   Fri, 2 Sep 2016 19:19:28 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] connect: know that zero-ID is not a ref
Message-ID: <20160902231928.pcuket2yrypbxeir@sigill.intra.peff.net>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <2bea354c6218a33db3972e42baa75676fdcbc598.1472836026.git.jonathantanmy@google.com>
 <20160902201321.35egsg5l6r2fvrtw@sigill.intra.peff.net>
 <84df7985-6c87-9485-261c-e8e9a3bbab7b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84df7985-6c87-9485-261c-e8e9a3bbab7b@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 02, 2016 at 03:11:16PM -0700, Jonathan Tan wrote:

> On 09/02/2016 01:13 PM, Jeff King wrote:
> > On Fri, Sep 02, 2016 at 10:15:39AM -0700, Jonathan Tan wrote:
> > > (git-daemon should probably also be changed to serve zero IDs, but such
> > > a change can be considered independently from this change; even if both
> > > the client and server changes were made in one commit, it is nearly
> > > impossible that all Git installations are updated at the same time - an
> > > updated client would still need to deal with unupdated servers and vice
> > > versa.)
> > 
> > I'm really not sure what you mean here. How does git-daemon enter into
> > this at all?
> 
> I was comparing the behavior of git daemon and jgit daemon - when serving
> the same repository, the former does not send the zero ID and
> capabilities^{} line, whereas the latter does; and I was stating that git
> daemon's behavior should be changed to JGit's behavior, but not necessarily
> immediately.

Ah, I see. I was confused because it's git-upload-pack, not git-daemon,
which would be modified (git-daemon may also spawn other tools like
receive-pack, which _does_ already have this behavior).

I remain unconvinced that we should transition to the JGit behavior on
the server side (as opposed to "fixing" the documentation). However,
given that JGit versions with this behavior are in the wild, it seems
like a no-brainer to make the receiver more liberal (i.e., this series).

-Peff

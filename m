Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A631CC54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8002A2074F
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fx/JbCQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDWVhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgDWVhl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:37:41 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CE8C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:37:39 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id m6so6012083pjo.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tCVXCH0ZvQslvVXOX+/Xuu7qK/k2859L8OGo4tIveJE=;
        b=fx/JbCQ8ecRLjH5aYqI4zuxKQ+z6uXj9aI14bJEL8jVkCGeyPUUrwIF4aAmwVW/lKg
         aiFeSYdKgpleBmomAro7V4KRmqNbOPAznV7Dx7bv5TCNGTmSQk0YAi74w1fUv6R692QK
         AaiAxMg4E8eaZUbOaD7FOhxduLqx7sc7BAIiLoyr9jSW7C+yv3d1bV/Qi6NcbtdPTbbY
         N3VBiSY6PcdOGsqNFAgWvuntZOgS3zZAAHkBMuOel8EiXPOzaOOuSv0IXvFdkCMrev6W
         LpvYU9vrMZnLDWInKBMEPU5ywFxfelhcMLAuuqJfoeTj3uTzgAr19nPenAnFBTp1y3HD
         lvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tCVXCH0ZvQslvVXOX+/Xuu7qK/k2859L8OGo4tIveJE=;
        b=Gtziiz9c5btQK0z3S3EVp/GZx2ASWeAusdf1iDNEF5Tfq9iuG1tSVH0lEM5xX1di+/
         FIMOYqufhqRyqZqUW2DrVw2BJgYz5+rDcA+MuKS1rc4CywHBIXq7pTnr+uMCqrCZBTb9
         zW7W0XL5gnxOBMUsnuUr5T9Xy8p+vh8LmpLt8xlTtzYNIkCWDxw1vBW8cDX/6dUW1sZ3
         wufqCAkwAvM9lpk1PKU7xAOUhz4J2RLsFEA/S2hSb/0bJ9VGQvOS62EGSVKI+BqEtFRd
         PJT4xs9RIeYTu+WNFUIzS44rjv50zUs1hFHe3RapblYu+kAYeczSywxnqJAYHw8du5WI
         2wDw==
X-Gm-Message-State: AGi0Pua/J9+GFc7DI/NhQgA7XGWIaNU2R2/bFypWjGwy9Zg3aUzWGCLj
        ckDmvMrDP0roFREly27Opil9JQWobqVB0TsTOm/r
X-Google-Smtp-Source: APiQypIYN+ICLd6dnamv8LxMBSiFmE7NbEypc/N/MVFJgoY306Rn8bKcPAIt1RWUPx+HxRhDRO0GO3woAmoVw7UqWVr3
X-Received: by 2002:a17:90a:a2d:: with SMTP id o42mr2825365pjo.164.1587677859395;
 Thu, 23 Apr 2020 14:37:39 -0700 (PDT)
Date:   Thu, 23 Apr 2020 14:37:35 -0700
In-Reply-To: <20200422104000.GA551233@coredump.intra.peff.net>
Message-Id: <20200423213735.242662-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200422104000.GA551233@coredump.intra.peff.net>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: Re: Git 2.26 fetches many times more objects than it should, wasting gigabytes
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     lkundrak@v3.sk, jrnieder@gmail.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Apr 22, 2020 at 06:30:11AM -0400, Jeff King wrote:
> 
> > So it really just seems like v2 does not try hard enough. I think the
> > culprit is the MAX_IN_VAIN setting. If I do this:
> > 
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 1734a573b0..016a413d49 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -46,7 +46,7 @@ static struct strbuf fsck_msg_types = STRBUF_INIT;
> >   * After sending this many "have"s if we do not get any new ACK , we
> >   * give up traversing our history.
> >   */
> > -#define MAX_IN_VAIN 256
> > +#define MAX_IN_VAIN 20000
> >  
> >  static int multi_ack, use_sideband;
> >  /* Allow specifying sha1 if it is a ref tip. */
> > 
> > then I get that same 48k objects, 23MB fetch that v0 does.
> 
> I don't quite think that's the solution, though. Both old and new are
> supposed to be respecting MAX_IN_VAIN. So it's not at all clear to me
> why it restricts the number of haves we'll send in v2, but not in v0.
> 
> Maybe somebody more familiar with the negotiation code can comment
> further.

Thanks for the reproduction recipe (in [1]) and your analysis. I took a
look, and it's because the check for in_vain is done differently. In v0:

  if (got_continue && MAX_IN_VAIN < in_vain) {

reflecting the documentation in pack-protocol.txt:

  However, the 256 limit *only* turns on in the canonical client
  implementation if we have received at least one "ACK %s continue"
  during a prior round.  This helps to ensure that at least one common
  ancestor is found before we give up entirely.

(Note that both the code and the documentation call it "continue", but
the code also correctly handles multi_ack_detailed, which instructs the
server to send "ACK common" and "ACK ready" in lieu of "ACK continue".)

When debugging, I noticed that in_vain was increasing far in excess of
MAX_IN_VAIN, but because got_continue was false, the client did not give
up.

But in v2:

  if (!haves_added || *in_vain >= MAX_IN_VAIN) {

("haves_added" is irrelevant to this discussion. It is another
termination condition - when we have run out of "have"s to send.)

So there is no check that "continue" was sent. We probably should change
v2 to match v0. I can start writing a patch unless someone else would
like to take a further look at it.

[1] https://lore.kernel.org/git/20200422095702.GA475060@coredump.intra.peff.net/

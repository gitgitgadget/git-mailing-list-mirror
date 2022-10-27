Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B204FA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 20:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbiJ0UWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 16:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiJ0UV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 16:21:59 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3EB6F260
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 13:21:58 -0700 (PDT)
Received: (qmail 18005 invoked by uid 109); 27 Oct 2022 20:21:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Oct 2022 20:21:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24370 invoked by uid 111); 27 Oct 2022 20:21:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Oct 2022 16:21:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Oct 2022 16:21:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] Mention that password could be a personal access token.
Message-ID: <Y1roZeM6EsPgpHqu@coredump.intra.peff.net>
References: <pull.1396.git.1666845947898.gitgitgadget@gmail.com>
 <xmqqk04lmagy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk04lmagy.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2022 at 10:40:13AM -0700, Junio C Hamano wrote:

> "M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> >  `password`::
> >  
> > -	The credential's password, if we are asking it to be stored.
> > +	The credential's password, if we are asking it to be stored. If the
> > +	host is a software forge, this could also be a personal access
> > +	token or OAuth access token.
> 
> Is this limited to software forge hosts?
> 
> Also, I wonder if the specific "it can be access token and not
> password" is something worth adding.  If there were a service styled
> after the good-old "anonymous ftp", it would expect the constant
> string 'anonymous' as the "username", and would expect to see your
> identity (e.g. 'mirth.hickford@gmail.com') as the "password".  The
> point is that it does not matter what it is called on the end-user's
> side, be it a password or access token or whatever.  It is what the
> other end that provides the service wants to see after you claimed
> who you are by providing "username", usually (but not necessarily)
> in order to prove your claim.
> 
> So, I dunno.

FWIW, I had the same reaction. From the client perspective for https,
this is going over basic-auth, and it might be nice to just say so. But
of course the whole credential system is abstract, so it gets awkward.
We could probably say something like:

  The credential's password, if we are asking it to be stored. Note that
  this may not strictly be a traditional password, but rather any secret
  string which is used for authentication. For instance, Git's HTTP
  protocol will generally pass this using an Authorization header;
  depending on what the server is expecting this may be a password typed
  by the user, a personal access token, or some other opaque value.

Maybe that is getting too into the weeds. OTOH, anybody reading this far
into git-credential(1) is probably pretty technical. There may be a
better way of wording it, too. Another way of thinking about it that
it's basically any secret that is a single string, and not part of a
challenge/response protocol. I couldn't find a way to word that which
didn't end up more confusing, though. ;)

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B403AC64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 03:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCIDMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 22:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCIDMb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 22:12:31 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27357EA3B
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 19:12:30 -0800 (PST)
Received: (qmail 4544 invoked by uid 109); 9 Mar 2023 03:12:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 03:12:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27075 invoked by uid 111); 9 Mar 2023 03:12:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Mar 2023 22:12:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Mar 2023 22:12:29 -0500
From:   Jeff King <peff@peff.net>
To:     Sebastian Tennant <sdt@sebyte.me>
Cc:     git@vger.kernel.org
Subject: Re: How to mirror and augment a git repository
Message-ID: <ZAlOnTovp0ncZopf@coredump.intra.peff.net>
References: <87ilfgemkb.fsf@sebyte.me>
 <ZAWfkkmrPUqNmrtu@coredump.intra.peff.net>
 <87fsaf9oa8.fsf@sebyte.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fsaf9oa8.fsf@sebyte.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2023 at 04:54:39PM +0000, Sebastian Tennant wrote:

> > You could use the normal "+refs/heads/*:refs/remotes/origin/*" refspec,
> > but it's awkward for the clients to access "refs/remotes/" on the
> > mirror.
> 
> Indeed.  To fetch a known ref, a client (also with the normal fetch
> refspec) would have to do something like this, for example:
> 
>  $ git fetch origin\
>        refs/remotes/origin/<ref>:refs/remotes/upstream/<ref>
> 
> Alternatively, they could add an additional fetch refspec to their
> config:
> 
> [remote="origin"]
>  ...
>  fetch = +refs/heads/*:refs/remotes/origin/*             # normal
>  fetch = +refs/remotes/origin/*:refs/remotes/upstream/*  # additional
> 
> This would have the advantage of fetching all the upstream refs on the
> next update giving them a better idea of what's happening upstream.
> 
> Is my understanding more or less correct?

Yes, that's exactly correct. In some ways it is cleaner than using
"refs/heads/upstream" because it leaves the whole "refs/heads/"
namespace intact for local client branches. It depends on how much of a
pain it is to configure the extra refspec in each client. :)

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF66DC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 10:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjCFKbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 05:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjCFKbh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 05:31:37 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD31618A
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 02:31:03 -0800 (PST)
Received: (qmail 6124 invoked by uid 109); 6 Mar 2023 10:31:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Mar 2023 10:31:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28540 invoked by uid 111); 6 Mar 2023 10:31:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Mar 2023 05:31:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Mar 2023 05:31:02 -0500
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Marcel Partap <mpartap@gmx.net>, git@vger.kernel.org
Subject: Re: [PATCH] add -p: obey diff.noprefix option if set
Message-ID: <ZAXA5ikipcTCfptl@coredump.intra.peff.net>
References: <20230304123900.358048-1-mpartap@gmx.net>
 <ZAWnDUkgO5clf6qu@coredump.intra.peff.net>
 <0ba2f495-892c-3e27-a32c-9f136e86fc26@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ba2f495-892c-3e27-a32c-9f136e86fc26@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2023 at 09:39:07AM +0000, Phillip Wood wrote:

> > The second is to just remember that we set noprefix and to add the
> > matching "-p0". Unfortunately we have to do so in a few places, but it's
> > not _too_ bad (and possibly some refactoring could make it less ugly).
> > Something like:
> 
> I think that is the better approach. Looking at how we handle diff.algorithm
> we should maybe add a "noprefix" member to "struct add_i_state" and
> initialize it in init_add_i_state() (which is in add-interactive.c). That
> way we're consistent with the existing code and we don't need to keep
> calling git_config_get_bool() whenever we want the value of diff.noPrefix.

Yeah, that was exactly the kind of refactoring I had in mind (but I
didn't work on it, even as a "maybe something like this" patch).

I agree it's the better approach.

> >   	strvec_pushv(&cp.args, s->mode->apply_check_args);
> > +	if (!git_config_get_bool("diff.noprefix", &noprefix) && noprefix)
> > +		strvec_pushf(&cp.args, "-p1");
> 
> I think you meant "-p0" here

Whoops, yes.

-Peff

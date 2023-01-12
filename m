Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766ACC61DB3
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 17:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjALR0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 12:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjALR0V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 12:26:21 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA02C8BF30
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:53:54 -0800 (PST)
Received: (qmail 5688 invoked by uid 109); 12 Jan 2023 16:46:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Jan 2023 16:46:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16953 invoked by uid 111); 12 Jan 2023 16:46:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Jan 2023 11:46:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Jan 2023 11:46:23 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
Message-ID: <Y8A5X0kHE31kSH3z@coredump.intra.peff.net>
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
 <xmqq358fu4vr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq358fu4vr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2023 at 12:52:40AM +0900, Junio C Hamano wrote:

> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > When adding a "break" command to a rebase todo list it can be helpful to
> > add a comment as a reminder as to what the user was planning to do when
> > the rebase stopped. Anything following the command is interpreted as an
> > argument to the command and results in an error. Change this so that a
> > "break command may be followed by "# <comment>" in the same way as
> > a "merge" command. Requiring the comment to begin with "# " allows the
> > break command to start taking an argument in the future if that turns
> > out to be useful.
> 
> Why do we special case "break" and not give the same "comment is
> emitted when the control reaches the insn in the todo list" for
> others like "exec" or even "pick"?

I had somewhat the opposite thought. The "break" command is special in
that it is not doing anything useful except returning control to the
user. And hence producing a message is a useful add-on. So I expected
the patch to just allow:

  break this is a message the user will see

without any "#" at all.

That does close the door for further arguments, but I have trouble
imagining what they would be.

> Another comment with devil's advocate hat on is if we are better off
> not adding "# this comment is emitted" at all, and instead do
> 
>     pick ...
>     pick ...
>     exec echo this comment is emitted
>     break
>     pick ...

Yeah, I have certainly done something like that before. I think it is
just a matter of ergonomics. I'm pretty sure I have also forgotten to
put in the "break" afterwards.

Actually, before we had "break" I think I've done:

  x false this message will be visible when this fails

which is even more horrible. ;)

-Peff

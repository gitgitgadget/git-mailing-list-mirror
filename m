Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE06C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 23:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B852720774
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 23:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgC2XYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 19:24:05 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55410 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgC2XYF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 19:24:05 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 1CBF61F487;
        Sun, 29 Mar 2020 23:24:05 +0000 (UTC)
Date:   Sun, 29 Mar 2020 23:24:04 +0000
From:   Eric Wong <e@80x24.org>
To:     Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] added: Multi line support for ignore-paths configuration
Message-ID: <20200329232404.GA12701@dcvr>
References: <e5c78a24-e17f-c1bb-4ea7-3ddaa45abcf0@lpl-mind.de>
 <20200325203823.GA21913@dcvr>
 <0515a11b-d9ae-3f22-65a8-5efee235d5c9@lpl-mind.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0515a11b-d9ae-3f22-65a8-5efee235d5c9@lpl-mind.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de> wrote:
> Hi Eric,
> 
> thanks for your feedback.
> 
> I will include your general Feedback in the next Patch mail.
> 
> In Addition i think its not clear what i was trying to solve. I use the git
> svn extension for our company SVN. Unfortunately we have a lot of stuff in
> the SVN what I do not use and don’t want to checkout. So I started to use
> the ignore-paths option. But git only allows to have ca. 150 char in one
> config line. Which is not enough for me. So I started to extend the code to
> use also the next line. So that your expression can be bigger than 150 char,
> spread over several lines.

Thanks for the explanation.  In the future, please keep
git@vger.kernel.org and anybody else in the discussion in the
Cc: list (use reply-to-all in your mailer).

> I hope that make it clear.

OK, please do, thank you :)

> I will resend the second mail in few seconds
> 
> > That looks like it would munge the following:
> > 
> > 	[svn-remote "foo"]
> > 		ignore-paths = a
> > 		ignore-paths = b
> > 
> > into "a\nb\n"
> > 
> > And finally into a regexp:/ab/
> > 
> > ...Which doesn't seem correct, to me.
> 
> No this will end up into "ab" the \n and \r are removed at
> 
> +    $v  =~ s/[\x0A\x0D]//g if (defined $v);

Right, so do you agree your patch is broken in that case
and needs fixing?

Sorry, my mental abilities are dulled from the stress and
insomnia caused by the pandemic, so I have more trouble
understanding things than usual :<

> Am 25.03.2020 um 21:38 schrieb Eric Wong:
> > > 2.25.1.windows.1
> > I'm not sure how git-config or chomp() behaves on Windows systems
> > with CRLF line endings, though.
> > 
> > A possibility would be replacing chomp(@v) with:
> > 
> > 	s/\r?\n\z//s for @v;
> 
> Yes that has to be done. Its implemented in
> 
> +    $v  =~ s/[\x0A\x0D]//g if (defined $v);

Does that mean you'll send a v2 of the patch which uses

	s/\r?\n\z//s for @v;

?

Thanks in advance for clarifying.

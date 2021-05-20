Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E03C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 03:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47DA61184
	for <git@archiver.kernel.org>; Thu, 20 May 2021 03:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhETDfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 23:35:38 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:49315 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhETDfh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 23:35:37 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 4B765CE025
        for <git@vger.kernel.org>; Thu, 20 May 2021 03:27:17 +0000 (UTC)
Received: (Authenticated sender: josh@joshtriplett.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2DA66FF803;
        Thu, 20 May 2021 03:26:54 +0000 (UTC)
Date:   Wed, 19 May 2021 20:26:52 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Standardized escaping to store a .git in git?
Message-ID: <YKXW/Elvf8l780Yp@localhost>
References: <YKV8hEAxIzolnROX@localhost>
 <YKWDlF59jWoyE+xJ@google.com>
 <YKWMbh/j1ZiMZiGs@localhost>
 <YKWTGMw3nShH9VKt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKWTGMw3nShH9VKt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 03:37:12PM -0700, Jonathan Nieder wrote:
> Josh Triplett wrote:
> > Part of my motivation, here, is that I'm looking to implement one such
> > escaping mechanism (in a tool built atop libgit2 that needs to handle
> > and version arbitrary files), and rather than inventing something
> > bespoke I'd love to interoperate. And since I've seen various approaches
> > used in the wild, I didn't want to add Yet Another distinct approach
> > before starting a design conversation about it.
>
> *nod* To be clear, I'm glad you brought it up, among other reasons
> because it means this discussion becomes available in the list archive
> for when people are wondering about the same thing in the future.
>
> > For the storing-arbitrary-files case, these wouldn't apply.
>
> Can you say a little more about the storing-arbitrary-files case?

Sure. I'm using git to record before-and-after states of running
commands in an isolated environment, to see the differences caused by
those commands. The "before" state includes everything the command
needs, and the delta from "before" to "after" is exactly what the
command changed. Some commands create git repositories; for instance,
some software build scripts `git clone` their dependencies or other
data. So when I go to record the "after" state, it might include a .git
directory. And I need to record that as transparently as possible.

I'd like to use git repositories so that people *can* push and pull
data using git, inspect the repository with things like "git show", use
"git diff", and similar.

> There are some other filenames that "git fsck" also forbids, so this
> comes down to more than figuring out how to handle ".git".

Are you talking about the case-insensitive check for paths that can be
confused with .git on some platforms, or something more than that?

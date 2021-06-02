Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209E3C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 15:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF00F61360
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 15:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhFBPbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 11:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhFBPbc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 11:31:32 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DEFC061574;
        Wed,  2 Jun 2021 08:29:47 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1loSoS-003q0F-9L; Wed, 02 Jun 2021 15:29:44 +0000
Date:   Wed, 2 Jun 2021 15:29:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     git@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: git feature request: git blame --ignore-cleanup/--ignore-trivial
Message-ID: <YLej6F24Emm7SX35@zeniv-ca.linux.org.uk>
References: <30399052.5964.1622647235870.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30399052.5964.1622647235870.JavaMail.zimbra@efficios.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 11:20:35AM -0400, Mathieu Desnoyers wrote:
> Hi,
> 
> Following a discussion with Peter Zijlstra about whether code cleanup
> and functional changes done to the Linux kernel scheduler belong to separate
> patches or should be folded together, the argument for folding cleanup
> and function changes came to be mainly motivated by the current behavior
> of git blame: code cleanup patches end up burying the important changes so
> it becomes cumbersome to find them using git blame.
> 
> Considering the added value brought by splitting cleanups from functional changes
> from a maintainer perspective (easier reverts) and from a reviewer perspective
> (easier to focus on the functional changes), I think it would be good to improve
> the git tooling to allow easily filtering out the noise from git blame.
> 
> Perhaps a new git blame "--ignore-trivial" and/or "--ignore-cleanup" could solve
> this by filtering out "trivial" and "cleanup" patches from the history it considers.
> 
> Tagging patches as trivial and cleanup should be done in the patch commit message
> (possibly in the title), and enforcing proper tagging of commits is already the
> responsibility of the maintainer merging those cleanup/trivial commits into the
> Linux kernel anyway.
> 
> Under the hood, I suspect it could use something similar to git log --grep=<pattern>
> --invert-grep.
> 
> This should allow git blame users to easily filter out the noise and focus on the relevant
> functional changes.
> 
> Any maybe the patterns associated to "cleanup" and "trivial" commits should be something
> that can be configured through a git config file.
> 
> Thoughts ?

Just an observation: quite a few subtle bugs arise from mistakes in
what should've been a trivial cleanup.  Hell, I've seen bugs coming
from rebase of provably no-op patches - with commit message unchanged.
So IME this is counterproductive...

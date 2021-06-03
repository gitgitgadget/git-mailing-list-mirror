Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3B9C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 10:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A76ED61359
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 10:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhFCKSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 06:18:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49310 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFCKSR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 06:18:17 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E994F219B8;
        Thu,  3 Jun 2021 10:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622715391;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s2dYAEKF3sS13bEvDeeDpxNGlMMkDWtT4qYijuEzx0g=;
        b=PW9nAJvkvO1KE0428ou0opl/nhtgeiZ0V9lsxjb51H7EWs9WycMoxg0q2GqK9dWHCSlynK
        nKjNYuYqJfC0ag2pb1JyEqx1hPNsjYDEJ3YKUBeO8Kj5PNbn5zgf89Zoga8O4gUy1Exth4
        Vd/fQID4dbc9CnA2XSt5bXGM5cfda88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622715391;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s2dYAEKF3sS13bEvDeeDpxNGlMMkDWtT4qYijuEzx0g=;
        b=t3CvZQ9OQMOUOKQ4oSM+hp3r0UBcIqAskoHDlrHbqmbPeoyerxQu0gwk58nLbVSIH2TSuE
        h0f8L2uLoTgk44Dw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D2520A3B8A;
        Thu,  3 Jun 2021 10:16:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E0ECFDA734; Thu,  3 Jun 2021 12:13:50 +0200 (CEST)
Date:   Thu, 3 Jun 2021 12:13:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        git@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: git feature request: git blame --ignore-cleanup/--ignore-trivial
Message-ID: <20210603101350.GW31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Al Viro <viro@zeniv.linux.org.uk>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        git@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <30399052.5964.1622647235870.JavaMail.zimbra@efficios.com>
 <YLej6F24Emm7SX35@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLej6F24Emm7SX35@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 03:29:44PM +0000, Al Viro wrote:
> On Wed, Jun 02, 2021 at 11:20:35AM -0400, Mathieu Desnoyers wrote:
> > Hi,
> > 
> > Following a discussion with Peter Zijlstra about whether code cleanup
> > and functional changes done to the Linux kernel scheduler belong to separate
> > patches or should be folded together, the argument for folding cleanup
> > and function changes came to be mainly motivated by the current behavior
> > of git blame: code cleanup patches end up burying the important changes so
> > it becomes cumbersome to find them using git blame.
> > 
> > Considering the added value brought by splitting cleanups from functional changes
> > from a maintainer perspective (easier reverts) and from a reviewer perspective
> > (easier to focus on the functional changes), I think it would be good to improve
> > the git tooling to allow easily filtering out the noise from git blame.
> > 
> > Perhaps a new git blame "--ignore-trivial" and/or "--ignore-cleanup" could solve
> > this by filtering out "trivial" and "cleanup" patches from the history it considers.
> > 
> > Tagging patches as trivial and cleanup should be done in the patch commit message
> > (possibly in the title), and enforcing proper tagging of commits is already the
> > responsibility of the maintainer merging those cleanup/trivial commits into the
> > Linux kernel anyway.
> > 
> > Under the hood, I suspect it could use something similar to git log --grep=<pattern>
> > --invert-grep.
> > 
> > This should allow git blame users to easily filter out the noise and focus on the relevant
> > functional changes.
> > 
> > Any maybe the patterns associated to "cleanup" and "trivial" commits should be something
> > that can be configured through a git config file.
> > 
> > Thoughts ?
> 
> Just an observation: quite a few subtle bugs arise from mistakes in
> what should've been a trivial cleanup.

I was about to write such comment. Cleanups that are eg. mechanically
switching names/types/variables/... and need some manual fixup are hot
candidates for buggy patches.

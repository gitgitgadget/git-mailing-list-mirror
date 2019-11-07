Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CDEF1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 19:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbfKGTEY (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 14:04:24 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196]:48895 "EHLO
        smtp1.lauterbach.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfKGTEY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 14:04:24 -0500
Received: (qmail 1827 invoked by uid 484); 7 Nov 2019 19:04:22 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.10.40 by smtp1.lauterbach.com (envelope-from <ingo.rohloff@lauterbach.com>, uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.10.40):. 
 Processed in 0.085416 secs); 07 Nov 2019 19:04:22 -0000
Received: from unknown (HELO ingpc3.intern.lauterbach.com) (Authenticated_SSL:irohloff@[10.2.10.40])
          (envelope-sender <ingo.rohloff@lauterbach.com>)
          by smtp1.lauterbach.com (qmail-ldap-1.03) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <Johannes.Schindelin@gmx.de>; 7 Nov 2019 19:04:22 -0000
Date:   Thu, 7 Nov 2019 20:04:21 +0100
From:   Ingo Rohloff <ingo.rohloff@lauterbach.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: Forbid to create local branches with confusing
 names
Message-ID: <20191107200421.6214b2e1@ingpc3.intern.lauterbach.com>
In-Reply-To: <nycvar.QRO.7.76.6.1911062101580.46@tvgsbejvaqbjf.bet>
References: <20191106165628.28563-1-ingo.rohloff@lauterbach.com>
        <nycvar.QRO.7.76.6.1911062101580.46@tvgsbejvaqbjf.bet>
Organization: Lauterbach GmbH
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

On Wed, 6 Nov 2019 23:15:44 +0100 (CET)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi Ingo,
> 
> On Wed, 6 Nov 2019, Ingo Rohloff wrote:
> 
> > Without this patch, git allows to do something like this:  
> 
> Maybe start the patch with a description of the problem it tries to
> solve? In other words, I would have appreciated a first paragraph that
> starts with "Many Git users ...".

That's actually one of the problems: 
It's not clear what exactly the problem is :-).

After thinking about it more: The minimal goal I can think of is to make sure 
that if you use
   git log refs/<something>

you will never get a 
   warning: refname '...' is ambiguous

Rationale behind that: If even "refs/<something>" gives you this warning, 
then you might be in a lot of trouble. It means even giving a "full" refname 
is not enough to resolve ambiguities.
I think this is bad, because it means it might be hard to get out of this 
situation, because you might get the "ambiguous" warnings when you try to 
get rid of the offending refnames.


> 
> A lot of this text should probably go into the commit message itself,
> possibly with accompanying Message-IDs or even public-inbox URLs right
> away.

I did read "Documentation/SubmittingPatches". There it says:

    Try to make sure your explanation can be understood
    without external resources. Instead of giving a URL to a 
    mailing list archive, summarize the relevant points of 
    the discussion.

so that's what I tried to do.

> 
> A more common problem for me, personally, is when I manage to fool
> myself by creating a local branch like `origin/master`. Clearly, I want
> to refer to the remote-tracking branch, but by mistake I create a local
> branch that now conflicts with the (short) name of the remote-tracking
> branch.
> 
> To remedy this, you would not only have to ensure that `create_branch()`
> verifies that the branch name does not have a `<remote-name>/` prefix
> where `<remote-name>` refers to a valid remote, but you would also need
> a corresponding patch that teaches `git add remote <nick> <url>` to
> verify that no local branch starts with `<nick>/`.
> 
> What do you think?
> 

I agree: When I first started to use git, I was quite surprised that this
"double naming" is allowed.

But I also think, this is for another patch series; you probably need to 
honor "--force", or even add a git configuration option to allow this
anyway.

I am able to imagine that people intentionally set up a local branch
called "refs/heads/repoX/master" which tracks "refs/remotes/repoX/master".

For me this sounds like an unnecessary complication (because now you always
have to use the "long" refname), but if you put some software on top of git, 
I can imagine that this might make a lot of sense...

I am not enough of a git wizard to fully grasp the implications here.

so long
  Ingo



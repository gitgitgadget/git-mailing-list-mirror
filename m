Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF5131F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 16:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753925AbcJKQh6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 12:37:58 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:58559 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753729AbcJKQh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 12:37:56 -0400
Received: from [84.131.249.130] (helo=book.hvoigt.net)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bu02q-0000yY-Qg; Tue, 11 Oct 2016 18:36:48 +0200
Date:   Tue, 11 Oct 2016 18:36:47 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] submodule add: extend force flag to add existing
 repos
Message-ID: <20161011163647.GA78554@book.hvoigt.net>
References: <20161006193725.31553-1-sbeller@google.com>
 <20161006193725.31553-2-sbeller@google.com>
 <xmqqshs9i6fr.fsf@gitster.mtv.corp.google.com>
 <20161007125239.GB61543@book.hvoigt.net>
 <CAGZ79kbg1KaeL14DMcV=ObaZOBpJpxOZAEYY1mmf8eqDUUqYmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbg1KaeL14DMcV=ObaZOBpJpxOZAEYY1mmf8eqDUUqYmA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Oct 07, 2016 at 10:25:04AM -0700, Stefan Beller wrote:
> On Fri, Oct 7, 2016 at 5:52 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > On Thu, Oct 06, 2016 at 01:11:20PM -0700, Junio C Hamano wrote:
> >> Stefan Beller <sbeller@google.com> writes:
> >>
> >> > Currently the force flag in `git submodule add` takes care of possibly
> >> > ignored files or when a name collision occurs.
> >> >
> >> > However there is another situation where submodule add comes in handy:
> >> > When you already have a gitlink recorded, but no configuration was
> >> > done (i.e. no .gitmodules file nor any entry in .git/config) and you
> >> > want to generate these config entries. For this situation allow
> >> > `git submodule add` to proceed if there is already a submodule at the
> >> > given path in the index.
> >
> > Is it important that the submodule is in the index?
> 
> If it is not in the index, it already works.

Ah ok I was not aware of that, sorry.

> > How about worktree?
> > From the index entry alone we can not deduce the values anyway.
> 
> Right, but as of now this is the only show stopper, i.e.
> * you have an existing repo? -> fine, it works with --force
> * you even ignored that repo -> --force knows how to do it.
> * you already have a gitlink -> Sorry, you're out of luck.
> 
> So that is why I stressed index in this commit message, as it is only about this
> case.

Forget what I wrote. As said above I was not aware that there is only an
error when it is already in the index.

> > [1] http://public-inbox.org/git/%3C20160916141143.GA47240@book.hvoigt.net%3E/
> 
> Current situation:
> 
> > clone the submodule into a directory
> > git submodule add --force
> > git commit everything
> 
> works fine, but:
> 
> > clone the submodule into a directory
> > git add <gitlink>
> > git commit <gitlink> -m "Add submodule"
> > # me: "Oh crap! I did forget the configuration."
> > git submodule add --force <url> <gitlink>
> > # Git: "It already exists in the index, I am not going to produce the config for you."
> 
> The last step is changed with this patch, as
> it will just work fine then.

Thanks.

Cheers Heiko

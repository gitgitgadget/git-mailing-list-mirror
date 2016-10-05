Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D1141F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 18:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754653AbcJESV6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 14:21:58 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:58779 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754187AbcJESV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 14:21:57 -0400
Received: from [84.131.248.67] (helo=sandbox)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1brqpD-0003j5-Vs; Wed, 05 Oct 2016 20:21:52 +0200
Date:   Wed, 5 Oct 2016 20:21:50 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jeremy Morton <admin@game-point.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Reference a submodule branch instead of a commit
Message-ID: <20161005182150.GA10927@sandbox>
References: <57F29FEF.30700@game-point.net>
 <xmqqfuod6yw2.fsf@gitster.mtv.corp.google.com>
 <20161004113625.GB20309@book.hvoigt.net>
 <CAGZ79kZWtAU6YG4Qz9_Gwk2db5L2kPCCKrN+64hMYDovRjiLRw@mail.gmail.com>
 <xmqqshscuilh.fsf@gitster.mtv.corp.google.com>
 <xmqqlgy4szuu.fsf@gitster.mtv.corp.google.com>
 <20161005141439.GD30930@book.hvoigt.net>
 <xmqqlgy2rcxq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgy2rcxq.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 05, 2016 at 09:13:53AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> >> It IS a hack, but having this information in .git<something> would
> >> mean that it can be forced to be in machine readable form, unlike a
> >> mention in README.  I do not know if the .gitmodules/.gitignore
> >> combination is a sensible thing to use, but it does smell like a
> >> potentially useful hack.
> >
> > IIRC the tree entries are the reference for submodules in the code. We
> > are iterating over the tree entries in many places so that change does
> > not seem so easy to me.
> >
> > But you are right maybe we should stop arguing against this workflow and
> > just let people use it until they find out whats wrong with it ;)
> 
> I didn't say that, though.  I am fairly firm on _not_ changing what
> the superproject records in its tree for the submodule, i.e. it must
> record the exact commit, not "a branch name", for reproducibility. 

I was not talking about changing what the superproject records in its
tree. I was just talking about changing where we look for submodules
(e.g. for updating and such). I.e. in .git* instead of just the tree as
it is at the moment. Thats what I understood from the discussion above.
Sorry that might have been ambiguous.

I agree that there should always be a commit as a reference for a
submodule. But as far as I understand for some projects its to much
overhead to record every change of a submodule but still they want to
use the latest code during development. Those projects might only want
to record the actual commit when they release something. At least thats
what I imagine.

> I am OK if people ignored the unmatch between the recorded commit
> from a submodule and what they had in the submodule directory while
> they developed and tested the superproject commit.  After all, it is
> not an error to make a commit while having a local uncommitted
> changes to tracked files, and it is equally valid to have a commit
> checked out in a submodule directory that is different from what
> goes in the superproject commit.  But we do show "modified but not
> committed" in the status output.  In that light, submodule.*.ignore
> may have been a mistake.

The original intend for submodule.*.ignore was to help people not
showing submodules as dirty when they had untracked files in them. That
was after status learned to look into submodules. 'untracked' to avoid the
performance overhead and 'dirty' for the people that accidentally worked
with dirty submodules. I agree 'all' might have been to much.

For the above workflow what user might actually want is something that
ignores all changes as long as they are part of the remote branch. But I
am just guessing here. My gut feeling is still that most people that
request this feature come from svn. Thats why I asked whether the
options I described provide the behavior that Jeremy wants.

Cheers Heiko

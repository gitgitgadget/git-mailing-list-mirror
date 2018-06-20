Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336561F403
	for <e@80x24.org>; Wed, 20 Jun 2018 10:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbeFTKnx (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 06:43:53 -0400
Received: from chiark.greenend.org.uk ([212.13.197.229]:39850 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbeFTKnw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 06:43:52 -0400
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1fVaac-00066e-Nh; Wed, 20 Jun 2018 11:43:50 +0100
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23338.12262.631847.860230@chiark.greenend.org.uk>
Date:   Wed, 20 Jun 2018 11:43:50 +0100
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: want <reason> option to git-rebase
In-Reply-To: <20180620014940.GD122284@aiede.svl.corp.google.com>
References: <23335.52730.475955.861241@chiark.greenend.org.uk>
        <20180619010655.GA173168@aiede.svl.corp.google.com>
        <c5fc1505-9847-25d8-02f3-c0e666afdd1d@kdbg.org>
        <20180620014940.GD122284@aiede.svl.corp.google.com>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder writes ("Re: want <reason> option to git-rebase"):
> Oh, good catch.  "git rebase" already generally does the right thing
> when GIT_REFLOG_ACTION is set (by only appending to it and never
> replacing it).

Great.  I indeed did not know about this.

> Ian, does that work well for you?  If so, any ideas where it should go
> in the documentation to be more discoverable for next time?

Thanks for asking exactly the right question :-).

I didn't make a record of exactly where I looked but I'm pretty sure I
looked at the manpages for git-reflog and git-rebase.  I think I
probably also looked at git-update-ref; I have read git-update-ref a
number of times.

Right now in Debian unstable I see that none of these places document
this convention.

I think git-reflog ought to mention it, so that it says where the
information it provides comes from.

It also ought to be mentioned in git-update-ref, because all callers
of git-update-ref need to implement it !

Indeed, because I didn't know about this convention, dgit and
git-debrebase do not honour it.  At least in my case, if it had been
in git-update-ref I would have implemented it myself and then I would
obviously have thought of making use of it myself.


Also, I have to say, the documentation for GIT_REFLOG_ACTION
in git(1) is very obscure.  It sort of generally waffles around what
it is for, but it does not say:
 * what does this variable contain
 * who can and should set it
 * who should consume it
 * what the rules are for modifying it

I don't think simply adding a cross-reference to GIT_REFLOG_ACTION in
git(1) would be sufficient, without also improving this part.


The explanations provided by you and Johannes, here in these emails,
are much much better:

> >> "git rebase" sets this itself, so it doesn't solve your problem.
> >
> > If it does so unconditionally, then that is a bug. If a script
> > wants to set GIT_REFLOG_ACTION, but finds that it is already set,
> > then it must not change the value. set_reflog_action in
> > git-sh-setup does the right thing.
> >
> > So, if there is another script or application around git-rebase, then it
> > should just set GIT_REFLOG_ACTION (if it is not already set) and export the
> > environment variable to git-rebase.
> 
> Oh, good catch.  "git rebase" already generally does the right thing
> when GIT_REFLOG_ACTION is set (by only appending to it and never
> replacing it).

Maybe some of this prose, which explains things quite well, could be
reworked into a form suitable for the git docs.  (Even though there
seems to be disagreement about whether a subcommand may *append* to
GIT_REFLOG_ACTION; which, ISTM, is a practice which ought to be
encouraged rather than discouraged.)


Regards,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.

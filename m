Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373701F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 14:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756501AbcHXOmt (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 10:42:49 -0400
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:36784 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755246AbcHXOmr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 10:42:47 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 8613847B3E8
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 16:21:31 +0200 (CEST)
Received: from mfilter20-d.gandi.net (mfilter20-d.gandi.net [217.70.178.148])
        by relay6-d.mail.gandi.net (Postfix) with ESMTP id 1B4C3FB8A9;
        Wed, 24 Aug 2016 16:20:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter20-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
        by mfilter20-d.gandi.net (mfilter20-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id UT6DO45X1rlW; Wed, 24 Aug 2016 16:20:28 +0200 (CEST)
X-Originating-IP: 75.98.193.200
Received: from x (unknown [75.98.193.200])
        (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 383B9FB8CB;
        Wed, 24 Aug 2016 16:20:26 +0200 (CEST)
Date:   Wed, 24 Aug 2016 10:20:24 -0400
From:   Josh Triplett <josh@joshtriplett.org>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Extending "extended SHA1" syntax to traverse through gitlinks?
Message-ID: <20160824142024.xnaehfo2spw26apj@x>
References: <9bad3d13-3257-2077-a734-f985c375b8d3@gmail.com>
 <20160821142634.dorgzldjvc3qiaby@x>
 <ab6e29c1-ea6d-c1c5-e69f-867c16cc736a@gmail.com>
 <20160823065359.34cirqig56fugnwy@x>
 <b2f7ff11-23b4-1065-2207-43f736c91988@gmail.com>
 <xmqq60qqu3rl.fsf@gitster.mtv.corp.google.com>
 <b264e17a-12ff-69ca-f130-78d2635a0f85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b264e17a-12ff-69ca-f130-78d2635a0f85@gmail.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 03:16:56PM +0200, Jakub Narębski wrote:
> W dniu 24.08.2016 o 07:36, Junio C Hamano pisze:
> > Jakub Narębski <jnareb@gmail.com> writes:
> > 
> >> The point is that submodule has it's own object database.  It might
> >> be the same as superproject's, but you need to handle submodule objects
> >> being in separate submodule repository anyway.  Common repository is
> >> just a special case.
> >>
> >> By the way, this also means that proposed "extended extended SHA1"
> >> syntax would be useful to user's of submodules...
> > 
> > Not really.
> > 
> > I think that you gave a prime example why <treeish>:<path1>//<path2>
> > is not a useful thing for submodules.  When the syntax resolves to a
> > 40-hex object name, that object name by itself is not useful.
> > 
> > You also need to carry an additional piece of information that lets
> > you identify the location of the repository, in which the object
> > name is valid, in the current user's context (i.e. somewhere in the
> > superproject where the submodule lives).  In other words, you'd need
> > to carry <treeish>:<path1> around anyway for the object name to be
> > useful, so there is no good reason why anybody should insist that
> > the plumbing level resolve <treeish>:<path1>//<path2> directly to an
> > object name in the first place.
> 
> Not really.
> 
> The above means only that the support for new syntax would be not
> as easy as adding it to 'git rev-parse' (and it's built-in equivalent),
> except for the case where submodule uses the same object database as
> supermodule.
> 
> So it wouldn't be as easy (on conceptual level) as adding support
> for ':/<text>' or '<commit>^{/<text>}'.  It would be at least as
> hard, if not harder, as adding support for '@{-1}' and its '-'
> shortcut.

Depends on which cases you want to handle.  In the most general case,
you'd need to find and process the applicable .gitmodules file, which
would only work if you started from the top-level tree, not a random
treeish.  On the other hand, in the most general case, you don't
necessarily even have the module you need, because .git/modules only
contains the modules the *current* version needed, not every past
version.

As an alternate approach (pun intended): treat every module in
.git/modules as an alternate and just look up the object by hash.  Or,
teach git-submodule to store all the objects for submodules in the
supermodule's .git/objects (and teach git's reachability algorithm to
respect refs in .git/modules, or store their refs in
.git/refs/submodules/ or in a namespace).

> Josh, what was the reason behind proposing this feature? Was it
> conceived as adding completeness to gitrevisions syntax, a low-hanging
> fruit?  It isn't (the latter).  Or was it some problem with submodule
> handling that you would want to use this syntax for?

This wasn't an abstract/theoretical completeness issue.  I specifically
wanted this syntax for practical use with actual trees containing
gitlinks, motivated by having a tool that creates and uses such
gitlinks. :)

> As for usefulness: this fills the hole in accessing submodules, one
> that could be handled by combining plumbing-level commands.  Namely,
> there are 5 states of submodule (as I understand it)
> 
>  * recorded in ref / commit in supermodule
>  * recorded in the index in supermodule
>  - recorded in ref / commit in submodule
>  - recorded in the index in submodule
>  - state of worktree in submodule
> 
> The last three can be easyly acessed by cd-ing to submodule.  The first
> two are not easy to get, AFAIUC.

Right.  I primarily care about those first two cases, especially the
first one: given a commit containing a gitlink, how can I easily dig
into the linked commit?

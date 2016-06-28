Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_50,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B2D91FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 11:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbcF1LKh (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 07:10:37 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:53102 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750871AbcF1LKg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 07:10:36 -0400
X-Greylist: delayed 986 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jun 2016 07:10:35 EDT
Received: from 206-55-177-216.fttp.usinternet.com ([206.55.177.216] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.86)
	(envelope-from <greened@obbligato.org>)
	id 1bHquT-0001Q8-S2; Tue, 28 Jun 2016 06:10:29 -0500
From:	greened@obbligato.org (David A. Greene)
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, techlivezheng@gmail.com,
	alex.crezoff@gmail.com, davvid@gmail.com, cbailey32@bloomberg.net,
	danny0838@gmail.com, prohaska@zib.de, th.acker@arcor.de,
	sschuberth@gmail.com, peff@peff.net, gitter.spiros@gmail.com,
	nod.helm@gmail.com
Subject: Re: [PATCH] contrib/subtree: Remove --annotate
References: <1451963101-4901-1-git-send-email-greened@obbligato.org>
	<1451963101-4901-2-git-send-email-greened@obbligato.org>
	<xmqqsi2cj5hu.fsf@gitster.mtv.corp.google.com>
	<87oaczwvz8.fsf@waller.obbligato.org>
	<xmqqbn8mish5.fsf@gitster.mtv.corp.google.com>
	<87oacjaint.fsf@waller.obbligato.org>
	<xmqq60yrektk.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 28 Jun 2016 06:10:29 -0500
In-Reply-To: <xmqq60yrektk.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 17 Jan 2016 17:29:59 -0800")
Message-ID: <87vb0td0wq.fsf@waller.obbligato.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Filter-Spam-Score:  ()
X-Filter-Spam-Report: 
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> greened@obbligato.org (David A. Greene) writes:
>
>> Just to clarify, what is the expectation of things in contrib?
>> Basically the same as other code?
>
> That heavily depends on your exit strategy.
>
> If the aspiration is to move up to exit, then the quality and
> stability expectation is basically the same as stuff in core, and we
> need to strive to keep it stable and high quality.

This is the strategy I was planning to pursue.  After extensive
experience with git-subtree and some local enhancements I have in
real-world work, I am convinced it is a great complementary tool to
git-submodule.  It seems odd to me to have one in core and one not.

>  * If the integration between "git subtree" and the rest of the
>    system is loose (in other words, if your improved version of "git
>    subtree" taken from Git 2.8 is dropped into an even newer version
>    of Git 2.13, or an older version like Git 2.4 for that matter, is
>    it expected to work, given the promise of interface stability git
>    core gives you?), there is not much technical reason why it must
>    stay in core.  Of course, your improvements may need to take
>    advantage of improvements on the core side and your new "git
>    subtree" may start to require at least Git 2.8, or you may even
>    send patches to the core side to extend and enhance the services
>    you use from the core side, but as long as that happens only
>    occasionally and the dependency does not require lock-step
>    upgrade, we can still call such an integration "loose" and moving
>    out will still be a viable possibility.

The enhancements to git-subtree that I have and/or am planning to
implement will probably require some changes to core, mostly bugfixes.
Some of the rebase tests I've sent are heading in that direction.  They
are problems I discovered while trying to enhance subtree.

>  * If you expect the pace of improvement would be far faster than
>    the release schedule of git core (usually a cycle lasts for 8 to
>    12 weeks), moving out would give users a shorter turnaround for
>    getting new and improved "git subtree".

I don't think this is a concern.

>  * It may even turn out that the users are a lot more tolerant for
>    instability (e.g. removal of rarely used features) in "git
>    subtree" than they require the git core proper to be stable, in
>    which case moving up (rather than moving out) to apply the same
>    stability requirement to "git subtree" as the rest of the system
>    would be undesirable.

That's a fair point.  Besides than removing this --annotate option, I
anticipate two other potentially breaking changes:

1. Reorganizing metadata to be more useful - The metadata tags are
   somewhat misleading at the moment and there is additional metadata
   I've thought about adding.

2. Changing the split algorithm to reuse more of git core -
   Specifically, I would like to leverage filter-branch to eliminate a
   bunch of custom code in the split algorithm.  In fact doing so would
   fix a couple of bugs that have come in.  My intent for this change is
   to not alter the resulting history from what split does now (except
   fixing the known bugs) but I can't absolutely guarantee that will be
   the case until I implement it and try it out.

>  * Moving up and staying in has a big social implication. It gives
>    the version that comes with git core an appearance of being
>    authoritative, even when other people fork the project.
>
>    - This discourages incompatible forks (e.g. when one such fork
>      finds the need to improve the "metadata" left by merge
>      operation and used by split, the resulting repository managed
>      by it may no longer usable by other variants of "git subtree",
>      and if there is one in-tree "authoritative" one that is
>      maintained, such a fork will not get wide adoption without
>      taking compatibility issues into account).

Other than the metadata rework mentioned above, I personally don't
anticipate a lot of change to it.  Some ideas have come in from
elsewhere but I'm not yet convinced they're necessary.  My guess is that
any future metadata changes will be more for convenience than any core
fnctionality.  Thus, they could be added in a backward-compatible way.

>    - On the other hand, if the "authoritative" one moves too slowly,
>      that may hinder progress.  An exit by "moving out" to become
>      one of the projects that help people's Git-life would result in
>      two or more honestly competing forks of "git subtree", which
>      might give users a better end-result after a few years, even
>      though the users who happened to have picked the losing side
>      during these few years may end up having to rewrite the
>      history.

That's an important point, especially given the time constraints I have.
Despite all my efforts, work is still taking the majority of my coding
time.  That may improve given some other life schedule changes but we
will see.  I think I can also justify taking some work time to implement
things, since the enhancements are all driven by work needs.

Overall, I think moving subtree to core is the best plan, given
submodule's status and the fact that both tools address similar tasks
but do them in fundamentally different ways, leading to useful
trade-offs for users.  One of the things I plan to do is add a section
to subtree's documentation that discusses submodule, subtree and
reasonable scenarios when one may be a better fit than the other.

                            -David

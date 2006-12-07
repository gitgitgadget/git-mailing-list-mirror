X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Explicitly add the default "git pull" behaviour to .git/config on clone
Date: Wed, 06 Dec 2006 19:44:55 -0800
Message-ID: <7v64cowers.fsf@assigned-by-dhcp.cox.net>
References: <200612061207.23437.andyparkins@gmail.com>
	<200612061800.17087.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0612070022180.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<200612070349.58521.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 03:45:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612070349.58521.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Thu, 7 Dec 2006 03:49:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33547>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsABw-0003d8-E6 for gcvg-git@gmane.org; Thu, 07 Dec
 2006 04:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968376AbWLGDo5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 22:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968514AbWLGDo5
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 22:44:57 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:46887 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S968376AbWLGDo4 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 22:44:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207034455.NLVJ22053.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Wed, 6
 Dec 2006 22:44:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id vfkK1V00j1kojtg0000000; Wed, 06 Dec 2006
 22:44:20 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> IMHO there only should be one place/command which is creating new branches,
> and which is called by other porcelain commands [*1*].

Giving an option to git branch to set something like this up
would be nice.  I would agree the division of labor you propose
is a good way to keep the scripts maintainable.

It however is a different matter if we would want to set up the
merge default always in the way you propose for a new branch at
the policy level.

It also is a different matter if "git branch" has enough
information to figure out which upstream "origin" needs to be
fetched from, given an origin SHA-1 expression to create a new
branch from, at the technical level

It entirely is possible to use the same remotes/origin/
hierarchy to track two physically different URLs (thus two
different "origin"s) on a mobile machine that has different
connectivity to the outside world depending on where you are
("that mirror is closer from here" and "I need to go over the
firewall while I am here").  Because they track the logically
same repository, it does not make sense to use different
hierarchies under remotes/ for this purpose.

In such a setup, "git branch new origin/for-public" would not be
able to tell which "origin" to fetch from, so it may not even be
feasible to do what you propose without an explicit help from
the command line option.  At least, however, the call to "git branch"
you would add as a part of this proposal to "git clone" would
know which URL, because at that point it would not even know
about the alternate connectivity yet.

> Why should we not setup branch.*.merge when a create a new development
> branch from a tracking branch via "git branch", or "git checkout -b"?

So while I am definitely in favor of the technical side of your
proposal to have "git checkout -b" use "git branch", instead of
doing it by hand, I think it would be an easier sell to separate
the policy from the discussion at least in the beginning.

I say this not because I disagree with your question: "Why
should we not?"  I do not have a ready-answer to that rhetorical
question yet.  But that is different from saying "it does not
make sense to do this setup because of such and such concrete
reasons", so I haven't formed an opinion on this policy matter
yet.


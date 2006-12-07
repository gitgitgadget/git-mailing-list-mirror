X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull and merging.
Date: Thu, 07 Dec 2006 11:06:34 -0800
Message-ID: <7vhcw7ttj9.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
	<200612061744.31213.Josef.Weidendorfer@gmx.de>
	<4577B8C0.3060200@gmail.com>
	<200612071227.46194.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 19:06:43 +0000 (UTC)
Cc: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612071227.46194.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Thu, 7 Dec 2006 12:27:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33603>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsOZs-0002pp-0q for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163206AbWLGTGg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163207AbWLGTGg
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:06:36 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:58993 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163206AbWLGTGf (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 14:06:35 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207190635.HOZR3525.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Thu, 7
 Dec 2006 14:06:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vv6k1V01A1kojtg0000000; Thu, 07 Dec 2006
 14:06:45 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> More important: Because "branch.*.merge" specifies a _remote_ branch,
> the user has to understand that this info is already used in the fetch.
> The intuitive mental model of a user about how it works IMHO is that
> "branch.*.merge" is checked in the merge phase (as the name of the option suggests).
> But this way, how could the merge phase know about any remote branch at all,
> which does not need to be touched at all in the merge phase?

I accepted the "branch.*.merge" patch long time ago but I did
not see the point of moving things into config back then, so I
did not look at the design issue deeply enough to notice that
this can be a source of confusion (in other words, "I wouldn't
use it myself, but I've seen some people on the list wanting to
have it, and the submitter must have thought about what are
needed a lot more than myself" did not go so well).

Once you place something like "branch.*.merge" in configuration
file (either $GIT_DIR/config, or a $GIT_DIR/remotes/* file), you
are talking about other repositories you regularly interact
with, so it might be probably Ok to require the user to use a
tracking branch if he wants the convenience of "branch.*.merge",
and make its value name the local tracking branch instead of the
remote branch.

But that means I would never be able to benefit from the
convenience of "branch.*.merge"; I pull from gitk repository to
get updates, but I do not have (and I do not see the point to
have) a remote tracking branch to track it.  If you want to
cater to people who fetch and merge without using tracking
branches, the remote branch name is the only sane thing you can
use for the value of "branch.*.merge".

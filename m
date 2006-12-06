X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull and merging.
Date: Tue, 05 Dec 2006 21:02:03 -0800
Message-ID: <7vodqhaa7o.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 05:02:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
	(Aneesh Kumar's message of "Wed, 6 Dec 2006 10:21:46 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33403>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grov5-0003dH-5b for gcvg-git@gmane.org; Wed, 06 Dec
 2006 06:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760073AbWLFFCI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 00:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760085AbWLFFCI
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 00:02:08 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:63481 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1760073AbWLFFCF (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 00:02:05 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206050204.TSGM9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Wed, 6
 Dec 2006 00:02:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id vH1U1V00n1kojtg0000000; Wed, 06 Dec 2006
 00:01:29 -0500
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Sender: git-owner@vger.kernel.org

"Aneesh Kumar" <aneesh.kumar@gmail.com> writes:

> I have a git.git clone using --use-separate-remote. That means i have
> the master branch created by default. Now i need to build git from the
> pu branch too. So i created git branch pu remotes/origin/pu.
>
>
> How how do i track the pu branch using git pull. What i mean is the
> master local branch is tracked by default using git pull. Is there a
> way to track the local pu branch too.

        $ cat >.git/remotes/origin <<\EOF
        URL: ...kernel.org/pub/scm/git/git.git
        Pull: refs/heads/master:refs/remotes/origin/master
        Pull: refs/heads/next:refs/remotes/origin/next
        Pull: +refs/heads/pu:refs/remotes/origin/pu
        EOF

Then you would checkout 'pu' by having a matching local branch:

	$ git branch pu remotes/origin/pu
	$ git checkout pu ;# this is your refs/heads/pu
        $ make

Hacking on it can be done in this branch as usual.  When you are
interested in the latest 'pu' from me:

	$ git checkout pu ;# this is your refs/heads/pu
	$ git fetch ;# most of the time git pull would also be fine...

and then:

	$ git rebase remotes/origin/pu

The 'rebase' in the last step is because my 'pu' rewinds freely;
otherwise you would do "git merge remotes/origin/pu" instead.

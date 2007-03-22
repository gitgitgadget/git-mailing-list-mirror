From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Thu, 22 Mar 2007 01:21:28 -0700
Message-ID: <7vlkhpvgc7.fsf@assigned-by-dhcp.cox.net>
References: <20070321120643.GI20583@mellanox.co.il>
	<7v648u38ws.fsf@assigned-by-dhcp.cox.net>
	<20070322043604.GA6303@mellanox.co.il>
	<7vd531yicx.fsf@assigned-by-dhcp.cox.net>
	<20070322062805.GD6303@mellanox.co.il>
	<7vaby5wxyn.fsf@assigned-by-dhcp.cox.net>
	<20070322074051.GA29341@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu Mar 22 09:21:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUIYB-0002X3-SW
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 09:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbXCVIVc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 04:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbXCVIVc
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 04:21:32 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:48253 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbXCVIVa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 04:21:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070322082129.HWTU2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 22 Mar 2007 04:21:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dkMU1W00o1kojtg0000000; Thu, 22 Mar 2007 04:21:29 -0400
In-Reply-To: <20070322074051.GA29341@mellanox.co.il> (Michael S. Tsirkin's
	message of "Thu, 22 Mar 2007 09:41:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42846>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

>> Quoting Junio C Hamano <junkio@cox.net>:
>> Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
>> 
>> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
>> 
>> > BTW, is there some way to figure it out besides looking at the code
>> > or grepping git archives?
>> 
>> Like SubmittingPatches?
>
> SubmittingPatches is for people contributing to git.
> But how are *users* of git-am supposed to figure it out?

(1) SubmittingPatches describes the git project policy on patch
    formatting, which happens to be similar to the kernel
    project.

(2) Users of git-am, git-format-patch and friends in general are
    not bound by SubmittingPatches, unless they are contributing
    to the git project.  As the policy differs from project to
    project, there is nothing authoritative in git documentation
    set, nor there should be anything stronger than merely our
    recommendation.  Yes, SubmittingPatches could be used as one
    potential BCP that is managed with git, but we are not in
    any position to impose that to other projects.  In other
    words, *users* of git-am are not supposed to figure it out.
    They will not find *their* project policy from git
    documentation, unless their project happens to be the git
    project.

(3) However, we are discussing your patch to support "git merge
    FETCH_HEAD" better, which I took as your contribution to the
    git project.  I asked you to follow the project policy for
    your contribution, and pointed at the document that
    describes the policy.

Clear?

I think your patch means well, and when polished it might be a
valuable addition.  "Hi!" and "Would the following be
appropriate?" are the least of the problems I pointed out, but
to clear the dust, let's finish them with responses: "Hi to
you!", and "Yes, what the patch tries to do looks very nice, but
there are a few issues I would want you to resolve" ;-).

To reiterate the more important points (this is also for my own
purpose because I do not want the patch lost in this noise we
are making):

 - Checking readability of $GIT_DIR/$remote itself is too loose;
   the name FETCH_HEAD should explicitly be checked, as that is
   the file that has the specific format that is understood by
   fmt-merge-msg.

 - "echo -n" is to be avoided for portability.

 - "git fetch $URL foo bar" would leave two lines in FETCH_HEAD;
   subsequent "git merge FETCH_HEAD" would merge only foo.  Pick
   the first line, stripping out not-for-merge marker and let it
   processed by fmt-merge-msg.

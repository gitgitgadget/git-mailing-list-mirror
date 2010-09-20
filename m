From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Find out on which branch a commit was originally made
Date: Mon, 20 Sep 2010 01:47:39 -0400
Message-ID: <201009200547.o8K5ldI7010683@no.baka.org>
References: <1jp0h7e.lgk0kp19qe5bbM%lists@haller-berlin.de> <201009192030.21659.robin.rosenberg@dewire.com> <201009192203.o8JM39PE011067@no.baka.org> <4C9698C5.70607@gmail.com> <201009192354.o8JNsVLs018778@no.baka.org>
        <4C96B97D.6030209@gmail.com>
Cc: git@vger.kernel.org
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 07:48:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxZEO-00073L-Oz
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 07:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279Ab0ITFrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 01:47:43 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:48154 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934Ab0ITFrm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 01:47:42 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id o8K5le6C030652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 20 Sep 2010 01:47:40 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id o8K5ldI7010683;
	Mon, 20 Sep 2010 01:47:39 -0400
In-reply-to: <4C96B97D.6030209@gmail.com>
Comments: In reply to a message from "Artur Skawina <art.08.09@gmail.com>" dated "Mon, 20 Sep 2010 03:31:41 +0200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156550>


In message <4C96B97D.6030209@gmail.com>, Artur Skawina writes:

    On 09/20/10 01:54, Seth Robertson wrote:

    > I'd like a command that would tell me the right branch something was
    > on whether it was on master or topic or whatever.  If instead of
    > "master" the branch was named "supertopic" and master commit AA had
    > child D would that make a difference?

    Like i said, "arguably". In theory, no, there is no difference. In
    practice, some branches will be more long-lived than others -- and
    certain conventions will apply. Hence, i think that answer /is/ the
    right one, in context -- that script was specifically looking for
    info on /another/ branch.

Only if the topic branch didn't have a merge on it.

         -AA-- subtopic
        /     \
       A---B---C topic
      /         \
 D---E---F---G---H---I---J---K---L---M---N master
                          \         /
                           O---P---Q another-topic


In the above example, the subtopic branch merge from AA to C prevents
you from finding out what branch B is on using the original script.


    > I'm not sure how you can figure out when a branch was first created.
    > We might "know" that master is older than the others, but if this
    > commit was on another-topic and supertopic we cannot use that
    > intuition..

    > Returning all possible branch names at least gives the user somewhere
    > to start and does not give them ones which are obviously insane.

    IOW, why would the right answer for 'F' be both 'master' and
    'another-topic', but for 'B' - just 'topic'?

I agree 100% that the right answer is topic for B and master for F.

I know how to get topic for B.  Finding master (and not another-topic)
for F is difficult because we have to know something that I don't know
how to get git to tell me: when another-topic branch was created.
Using git-rev-parse another-topic....master we know what commit
another-topic and master diverged, but I cannot figure out a way to
discover which branch was created at that point and which branch
pre-existed (obviously for master we know, but if this was a
supertopic branch we would not).  I thought about using merge
direction for subsequent merges as a hint, but we don't know if the
second branch has been permanently been merged or not, if there was a
K->P merge and Q-M did not happen (yet) then we would give the wrong
branch name.

If you (or anyone) can answer that question, I'll be happy to update
the script.  Otherwise getting both answers is as close as we can come.

					-Seth Robertson

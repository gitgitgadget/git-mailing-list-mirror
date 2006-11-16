X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 02:31:52 -0800
Message-ID: <7vejs3d6nb.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<455BBCE9.4050503@xs4all.nl>
	<Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 10:32:20 +0000 (UTC)
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwen@xs4all.nl>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31566>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkeXW-00047T-PN for gcvg-git@gmane.org; Thu, 16 Nov
 2006 11:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423727AbWKPKby (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 05:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423740AbWKPKby
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 05:31:54 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:10646 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1423727AbWKPKbx
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 05:31:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116103152.KDSH7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 05:31:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nNXy1V00H1kojtg0000000; Thu, 16 Nov 2006
 05:31:59 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> And I've said this again, and I'll say it once more: that has basically 
> _nothing_ to do with whether you spell "pull" as "pull" or "merge".
>
> The reason people have trouble wrapping their heads around git is because 
> they have been braindamaged by CVS and SVN, and just don't understand the 
> fairly fundamental new concepts and workflow.
> ...
> Let's face it, you could just alias "merge" to "pull", and it wouldn't 
> really change ANYTHING. You'd still have to learn the new model. 

I had a bit different feeling about yesterday's discussion
myself.

If somebody uses git like you do in "truly distributed way", the
current pull behaviour and pull being an operational mirror to
push are natural consequence of the model and concepts, and
there is nothing to fix (modulo "the default merge source per
branch" should be made easier to use).  Renaming the pull to
merge would not make it any easier to use unless the underlying
model is understood, and I fully agree with you on that.

But for people working in a project organized around central
repository in the CVS/SVN fashion, the workflow is quite
different.  CVS does not even let you "fetch" without either
merging (co) or throwing away your work (co -C), and we already
do support that model with:

	git clone
        git pull
        work work work; git commit
        git push
        : oops not fast forward?
        git pull
        resolve work; git commit
	git push

without ever using a local branch, any tracking branch, nor
use of git-fetch.  So we do support both extremes ("truly
distributed" and "not distributed at all") reasonably well.

The trouble starts when the users hear about this wonderful
"distributed" stuff git offers, and try to use it without
understanding the key concepts.  People tend to learn by doing
and there is a leap the user need to make because now they need
to understand branched development, branches and fetching like
you explained if they want to use git the same way as you do.
Once they understand them, then the current set of tools offer
them a simple and very straightforward user interface (the tools
directly reflect the concepts and it is straightforward only
because we are talking about users who understood the concepts).

But we have to admit that this leap may rather be difficult for
people who are used to other models.  Telling them that our
model is different and it is different for a good reason does
not change the fact that the more different something is, the
more difficult to learn it.

I suspect that there could be a way to use git, not like you or
I do.  Our workflows are already quite different (e.g. you
almost never do topic branch merge yourself in your repository,
but I have abundance of them).  There is no reason to think
there won't be other workflows that are suitable for other
people.  Some workflows might be classified less distributed and
inferiour compared to the "truly git way" from "truly
distributed is the point of git" point of view, but nevertheless
could be "good enough" for those people.  In other words, a
workflow that is a bit more advanced than just a single trunk
CVS/SVN usage could still take advantage of some of the features
to support distributed development model git has, while not
taking full advantage of truly distributed nature of git.

I think the complaints in the yesterday's discussion are mostly
about frustration that, while we have a reasonable support for
the both extremes, we do not either know what that middle ground
workflow is, or even if we know what that is, we do not support
it very well.

And I am not opposed to people exploring what that different
workflow would be, and while they do so if they come up with a
set of commands (get/put perhaps) to suppor that slightly
different workflow, that would be a very good thing.

Add foreign SCM importers in the mix and the situation becomes
more difficult and interesting.  cvsimport mostly works and
quacks like git-fetch with set of tracking branches, which I
think is the right model for the importers, and would integrate
well with the current set of tools.  I believe svnimport is the
same way.  But I do not know about git-svn.

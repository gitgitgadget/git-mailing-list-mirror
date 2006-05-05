From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Thu, 04 May 2006 17:25:47 -0700
Message-ID: <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
	<87mzdx7mh9.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 02:25:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fbo8r-0006JK-5p
	for gcvg-git@gmane.org; Fri, 05 May 2006 02:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWEEAZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 20:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWEEAZv
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 20:25:51 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:29116 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750839AbWEEAZv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 20:25:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060505002550.KVGY27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 May 2006 20:25:50 -0400
To: Carl Worth <cworth@cworth.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19589>

Carl Worth <cworth@cworth.org> writes:

> ... So the conversation changes from "I WANT
> <fetch-heads> and I HAVE <heads>" to one of "I WANT <fetch-heads>, and
> I HAVE <heads>, except that I'm MISSING <cauterized-commits>".
>
> Finally, whenever a fetch receives an commit object that is in its
> list of cauterized commits, it should remove that commit from the
> list. This allows a shallow clone to be naturally migrated to
> something unshallow. And the user can do this as incrementally as
> desired based on the need to see more history:
>
> get a bit:
> 	git fetch somewhere --since=2.weeks.ago
>
> then a bit more:
> 	git fetch somewhere --since=1.year.ago
>
> then get it all:
> 	git fetch somewhere
>
> Maybe that's no different from Junio's original proposal. If not, what
> do you see in the above that wouldn't work?

Lack of actual code to do all that ;-)

Jokes aside, I think listing the updated conversation elements
like you did above is a good step forward.

The vocabulary we would want from the requestor side is probably
(at least):

	I WANT to have these
        I HAVE these
        I'm MISSING these
        Don't bother with these this time around (--since, ^v2.6.16, ...)

I am not sure how we would want to encode the last one and have
it used by rev-list on the upload-pack end safely and sanely.

And the responder side needs to be able to say, "Now you are
MISSING these, remember it and tell me you are missing them next
time you make a request".  That would be, in the simplest case,
a list of commit IDs to cauterize, but I am not sure what is the
right way to come up with that list.  Especially I do not know
if --boundary would/should work with --objects.

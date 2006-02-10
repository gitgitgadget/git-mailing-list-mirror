From: Junio C Hamano <junkio@cox.net>
Subject: Re: Two crazy proposals for changing git's diff commands
Date: Thu, 09 Feb 2006 16:13:42 -0800
Message-ID: <7vr76c5avd.fsf@assigned-by-dhcp.cox.net>
References: <87slqtcr2f.wl%cworth@cworth.org>
	<7vfymtl43b.fsf@assigned-by-dhcp.cox.net>
	<87bqxgxfl7.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 01:14:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7LvK-0005yt-Sn
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 01:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWBJANs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 19:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWBJANs
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 19:13:48 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:50632 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750857AbWBJANr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 19:13:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210001238.LHRR15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 19:12:38 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87bqxgxfl7.wl%cworth@cworth.org> (Carl Worth's message of "Thu,
	09 Feb 2006 15:44:20 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15845>

Carl Worth <cworth@cworth.org> writes:

> So, what I'm trying to work towards is a situtation where those
> workflows are captured through obviously-correlated command
> subsets. This is what I was getting at in the PS. of my previous
> post. For example, the above could be, (ignoring the clash with
> existing core commands), something like:
>
> Index-lover:
>
> 	update-index
> 	diff-index
> 	commit-index
>
> Index-ignorer:
>
> 	diff-files
> 	commit-files

I see where you are coming from and I personally kind of like
this consistency.  But I am hesitant to declare these two
workflows as the _only_ ones officially supported by the tool at
this moment.  The collective use pattern of git is still young
and leaving the door open would help us to evolve more useful
workflows around the core in the future.  One of our first goals
would be to have good set of introductory documentations for
best current practices -- if the project you work on fits this
workflow, here is a way to do it.  With that workflow, there is
this way.  By that time, hopefully many useless workflows (my
"constantly rewinding pu branch" pattern _could_ fall into that
category) would be withered away and it would be a good time to
streamline the tool around officially supported workflows.

My feeling is that it is a bit premature to do that right now; I
do not think we are there yet.

> Sure. In that light, try to conceive as my proposed "diff-files" and
> "diff-index" commands as two new highlevel commands. They would be
> useful in day-to-day operation, and most commonly without any need for
> command-line arguments. Those two operations exist today within the
> git-diff wrapper already as "diff HEAD" and "diff --cached HEAD" (or
> "diff --cached). But as described above, I think it would be better to
> put these operations on separate command names, and get them down to
> not requiring any command-line arguments in their common usage.

Sorry, I am not convinced about separate command names, but in
the meantime you could have small wrappers around "git diff":
"cw-diff-files" and "cw-diff-index" would be one liner each,
wouldn't they?

And that is a _good_ thing about git.  If the sample set of
barebone Porcelains do not fit your needs, you can mix and match
using lowlevel commands to quickly script your customized ones.
If that is useful in general, that would become one of the best
current practices.

> If you compare my above two chunks of example commands, there's nothing
> like a low-level vs. high-level distinction between them. It's more
> about separate command names being uses for different use cases and
> consistent naming used to group related commands within a use case.

I think that is where we differ.  I think even for index-lover
"diff HEAD" is useful in certain cases (obviously index-ignorer
would not see much useful output from "diff --cached", though).
In fact, I fall into "index-lover" camp but I use both depending
on occasion.  And as I said, I do not think "index-lover" and
"index-ignorer" distinction above would be the only two valid
workflows anyway, so I feel partitioning the command set along
those lines is at least premature if not wrong.

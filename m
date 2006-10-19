From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 13:27:59 +0200
Message-ID: <20061019112759.GA31066@diana.vm.bytemark.co.uk>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org> <45359B2A.1070102@utoronto.ca> <87y7rdd47j.wl%cworth@cworth.org> <20061019091045.GV75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carl Worth <cworth@cworth.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 19 13:28:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaW4h-0005Ms-Ar
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 13:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423295AbWJSL2c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Oct 2006 07:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161395AbWJSL2c
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 07:28:32 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:7696 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1161110AbWJSL2b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 07:28:31 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1GaW47-00007Y-00; Thu, 19 Oct 2006 12:27:59 +0100
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
Content-Disposition: inline
In-Reply-To: <20061019091045.GV75501@over-yonder.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29341>

On 2006-10-19 04:10:45 -0500, Matthew D. Fuller wrote:

> I think this has the causality backward. It's avoided because it
> changes the ancestry of the branch in question, by rearranging the
> left parents; this ties into Linus' assertion that all parents ought
> to be treated equally, which I'm beginning to think is the base
> lynchpin of this whole dissension.

Yes, it seems you have found the needle. :-) In git, history is a DAG;
a commit has a _set_ of parents, so by definition they are not
ordered. This has a number of consequences. For example, you can't
really answer the question "Which branch was this commit on?". All you
can say is that "This commit is reachable from (and therefore part of)
branches X, Y, and Z."

In all other SCMs I have seen, a "branch" is conceptually an ordered
series of commits (some of which may be merges). In git, a "branch" is
a pointer to a commit, period. The commit knows its set of parents, so
all its history is there, but there is fundamentally no way to tell
which branch a commit was "on" when it was created.

This is an important point; it means there is no concept of "my" or
"your" branch. Every participant is adding commits to the same DAG,
and may at any point decide to share her additions with someone else,
or keep them private forever. And because "branches" don't really
exist, every commit really is created equal.

Really, every commit. Not even the initial commit of a project is
special -- it's just a commit with an empty parent set. And, it's
perfectly possible to make a (merge) commit whose parents belong to
previously disconnected parts of the DAG. This of course means that
it's not even possible to differentiate commits based on which project
they're part of, since one can create a commit whose parents belong to
different projects. All commits are _really_ born equal! There's just
one great DAG of all git commits that could possibly exist. (This has
been done in git's own history; the graphical viewer gitk was
originally a separate project, with its own initial commit, but that
initial commit is now reachable from all commits currently being made
to git -- that is, it has been merged.)

This structure of things may seem complex, since it's different, but
mathematically it's quite simple, and that's what counts in the end if
you want to do nontrivial things.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

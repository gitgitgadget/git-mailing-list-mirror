From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] merge-recursive: do not report the resulting tree object name
Date: Sat, 13 Jan 2007 00:14:47 -0500
Message-ID: <20070113051447.GA22063@spearce.org>
References: <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com> <7v8xgileza.fsf@assigned-by-dhcp.cox.net> <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com> <20070107163112.GA9336@steel.home> <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net> <20070112184839.9431ddff.vsu@altlinux.ru> <7vr6u0t87q.fsf@assigned-by-dhcp.cox.net> <7v8xg8t3aj.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701130034000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vbql3pxz8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 06:15:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5bEH-0007Gc-C1
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 06:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161288AbXAMFOy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 00:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161291AbXAMFOy
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 00:14:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36759 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161288AbXAMFOx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 00:14:53 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5bE9-00025X-L3; Sat, 13 Jan 2007 00:14:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CBC1220FBAE; Sat, 13 Jan 2007 00:14:47 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbql3pxz8.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36739>

Junio C Hamano <junkio@cox.net> wrote:
>         $ git merge jc/merge-base
>      1	Trying really trivial in-index merge...
>      2	fatal: Merge requires file-level merging
>      3	Nope.
>      4	Merging HEAD with jc/merge-base
>      5	Merging:
>      6	b60daf0 Make git-prune-packed a bit more chatty.
>      7	5b75a55 Teach "git-merge-base --check-ancestry" about refs.
>      8	found 1 common ancestor(s):
>      9	1c23d79 Don't die in git-http-fetch when fetching packs.
>     10	Auto-merging Makefile
>     11	Auto-merging builtin-branch.c
>     12	Auto-merging builtin-reflog.c
>     13	CONFLICT (content): Merge conflict in builtin-reflog.c
>     14	Auto-merging builtin.h
>     15	Auto-merging git.c
>     16	Removing merge-base.c
>     17	Resolved 'builtin-reflog.c' using previous resolution.
>     18	Automatic merge failed; fix conflicts and then commit the result.
> 
> Among these, I think lines 2..3 are somewhat confusing but I am
> used to seeing them and do not mind them too much.

In my experience these lines scare new users.  And then they start
to ignore other "fatal:" messages from Git because they can safely
ignore this particular one.  Not good.  One reason I like my patch
that's in next.

> Lines 4..9 do not have any real information that helps the end
> user (even though it would be a very good debugging aid for
> merge-recursive developers).

I agree.  I've grown used to seeing them and read it for
entertainment.  Clearly I need to get out more.  They probably
should be relegated to a GIT_MERGE_OPTIONS environment variable
flag or to a command line parameter, as they are probably only
useful when debugging the application itself.
 
> Lines 10..16 are useful, but I think we probably should show
> them only for outermost merges.

Actually I think that only 13 is useful.  10-12,14-17 are
pretty useless messages in my mind.  I really don't care that
merge-recursive automatically merged these files, as in all cases but
the one reported by line 13 the merge was successful.  The diffstat
that is normally displayed by git-merge after a successful merge
shows you what files were modified by the other branch.  It also
often causes the output of merge-recursive to scroll off the screen,
making those messages even less useful.

> An multi-base example:
>     16	Auto-merging gitweb/gitweb.perl
>     17	Merge made by recursive.
>     18	 gitweb/gitweb.css  |    2 +
>     19	 gitweb/gitweb.perl |  165 ++++++++++++++++++++++++++++++++...
>     20	 2 files changed, 117 insertions(+), 50 deletions(-)
> 
> I do not think we need to show 1..15 at all, perhaps without
> "export GIT_MERGE_BASE_DEBUG=YesPlease".

Yes, I agree.  Except I'd say 1..16, for the reason stated above.

But then I would like a progress meter, showing % of files resolved,
to keep the user entertained.  Alex has 1 min+ merges.  1 minute
of absolutely no feedback is not very nice to a new user.

Maybe when I'm done hacking on git-describe performance improvements
I'll look at merge-recursive.

-- 
Shawn.

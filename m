From: Paul Fox <pgf@foxharp.boston.ma.us>
Subject: Re: Topics currently in the Stalled category
Date: Wed, 21 Nov 2012 14:50:58 -0500
Message-ID: <20121121195058.32DAF2E9303@grass.foxharp.boston.ma.us>
References: <20121121024647.BBCC82E9301@grass.foxharp.boston.ma.us> <20121121092750.GA8262@shrek.podlesie.net> <20121121193401.GC16280@sigill.intra.peff.net> (sfid-20121121_143409_470299_FB6B658B)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Krzysztof Mazur <krzysiek@podlesie.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:51:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbGKJ-0003Wz-5l
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab2KUTu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:50:59 -0500
Received: from colo.foxharp.net ([166.84.7.52]:55832 "EHLO colo.foxharp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755883Ab2KUTu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:50:58 -0500
Received: from grass.foxharp.boston.ma.us (localhost [127.0.0.1])
	by colo.foxharp.net (Postfix) with ESMTP id 4E8B1540E4;
	Wed, 21 Nov 2012 14:47:53 -0500 (EST)
Received: by grass.foxharp.boston.ma.us (Postfix, from userid 1000)
	id 32DAF2E9303; Wed, 21 Nov 2012 14:50:58 -0500 (EST)
Received: from grass (localhost [127.0.0.1])
	by grass.foxharp.boston.ma.us (Postfix) with ESMTP id 269622E9302;
	Wed, 21 Nov 2012 14:50:58 -0500 (EST)
In-reply-to: <20121121193401.GC16280@sigill.intra.peff.net> (sfid-20121121_143409_470299_FB6B658B)
Content-ID: <3609.1353527458.1@grass>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210171>

jeff wrote:
 > On Wed, Nov 21, 2012 at 10:27:50AM +0100, Krzysztof Mazur wrote:
 > 
 > > >  > * pf/editor-ignore-sigint (2012-11-11) 5 commits
 > > >  > 
 > > >  >  Avoid confusing cases where the user hits Ctrl-C while in the editor
 > > >  >  session, not realizing git will receive the signal. Since most editors
 > > >  >  will take over the terminal and will block SIGINT, this is not likely
 > > >  >  to confuse anyone.
 > > >  > 
 > > >  >  Some people raised issues with emacsclient, which are addressed by this
 > > >  >  re-roll. It should probably also handle SIGQUIT, and there were a
 > > >  >  handful of other review comments.
 > > >  > 
 > > >  >  Anybody interested in moving this forward?
 > > > 
 > > > i started this, but then jeff took it and ran with it and made it
 > > > right.  i think the remaining changes are small -- if jeff would
 > > > prefer, i can probably finish it.  (but i won't guarantee not to
 > > > mess up the "From:" lines.  :-)
 > > > 
 > > 
 > > I'm also interested. I sometimes use ":r !command" in vim, so far I never
 > > needed to use Ctrl-C, but maybe in future.
 > > 
 > > The SIGINT part seems to be finished, we need to decide what about SIGQUIT.
 > 
 > My plan was to just add in SIGQUIT[1] alongside SIGINT (and I think
 > there may have been one or two other minor comments in response to the
 > series). I am on vacation this week, but can revisit it next week. If
 > somebody wants to re-roll it in the meantime, that would be fine with
 > me.
 > 
 > -Peff
 > 
 > [1] Given the core-dumping behavior of SIGQUIT, I suspect it is not
 >     nearly as widely used as SIGINT, but it sounds more like the
 >     principle of least surprise to treat them the same.

i see no real point in treating them the same -- as you suggest, one
would only use SIGQUIT if SIGINT didn't work, and then you'd want them
to be treated differently.  so i'd be happy with the current code in
that regard.

i think krzysiek said that since editors usually catch SIGQUIT, git
should kill the editor when receiving SIGQUIT, essentially translating
the SIGQUIT to SIGTERM for the editor.  (please correct me if i
misunderstood.)  since well-behaved editors will die quickly anyway
(they get EIO on their next read from stdin), i'm not sure there's a
compelling reason for that extra step.

but i have no real objection to that behavior if others think it's
right -- there's certainly logic in saying that if git dies it should
ensure the editor does too.

(i'm away for the rest of the week also.)

paul
=---------------------
 paul fox, pgf@foxharp.boston.ma.us (arlington, ma, where it's 44.6 degrees)

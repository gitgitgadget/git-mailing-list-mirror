From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: interactive rebase not rebasing
Date: Wed, 1 Oct 2008 01:03:06 -0500
Organization: Exigence
Message-ID: <20081001010306.01cc34eb.stephen@exigencecorp.com>
References: <20080928235013.5c749c6e.stephen@exigencecorp.com>
	<48E078BF.5030806@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Oct 01 08:04:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkuox-0000KU-SX
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 08:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbYJAGDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 02:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbYJAGDM
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 02:03:12 -0400
Received: from smtp172.sat.emailsrvr.com ([66.216.121.172]:46174 "EHLO
	smtp172.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbYJAGDL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 02:03:11 -0400
Received: from relay7.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay7.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id BFBDA9B0B77;
	Wed,  1 Oct 2008 02:03:09 -0400 (EDT)
Received: by relay7.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 5B6F85B38BD;
	Wed,  1 Oct 2008 02:03:09 -0400 (EDT)
In-Reply-To: <48E078BF.5030806@op5.se>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97201>


> > # A --C------            <-- origin/stable
> > #  \  |      \
> > #   B -- D -- E -- F     <-- origin/topic2
> > #    \|
> > #     g -- h             <-- topic2
> > 
> > Nothing has changed. g & h haven't moved...I can keep executing this
> > operation and the commits never make it on top of origin/topic2's F. 
> > 
> > Frustratingly, if I run non-interactive rebase, it works perfectly.
> 
> I can imagine. Since you don't want to preserve the merges in this
> case, you shouldn't be using the -p flag.

No, I do want to preserve most merges. This "most" qualification is
because the merge "g", if rebased, would have been a no-op, so `rebase
-i -p` correctly kept it out of the TODO file.

Which is cool, except that later on, when rewriting the other TODO
commits, some of which were children of "g", it did not remember that
"g" had gone away, so did nothing to take "g" out of the rewritten
children's parent list.

> In fact, for this particular scenario (assuming "h" is really the only
> commit on topic2), you probably want to just cherry-pick that commit
> into origin/topic2:
> 
>    git checkout topic2
>    git reset --hard origin/topic2
>    git cherry-pick ORIG_HEAD

Agreed. This makes a lot of sense for me, who has been hacking around in
git-rebase--interactive fixing things, but I'd really like the other
people on my team to just have to run `git rebase -i -p`.

> I don't think you can have a single command that does all the things
> you want, because the possible differences in input makes it very
> nearly impossible to always do "the right thing".

Ah, you are too pessimistic. :-)

> Assuming you're passing a correct input file to rebase -i; yes. At the
> very least, "h" should be moved to the tip of origin/topic2.

Cool, agreed. I've got a patch that gets `rebase -i -p` to do this. I'll
send it to the list soon.

- Stephen

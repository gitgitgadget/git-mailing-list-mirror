From: Pete Wyckoff <pw@padd.com>
Subject: Re: New script to convert p4 repositories to git - git-p4c version
	1.
Date: Mon, 15 Dec 2008 14:30:58 -0500
Message-ID: <20081215193058.GA5098@osc.edu>
References: <1228818317.5504.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: John Chapman <thestar@fussycoder.id.au>
X-From: git-owner@vger.kernel.org Mon Dec 15 20:32:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCJAx-0002UD-Iw
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 20:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbYLOTbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 14:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbYLOTbA
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 14:31:00 -0500
Received: from marge.padd.com ([99.188.165.110]:40519 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357AbYLOTa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 14:30:59 -0500
Received: from oink.padd.com (oink.padd.com [69.36.12.13])
	by marge.padd.com (Postfix) with ESMTPSA id 372A710F8186;
	Mon, 15 Dec 2008 11:28:53 -0800 (PST)
Received: by oink.padd.com (Postfix, from userid 7770)
	id 0F2FEFD4164; Mon, 15 Dec 2008 14:30:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1228818317.5504.23.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103199>

thestar@fussycoder.id.au wrote on Tue, 09 Dec 2008 21:25 +1100:
> I couldn't use git-p4 on my system because I kept running out of memory,
> and I didn't like the workflow it imposed.
> Also, it had various other issues with the repo I was trying to use,
> mainly because it is not an ideal repository, however those are
> (generally) the fault of the particular repo I was using, and not
> git-p4. (Which is an excellent script by itself).
> 
> This script is severely crippled in that it doesn't (yet) allow one to
> contribute changesets back to perforce, however it manages to read from
> perforce with:
> * No need to rebase.
> * Mangling of file names. (Especially with regards to case sensitivity).
> * Tagging of revisions with the perforce changesets.
> * Ability to handle branches with spaces in the name.
> * Ability to pretend that perforce doesn't exist. (That's the plan,
> anyway).
> * Be extremely memory efficient. It does NOT require as much memory as
> does git-p4, even when the size of the change is large.
> * Be easy to manually modify the repository, particularly if bad things
> happen.

I like how your script imports one change at a time, as the initial
import using git-p4 here does indeed get close to exhasting virtual
memory, but I'm running into a different limitation with p4c.

The command:

    p4 -G changes -l -t

is adminstratively limited to a paltry six-digit number, and
produces only an error message.

The other feature I need is the ability to use a client
specification.  We merge together 40-odd different chunks of //depot
into a single checked-out client, and use some other number of
"-//depot/..." rules to exclude some parts of the full depot.

If I hack p4c to limit the changes with "-m 10" or so, then things
are a bit better in that I get two objects (changesets) but no
diffs.  Had to hack the on_branch() code somewhat, in that no form
of --branches seemed to produce an "interesting" changeset by your
definition.  Could be my lack of understanding here.

If you think you want to handle client specifications, and can think
of a way around the "p4 changes" limitation, I'll be happy to poke
at your next version.  Perhaps I'm not in your target audience,
though.  I don't necessarily need to have a full git history of the
entire p4, but this seems to be a fundamental part of your approach.

		-- Pete

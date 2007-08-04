From: Sean <seanlkml@sympatico.ca>
Subject: Re: Terminology question about remote branches.
Date: Sat, 4 Aug 2007 10:48:51 -0400
Message-ID: <20070804104851.162d7e00.seanlkml@sympatico.ca>
References: <854pjfin68.fsf@lola.goethe.zz>
	<20070804092933.aaec6d52.seanlkml@sympatico.ca>
	<85ejijgzzg.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 16:49:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHKwS-0000Dn-KX
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 16:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230AbXHDOtB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 10:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754599AbXHDOtB
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 10:49:01 -0400
Received: from bay0-omc2-s3.bay0.hotmail.com ([65.54.246.139]:39190 "EHLO
	bay0-omc2-s3.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754177AbXHDOtB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 10:49:01 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.184]) by bay0-omc2-s3.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sat, 4 Aug 2007 07:49:00 -0700
X-Originating-IP: [64.231.205.174]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([64.231.205.174]) by bayc1-pasmtp11.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sat, 4 Aug 2007 07:49:45 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IHKw6-0001GE-OK; Sat, 04 Aug 2007 10:48:58 -0400
In-Reply-To: <85ejijgzzg.fsf@lola.goethe.zz>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.13; i686-pc-linux-gnu)
X-OriginalArrivalTime: 04 Aug 2007 14:49:46.0078 (UTC) FILETIME=[B31547E0:01C7D6A6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54860>

On Sat, 04 Aug 2007 16:01:55 +0200
David Kastrup <dak@gnu.org> wrote:

> So --track does not set up a tracking branch, but makes a local
> _following_ branch _refer_ to a tracking branch.

Sure, that's one way to describe it; perhaps it would be best if
we switched to that nomenclature in the documentation.

> What happens with
> 
>     git checkout origin/branchX
>     git branch --track mylocalbranch
>     git checkout mylocalbranch

This is easy to test, and the answer is that no tracking is set up.
You must supply the remote-tracking-branch on the command line with
the --track option to git branch.  Actually I realized that with a
new enough version of Git, --track is implied.

> ?  What if after the checkout (which leads to a detached head) I check
> in a few things, and then decide to name the branch and set it up as
> following a remote tracking branch?  Instead of using git-branch for
> setting up the following, do I have to explicitly add the respective
> "remote" line (which does not specify a remote, but a remote tracking
> branch) into, uh, where?

It's not a problem, you could just add an appropriate [branch...] section
in your .git/config.   Actually looking at a typical branch section
is even more confusing to me:

    $ git branch fudge origin/fix1

adds this to the .git/config:

    [branch "fudge"]
        remote = origin
        merge = refs/heads/fix1

The config file does not record the remote-tracking-branch, instead
it explicitly records the remote repository information.  So it sure
appears that if you add the --track option, it _does_ make the local
branch track a remote directly.  Thus it's hard to call it anything
but what you labelled it,  a local tracking-branch.

While I thought i had a handle on this, i'm now officially more
confused than you; hopefully someone with knowledge of the guts
of Git will speak up.   Junio Help!

Sean

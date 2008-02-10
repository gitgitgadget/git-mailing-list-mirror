From: Jeff King <peff@peff.net>
Subject: Re: Upcoming memcached releases + rambling.
Date: Sun, 10 Feb 2008 06:15:57 -0500
Message-ID: <20080210111557.GA27348@coredump.intra.peff.net>
References: <47AAC7DA.2010604@rydia.net> <4422C0B2-6874-41EA-B4A0-4F3414F385FC@spy.net> <47AB3DBD.60004@rydia.net> <3897B3FD-4DCB-4150-8A07-7F8868A70A93@spy.net> <47AD2D1F.7030807@rydia.net> <5222C3B4-5E2C-45D2-8DF3-A85D69DDA2CF@spy.net> <47AD643D.3040800@rydia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dustin Sallings <dustin@spy.net>,
	memcached list <memcached@lists.danga.com>, git@vger.kernel.org
To: dormando <dormando@rydia.net>
X-From: git-owner@vger.kernel.org Sun Feb 10 12:16:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOAB7-0008QS-Du
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 12:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756211AbYBJLQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 06:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756769AbYBJLQB
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 06:16:01 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3183 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754899AbYBJLQA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 06:16:00 -0500
Received: (qmail 26435 invoked by uid 111); 10 Feb 2008 11:15:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 10 Feb 2008 06:15:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Feb 2008 06:15:57 -0500
Content-Disposition: inline
In-Reply-To: <47AD643D.3040800@rydia.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73338>

On Sat, Feb 09, 2008 at 12:28:45AM -0800, dormando wrote:

> If I _think_ I understand these right, you can actually sometimes git
> diff with the second repo as an argument. That'll show the differences
> since the target repo/branch (git diff . /path/to/other/repo#branch),
> which will be incoming or outgoing.

No, that doesn't work. It will literally diff the two directories.

What you have probably seen is:

  git diff origin HEAD

which means "diff my current branch with the branch origin". Now
"origin" is typically the name of your upstream remote. However, we also
use the same name to store "tracking branches" that keep tabs on the
remote's state. So the branch "origin" stores the state of the remote's
current branch (as of the last time you did a "git fetch" of course).

But "git diff HEAD <someURL>" does not work. You would want "git fetch
<someURL> && git diff HEAD FETCH_HEAD".

> That'll show the raw changes... for showing the difference in changeset,
>   you can do a: git log --since HEAD origin
> ... if origin were the remote repo. If you don't have the latest
> changes, fetch more, rebase your repo on top of that, then git log
> --since will show you what you have to upload.

That --since is not necessary. You want "git log HEAD..origin" (where
"A..B" means "what's in B, but not in A"). "--since" is for
date-limiting, and the syntax is like "--since=2.weeks.ago".

> I think my knowledge on how to do this in git is a bit dated, so I'll go
> read (I started with git in 0.99 series, where it was missing most of
> these fancy "usability features", so sometimes I do things the hard way
> still).

Pre-1.5 and 1.5 have quite a few interface differences (and of course
there were many changes from 0.99 to 1.5 :) ).

> Otherwise you can use git fetch to "pull" the remote changes into a
> branch but not apply anywhere, then use git log with relative commit ids
> to show the changesets (with -p to show the full changes!)

Yes, although I would say that git fetch "fetches" changes, so as not to
confuse it with the "pull" command which does something different.

> Unless I'm getting my wires crossed and this is a patch management
> thinger, in that case it's 'git format-patch' and 'git am' (although
> there's an alternative to am).

Actually "am" is the new alternative to "applymbox" which is now
officially gone in 1.5.4.

-Peff

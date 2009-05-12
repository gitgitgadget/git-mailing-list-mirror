From: Jeff King <peff@peff.net>
Subject: Re: git default behavior seems odd from a Unix command line point
	of view
Date: Tue, 12 May 2009 12:24:45 -0400
Message-ID: <20090512162444.GC29566@coredump.intra.peff.net>
References: <4e963a650905120818m70b75892gb4e052187910b9a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andrew Schein <andrew@andrewschein.com>
X-From: git-owner@vger.kernel.org Tue May 12 18:25:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3ump-0002Mb-Hh
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbZELQYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 12:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbZELQYq
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:24:46 -0400
Received: from peff.net ([208.65.91.99]:48907 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbZELQYp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:24:45 -0400
Received: (qmail 32056 invoked by uid 107); 12 May 2009 16:25:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 May 2009 12:25:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 May 2009 12:24:45 -0400
Content-Disposition: inline
In-Reply-To: <4e963a650905120818m70b75892gb4e052187910b9a5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118918>

On Tue, May 12, 2009 at 11:18:25AM -0400, Andrew Schein wrote:

> The [1] in my prompt indicates the exit code of the git commands. What
> I find odd is that even with the -q option, you get this verbose
> output.  Also, you get  a non-zero exit status (which I would expect
> only on a failure such as presence of an unresolved conflict).  My git
> usage is to have a number of small repositories and use a shell script
> to loop over them and perform a sync with a centralized server.
> Having all this wordy output on a "no sync necessary" scenario seems
> counter the desired properties of output only when work is taking
> place or when an error occurs.
> 
> Have others developed git practices to sync a bunch or repositories
> without all this verbose output on a "no change" scenario?

Yes, I have such a script. I check:

  git ls-files -m -o -d --exclude-standard --directory --no-empty-directory

If it produces any output, then there is something to commit (either a
change in a tracked file, or an untracked file that might need to be
added).

I also do a fetch and check to see if we have any commits that need to
be merged:

  git rev-list master..origin

or any commits that we need to push:

  git rev-list origin..master

(actually, it is a bit more complicated, since "master" and "origin" are
just convention; I actually parse the config to find the branch pairs).

-Peff

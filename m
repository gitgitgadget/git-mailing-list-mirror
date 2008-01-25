From: Jeff King <peff@peff.net>
Subject: Re: What's a "work tree"?
Date: Fri, 25 Jan 2008 01:14:21 -0500
Message-ID: <20080125061421.GC21973@coredump.intra.peff.net>
References: <4798E26D.3040707@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 07:15:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIHqD-0000eA-If
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 07:15:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbYAYGOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 01:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbYAYGOY
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 01:14:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3611 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbYAYGOY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 01:14:24 -0500
Received: (qmail 18444 invoked by uid 111); 25 Jan 2008 06:14:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 25 Jan 2008 01:14:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Jan 2008 01:14:21 -0500
Content-Disposition: inline
In-Reply-To: <4798E26D.3040707@talkingspider.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71683>

On Thu, Jan 24, 2008 at 02:09:33PM -0500, Mike wrote:

> I'm trying to figure out what a "work tree" is.  as in --work-tree. This 
> is a new command right, the tutorials I've read don't have it. The man 
> page has the syntax but I don't know what it's for.

The work tree is the place where your checked out files reside. E.g.,
in an ordinary repo (made with "git init" or "git clone") everything
that isn't in the .git directory.

> $ cd /www/mysitedocroot
> $ git --git-dir /gitdir/mysitegit/ add .
> fatal: add must be run in a work tree

You are using --git-dir to point to a repository directory that isn't
".git". That's OK, and it will generally assume that your current
directory is the work tree. E.g., this works:

  mkdir repo && cd repo
  git init
  mv .git mygitdir
  touch file
  git --git-dir=mygitdir add file

However, there is a config option "core.bare" which indicates that a
repository is "bare", meaning that it has no work tree (and that is
presumably what's happening in your example). So you could use
--work-tree=. to override that in your example (though you might just be
better off setting config.bare to false).

The more probable use case for --work-tree is something like

  $ cd /gitdir/mysitegit
  $ git --work-tree=/www/mysitedocroot add .

i.e., you are in the git dir, so you specify the work tree rather than
the other way around. You could even do this:

  $ cd /some/other/directory
  $ git --git-dir=/gitdir/mysitegit --work-tree=/www/mysitedocroot add .

although I'm not sure it's that useful.

-Peff

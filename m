From: Jeff King <peff@peff.net>
Subject: Re: Fatal error running status in new repo
Date: Tue, 16 Feb 2010 01:05:28 -0500
Message-ID: <20100216060528.GB2169@coredump.intra.peff.net>
References: <20100216041945.GB10296@vfb-9.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 07:05:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhGYy-0001vP-Mn
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 07:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166Ab0BPGFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 01:05:31 -0500
Received: from peff.net ([208.65.91.99]:46669 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105Ab0BPGFa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 01:05:30 -0500
Received: (qmail 29752 invoked by uid 107); 16 Feb 2010 06:05:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Feb 2010 01:05:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2010 01:05:28 -0500
Content-Disposition: inline
In-Reply-To: <20100216041945.GB10296@vfb-9.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140069>

On Mon, Feb 15, 2010 at 08:19:45PM -0800, Jacob Helwig wrote:

> I just noticed this when creating a new repo for a project.
> 
> $ mkdir tmp
> $ cd tmp
> $ git init
> Initialized empty shared Git repository in /home/jhe/projects/tmp/.git/
> $ git status
> # On branch master
> #
> # Initial commit
> #
> warning: ignoring dangling symref HEAD.
> fatal: bad revision 'HEAD'
> nothing to commit (create/copy files and use "git add" to track)
> $ echo $?
> 0
> $ git --version
> git version 1.7.0

I can't reproduce it here:

  $ mkdir tmp && cd tmp && git init && git status
  Initialized empty Git repository in /home/peff/tmp/.git/
  # On branch master
  #
  # Initial commit
  #
  nothing to commit (create/copy files and use "git add" to track)

Furthermore, the "ignoring dangling symref" message can only come from
one place (sha1_name.c:285), and is specifically protected by a
conditional making sure that the refname is not "HEAD". Which is just
plain weird.

Do you have anything strange in your ~/.gitconfig? Can you try running
with GIT_TRACE=1 to make sure we are not invoking some sub-command or
something? Did you build git yourself? Can you double-check with a "make
clean && make" that a newly built version exhibits the problem?

> Seems a bit silly that "git status" should be issuing warnings, and
> fatal errors (especially when the exit code is still 0), when run before
> the first commit has been created in a brand new repository.
> 
> The warnings make sense if you know what's going on behind the scenes,
> but seem like the kind of thing that could scare someone new to git when
> they haven't actually done anything wrong at this point.

Agreed. These warnings absolutely should not be shown, but I don't
really understand what is showing them.

-Peff

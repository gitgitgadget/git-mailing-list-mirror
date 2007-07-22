From: Jeff King <peff@peff.net>
Subject: Re: executing git from a non git directory
Date: Sun, 22 Jul 2007 03:11:37 -0400
Message-ID: <20070722071136.GA346@coredump.intra.peff.net>
References: <6b6419750707212355q48a934e4n3be0d6111694ad01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Patrick Aljord <patcito@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 09:11:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICVbU-0008Ci-D0
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 09:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277AbXGVHLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 03:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754309AbXGVHLk
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 03:11:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3695 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754277AbXGVHLj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 03:11:39 -0400
Received: (qmail 28332 invoked from network); 22 Jul 2007 07:12:07 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 22 Jul 2007 07:12:07 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Jul 2007 03:11:37 -0400
Content-Disposition: inline
In-Reply-To: <6b6419750707212355q48a934e4n3be0d6111694ad01@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53226>

On Sun, Jul 22, 2007 at 01:55:33AM -0500, Patrick Aljord wrote:

> $ git --git-dir=/path/to/my_git_dir status
>
> and
>
> $ GIT_DIR='/path/to/my_git_dir' && git status
>
> but in both cases I get this error:
> fatal: Not a git repository: '/path/to/my_git_dir'

A git dir is the location where all of the repository information is
stored; it is called '.git' for a directory with a working tree. Is
/path/to/my_git_dir really a git dir, or is it a working directory that
has a '.git' inside it?

If the latter, then you need to specify the .git directory. However,
running 'git-status' won't make any sense then, since you won't be in
the correct working tree (so of course it will look like files have been
removed).

You could do something like "git --dir /path/to/my_git_dir/.git branch"
and it would at least produce sensible results.

> yet when I do "$ cd /path/to/my_git_dir && git status" I do get the results.

Right. That's the way you have to do it in the case of 'status', since
you need your current working directory to be in the right place.

If you are running a very recent git, you can now try:

  git --work-tree=/path/to/my_git_dir --git-dir=/path/to/my_git_dir/.git status

which is what you actually want.

-Peff

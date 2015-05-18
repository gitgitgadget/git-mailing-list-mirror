From: Jason Cooper <git@lakedaemon.net>
Subject: Re: Git Server Repository Security?
Date: Mon, 18 May 2015 12:18:05 +0000
Message-ID: <20150518121805.GA29057@io.lakedaemon.net>
References: <CABQ4iYiWu17H1XhPYebmP27x=R11SKW0P91AW2y9S=r-2c0B1A@mail.gmail.com>
 <20150518102633.GA15186@book.hvoigt.net>
 <CABQ4iYgjtdw46Psow_e7uGLqx0ZiFt+TQOgXvCmP1-W10LGEmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: John McIntyre <joh98.mac@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 14:34:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuKFR-0005jT-WA
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 14:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbbERMeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 08:34:13 -0400
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:24143 "HELO
	pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751154AbbERMeL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2015 08:34:11 -0400
X-Greylist: delayed 961 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 May 2015 08:34:11 EDT
Received: from io (unknown [72.84.113.125])
	by outbound2.ore.mailhop.org (Halon Mail Gateway) with ESMTPSA;
	Mon, 18 May 2015 12:18:17 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
	by io (Postfix) with ESMTP id 8A88F80068;
	Mon, 18 May 2015 12:18:05 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 8A88F80068
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
	s=mail; t=1431951485;
	bh=MBuMJDigMw3xAEr7prLx36RREojs+ovP8KHq5to8B8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FtvexQmr05v+AZz8p8l5Hd+gaXkCmiZZQ2EDg4qMfCEQqde36k5sH8NVCwf2LvTTG
	 6Zvzw68WAamqxGmsajyrrdFbIChthhvrcD2hAAfGxJeCMJqUHxHpow5xJ8EbQpksVG
	 miIvq1N/g/GsO1sjdVrICgiie9PlKz7/2XnmrBvXFGR7/92+TICx3VnBBOl0V4hFoM
	 CEnfgiMzdXNhxTd7+2rIguFxykZa8bd2ZUn9Lm4IUTQlz0tExvoTLRCfRQteJgaTef
	 VhZ0za73w8jntsD+eZJxeMaoG/SYlHeQj2DFfbmuZ/D39kmwAK0G//j2IJuUFn+Z6U
	 k35dJOyfQhY8Q==
Content-Disposition: inline
In-Reply-To: <CABQ4iYgjtdw46Psow_e7uGLqx0ZiFt+TQOgXvCmP1-W10LGEmg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269231>

On Mon, May 18, 2015 at 11:58:03AM +0100, John McIntyre wrote:
> 2015-05-18 11:26 GMT+01:00 Heiko Voigt <hvoigt@hvoigt.net>:
> > Hi,
> >
> > On Mon, May 18, 2015 at 11:07:02AM +0100, John McIntyre wrote:
> >> Hi,
> >> I've been asked to set up a git repository for a few projects.  So I
> >> have a Linux CentOS server running git.   I place the repositories
> >> under /opt and I use the .ssh/authorized_keys of the git user, to
> >> grant access. The user sends me his private key, and I paste it into
> >> the end of the file.

I _hope_ you meant 'public' key here. ;-)

> >> And now, I realise that there's a problem.  If I have /opt/repo1.git
> >> and /opt/repo2.git, then all users can access both repositories.
> >>
> >> Is there a way to prevent this?
> >
> > If you want a simple tool using ssh-keys have a look at gitolite[1].
> > It quite simple to setup and with it you can specify all kinds of access
> > rights.
> 
> That's adding a separate level of complexity.

What you're asking for is going to a require *some* additional
complexity.

> I looked into filesystem-level permissions.  I don't see any means of
> doing so, because everyone accesses the repositories using the 'git'
> user.  So even if I add a group like 'devClient1' and then change the
> group ownership of a repo to that user, they'll still be able to
> access all repos..?

The github/Atlassian workflow isn't the only way to skin the cat. :)

It sounds to me like you want users to git+ssh into with their own user
accts.  Then you can leverage the posix permissions model.
Unfortunately, without a bit a restriction, you'll also be granting each
of them a user shell on the git server.  You may not want that.

There are many low-level ways to accomplish this, depending on the
maintenance burden you are willing to take on.  If the server is
Internet-accessible will also affect what you are willing to tolerate.

Most of the solutions you may be interested in will involve ssh
single-purpose keys.  Basically, pre-pending the public key in the
~/.ssh/authorized_keys file with 'command=/path/to/allowed/cmd ...'.
Users attempting to ssh in to that user acct will *only* be allowed to
execute that command.  The command can be a filter for the
user-requested command, held in the environment var,
SSH_ORIGINAL_COMMAND.

For an example of one way to leverage this, see some code I wrote to
allow passwordless (cronjob) git and rsync ssh commands:

  http://git.infradead.org/users/jcooper/secsh.git/blob/HEAD:/README

secsh's big drawback is that if the restricted public key is the only
one granting them access to the git server, the user has no way to
add/delete git repos.  For your usecase, that may not be important.

Should you consider deploying secsh, you may also want this [1] patch
for openssh that adds a 'no-user-shell' option for the ssh public key
restrictions.  With that enabled, no shell is executed on the box,
significantly limiting damage caused by a stolen user ssh key.  Yes,
I've been meaning to submit it.  -ETIME and whatnot.  It probably needs
updated in order to apply cleanly.

hth,

Jason.

[1] http://www.openwall.com/lists/oss-security/2014/09/25/41

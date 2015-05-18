From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Git Server Repository Security?
Date: Mon, 18 May 2015 13:57:49 +0200
Message-ID: <20150518115749.GA16841@book.hvoigt.net>
References: <CABQ4iYiWu17H1XhPYebmP27x=R11SKW0P91AW2y9S=r-2c0B1A@mail.gmail.com>
 <20150518102633.GA15186@book.hvoigt.net>
 <CABQ4iYgjtdw46Psow_e7uGLqx0ZiFt+TQOgXvCmP1-W10LGEmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John McIntyre <joh98.mac@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 13:58:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuJgJ-0005zO-QZ
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 13:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbbERL57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 07:57:59 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.94]:33436 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbbERL56 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 07:57:58 -0400
Received: from [195.71.20.144] (helo=book.hvoigt.net)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YuJgA-0004ci-Qg; Mon, 18 May 2015 13:57:54 +0200
Content-Disposition: inline
In-Reply-To: <CABQ4iYgjtdw46Psow_e7uGLqx0ZiFt+TQOgXvCmP1-W10LGEmg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269228>

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
> >>
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

Yes its a little more complex but not much.

> I looked into filesystem-level permissions.  I don't see any means of
> doing so, because everyone accesses the repositories using the 'git'
> user.  So even if I add a group like 'devClient1' and then change the
> group ownership of a repo to that user, they'll still be able to
> access all repos..?

No the repositories are only accessible by the defined groups/users.

The access control is done by the gitolite layer. It uses the command
option in the authorized_keys file to restrict access. The access rights
and groups and so on are configured in its own gitolite.conf file which
is itself stored in a git repository in which you commit and push to
change them (or add more ssh-keys).

It only uses ssh to authenticate the authorisation is then handled by
the gitolite tool.

In my experience this is a setup simpler to handle then groups and users
directly on the server. It also allows to give a unique url for
accessing one repository. With multiple system users you would have one
url per user per repository which is not nice when sharing these and
breaks (or needs extra complexity) when using submodules.

Cheers Heiko

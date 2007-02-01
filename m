From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Thu, 1 Feb 2007 01:20:58 +0100
Message-ID: <200702010120.58806.Josef.Weidendorfer@gmx.de>
References: <87odognuhl.wl%cworth@cworth.org> <8aa486160701311127v686929c8vb9b5771031776ed8@mail.gmail.com> <871wlbascq.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Santi =?utf-8?q?B=C3=A9jar?=" <sbejar@gmail.com>,
	git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Thu Feb 01 01:21:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCPhl-0002Ej-Mk
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 01:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbXBAAVa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 19:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbXBAAVa
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 19:21:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:46769 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161111AbXBAAVa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 19:21:30 -0500
Received: (qmail invoked by alias); 01 Feb 2007 00:21:28 -0000
Received: from p5496A6CA.dip0.t-ipconnect.de (EHLO noname) [84.150.166.202]
  by mail.gmx.net (mp013) with SMTP; 01 Feb 2007 01:21:28 +0100
X-Authenticated: #352111
User-Agent: KMail/1.9.6
In-Reply-To: <871wlbascq.wl%cworth@cworth.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38314>

On Wednesday 31 January 2007, Carl Worth wrote:
> > It would be nice if:
> >
> > git clone -b ${branch} git://...

Nice indeed.

Additionally, it would be nice for clone to directly
checkout tags. Why not an option "--checkout <ref>"
to directly checkout <ref> after cloning?

This goes nicely with the "-b" option
to create a new branch. A "-b <branch>" option alone would
imply "--checkout origin/<branch>". And without "--checkout"
or "-b" option it defaults to "-b master" which gives
exactly the same behavior as now.

This way,

 git clone --checkout v1.0 git://...

would checkout tag v1.0, and use a detached head for it.

> In addition, it would be great to have a command that did the same
> setup within an existing repository.

Why not use "git clone" for this?
Currently, the man page says about the directory it will clone into:

 "Cloning into an existing directory is not allowed."

But we could relax this: if the specified directory is the root of
a checkout (ie. with a .git subdir), we would clone a remote repository
into the same local repository. However, this should not default
to "-b master", ie. not switch the current branch. Additionally, the
remote name should not default to "origin", but to the 
"humanish" part of the source repository. IMHO we should have done
the latter since long time ago, as a remote "origin" is not really
useful once you work with branches from multiple remote repositories.

Doing this,

 git clone git://... <newdir>

would be the equivalent of

 mkdir <newdir>
 cd <newdir>
 git init
 git clone -b master git://... .

which IMHO would make a lot of sense.
 
> And I would be most happy if the two commands for these two use cases
> shared as much syntax as possible, so I could publish one string and
> users could cut-and-paste it to either command as appropriate.

You would say:

"To get version <xyz>, do a

  git clone --checkout <xyz> git://...

If you already have a local clone of the repository, append the
directory of your local repository as target to clone this version
into".


> One string I would have liked would have been "git://... ${branch}"

IMHO "-b" option is better as it tells you that it creates a new
local development branch for you.

Josef

> but existing git-clone and git-fetch command syntax is not too
> amenable for that, (git-clone interprets an argument after the URL as
> the name of the local directory to create while git-fetch interprets
> the argument after the URL as a refspec).
> 
> -Carl
> 

From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Thu, 1 Feb 2007 10:02:44 +0100
Message-ID: <8aa486160702010102q3a49c4cfle44379a5f0b5422d@mail.gmail.com>
References: <87odognuhl.wl%cworth@cworth.org>
	 <8aa486160701311127v686929c8vb9b5771031776ed8@mail.gmail.com>
	 <871wlbascq.wl%cworth@cworth.org>
	 <200702010120.58806.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Carl Worth" <cworth@cworth.org>, git@vger.kernel.org
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 01 10:03:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCXqN-0007qu-OC
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 10:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030575AbXBAJCr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 04:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbXBAJCr
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 04:02:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:27382 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030520AbXBAJCp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 04:02:45 -0500
Received: by ug-out-1314.google.com with SMTP id 44so408924uga
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 01:02:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H6uBVXUdi2vi/3ZM40vstVcYSA9p56PT7ikktHPuUZQO8Kjv45aG51zQmc20Vyy0p2Amlpgt1woyK9AB+4mWSM5afkucKEaA4VdChBcZpykrrPmhTYcj6aicdERTCiw95Yqpi86l7V33mNLmfWgaTxZHpbsHqLCtvieSt2mfEHs=
Received: by 10.78.203.13 with SMTP id a13mr454622hug.1170320564189;
        Thu, 01 Feb 2007 01:02:44 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Thu, 1 Feb 2007 01:02:44 -0800 (PST)
In-Reply-To: <200702010120.58806.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38333>

On 2/1/07, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Wednesday 31 January 2007, Carl Worth wrote:
> > > It would be nice if:
> > >
> > > git clone -b ${branch} git://...
>
> Nice indeed.
>
> Additionally, it would be nice for clone to directly
> checkout tags. Why not an option "--checkout <ref>"
> to directly checkout <ref> after cloning?

Maybe, I'm not sure.

> > In addition, it would be great to have a command that did the same
> > setup within an existing repository.
>
> Why not use "git clone" for this?
> Currently, the man page says about the directory it will clone into:
>
>  "Cloning into an existing directory is not allowed."
>
> But we could relax this: if the specified directory is the root of
> a checkout (ie. with a .git subdir), we would clone a remote repository
> into the same local repository.

You can do it with git-remote. I think it is sensible to have a
command to get a new repository and a command to have a new remote.

For the "work on the non-HEAD branch" I think we could have:

# clone a remote repository and start working with branch ${branch}
$ git clone -b ${branch} ${url}

# add a new branch based on a remote branch,
# and configure to pull from there.
$ git branch ${branch} ${remote_branch}
$ git checkout -b ${branch} ${remote_branch}

as you see it is the current syntax, so I suggest to automatically
setup the branch.${branch}.{remote,merge} configs to follow the
${remote_branch} if this is sensible. So for example

$ git clone ${url_of_git.git}
$ cd git
$ git checkout -b maint origin/maint
$ git-config -l | grep ^branch.maint
branch.master.remote=origin
branch.master.merge=refs/heads/maint

( or branch.master.merge=refs/remotes/origin/maint )

This changes the current behaviour, but I think it make sense. If this
is not possible another way would be to have another option (-r for
remote, or -f for follow, or -p for pull, or -m for merge, ...) as:

$ git branch ${branch} -r ${remote_branch}
$ git checkout -b ${branch} -r ${remote_branch}

And if you want to add/change the remote/merge config for an existing
branch, in addition to doing this with git-config, git-remote could do
it as it currently shows the tracking branches.

Santi

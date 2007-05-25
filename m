From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 19:41:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705251924280.4648@racer.site>
References: <8c5c35580705250752k2021f02dv804d87da5c0d5da7@mail.gmail.com>
 <11801165433267-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 20:41:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrejc-0003Xv-51
	for gcvg-git@gmane.org; Fri, 25 May 2007 20:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763879AbXEYSlr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 14:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763881AbXEYSlq
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 14:41:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:35003 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763868AbXEYSlq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 14:41:46 -0400
Received: (qmail invoked by alias); 25 May 2007 18:41:44 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 25 May 2007 20:41:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lLrBI5/yl0nelceoc6DwvE7BJh8ldhzWvBbGY61
	GKjwp5gA01XUbY
X-X-Sender: gene099@racer.site
In-Reply-To: <11801165433267-git-send-email-hjemli@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48399>

Hi,

On Fri, 25 May 2007, Lars Hjemli wrote:

> Btw: testing this quickly becomes tedious, so I'll try to make a proper 
> testscript later tonight.

Very good.

> +'git-submodule' [--init | --update | --cached] [--quiet] [--] [<path>...]

I did not realize this earlier, but we seem to have more and more programs 
where actions are specified without "--", i.e. "git-svn fetch", or 
"git-bundle create".

I actually like that, to separate actions from options. Hmm?

> +-i, --init::
> +	Initialize the specified submodules, i.e. clone the git repository
> +	specified in .gitmodules and checkout the sha1 specified in the
> +	index.

How about "Initialize the submodules...", and then another sentence "If 
you do not want to initialize all submodules, you can specify the subset 
to initialize"?

> +-u, --update::
> +	Update the specified submodules, i.e. checkout the sha1 specified
> +	in the index

The full stop is missing here. And again, I would add another sentence 
"Submodules which have not been initialized are not touched by this 
operation."

> +FILES
> +-----
> +When cloning submodules, a .gitmodules file in the top-level directory
> +of the containing work-tree is examined for the url of each submodule.
> +The url is the value of the key module.$path.url.

IIRC Junio talked about a name for overriding. But I think it would be 
even better to to override by mapping the URLs from .gitmodules to the 
locally-wanted URLs.

Junio?

> +When updating submodules, the same .gitmodules file is examined for a key
> +named 'module.$path.branch'. If found, and if the named branch is currently 
> +at the same revision as the commit-id in the containing repositories index, 
> +the specified branch will be checked out in the submodule. If not found, or 
> +if the branch isn't currently positioned at the wanted revision, a checkout
> +of the wanted sha1 will happen in the submodule, leaving its HEAD detached.

A very good description, and I think this is the only method to checkout 
the submodule which makes sense. (Just maybe default the value of 
module.<path>.branch to "master"?)

> +++ b/git-submodule.sh
> @@ -0,0 +1,178 @@
> +#!/bin/sh
> +#
> +# git-submodules.sh: init, update or list git submodules
> +#
> +# Copyright (c) 2007 Lars Hjemli
> +
> +USAGE='[--init | --update | --cached] [--quiet] [--] [<path>...]'
> +. git-sh-setup
> +require_work_tree

Maybe

	test -f "$GIT_DIR"/.gitmodules || die "Not a superproject"

Hmm?

> +			rmdir "$path" 2>/dev/null ||

Just out of curiousity: is rmdir portable? I always used "rm -r"...

> +case "$init,$update,$cached" in
> +1,,)
> +	modules_init $@
> +	;;

:-)

Now I run out of comments...

Ciao,
Dscho

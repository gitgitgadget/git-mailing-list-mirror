From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] [PATCH] git-mirror - exactly mirror another repository
Date: Fri, 27 Apr 2007 09:58:26 +0100
Message-ID: <4631BB32.9080405@shadowen.org>
References: <20070427021505.1740.58136.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Apr 27 10:58:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhMHq-0007GE-8r
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 10:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501AbXD0I6Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 04:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755499AbXD0I6Y
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 04:58:24 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:2796 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501AbXD0I6X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 04:58:23 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1HhMIL-0006GY-Ie; Fri, 27 Apr 2007 09:59:13 +0100
User-Agent: Icedove 1.5.0.9 (X11/20061220)
In-Reply-To: <20070427021505.1740.58136.stgit@rover>
X-Enigmail-Version: 0.94.2.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45706>

Petr Baudis wrote:
> Sometimes its handy to be able to efficiently backup or mirror one
> Git repository to another Git repository by employing the native
> Git object transfer protocol.  But when mirroring or backing up a
> repository you really want:
> 
>   1) Every object in the source to go to the mirror.
>   2) Every ref in the source to go to the mirror.
>   3) Any ref removed from the source to be removed from the mirror.
> 
> and since git-fetch doesn't do 2 and 3, here's a tool that does.
> 
> This is based on Shawn Pearce's patch from 25 Sep 2006, updated to take
> Junio's and Sergey's review into account, to use few newer pieces of Git
> infrastructure and with few trivial tweaks. The repacking part was dropped
> since git-fetch does that on its own now.
> 
> I actually still would kind of prefer this to be a git-fetch's feature but
> the general mood seems to be to have this as a separate command and I can't
> say I care at all.
> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
> 
>  .gitignore                   |    1 
>  Documentation/config.txt     |    6 ++
>  Documentation/git-mirror.txt |   54 +++++++++++++++++++++
>  Makefile                     |    2 -
>  git-mirror.perl              |  110 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 172 insertions(+), 1 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 4dc0c39..d0b67da 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -80,6 +80,7 @@ git-merge-resolve
>  git-merge-stupid
>  git-merge-subtree
>  git-mergetool
> +git-mirror
>  git-mktag
>  git-mktree
>  git-name-rev
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e0aff53..e05e4c5 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -513,6 +513,12 @@ log.showroot::
>  	Tools like gitlink:git-log[1] or gitlink:git-whatchanged[1], which
>  	normally hide the root commit will now show it. True by default.
>  
> +mirror.allowed::
> +	If true, gitlink:git-mirror[1] will be allowed to run on the
> +	repository.  Please see its documentation for all the implications.
> +
> +mirror.
> +

Ok, I can see why you'd want to protect a user from going git-mirror
<foo> and losing their local changes.  But you've only protected them
from mirroring at all.  If they want to use this repo as a mirror of
somewhere X you have not stopped them from git-mirror Y'ing themselves.
 Now yes if you know its a mirror then I guess you can recover with a
git-mirror X but ...

It seems to me if you are having a config option that perhaps it should
be the URL from whence the mirror comes, and the command should just be
'git mirror'.

[mirror]
	url='somewhere'

-apw

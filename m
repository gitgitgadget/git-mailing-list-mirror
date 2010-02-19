From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH] Handle failure of core.worktree to identify the
	working directory.
Date: Fri, 19 Feb 2010 16:55:22 +0300
Organization: Marine Bridge & Navigation Systems
Message-ID: <20100219135522.GA27417@tugrik.mns.mnsspb.ru>
References: <20100217121304.GA1623@tugrik.mns.mnsspb.ru> <87iq9vgugf.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 14:58:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiTNJ-0002dl-28
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 14:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185Ab0BSN61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 08:58:27 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:39021 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867Ab0BSN60 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 08:58:26 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1NiTMV-0005pX-LT; Fri, 19 Feb 2010 16:57:56 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1NiTKE-0007aP-CW; Fri, 19 Feb 2010 16:55:22 +0300
Content-Disposition: inline
In-Reply-To: <87iq9vgugf.fsf@users.sourceforge.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140452>

On Thu, Feb 18, 2010 at 02:11:21AM +0000, Pat Thoyts wrote:
> Commit 21985a11 'git-gui: handle non-standard worktree locations' attempts
> to use either GIT_WORK_TREE or core.worktree to set the _gitworktree
> variable but these may not be set which leads to a failure to launch
> gitk to review history. Use _gitdir to set the location for a standard
> git layout where the parent of the .git directory is the working tree.
> 
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

Now it works, thanks.

Tested-by: Kirill Smelkov <kirr@mns.spb.ru>

> >Git-gui as shipped with todays git.git master is a bit broken:
> >
> >in git.git master (v1.7.0-29-g6d81630), try running:
> >
> >    $ git gui blame xdiff-interface.h
> >
> >Then select first line 'd9ea d9ea   1 #ifndef XDIFF_INTERFACE_H', right
> >click to popup context menu, select "Show History Context" -->
> >
> >--> git gui errors with:
> >
> >    "Error: couldn't change working directory to "": no ...
> >
> >
> >Thanks,
> >Kirill
> 
>  git-gui.sh |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 8996d2d..ec81b15 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1158,6 +1158,9 @@ apply_config
>  # try to set work tree from environment, falling back to core.worktree
>  if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
>  	set _gitworktree [get_config core.worktree]
> +	if {$_gitworktree eq ""} {
> +		set _gitworktree [file dirname [file normalize $_gitdir]]
> +	}
>  }
>  if {$_prefix ne {}} {
>  	if {$_gitworktree eq {}} {

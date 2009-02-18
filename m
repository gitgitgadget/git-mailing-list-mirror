From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/3] git-gui: use the actual worktree
Date: Wed, 18 Feb 2009 09:22:19 -0800
Message-ID: <20090218172219.GF22848@spearce.org>
References: <1234144850-2903-1-git-send-email-giuseppe.bilotta@gmail.com> <1234144850-2903-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 18:23:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZq9I-0004VX-1O
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 18:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbZBRRWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 12:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbZBRRWU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 12:22:20 -0500
Received: from george.spearce.org ([209.20.77.23]:58430 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbZBRRWU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 12:22:20 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 369B3381FF; Wed, 18 Feb 2009 17:22:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1234144850-2903-3-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110562>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
> Don't rely on the git worktree being the updir of the gitdir, since it
> might not be. Instead, define (and use) a new _gitworktree global
> variable, setting it to $GIT_WORK_TREE if present, or to whatever we
> guess the correct worktree is.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  git-gui/git-gui.sh |   25 +++++++++++++++++++------
>  1 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 658a728..94317c7 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -1062,13 +1063,19 @@ if {![file isdirectory $_gitdir]} {
>  	error_popup [strcat [mc "Git directory not found:"] "\n\n$_gitdir"]
>  	exit 1
>  }
> +set _gitworktree $env(GIT_WORK_TREE)

In TCL it is an error if an environment variable is undefined
when accessed.  You need to wrap this up in a catch block to handle
the error:

Error in startup script: can't read "env(GIT_WORK_TREE)": no such variable
    while executing
"set _gitworktree $env(GIT_WORK_TREE)"
    (file "./git-gui.sh" line 1066)

Also, what about honoring core.worktree as a setting, in
addition to $env(GIT_WORK_TREE) like the git wrapper does?

-- 
Shawn.

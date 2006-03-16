From: Qingning Huo <qhuo@mayhq.org>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Thu, 16 Mar 2006 20:33:19 +0000
Message-ID: <20060316203319.GA20159@localhost.localdomain>
References: <20060314211022.GA12498@localhost.localdomain> <Pine.LNX.4.64.0603141351470.3618@g5.osdl.org> <20060314224027.GB14733@localhost.localdomain> <Pine.LNX.4.64.0603141506130.3618@g5.osdl.org> <7vek13ieap.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603151450070.3618@g5.osdl.org> <7vlkvbffhz.fsf@assigned-by-dhcp.cox.net> <20060316075324.GA19650@pfit.vm.bytemark.co.uk> <7v64mebxsu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 21:33:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJz9o-00055t-PS
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 21:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbWCPUdN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 15:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbWCPUdN
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 15:33:13 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:58345 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932718AbWCPUdN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 15:33:13 -0500
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20060316203311.DVFS29343.mtaout01-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Thu, 16 Mar 2006 20:33:11 +0000
Received: from rabbit.zoo.mayhq.org ([80.0.127.16])
          by aamtaout04-winn.ispmail.ntl.com with SMTP
          id <20060316203311.KEJM18957.aamtaout04-winn.ispmail.ntl.com@rabbit.zoo.mayhq.org>
          for <git@vger.kernel.org>; Thu, 16 Mar 2006 20:33:11 +0000
Received: (qmail 20354 invoked by uid 1000); 16 Mar 2006 20:33:19 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64mebxsu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17647>

On Thu, Mar 16, 2006 at 12:26:09AM -0800, Junio C Hamano wrote:
> 
> We could probably define a shell function that looks like:
> 
>         git_exec () {
>                 cmd="$1"
>                 shift
>                 case "${GIT_EXEC_PATH+set}" in
>                 set) ;;
>                 *) GIT_EXEC_PATH='@@GIT_EXEC_PATH@@' ;;
>                 esac
>                 "$GIT_EXEC_PATH/git-$cmd" "$@"
>         }
> 
> in git-sh-setup [*1*], and then rewrite the above to something
> like this instead:
> 
>         diff --git a/git-commit.sh b/git-commit.sh
>         index 330a434..8a73420 100755
>         --- a/git-commit.sh
>         +++ b/git-commit.sh
>         ...
>         @@ -115,7 +115,7 @@ run_status () {
>                     echo '#
>          # Initial commit
>          #'
>         -	    git-ls-files |
>         +	    git_exec ls-files |
>                     sed -e '
>                             s/\\/\\\\/g
>                             s/ /\\ /g
>         @@ -126,7 +126,7 @@ run_status () {
>                     committable="$?"
>                 fi
> 
>         -	git-diff-files  --name-status |
>         +	git_exec diff-files  --name-status |
>                 sed -e '
>                         s/\\/\\\\/g
>                         s/ /\\ /g
>         ...
> 
> But that does not cover Perl nor Python scripts, and does not
> address the ugliness either.

This is similiar to what I had in mind when I recommended the full path
approach.  Perl or Python should be able to do the similiar.  I have no
comment on the ugliness.  The functionality and effeciency of the
program is more important to me.  But I do recognize the difficulties of
changing all scripts overnight.

Anyway, there are at least other two ways to solve my problem.  (a)
setup PATH in git-sh-setup, or (b) consistently use git-command form in
scripts.  Even before their implementation, I can still use "git push".  

Qingning

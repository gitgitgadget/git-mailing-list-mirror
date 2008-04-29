From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: [DOC] more explanation about --git-dir and --work-tree options
Date: Tue, 29 Apr 2008 17:49:44 +0200
Message-ID: <fv7g2s$g59$1@ger.gmane.org>
References: <48162EF0.6050705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 15:12:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrC5U-0004TC-0I
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 15:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758587AbYD3NKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 09:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758594AbYD3NKL
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 09:10:11 -0400
Received: from main.gmane.org ([80.91.229.2]:41876 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbYD3NKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 09:10:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JrC4Q-0008W8-EZ
	for git@vger.kernel.org; Wed, 30 Apr 2008 13:10:02 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 13:10:02 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 13:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <48162EF0.6050705@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80836>

Liu Yubao venit, vidit, dixit 28.04.2008 22:09:
> Hi,
> 
> I find these two options bring me surprise:
> 
>    git init $HOME
>    git add ~/.vimrc ~/.gvimrc ~/.vim
>    cd $HOME/work/xxx
>    ....do some work, then change ~/.vimrc without changing
>        working directory
>    git --git-dir $HOME/.git status
> 
> I use --git-dir because I have another .git in $HOME/work/xxx, the
> last command surprises me much, it tells me .vim* are all deleted!
> 
> After checking the code, I realize git thinks the current working
> directory as top directory of the working tree if --git-dir is specified
> without --work-tree option.

Yes, I found this surprising at first, too. And I noticed later on why 
things are the way they are, just as you did. :)

More doc on this is certainly helpful.

> And here is my supplement to the documentation.

> +	variable and the '--work-tree' command line option. It can be
> +	a absolute path or relative path to the directory specified by

"an absolute path or a relative...""

> +	--git-dir or GIT_DIR.
> +	Note: If --git-dir or GIT_DIR are specified but none of
> +	--work-tree, GIT_WORK_TREE and core.worktree is specified,

I would probably interchange "is" and "are" here.

Same changes in the following.

I often find myself wanting to operate on a repo without cd'ing to it. While

( cd repo && git command args)

is certainly an option I find the following shell functions helpful:

alias g=git
function gg ()
{
   local _gg="$1";
   shift;
   git --git-dir="${_gg}/.git" --work-tree="${_gg}" "$@"
}

That way,

gg repo command args

runs git in a different location while

g command args

works as usual (and is shorter).

Now I'm just waiting for the experts to tell me that cd'ing to repo is 
completely different from specifying --git-dir and --work-tree, and that 
either way is completely wrong. (I'm still stupid and ugly, but I want 
to become clever and smart.) ;)

Michael

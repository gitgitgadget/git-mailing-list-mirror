From: Junio C Hamano <junkio@cox.net>
Subject: Re: as promised, docs: git for the confused
Date: Fri, 09 Dec 2005 17:22:05 -0800
Message-ID: <7vk6edycea.fsf@assigned-by-dhcp.cox.net>
References: <7vbqzrcmgr.fsf@assigned-by-dhcp.cox.net>
	<20051209054401.4016.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 02:24:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EktT7-0000Gj-5M
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 02:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVLJBWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 20:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVLJBWK
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 20:22:10 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:57262 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932507AbVLJBWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2005 20:22:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051210012018.CAUU20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Dec 2005 20:20:18 -0500
To: linux@horizon.com
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13439>

linux@horizon.com writes:

> ....  There has
> been motion towards putting the git-* commands in their own directory,
> to be invoked by the /usr/bin/git wrapper.
>
> In this case, you'll have to leave out the initial hyphen, or add the
> git binary directory to your $PATH.

Misleading, if not incorrect.  git wrapper and a handful others
such as receive-pack and upload-pack that need to be directly
invoked via ssh will remain in /usr/bin and the users do not
need to worry about where the rest went.  The recommended way
would be to use non-dash form.  If you care about the extra
indirection done by "git" in your script, run "git --exec-path"
once to get the git binary directory and prepend the result to
PATH.  You _could_ do the latter for your interactive shell
session as well, but it is not actively recommended.

> * Resetting
>
> There are actually three kinds of git-reset:
> git-reset --soft: Only overwrite the reference.  If you need to, you
> 	can put everything back with a second git-reset --soft OLD_HEAD.

I am not sure what you mean by "second" here.  Did you mean to
say something like this?

    After you did "git-reset --soft somewhereyoudidnotmeantogo"
    by mistake, you can recover with "git-reset --soft ORIG_HEAD".

> There is an undelete: git-reset stores the previous HEAD commit in
> OLD_HEAD.

And probably you meant to say ORIG_HEAD (the latter part of the
documentation you do say ORIG_HEAD).

Now I finally had a chance to finish the command list part.

> git-prune.sh
>...
> 	eliminate the 

Incomplete sentence.

> git-pack-objects
> 	Given a list of objects on stdin, build a pack file.  This is
> 	a helper used by the various network communication scripts.

... and by (obviously) git-repack.

> + Accepting changes by e-mail
> git-apply
> 	Apply a (git-style extended) patch to the current index
> 	and working directory.

Actually it can take "patch -p1" format patch, and the input
does not have to be git-extended patch.  Two extra things you
can do when the input is git-extended patch is to apply
rename/copy and filemode changes.

>   git-merge-base
>...
> 	somewhat hairy.  The algorithm is not 100% final yet.

I do not think there is any remaining issues with the current
algorithm, so you can mark it final now.

>   git-mktag
> 	Creates a tag object.  Verifies syntactic correctness of its
> 	input.  (If you want to cheat, use git-hash-object.)

Is there a particular reason to encourage cheating?  IOW, is
mktag cumbersome to use, and if so how?

>   git-local-fetch
> 	Duplicates a git repository from the local system.
> 	(Er... is this used anywhere???)

Not by git barebone Porcelain, but other Porcelains can use it
if they want.  Same thing for git-ssh-fetch.

>   git-ssh-pull
> 	A helper program that pulls over ssh.

git-ssh-pull and git-ssh-fetch are the same program, and the
former is only for backward compatibility.  Earlier, only
git-ssh-pull/git-ssh-push pair existed and they continue to
invoke the other on the other end.  Terminology standardized to
call downloading phase "-fetch", and its counterpart "-upload";
so git-ssh-fetch invokes git-ssh-upload on the other end (so
ssh-pull/ssh-push can be viewed obsolete if you want).

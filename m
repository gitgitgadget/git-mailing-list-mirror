From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Write .editmsg in GIT_DIR to avoid being in git-status.
Date: Wed, 05 Oct 2005 14:54:58 -0700
Message-ID: <7vk6griq8d.fsf@assigned-by-dhcp.cox.net>
References: <87achnq4z7.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp-2
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 23:56:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENHEU-0006TQ-3T
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 23:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbVJEVzB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 17:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbVJEVzB
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 17:55:01 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:42637 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965137AbVJEVzA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 17:55:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051005215454.QBRJ4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Oct 2005 17:54:54 -0400
To: <sbejar@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9738>

Santi B.ANijar <sbejar@gmail.com> writes:

> It appears in the git-status output during a git-commit if you have
> something in info/exclude.

... which does not worry me too much; you'll get used to it ;-).

> Also for .cmitmsg and .cmitchk to make git-commit work
> in read-only working trees.

If a working tree is read-only, I wonder what you are committing.

It might not be a bad idea to think about this a bit more before
actually coding.  You are moving things out of the working tree
root level, which is a valid thing to do when worrying about a
repository (or working tree) that you do not have write access
to.  We've had a fix similar to this for temporary files used by
diff commands, which moved them to $TMPDIR or something like
that.  If the working tree root level is not writable for you,
is it valid/reasonable to assume that $GIT_DIR is?  Are there
better places?  E.g. perhaps $HOME/.gittmp/?

>  ret="$?"
> -rm -f .cmitmsg .editmsg .cmitchk
> +rm -f "$GIT_DIR"/{.cmitmsg,.editmsg,.cmitchk}

Please do not do "{a,b,c}".  I think ksh can grok the rest of
the git-commit.sh code, but not this.

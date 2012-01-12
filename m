From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: clone bug
Date: Thu, 12 Jan 2012 15:32:06 +0100
Message-ID: <87aa5tng9l.fsf@thomas.inf.ethz.ch>
References: <CAO1Zr+pSLwRbsEZ_0LCeE2qLn+S=iMKVcMjqtYrmiBoQmjac_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Alexey Kuznetsov <kuznetsov.alexey@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 15:32:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlLhQ-00078j-U0
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 15:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847Ab2ALOcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 09:32:11 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:20834 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab2ALOcL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 09:32:11 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 12 Jan
 2012 15:32:06 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 12 Jan
 2012 15:32:07 +0100
In-Reply-To: <CAO1Zr+pSLwRbsEZ_0LCeE2qLn+S=iMKVcMjqtYrmiBoQmjac_A@mail.gmail.com>
	(Alexey Kuznetsov's message of "Thu, 12 Jan 2012 16:43:50 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188446>

Alexey Kuznetsov <kuznetsov.alexey@gmail.com> writes:
>
> [branch "common"]
> 	remote = common
> 	merge = refs/heads/master
>
> ?? correct
>
> axet-laptop:123 axet$ git pull
> Already up-to-date.
> axet-laptop:123 axet$ git push
> To https://github.com/axet/common-bin.git
>  ! [rejected]        master -> master (non-fast-forward)
> error: failed to push some refs to 'https://github.com/axet/common-bin.git'
> To prevent you from losing history, non-fast-forward updates were rejected
> Merge the remote changes (e.g. 'git pull') before pushing again.  See the
> 'Note about fast-forwards' section of 'git push --help' for details.
> axet-laptop:123 axet$
>
>
> it tries to push local master to remote common/master which is not correct.

This is controlled by the 'push.default' variable, the docs for which
are as follows:

  push.default::
  	Defines the action git push should take if no refspec is given
  	on the command line, no refspec is configured in the remote, and
  	no refspec is implied by any of the options given on the command
  	line. Possible values are:
  +
  * `nothing` - do not push anything.
  * `matching` - push all matching branches.
    All branches having the same name in both ends are considered to be
    matching. This is the default.
  * `upstream` - push the current branch to its upstream branch.
  * `tracking` - deprecated synonym for `upstream`.
  * `current` - push the current branch to a branch of the same name.

The default of 'matching' pushes X to remotename/X, which is what you
are seeing.  You can either set it to 'upstream' or specify the
target explicitly, as in

  git push common common:master

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

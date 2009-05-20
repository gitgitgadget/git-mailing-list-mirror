From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: help reproduce fast-forward in rebase
Date: Wed, 20 May 2009 11:33:21 +0200
Message-ID: <20090520093321.GF6169@leksak.fem-net>
References: <fcaeb9bf0905200113s43eb5693l24a1f8848bafabd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 11:33:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6iB6-00053C-3C
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 11:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985AbZETJd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 05:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbZETJd1
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 05:33:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:39391 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752793AbZETJd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 05:33:27 -0400
Received: (qmail invoked by alias); 20 May 2009 09:33:27 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp019) with SMTP; 20 May 2009 11:33:27 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/jTs1fsrrj2oZ/ggqHHnkG4XG5HfwkaEc1Mh33Bd
	AXKI6tFcKd/CAJ
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1M6iAr-0008AD-KL; Wed, 20 May 2009 11:33:21 +0200
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0905200113s43eb5693l24a1f8848bafabd2@mail.gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119593>

Hi Nguyen,

Nguyen Thai Ngoc Duy wrote:
> Hi,
> 
> I'm rewriting rebase in C

Oh. First two remarks that may or may not affect you:

 1. rebase -i -p is reworked by Dscho:

    http://repo.or.cz/w/git/dscho.git?a=shortlog;h=refs/heads/rebase-i-p

 2. sequencer, a C backend for git am and git rebase -i, actually exists

    http://repo.or.cz/w/git/sbeyer.git?a=shortlog;h=refs/heads/seq-builtin-dev

    although to even more lack of time the missing/non-perfect parts are not
    getting fewer.


Both remarks regard "rebase -i" and not the am-based rebase, which means
you are not getting into some kind of conflict with these other developments
(or IOW: you are not doing already done work a second or third time) when you
keep your rebase rewrite close to the original in sh.

> and do not quite understand this code inside git-rebase.sh
> 
> # If the $onto is a proper descendant of the tip of the branch, then
> # we just fast forwarded.
> if test "$mb" = "$branch"
> then
> 	echo >&2 "Fast-forwarded $branch_name to $onto_name."
> 	move_to_original_branch
> 	exit 0
> fi
> 
> Anyone has an example how to make "git rebase" execute that code?

Yes, "if the $onto is a proper descendant of the tip of the branch",
then there are no commits that have to be rewritten. Rebasing can be
done by simple fast-forwarding, i.e. setting the branch to another,
yet existing commit.

Example:

   * onto                 * onto, mybranch
   |                      |
   *                      *
   |                      |
   * mybranch    =>       *
   |                      |
   *                      *
   |                      |


Regards,
  Stephan

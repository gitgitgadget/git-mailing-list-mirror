From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to resolve git-am conflict (possible bug)
Date: Sat, 12 Aug 2006 12:49:21 -0700
Message-ID: <7v7j1dpwe6.fsf@assigned-by-dhcp.cox.net>
References: <ebj7er$64j$1@sea.gmane.org>
	<7vslk2rbq8.fsf@assigned-by-dhcp.cox.net> <ebk5tf$31k$1@sea.gmane.org>
	<Pine.LNX.4.63.0608121146550.10541@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 12 21:49:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBzU6-000109-MR
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 21:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWHLTtY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Aug 2006 15:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWHLTtX
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 15:49:23 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:53227 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030271AbWHLTtX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Aug 2006 15:49:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060812194922.LFXZ23903.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 12 Aug 2006 15:49:22 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <Pine.LNX.4.63.0608121146550.10541@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 12 Aug 2006 11:52:54 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25263>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 12 Aug 2006, Jakub Narebski wrote:
>
>> Why do we not record commit id in patch?
>
> Because we do not have to.

More relevant point is that more often than not it does not
help.  The most common workflow that involves format-patch
output is to give your change to somebody else that does not
have (and does not merge with) your repository, and the commit
that is formatted is your own.  The other party does not have
the commit so telling its object name is useless.

Even if you recorded the commit object name of the pre-image
that would not help unless the patch happens to be the first
patch in a series forked from something the other party has.

>> And how git-rebase deals with this? 

It applies the format-patch output using "git-am -3".  In this
case, the preimage blobs recorded on "index" lines are
guaranteed to exist in the repository the "git-am" runs, because
the patches are coming from the same repository.  And the
patches are obviously not munged (we do not give you a chance to
muck with them between the time we generate and we apply) so
they are guaranteed to apply to the blobs recorded on "index"
lines.  Running the three-way fallback procedure on a change
already present on the new "onto" branch results in no change in
the index and that is how it notices the patch has already been
applied.

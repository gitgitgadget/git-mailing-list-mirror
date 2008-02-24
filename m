From: Paul Mackerras <paulus@samba.org>
Subject: Re: Rewriting boundary parents when path-limiting
Date: Sun, 24 Feb 2008 12:55:48 +1100
Message-ID: <18368.52900.408974.782802@cargo.ozlabs.ibm.com>
References: <18358.53933.747911.449078@cargo.ozlabs.ibm.com>
	<alpine.LFD.1.00.0802190921460.7833@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 02:57:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT66r-0004RJ-Vc
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 02:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754210AbYBXBz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 20:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbYBXBz5
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 20:55:57 -0500
Received: from ozlabs.org ([203.10.76.45]:58880 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbYBXBz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 20:55:57 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 95FCADDDEC; Sun, 24 Feb 2008 12:55:55 +1100 (EST)
In-Reply-To: <alpine.LFD.1.00.0802190921460.7833@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74898>

Linus Torvalds writes:

> Quite frankly, I suspect it's not worth it, and maybe you just shouldn't 
> do that optimization and limit the commits in other ways instead (ie you 
> might try to limit them *numerically* instead of by using negative 
> commits, and do one first run with the number of commits limited to <n>, 
> and then if that wasn't enough to re-connect the trees, you do the whole 
> thing)

OK.  I have fixed the problem in gitk by making it do:

    git rev-list --first-parent --max-count=1 $id -- paths...

for each id that it gets while updating that is a boundary commit, if
we are doing path limiting and the id is one that isn't in the graph.
If what we get back is a commit that is already in the graph, then we
use it instead.  That seems to do what I want.

Currently gitk executes that git rev-list synchronously, but if that
causes noticeable pauses, it could be done asynchronously instead.

Paul.

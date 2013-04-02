From: Neil Horman <nhorman@tuxdriver.com>
Subject: RFC: allowing multiple parallel sequencers
Date: Tue, 2 Apr 2013 13:46:40 -0400
Message-ID: <20130402174640.GA14473@neilslaptop.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 19:47:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN5Ik-0003oi-Ix
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758565Ab3DBRqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:46:50 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:45737 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758221Ab3DBRqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 13:46:49 -0400
Received: from nat-pool-3-rdu.redhat.com ([66.187.233.203] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1UN5IF-0003PV-50
	for git@vger.kernel.org; Tue, 02 Apr 2013 13:46:49 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219819>

Hey-
	I've recently started looking into the possibility of having git support
multiple in-progress sequencers, and wanted to solicit opinions for how best to
do it.  The use case is primarily for cherry-pick - i.e. I often have need to
cherry pick a large set of commits to an older kernel, and I may do this for
several work efforts in parallel.  As such, it would be great if I could be able
to have multiple sequencer states in progress that could be swapped out with one
another.  I know this could be done manually by saving the sequencer directory
to another name and moving it back, but it would be really nice if there was
something a bit more polished and integrated.  The thoughts I had were:

1) A per branch sequence directory - when creating the sequence directory,
prepend the name of the branch that you are on to the sequencer directory name,
and lookup the sequencer using that prefix.  This would fit quite well I think.
It would allow us to maintain a sequencer per branch, and would be relatively
easy to implement (we would need to have a generic function to return the
current branch name, and some extra check to delete sequencers when branches are
deleted, but nothing too difficult).  It would be problematic however, in that
working in detached head state would preclude the use of the mechanism (we could
work around that by using a global sequencer in detached head mode, or we could
add an option to specify a sequencer prefix).

2) Augment the git-stash command to save sequencer state optionally.  This would
be somewhat more difficult to implement I think (we would need to add
.git/sequencer/* to the untracked file list when creating the stash commit).  It
would however allow arbitrary sequencers to be used on arbitrary branches
(including detached head mode, if thats useful).

So, before I went implementing, I wanted to solicit opinions here.  Does anyone
have any thoughts (including completely different directions to move in for this
feature)?

Thanks!
Neil

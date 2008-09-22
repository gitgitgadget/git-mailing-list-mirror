From: Stephen Haberman <stephen@exigencecorp.com>
Subject: rebasing merges
Date: Mon, 22 Sep 2008 15:57:49 -0500
Organization: Exigence
Message-ID: <20080922155749.c8070681.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 22 23:31:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khszj-0006AG-IL
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 23:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbYIVV3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 17:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753081AbYIVV3t
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 17:29:49 -0400
Received: from smtp112.sat.emailsrvr.com ([66.216.121.112]:43081 "EHLO
	smtp112.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbYIVV3t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 17:29:49 -0400
X-Greylist: delayed 1911 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Sep 2008 17:29:48 EDT
Received: from relay1.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay1.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 4FBAB25082B
	for <git@vger.kernel.org>; Mon, 22 Sep 2008 16:57:55 -0400 (EDT)
Received: by relay1.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 209932504F1
	for <git@vger.kernel.org>; Mon, 22 Sep 2008 16:57:55 -0400 (EDT)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96513>

Hello,

I was wondering if there are any plans to enhance the rebase
functionality to match something like [1], specifically to handle
rebasing merge commits.

My understanding of the current rebase implementation is that it dumps
all the changes as a patch, moves HEAD, and applies the patch.

This works great for regular commits, but if one of the new commits was
a merge, rebase seems to "flatten" the merge. Because the patch dump
doesn't include any information about the merged commit's existing
hashes/parents, when the patch is applied, each merged commit gets
reapplied as a new commit, with a new hash, and no DAG link back to
where the original pre-rebase merge came from.

We've had this happen on topic branches when devs merged in a new
stable release that contains ~100 commits, but had their branch's
remote head move on them, so they pull --rebase as usual, but end up
with all ~100 commits from the release essentially cherry-picked into
their topic branch. So now we have the disclaimer of "usually pull
--rebase...unless you've done a merge, then do a pull --merge".

[1] seems to solve this with some fairly complex cherry-picking and
ancestry manipulation that, admittedly, I don't quite understand, but
it seems like it might be able to bring along a merge's multiple
parents information throughout the rebase and maintain the merge as a
single, non-flattened merge commit.

Thanks,
Stephen

1: http://www.selenic.com/mercurial/wiki/index.cgi/RebasePlan

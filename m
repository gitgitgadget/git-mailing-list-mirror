From: Marc Branchaud <marcnarc@xiplink.com>
Subject: hooks/post-receive-email bug?
Date: Wed, 17 Jun 2009 18:21:34 -0400
Message-ID: <4A396C6E.2050600@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 00:21:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH3Vu-0006Mo-3z
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 00:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbZFQWVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 18:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755426AbZFQWVk
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 18:21:40 -0400
Received: from smtp142.dfw.emailsrvr.com ([67.192.241.142]:38085 "EHLO
	smtp142.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbZFQWVk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 18:21:40 -0400
Received: from relay4.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay4.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id ED32910CBF56
	for <git@vger.kernel.org>; Wed, 17 Jun 2009 18:21:42 -0400 (EDT)
Received: by relay4.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 4766510CBF55;
	Wed, 17 Jun 2009 18:21:34 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121780>

Hi all,

We currently have two main development branches: master and release.  These branches exist on our shared git server.  I had to make a change in both branches, so I made a topic branch off of their merge-base and did the work:

  o--o--A--B--C		<-- origin/master
     |\
     | X--Y		<-- origin/release
      \
       1--2--3		<-- topic

I then merged topic into both master and release.  The merges were clean:

  o--o--A--B--C---D	<-- master
     |\           |
     | X--Y----Z /	<-- release
      \       / /
       1--2--3--	<-- topic

Then I did
	git push origin
to push matching refspecs to the origin repo.

port-receive-email sent two messages for that push, one for each branch.  Each message showed that commits 1, 2 and 3 were applied to the appropriate branch:

	The branch, release has been updated
	       via  hash for Z (commit)
	       via  hash for 3 (commit)
	       via  hash for 2 (commit)
	       via  hash for 1 (commit)
	      from  hash for Y (commit)

However, the details of the topic commits were missing from both messages.  Instead, both only contained the details of the merge commits D and Z.

I was expecting at least one of the messages to have the details of commits 1, 2 and 3.  Was I wrong to expect that?

Thanks,

		M.

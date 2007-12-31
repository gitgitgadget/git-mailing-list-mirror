From: Brian Swetland <swetland@google.com>
Subject: observing changes to a git repository
Date: Mon, 31 Dec 2007 14:28:20 -0800
Organization: Google, Inc.
Message-ID: <20071231222820.GA11278@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 31 23:30:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9T95-0007du-Np
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 23:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbXLaW3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 17:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbXLaW3j
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 17:29:39 -0500
Received: from smtp-out.google.com ([216.239.45.13]:18273 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbXLaW3j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 17:29:39 -0500
Received: from zps77.corp.google.com (zps77.corp.google.com [172.25.146.77])
	by smtp-out.google.com with ESMTP id lBVMTaaH023475
	for <git@vger.kernel.org>; Mon, 31 Dec 2007 14:29:36 -0800
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:subject:message-id:mime-version:
	content-type:content-disposition:organization:user-agent;
	b=L038gBaR1Bhl/SVxIN6h3Awdw/JnFr5iemLJtau8FuT9sbdNwcTRQ8n6FFUCTcB5O
	rDYdQQKm9aPCJPJSr9NXw==
Received: from bulgaria (bulgaria.corp.google.com [172.18.102.38])
	by zps77.corp.google.com with ESMTP id lBVMTaQ1026592
	for <git@vger.kernel.org>; Mon, 31 Dec 2007 14:29:36 -0800
Received: by bulgaria (Postfix, from userid 1000)
	id 087D5122F92; Mon, 31 Dec 2007 14:28:19 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69422>


Assuming I wanted to use a script (possibly run from cron) to observe
and report changes to a git repository (instead of running something
from the various hooks), does the following strategy seem workable:

- for each branch to observe, record the initial position of that 
  branch (sha1 commit id) -- call this Last

- periodically:
  - grab the current head (call this Current)
  - if it's the same as Last stop
  - do a git log Current ^Last to observe what has happened since
    we last noticed a change.  report on these commits.
  - Last = Current

If these branches can be updated such that history is rewritten (not
a concern in my particular case), I assume that for correctness you'd
have to make Last and Current actual branches (perhaps under
refs/heads/observer/... or whatever) to ensure that they don't get gc'd
out from under you.

Am I correct in believing that the above strategy will (if history
is not rewritten) correctly report all the commits between the last-
observed and current state of the branch?  Even if history *is*
rewritten, I think (assuming I ensure things aren't gc'd) I'd get
still get it right.

If I'm tracking several branches which can be merged between, I might
want to keep track of which commits I've sent reports about if I don't
want to re-report commits when they're merged into another branch.

Brian

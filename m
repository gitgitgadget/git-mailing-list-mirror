From: Charles Bailey <charles@hashpling.org>
Subject: Bug(let): status reports 'can fast-forward' when not true
Date: Tue, 21 Apr 2009 21:53:52 +0100
Message-ID: <20090421205352.GA29125@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 22:55:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwN0X-0000r8-Ej
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 22:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbZDUUx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 16:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbZDUUxz
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 16:53:55 -0400
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:10593 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752218AbZDUUxz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 16:53:55 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAIXP7UnUnw6R/2dsb2JhbADUYYN6Bg
Received: from ptb-relay01.plus.net ([212.159.14.145])
  by relay.ptn-ipout02.plus.net with ESMTP; 21 Apr 2009 21:53:53 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay01.plus.net with esmtp (Exim) id 1LwMyX-0000WU-2q
	for git@vger.kernel.org; Tue, 21 Apr 2009 21:53:53 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n3LKrqCx029700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 21 Apr 2009 21:53:52 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n3LKrqaA029699
	for git@vger.kernel.org; Tue, 21 Apr 2009 21:53:52 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 9e24f552a421deda8a5e5c71cf2440e7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117156>

I was not really thinking when I get fetched, and ran git status on my
pu branch. I was told that pu was behind origin/pu by 104 commits and
could be fast-forwarded, so I git merged origin/pu and was mildly
surprised when git merge made a commit for me.

A quick investigation revealed that pu had (of course) been rewound,
but the only commits that it had that the new pu didn't, were merge
commits.

I think that the problem is that in remote.c, a list of non-merge
commits is generated for the status report. If it's non-zero, then
it's the correct number of 'useful' commits to report, however if it
is zero then this is not sufficient for a merge to fast-forward. The
total number of commits unique to the local branch, including merges,
must also be zero.

Is this a bug?

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/

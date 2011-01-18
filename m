From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: gitk "find commit adding/removing string"/possible pickaxe bug?
Date: Tue, 18 Jan 2011 17:44:17 +0100
Message-ID: <201101181744.18139.trast@student.ethz.ch>
References: <514EB3AA-CD31-4BDB-B777-B7AAEEDF5663@sebastianhahn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Hahn <mail@sebastianhahn.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 18 17:45:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfEgA-0006gO-UL
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 17:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356Ab1ARQpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 11:45:04 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:12888 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab1ARQpD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 11:45:03 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 18 Jan
 2011 17:44:42 +0100
Received: from pctrast.inf.ethz.ch (129.132.211.99) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 18 Jan
 2011 17:45:00 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <514EB3AA-CD31-4BDB-B777-B7AAEEDF5663@sebastianhahn.net>
X-Originating-IP: [129.132.211.99]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165207>

Sebastian Hahn wrote:
> 
> I quite like gitk and am a fan of the ability to easily locate commits
> where a specific string was added/removed. If the string in question
> was added in a merge commit as part of a conflicted/otherwise
> changed merge, gitk doesn't display it.
[...]
> I presented the issue to #git, and it was suggested that it is probably
> a pickaxe bug

In particular, in a history where

  $ git show HEAD:foo
  quux
  $ git show HEAD^:foo
  bar
  $ git show HEAD^2:foo
  baz

the behaviour is:

  git log -Squux                  # empty
  git log -Squux -p               # empty
  git log -Squux --pickaxe-all    # empty

  git log -Squux -c      	  # shows merge, but no diff
  git log -Squux --cc    	  # shows merge, but no diff
  git log -Squux -c -p   	  # shows merge, but no diff
  git log -Squux -c --pickaxe-all # shows merge, but no diff

  git log -Squux --pickaxe-all -c -p  # shows merge & combined diff

So it only shows the diff with --pickaxe-all, even though the (only)
hunk clearly introduced the string.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

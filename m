From: Sergei Organov <osv@javad.com>
Subject: Strange git-show-branch behavior.
Date: Sat, 03 Nov 2007 20:46:39 +0300
Message-ID: <871wb79q80.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 18:47:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoN5R-0000R6-FD
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 18:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbXKCRqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 13:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbXKCRqt
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 13:46:49 -0400
Received: from javad.com ([216.122.176.236]:3491 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540AbXKCRqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 13:46:49 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lA3Hkjm73766
	for <git@vger.kernel.org>; Sat, 3 Nov 2007 17:46:48 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IoN4x-0007zW-NL
	for git@vger.kernel.org; Sat, 03 Nov 2007 20:46:39 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63294>

Hello,

I need to ask about git-show-branch once again as I really can't
understand its behavior myself. Could please anybody either confirm bug(s) in
git-show-branch, or explain why does it work this way.

Consider its invocation in a toy repository that has total 6 commits, as
can be seen from this output:

$ git branch
* master
  mybranch
$ git rev-list master mybranch --pretty=oneline
e9217caffebd6311073867d410f0c6e46910a13d Go to sleep
5f19837be87493e9b284fe7db03f00f23d006d2e Merged mybranch
2e2a4956db9737faf5f4f296b895500fafab7350 Some fun.
6478a15c48b0a7ce28069310ff5e51f95b250c7c Some work.
48d3660dc2005471c27f1d5b09d334885b612380 Commit message
2c14c05709bde3c1a7bbdd7effbf73a5667fa265 Initial commit
$

Or, using git-show-branch itself:

$ git-show-branch --more=9 master
[master] Go to sleep
[master^] Merged mybranch
[master^^2] Some work.
[master~2] Some fun.
[master~3] Commit message
[master~4] Initial commit
$

[NOTE: the format of this output contradicts the manual page, but it's
 not the topic of this post]

Now comes the confusion:

$ git-show-branch --more=9 master mybranch
* [master] Go to sleep
 ! [mybranch] Some work.
--
*  [master] Go to sleep
*+ [mybranch] Some work.
*  [master~2] Some fun.
*+ [master~3] Commit message
*+ [master~4] Initial commit
$

In this output, why git doesn't show the merge commit having "Merged
mybranch" commit message?

Yet another confusion: 

$ git-show-branch master mybranch
* [master] Go to sleep
 ! [mybranch] Some work.
--
*  [master] Go to sleep
*+ [mybranch] Some work.
$

Why does it stop at "Some work." commit? The manual page says: "Usually
the command stops output upon showing the commit that is the common
ancestor of all the branches.", so I'd expect it should go down to
"Commit message" commit that is the fork point.

$ git --version
git version 1.5.3.5.529.ge3d6d
$

[The version is from today's master, but I tried with git version 1.5.3.4
as well, and with the same result]

-- 
Sergei.

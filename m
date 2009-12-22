From: Andrew Myrick <amyrick@apple.com>
Subject: Regression: git-svn clone failure
Date: Tue, 22 Dec 2009 10:43:20 -0800
Message-ID: <8BD646EB-3F47-41F8-918C-19133CCCA89C@apple.com>
Mime-Version: 1.0 (Apple Message framework v1130)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Wong <normalperson@yhbt.net>, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 19:43:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN9hh-00074W-H1
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 19:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbZLVSnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 13:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbZLVSnX
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 13:43:23 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:57329 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbZLVSnX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 13:43:23 -0500
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out3.apple.com (Postfix) with ESMTP id 0B0487DD564D;
	Tue, 22 Dec 2009 10:43:21 -0800 (PST)
X-AuditID: 1180711d-b7b18ae000001001-94-4b311348646a
Received: from agility.apple.com (agility.apple.com [17.201.24.116])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay13.apple.com (Apple SCV relay) with SMTP id EC.F4.04097.843113B4; Tue, 22 Dec 2009 10:43:20 -0800 (PST)
X-Mailer: Apple Mail (2.1130)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135593>

[Resending because I forgot to make the message plain text]

I was testing the latest changes to git-svn pushed to Eric's repo (git://git.bogomips.org/git-svn) by cloning a few other projects that I work on, and one of those clones failed where it had succeeded with git 1.6.5.  The error message I received is:

W:svn cherry-pick ignored (/branches/BranchA:3933-3950) - missing 1 commit(s) (eg 3fc50d3a7e0f555547ab34bb570db47ce71e1abb)
W:svn cherry-pick ignored (/branches/BranchB:3951-3970) - missing 1 commit(s) (eg 3beb9f2fde0a91aa0e8097e05f9054b23b221daf)
W:svn cherry-pick ignored (/branches/BranchC:3971-3985) - missing 1 commit(s) (eg a7ae202254604f8a78cca391be36c58efc79eb20)
Found merge parent (svn:mergeinfo prop): 8b2cf9e9250b5ff1fe47c68215d0a178cfe35a3b
Found merge parent (svn:mergeinfo prop): 59f8c571ae77885469bb31f007b0048ee7812e07
fatal: ambiguous argument '0..1': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
rev-list -1 0..1: command returned error: 128

At this point, the clone got stuck in a loop and I had to kill it.

Note that all of the projects I cloned had "svn cherry-pick ignored" warnings sprinkled throughout the fetch logs; I'm not sure how much they matter.  It comes from find_extra_svn_parents(), which I would guess is a best-effort algorithm, and any failures to detect extra parents aren't anything to worry about.

Does anyone have suggestions on how I can debug this?  If you want to poke around, I can't provide access to the repository, but I can run commands and relay (sanitized) output if it will aid in debugging.

-Andrew
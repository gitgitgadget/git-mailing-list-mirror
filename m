From: Daniel Egger <daniel@eggers-club.de>
Subject: git worktree loses path information after git reset --hard
Date: Mon, 8 Feb 2016 09:07:10 +0100
Message-ID: <A1270C54-3868-42F4-8F7E-8F444631078F@eggers-club.de>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 09:07:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSgrR-0004pp-Qq
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 09:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542AbcBHIHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 03:07:15 -0500
Received: from mx2.eggers-club.de ([78.47.14.144]:52680 "EHLO
	mx2.eggers-club.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278AbcBHIHP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 03:07:15 -0500
Received: from mail.eggers-club.de (unknown [IPv6:2001:4dd0:ff75:1:219:d1ff:fe6a:8121])
	by mx2.eggers-club.de (Postfix) with ESMTPA id 66D0C3983BDE
	for <git@vger.kernel.org>; Mon,  8 Feb 2016 09:07:13 +0100 (CET)
Received: from [10.0.0.165] (unknown [88.217.248.30])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.eggers-club.de (Postfix) with ESMTPSA id 70960501BB
	for <git@vger.kernel.org>; Mon,  8 Feb 2016 09:07:17 +0100 (CET)
X-Mailer: Apple Mail (2.3112)
X-eggers-club-de-MailScanner-ID: 70960501BB.A3337
X-eggers-club-de-MailScanner: Found to be clean
X-eggers-club-de-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1, required 6, ALL_TRUSTED -1.00)
X-eggers-club-de-MailScanner-From: daniel@eggers-club.de
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285751>

Hi guys,

I stumbled across a problem with worktrees recently; I incorrectly opened a ticket a GitHub for that and it was suggested that it might be fixed in 2.7.1 so I held off reporting it here but as it turned out it is still broken in 2.7.1 so here we go.

The problem is that the paths of the worktrees in $GIT_DIR/worktrees/worktree_name/gitdir are rewritten to read .git instead of /path/to/worktree/root/.git after a git reset --hard (and potentially other operations) which causes all worktrees in git worktree list to point to the current worktree instead of the main repository path.

Let me demonstrate:

# git worktree list
/Users/user/Desktop/Source/Product          2991e32 [master]
/Users/user/Desktop/Source/Product-2.1      3fc1082 [releases/master-2.1]
/Users/user/Desktop/Source/Product-2.2      3ccc3fe [releases/master-2.2]
/Users/user/Desktop/Source/Product-2.3      4044881 [releases/master-2.3]
# cd /Users/user/Desktop/Source/Product-2.1
# git reset --hard
# cd /Users/user/Desktop/Source/Product-2.2
# git reset --hard
# cd /Users/user/Desktop/Source/Product
# git worktree list
/Users/user/Desktop/Source/Product          2991e32 [master]
/Users/user/Desktop/Source/Product          3fc1082 [releases/master-2.1]
/Users/user/Desktop/Source/Product          3ccc3fe [releases/master-2.2]
/Users/user/Desktop/Source/Product-2.3      4044881 [releases/master-2.3]

Servus,
      Daniel

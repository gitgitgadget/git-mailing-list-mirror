From: Andreas Schwab <schwab@linux-m68k.org>
Subject: git rev-list --all --reflog does not include worktree references
Date: Mon, 05 Oct 2015 21:08:19 +0200
Message-ID: <87io6l16cc.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 21:08:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjB7b-0006f3-T3
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 21:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbbJETIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 15:08:23 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:57042 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbbJETIW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 15:08:22 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3nVBKK1zRGz3hj2R
	for <git@vger.kernel.org>; Mon,  5 Oct 2015 21:08:21 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3nVBKK1d3lzvh2Z
	for <git@vger.kernel.org>; Mon,  5 Oct 2015 21:08:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id R9Q0qNZQXeQ1 for <git@vger.kernel.org>;
	Mon,  5 Oct 2015 21:08:20 +0200 (CEST)
X-Auth-Info: 6G8gHK2WDxBOg4qUGTXhuco2n8/NXGobbCeJmDBwbYQLEUnnsnhmqLYGMGE9wv4o
Received: from igel.home (host-188-174-206-190.customer.m-online.net [188.174.206.190])
	by mail.mnet-online.de (Postfix) with ESMTPA
	for <git@vger.kernel.org>; Mon,  5 Oct 2015 21:08:19 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id A51B72C415D; Mon,  5 Oct 2015 21:08:19 +0200 (CEST)
X-Yow: I have seen these EGG EXTENDERS in my Supermarket..
 ..  I have read the INSTRUCTIONS...
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279067>

When running git rev-list --all --reflog in the main worktree it doesn't
include commits only referenced by the worktrees, neither HEAD nor its
reflog.

$ git init test
$ cd test
# add some commits
$ touch 1; git add 1; git commit -m 1
$ touch 2; git add 2; git commit -m 2
# add new worktree
$ git worktree add ../test2 master^{}
$ cd ../test2
# add more commits
$ touch 3; git add 3; git commit -m 3
$ touch 4; git add 4; git commit -m 4
# create an unreferenced commit
$ git checkout @^
# both commands should give the same number of commits
$ git rev-list --reflog | wc -l
4
$ git -C ../test rev-list --all --reflog | wc -l
2

IIUC this will cause git gc to prune references from worktrees too
early.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

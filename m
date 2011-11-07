From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: reset reports file as modified when it's in fact deleted
Date: Mon, 7 Nov 2011 10:43:30 +0100
Message-ID: <20111107094330.GB10936@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 10:43:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNLk5-0002sz-An
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 10:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab1KGJnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 04:43:42 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:43731 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734Ab1KGJnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 04:43:41 -0500
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 0298446196
	for <git@vger.kernel.org>; Mon,  7 Nov 2011 10:43:05 +0100 (CET)
Received: (nullmailer pid 11670 invoked by uid 1000);
	Mon, 07 Nov 2011 09:43:30 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184965>

Hello,

When I delete a file (git rm) and then reset so it exists in the index
again, the message tells me 'M file.txt' even though the file doesn't
exist in the worktree anymore. Running git status afterwards does give
the correct output. So, here's the minimal steps to reproduce:

    $ git init
    Initialized empty Git repository in /home/carlos/test/reset-err/.git/
    $ touch file.txt
    $ git add file.txt
    $ git ci file.txt -m initial
    [master (root-commit) a536393] initial
     0 files changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 file.txt
    $ git rm file.txt
    rm 'file.txt'
    $ git reset -- file.txt
    Unstaged changes after reset:
    M		 file.txt
    $ git status -b -s
    ## master
     D file.txt

I'd expect the output after "Unstaged changes after reset" to tell me
file.txt has been deleted instead of modified. This happens with
1.7.8-rc0, 1.7.7 and 1.7.4.1 and I expect with many more that I don't
have here.

I thought the index diff code might have been checking the index at the
wrong time, but I can run 'git reset HEAD -- file.txt' as many times
as I want, and it will still say 'M', so now I'm not sure.

   cmn

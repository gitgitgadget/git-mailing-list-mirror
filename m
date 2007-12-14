From: David Miller <davem@davemloft.net>
Subject: Re: testsuite failures in mainline...
Date: Fri, 14 Dec 2007 11:17:36 -0800 (PST)
Message-ID: <20071214.111736.258936000.davem@davemloft.net>
References: <20071214.104312.103638776.davem@davemloft.net>
	<7vfxy5rsui.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 14 20:18:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3G32-0006Z6-0b
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 20:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbXLNTRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 14:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752307AbXLNTRo
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 14:17:44 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:34896
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751876AbXLNTRn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 14:17:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 14D5335C001;
	Fri, 14 Dec 2007 11:17:37 -0800 (PST)
In-Reply-To: <7vfxy5rsui.fsf@gitster.siamese.dyndns.org>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68329>

From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 14 Dec 2007 11:15:01 -0800

> When I can reproduce a breakage, in our tests, I'd run
> 
> 	cd t && sh -x t3200-branch.sh -i -v
> 
> (replace "t3200-*" with the failing test) and see which one of the steps
> chained with && is breaking first.

Looks like a malloc() failure:

+ test_expect_success 'test tracking setup via config' 'git config branch.autosetupmerge true &&
     git config remote.local.url . &&
     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
     (git show-ref -q refs/remotes/local/master || git-fetch local) &&
     git branch my3 local/master &&
     test $(git config branch.my3.remote) = local &&
     test $(git config branch.my3.merge) = refs/heads/master'
+ test 2 = 2
+ test_skip 'test tracking setup via config' 'git config branch.autosetupmerge true &&
     git config remote.local.url . &&
     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
     (git show-ref -q refs/remotes/local/master || git-fetch local) &&
     git branch my3 local/master &&
     test $(git config branch.my3.remote) = local &&
     test $(git config branch.my3.merge) = refs/heads/master'
++ expr ./t3200-branch.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t3200
++ expr 19 + 1
+ this_test=t3200.20
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success: git config branch.autosetupmerge true &&
     git config remote.local.url . &&
     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
     (git show-ref -q refs/remotes/local/master || git-fetch local) &&
     git branch my3 local/master &&
     test $(git config branch.my3.remote) = local &&
     test $(git config branch.my3.merge) = refs/heads/master'
+ say_color info 'expecting success: git config branch.autosetupmerge true &&
     git config remote.local.url . &&
     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
     (git show-ref -q refs/remotes/local/master || git-fetch local) &&
     git branch my3 local/master &&
     test $(git config branch.my3.remote) = local &&
     test $(git config branch.my3.merge) = refs/heads/master'
+ test -z info
+ shift
+ echo '* expecting success: git config branch.autosetupmerge true &&
     git config remote.local.url . &&
     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
     (git show-ref -q refs/remotes/local/master || git-fetch local) &&
     git branch my3 local/master &&
     test $(git config branch.my3.remote) = local &&
     test $(git config branch.my3.merge) = refs/heads/master'
* expecting success: git config branch.autosetupmerge true &&
     git config remote.local.url . &&
     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
     (git show-ref -q refs/remotes/local/master || git-fetch local) &&
     git branch my3 local/master &&
     test $(git config branch.my3.remote) = local &&
     test $(git config branch.my3.merge) = refs/heads/master
+ test_run_ 'git config branch.autosetupmerge true &&
     git config remote.local.url . &&
     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
     (git show-ref -q refs/remotes/local/master || git-fetch local) &&
     git branch my3 local/master &&
     test $(git config branch.my3.remote) = local &&
     test $(git config branch.my3.merge) = refs/heads/master'
+ eval 'git config branch.autosetupmerge true &&
     git config remote.local.url . &&
     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
     (git show-ref -q refs/remotes/local/master || git-fetch local) &&
     git branch my3 local/master &&
     test $(git config branch.my3.remote) = local &&
     test $(git config branch.my3.merge) = refs/heads/master'
++ git config branch.autosetupmerge true
++ git config remote.local.url .
++ git config remote.local.fetch 'refs/heads/*:refs/remotes/local/*'
++ git show-ref -q refs/remotes/local/master
++ git branch my3 local/master
fatal: Out of memory, malloc failed
+ eval_ret=128
+ return 0
+ '[' 0 = 0 -a 128 = 0 ']'
+ test_failure_ 'test tracking setup via config' 'git config branch.autosetupmerge true &&
     git config remote.local.url . &&
     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
     (git show-ref -q refs/remotes/local/master || git-fetch local) &&
     git branch my3 local/master &&
     test $(git config branch.my3.remote) = local &&
     test $(git config branch.my3.merge) = refs/heads/master'
++ expr 19 + 1
+ test_count=20
++ expr 0 + 1
+ test_failure=1
+ say_color error 'FAIL 20: test tracking setup via config'
+ test -z error
+ shift
+ echo '* FAIL 20: test tracking setup via config'
* FAIL 20: test tracking setup via config
+ shift
+ echo 'git config branch.autosetupmerge true &&
     git config remote.local.url . &&
     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
     (git show-ref -q refs/remotes/local/master || git-fetch local) &&
     git branch my3 local/master &&
     test $(git config branch.my3.remote) = local &&
     test $(git config branch.my3.merge) = refs/heads/master'
+ sed -e 's/^/	/'
	git config branch.autosetupmerge true &&
	     git config remote.local.url . &&
	     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
	     (git show-ref -q refs/remotes/local/master || git-fetch local) &&
	     git branch my3 local/master &&
	     test $(git config branch.my3.remote) = local &&
	     test $(git config branch.my3.merge) = refs/heads/master
+ test t = ''
+ trap - exit
+ exit 1

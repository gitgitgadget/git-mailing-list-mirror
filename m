From: Joey Hess <id@joeyh.name>
Subject: merge committing staged deletions?
Date: Mon, 13 Jun 2016 14:13:08 -0400
Message-ID: <20160613181308.GA31546@kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 20:13:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCWMX-0007sE-SV
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 20:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbcFMSNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 14:13:21 -0400
Received: from kitenet.net ([66.228.36.95]:58642 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655AbcFMSNU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 14:13:20 -0400
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=CRfvzzt5;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1465841588; bh=uiYoc6N+rmgbzDT4HzwNi42BL8iLIEFVDt2awBia2Sw=;
	h=Date:From:To:Subject:From;
	b=CRfvzzt53F0dDhndGif4qy0Ls2NavRHjBpa/gLj7ufQtW1/10p94Ood6/CnaeUosn
	 FaBWCwd30hQ7ZFfy2Kh7jrLax4DSYMpcVvv6SyWaA/vSO+PUTAA+8pLlnYCqivllvG
	 dD9ftrpbcpO5/qBDCPvrB62UfeEqTdVokt1WCYVA=
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Status: No, score=-93.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_RP_RNBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297237>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have a case where git merge seems to include staged deletions into the
merge commit. This seems pretty surprising, dunno if it's a bug.

joey@darkstar:~/tmp/x/1>git rm 1 foo
joey@darkstar:~/tmp/x/1>git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	deleted:    1
	deleted:    foo
joey@darkstar:~/tmp/x/1>git merge refs/heads/synced/master --no-ff
Already up-to-date!
Merge made by the 'recursive' strategy.
 1   | 1 -
 foo | 1 -
 2 files changed, 2 deletions(-)
 delete mode 100644 1
 delete mode 100644 foo

I thought that a merge would leave staged changes alone, unless
they conflict in some way with the changes merged in. 
So why is merge looking at the staged deletions in this case?

I'm using --no-ff because the commit being merged is itself a merge
of HEAD and another commit. HEAD and the commit being merged in fact
have the same tree, so the right merge solution, AFAICS, would be to
keep that tree.

I've attached a 1 kb git bundle that you can clone to reproduce this:

	git clone bundle b
	cd b
	git rm 1
	git merge remotes/origin/synced/master --no-ff

git version 2.8.1

-- 
see shy jo

--DocE+STaALJfprDB
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=bundle
Content-Transfer-Encoding: base64

IyB2MiBnaXQgYnVuZGxlCjk5ZWMwMTYyZmZjODkzZWFlYjJiNjU0NDZlZGFiMTY4NzQwNTE4
MmIgSEVBRAo5OWVjMDE2MmZmYzg5M2VhZWIyYjY1NDQ2ZWRhYjE2ODc0MDUxODJiIHJlZnMv
aGVhZHMvbWFzdGVyCjRkNDMzZGM1Mjk2YTkzODdkNjY1MzQ3Zjk1YWIxMTEyNTI0YjA0NWQg
cmVmcy9oZWFkcy9zeW5jZWQvbWFzdGVyCgpQQUNLAAAAAgAAAAiQFHiclY3LSgQxEEX3/RW1
m9U4eVZSIKKgMAh+RCVd/RjpRNJx4d/bKH6Am8uBey63NxEISDpm1OK0j9mOPgdyk2OFnJiD
WHHBoc7DBzcpHTwjGa8OUVB8ouhHS2hIj5YnQ6gCRuuS/fOJJCuNZppyJCssyST0zqGMnDTG
4JTX0aSBP/tSG7xW+YKr7Dvc3w5cHn/yrvAmD6Ad+mgjBQ1n5ZQact22tXf57254kzYLNNlq
l3NvnN/XMkNqXPICpybTfvkt90tt67yWy8b78XOCtfQK15en5+EbffBhSpUPeJyVi0sOwiAQ
QPecYi6ghTIMYIxxabzFFKdaTWlDMdGNZ/dzAzcvb/FeLSLgKZqQyAgaF5I9ueQj9siauGP2
YgU9kklq5iK5QvCp7cVpSzExEqbgqI+tjb10Xpg4ds61SIrv9TIVOE7yhIMsC2yvH73sf1xn
HmUHBskF6622sNKotUrTOA61yr+fOg91xTnLA4YM33R/4nJbKpfNq6nj3DxFZm6MegPgrkqo
6QGALXic+8p4gXFCN6PFxB5zXgsFXQMTAwMursSUFC4AbJ4HDZUMeJyVi0sOgjAQQPc9xVwA
KVCm1RjD0niLoR0ETQspYyIbz+7nBm5e3uI9ycxAQ29axGpwlvYenWt9r32DtfO65gGDbSwG
FxQ9ZJwzXGbe4MzrCsfbR8fux12iyCeoDLausbVBKLTRWvk5xkmE//3UdZKCUuInTAm+aRco
31ehfHiVEpdyY16orNQbVEQ9YqwDeJwzNDIAAgVDhlVuxTdFPR77h2yefUnw3gPOCsnKOYYQ
ybT8fIYqd8WjCfGaT1XNKwznNbdfWGb0aw0AgJQXKLILeJytzDsOwjAMANATBRv/mowMSN0r
wZzETlWGMrQDx+cSfQd4t3U7oe57/ODbPtHPA+gNL4VlfpDaMx2UkrBqFWv34izZOw2dOoqN
HMPYRTlHa4UNEQf3ElFUKk1i6J7t2uwPgH0wibQLeJytzDEOwjAMBdATBcdJ7DQjA1IXJiR2
O99CMBSkduD4XIJ3gHd6PA+ybYsvvf0V89jpeqflQ7f1XEQvaa85JZeJiRazYTiDVaPYIo4Y
vZTaameznCHgDFfnaLlHDFUIw+y/2w/HozPGrwF4nDM0MgAChbT8fIYqd8WjCfGaT1XNKwzn
NbdfWGb0aw0AmHAL99vrAe8K8LK4QZz/44VI9kGP/Tbg

--DocE+STaALJfprDB--

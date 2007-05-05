From: David Woodhouse <dwmw2@infradead.org>
Subject: 'upstream' branches.
Date: Sat, 05 May 2007 13:29:26 +0100
Message-ID: <1178368166.11851.60.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 17:44:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkMRA-000528-CH
	for gcvg-git@gmane.org; Sat, 05 May 2007 17:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423240AbXEEPoW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 11:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423283AbXEEPoV
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 11:44:21 -0400
Received: from canuck.infradead.org ([209.217.80.40]:36052 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423217AbXEEPoI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 11:44:08 -0400
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by canuck.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HkJOC-0001tf-86
	for git@vger.kernel.org; Sat, 05 May 2007 08:29:37 -0400
X-Mailer: Evolution 2.10.1 (2.10.1-4.fc7.dwmw2.2) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46257>

When creating a repository which may pull from one or more 'upstream'
repositories, it's useful to keep 'branches' which keep track of the
last pull from those upstream repositories -- either directly or
indirectly.

At http://www.linux-mtd.infradead.org/doc/git.html I've described the
setup I'm currently using to achieve this, which looks something like
the following:

[remote "origin"]
        url = ssh://git.infradead.org/~/public_git/foo-2.6.git
        fetch = +refs/heads/*:refs/remotes/origin/*
	fetch = +refs/heads/mtd:refs/heads/mtd
	fetch = +refs/heads/linus:refs/heads/linus
        push = refs/heads/master:refs/heads/master
        push = refs/heads/mtd:refs/heads/mtd
        push = refs/heads/linus:refs/heads/linus
[branch "master"]
        remote = origin
        merge = refs/heads/master
[remote "mtd"]
        url = git://git.infradead.org/mtd-2.6.git
        fetch = refs/heads/master:refs/heads/mtd
        fetch = +refs/heads/linus:refs/heads/linus
[remote "linus"]
        url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.$
        fetch = refs/heads/master:refs/heads/linus

Is there a better way to do this? Preferably which doesn't involve
directing the user to edit .git/config directly?

Basically, I want the local 'linus' branch to be updated whenever the
user pulls from _any_ other repository with a 'linus' branch, so that
the 'linus' branch always represents the latest commit pulled from
upstream. Likewise, the 'mtd' branch should be updated when pulling from
that tree (or any other dependent tree which will have an 'mtd' branch).

These branches should be pushed back to the origin each time.

What I have at the moment isn't ideal because I think pulling from the
'mtd' tree will fail if the 'linus' branch there is older than the local
clone's 'linus' branch. But it mostly works.

Is there a better way?

-- 
dwmw2

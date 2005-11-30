From: David Woodhouse <dwmw2@infradead.org>
Subject: GIT_OBJECT_DIRECTORY handling broken on master.kernel.org?
Date: Wed, 30 Nov 2005 13:59:33 +0000
Message-ID: <1133359173.4117.68.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 30 16:07:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhSVE-0003uC-Eq
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 15:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVK3N7p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 08:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVK3N7o
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 08:59:44 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:47253 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1751235AbVK3N7n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 08:59:43 -0500
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.54 #1 (Red Hat Linux))
	id 1EhSUf-0004bO-Ks
	for git@vger.kernel.org; Wed, 30 Nov 2005 13:59:33 +0000
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12999>

Daily kernel snapshots broke again. Trying to access, literally, "GIT_OBJECT_DIRECTORY".

hera /home/dwmw2 $ export GIT_DIR=/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
hera /home/dwmw2 $ git-rev-parse --revs-only 00d7a7358e3f9f2575501674e604fe4c6700b365
00d7a7358e3f9f2575501674e604fe4c6700b365
hera /home/dwmw2 $ export GIT_OBJECT_DIRECTORY=/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects
hera /home/dwmw2 $ git-rev-parse --revs-only 00d7a7358e3f9f2575501674e604fe4c6700b365
fatal: Not a git repository: '/pub/scm/linux/kernel/git/torvalds/linux-2.6.git'
hera /home/dwmw2 $ strace git-rev-parse --revs-only 00d7a7358e3f9f2575501674e604fe4c6700b365 2>&1 | tail
access("/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs", X_OK) = 0
lstat64("/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/HEAD", {st_mode=S_IFLNK|0777, st_size=17, ...}) = 0
readlink("/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/HEAD", "refs/heads/master", 255) = 17
access("GIT_OBJECT_DIRECTORY", X_OK)    = -1 ENOENT (No such file or directory)
write(2, "fatal: ", 7fatal: )                  = 7
write(2, "Not a git repository: \'/pub/scm/"..., 72Not a git repository: '/pub/scm/linux/kernel/git/torvalds/linux-2.6.git') = 72
write(2, "\n", 1
)                       = 1
exit_group(128)                         = ?
Process 30646 detached

-- 
dwmw2

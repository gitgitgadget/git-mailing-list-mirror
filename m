From: Jan Engelhardt <jengelh@medozas.de>
Subject: git-diff not coping with symlinks tonight
Date: Tue, 19 Aug 2008 23:54:42 -0400 (EDT)
Message-ID: <alpine.LNX.1.10.0808192351090.5691@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 05:55:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVena-00053Q-6d
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 05:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbYHTDyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 23:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753136AbYHTDyp
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 23:54:45 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:54351 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbYHTDyo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 23:54:44 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 0F51A180376E0; Wed, 20 Aug 2008 05:54:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 03DAF1D1C2717
	for <git@vger.kernel.org>; Tue, 19 Aug 2008 23:54:43 -0400 (EDT)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92960>

Hi,


Once upon a git-status, a file was deemed changed:

23:50 kaven:~/Coding/pam_mount > git st
# On branch ofl
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   src/ofl-lib-nlt.c
#
no changes added to commit (use "git add" and/or "git commit -a")

So why did the symlink change we might ask:

23:50 kaven:~/Coding/pam_mount > strace -fe readlink git diff
Process 13185 attached (waiting for parent)
Process 13185 resumed (parent 13184 ready)
[pid 13185] readlink("src/ofl-lib-nlt.c", "ofl-lib.c", 25) = 9
Process 13185 detached
--- SIGCHLD (Child exited) @ 0 (0) ---
error: readlink("src/ofl-lib-nlt.c"): No such file or directory
fatal: cannot hash src/ofl-lib-nlt.c

That's about it - /src/ofl-lib.c does exist, and hence the link is 
valid.

Observed on git 1.5.6.4.
Even a hard reset won't change anything.

23:52 kaven:~/Coding/pam_mount > git reset --hard
HEAD is now at 44a089b kill on logout support (unfinished)
23:53 kaven:~/Coding/pam_mount > git st
# On branch ofl
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   src/ofl-lib-nlt.c
#
no changes added to commit (use "git add" and/or "git commit -a")

Still modified. Any ideas?

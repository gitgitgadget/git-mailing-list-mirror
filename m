From: Simon Sasburg <simon.sasburg@gmail.com>
Subject: [RFC PATCH 0/3] Starting rebase from dirty tree
Date: Thu,  1 Nov 2007 22:30:21 +0100
Message-ID: <1193952624-608-1-git-send-email-Simon.Sasburg@gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 01 22:32:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inhec-0001fZ-Mz
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837AbXKAVc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753621AbXKAVc1
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:32:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:49629 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbXKAVc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:32:26 -0400
Received: by nf-out-0910.google.com with SMTP id g13so656760nfb
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 14:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=Gvba5c3j0AlJnOYkmy4q94jALc8kDGNYXx3XQ3osvVE=;
        b=Zm3x1i4BWygaFNGNJVf8E/XOtDxG5sLL663ktQCJ6gtD/mW/pyMuWex9mQ6E8yD1hl778FxWULjMC2dgAip44JRqNpIxzs3pBugVjewXEQbR3OyEHeZe0eIGIZuWseJJYLjy6TOo1boDE4KgxlhjUscRSlB0HLHWP3P4iemH+Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=WNgYB66t1JUC5lgFIOCCc4tBqdUpwQi1fsXaeMi/pSqz2xL1wKZ/xlAlJlaG1ve0zXegC+4StZhTKL3lVsuzvxIDgR1NF1FkS7VFTrXiiof4zrSSK6bRR+XCwFEN6CtX9Fy0T4I/riq1O+hE6CX7wv72e9BAeziGUUc/FdAbDVw=
Received: by 10.78.181.13 with SMTP id d13mr860523huf.1193952741672;
        Thu, 01 Nov 2007 14:32:21 -0700 (PDT)
Received: from localhost ( [86.85.232.104])
        by mx.google.com with ESMTPS id f3sm2302439nfh.2007.11.01.14.32.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 14:32:20 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.503.gbcee6f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63007>


These patches allow a --dirty option for git-rebase, git-rebase--interactive, and git-svn rebase.

When --dirty is given, starting from a dirty tree state will be allowed.
The difference between HEAD and the index and between the index and the working tree will be committed,
these commits will be undone when the rebase is completed.

For me the most often used use case is git-svn rebase one, which i use often.
This prevents me form having to commit+reset or stash+unstash everytime i want
to do this in a dirty tree.

I recently saw some discussion about a stash-based patch to do the same thing, and decided to share this.
These patches are a bit rough in some places, and mostly meant to see what others think if this way of doing this.

One advantage above using stash is that merge conflicts will be presented to the user in the same way as when doing a normal rebase.
Also having to explicitly ask for this behaviour with --dirty will hopefully give the user some clue that this isn't a standard operation.

But, in the rebase--interactive case, it allows the user to shoot himself in the foot by re-ordering the commits such that the temporary ones aren't at the end anymore.

Well, comments are welcome :-)

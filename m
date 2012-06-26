From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 0/5] rebase: calculate patches in upstream correctly
Date: Tue, 26 Jun 2012 07:51:53 -0700
Message-ID: <1340722318-24392-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 16:52:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjX7r-0005TR-8N
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 16:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757759Ab2FZOwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 10:52:15 -0400
Received: from mail-lb0-f202.google.com ([209.85.217.202]:52873 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755973Ab2FZOwO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 10:52:14 -0400
Received: by lbbgp10 with SMTP id gp10so12021lbb.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 07:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=/JuNRl6WpIJStUXXL9lwmURcr/Th5SfHe3nYSd5f9qM=;
        b=ChaH/ONq54iWvBsuk5SiFoH69sU1wT3C88Ql0WnfZr+O7aLbrqJNrS+28eFKKqFMsO
         22c/c87Q/Kqp6sh5wot3pFNl+OkQye0QPV4L88EelFSX7+aWy0MKuTSZ0hFofMIXhbzX
         lirFsyK98MLc3XvMpqRiKJB8rXhOorfU/bdpkSjBDIS8zw7kndPNhxoTCf2fHgbPku3s
         jgUP7Sg740wYCwDl7z1MsP7gF1ycOd919bGiFcFDjNj7fXlqbMcnEBbKxGTj+1YPlzpE
         rBmulPn+Izgm8Gtj6W1VuuUlcM8bvXMKT8cJBQW/QHaaNempSVi4arGYTuRJK+RpAe08
         rjbw==
Received: by 10.14.185.140 with SMTP id u12mr4904894eem.0.1340722333189;
        Tue, 26 Jun 2012 07:52:13 -0700 (PDT)
Received: by 10.14.185.140 with SMTP id u12mr4904889eem.0.1340722333103;
        Tue, 26 Jun 2012 07:52:13 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id b16si37898390eeg.3.2012.06.26.07.52.13
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 26 Jun 2012 07:52:13 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id E1BEF5C0050;
	Tue, 26 Jun 2012 07:52:12 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id DCFD4C19F8; Tue, 26 Jun 2012 07:52:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.3.327.g2980b
X-Gm-Message-State: ALoCoQkgqiDzbruKx1bKKBT/RWGo2bkRRVIJgoeG5g+KzO9iwPoCjw2YceNXReUFbb5rJXJsb3d45+C5elnq4t+/yObyU3g5sWLHom3a0dRxZXCQyUe6cVr5odZbxusPtiyyKoEc4A5gx1FJh3ndedZw0NAcUp/YTYf3+4NpXwl9dx3GrgpTTSdBRvQfNuHvbU3U+Kg2Qbxc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200644>

I worked on these patches last year but never sent them because I
wasn't sure how they impact performance. I was hoping that getting the
patch body from the commit and avoiding the call to mailinfo would
make am-based rebase a little faster, but if I remember correctly, it
got a little slower instead (not by much, though). I was also working
on a way to implement the 'git cherry' functionality in 'git
rev-list', but I wasn't sure how that would work and I ran out of
time. I hope at least some of these patches can still be useful.

Martin von Zweigbergk (5):
  rebase: don't source git-sh-setup twice
  rebase --root: print usage on too many args
  am --rebasing: get patch body from commit, not from mailbox
  am: don't call mailinfo if $rebasing
  rebase [-m]: calculate patches in upstream correctly

 git-am.sh                   |   48 ++++++++++++++++++++++---------------------
 git-rebase--am.sh           |    8 ++------
 git-rebase--interactive.sh  |    4 +---
 git-rebase--merge.sh        |    4 +---
 git-rebase.sh               |   13 ++++++------
 t/t3401-rebase-partial.sh   |   17 +++++++++++++++
 t/t3405-rebase-malformed.sh |   32 +++++++++++++++++++++++++----
 t/t3406-rebase-message.sh   |   14 ++++++-------
 t/t3412-rebase-root.sh      |    8 +++++++-
 9 files changed, 94 insertions(+), 54 deletions(-)

-- 
1.7.9.3.327.g2980b

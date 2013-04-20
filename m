From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 0/8] Improving the search for remote-tracking branches
Date: Sat, 20 Apr 2013 17:05:55 +0200
Message-ID: <1366470363-22309-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 20 17:06:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTZMu-0008Pa-Ub
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 17:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340Ab3DTPGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 11:06:19 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:55859 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab3DTPGS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 11:06:18 -0400
Received: by mail-la0-f48.google.com with SMTP id eo20so485658lab.7
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 08:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=6pho/SqRGNvqXBmzEcCZ0TAzD8EweGlv/5NjrKP5tz0=;
        b=b4uquSbOI1BubS/hXI+uQQQwS/EJ6IFbsMH8PJGCi4/DFMk7R6v1NZHEDkMEzVPegs
         rPFx51Yg3PrdnnUUhJBh2gl4VVNLNwjv8yka1LFR1sQcyGvb3nRRetWi0KKl36CJG66x
         hm7uY0T4o+QQVjWAnexD/NHdbG5tfxcTWjj/plWFlAsbPSprK4Vo6igbSPyTSjdCruyg
         iUVNawHd/ohBOW8tseZO38gApiYeeI03oVWoirFzIoVDdO/otIWQRiRqMgZgnbH2uY7a
         mYBQ3P1NxZB7l6pjHuDDiAqwNaGhCKDs7RKjgfPtheI17Om4IP1jnGcP9wDzJd+HGLlj
         06bQ==
X-Received: by 10.112.19.7 with SMTP id a7mr10134250lbe.0.1366470376915;
        Sat, 20 Apr 2013 08:06:16 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id sl5sm7539983lbb.10.2013.04.20.08.06.14
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 08:06:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221860>

Hi,

This is second iteration of this series. The initial three patches are
unchanged, although the commit message of #3 has been rephrased based
on Junio's comments.

Patches #4-#6 fixes existing tests in preparation for patch #7, which
changes the validation of the remote-tracking branch passed to --track:
We now require the --track argument to refer to a ref that matches a
configured refspec - otherwise, we can not reliably deduce the upstream
information to store into branch.<name>.remote and branch.<name>.merge.

Finally, patch #8 updates the paragraph on remote-tracking branches in
the glossary to be somewhat closer to the current state of things.


Have fun! :)

...Johan


Johan Herland (8):
  t2024: Add tests verifying current DWIM behavior of 'git checkout <branch>'
  t2024: Show failure to use refspec when DWIMming remote branch names
  checkout: Use remote refspecs when DWIMming tracking branches
  t3200.39: tracking setup should fail if there is no matching refspec.
  t7201.24: Add refspec to keep --track working
  t9114.2: Don't use --track option against "svn-remote"-tracking branches
  branch.c: Validate tracking branches with refspecs instead of refs/remotes/*
  glossary: Update and rephrase the definition of a remote-tracking branch

 Documentation/git-checkout.txt     |   6 +-
 Documentation/glossary-content.txt |  13 +++--
 branch.c                           |  17 +++++-
 builtin/checkout.c                 |  42 +++++++-------
 t/t2024-checkout-dwim.sh           | 116 +++++++++++++++++++++++++++++++++++++
 t/t3200-branch.sh                  |   8 +--
 t/t7201-co.sh                      |   1 +
 t/t9114-git-svn-dcommit-merge.sh   |   2 +-
 8 files changed, 170 insertions(+), 35 deletions(-)
 create mode 100755 t/t2024-checkout-dwim.sh

-- 
1.8.1.3.704.g33f7d4f

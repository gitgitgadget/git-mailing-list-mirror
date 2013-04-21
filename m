From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 0/8] Improving the search for remote-tracking branches
Date: Sun, 21 Apr 2013 23:51:58 +0200
Message-ID: <1366581126-3880-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 21 23:52:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU2BM-0008SQ-91
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 23:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410Ab3DUVwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 17:52:20 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:48826 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab3DUVwT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 17:52:19 -0400
Received: by mail-la0-f44.google.com with SMTP id ed20so1914473lab.3
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 14:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=8kRinWIrAqgVHvPYGwX3wJMkYBsT1LVgIRsCVA/9RKE=;
        b=ckcLmH4UYhcIyL7VTuHjj34GOBahmI8yrb3voLZo/uotMftr1ceuR/U8GZ/jOW7N7I
         u1EjAiInEFoEMcQtcrf/+y9hgGRMlVB2KqTj7G79ELGy+nFG5V61RGWKUrAv+2t2Un1U
         YLAXf6TxkOUB8F73Q0Asyr9KGELbSlSfq8h2bUwoUUHWfMmPwgUQNV81b34tsmj0O4/6
         YJBa7eqe0XAgjFKjHV4kfcITijuMmis3qcCYrigkPPxo+qILo5H1afYh9uuQ+UKpzB9t
         q6U+ZYz7e965Fjd/7Bqdowwiu2ORBtWMUbOuAx7BwDS9PWwqVKGfvc8FdE6QDnjdiE3s
         r9yw==
X-Received: by 10.112.73.70 with SMTP id j6mr3802812lbv.39.1366581137306;
        Sun, 21 Apr 2013 14:52:17 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id ak4sm9489460lbc.12.2013.04.21.14.52.14
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 14:52:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221969>

Hi,

This is third iteration of this series. The only difference from v2 is
improved test code (in patches #1 and #2) thanks to Jonathan Nieder,
and Eric Wong's ACK to patch #6.

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
 Documentation/glossary-content.txt |  13 +--
 branch.c                           |  17 +++-
 builtin/checkout.c                 |  42 +++++-----
 t/t2024-checkout-dwim.sh           | 167 +++++++++++++++++++++++++++++++++++++
 t/t3200-branch.sh                  |   8 +-
 t/t7201-co.sh                      |   1 +
 t/t9114-git-svn-dcommit-merge.sh   |   2 +-
 8 files changed, 221 insertions(+), 35 deletions(-)
 create mode 100755 t/t2024-checkout-dwim.sh

-- 
1.8.1.3.704.g33f7d4f

>From fcab754f6702ea2724258dacd40803943db1e172 Mon Sep 17 00:00:00 2001
From: Johan Herland <johan@herland.net>
Date: Sat, 20 Apr 2013 14:28:51 +0200
Subject: [PATCHv2 0/8] Improving the search for remote-tracking branches

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

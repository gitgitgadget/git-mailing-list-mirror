From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 00/14] fast-export and remote-testgit improvements
Date: Fri,  2 Nov 2012 03:02:04 +0100
Message-ID: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 03:02:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU6av-0000Oj-4Q
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 03:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762593Ab2KBCCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 22:02:31 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43159 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758264Ab2KBCCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 22:02:30 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1234245bkc.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 19:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=wTgyEuB98VoZ6CBjD8JAtShI/iV+iM4TDOyXIUB7lvw=;
        b=oGEyq6cUgkifKEQwkshqro5mEO+seHCEw6nxBIvY2XD0nEi8BTF8EPoWOjVCPcYgb8
         gwyzUhV79Q9vlB2JDJFoyQuNAVox1MyLPga8HIvxYrtsXt8UNP8tmlFVpuMIZNy232TJ
         A1E3kNFzHKIo9PVYSikP9cGeiS/R57N64+W2/VifWbcmoV6jOqw/mHmxKF3OqkuaHbjA
         QEJ1l8Fsni/nRmRM1NzqSAM6D+IZ4aNMq4kXD3lgDoH52EETrVroVXeQNGrSEvxDpojg
         BX7CrLhdu5OQ9OFYD9JIVryyDMQGUZr56lTnaoeXxUP8RQoxDSkNfeg5HLzjbD+ASWJQ
         0w2A==
Received: by 10.204.12.195 with SMTP id y3mr26673bky.7.1351821748510;
        Thu, 01 Nov 2012 19:02:28 -0700 (PDT)
Received: from localhost (ip-109-43-0-51.web.vodafone.de. [109.43.0.51])
        by mx.google.com with ESMTPS id e13sm5773826bkw.12.2012.11.01.19.02.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 19:02:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208896>

Hi,

I found more issues in fast-export. remote-testgit, and eventually I decided
there's no reason to use this python script, so I wrote a much simpler version
that does the same, and more. I'm not going to list all the reasons because
apparently opinions are not welcome in the list any more. For the actual
differences you can check the patch itself.

The old remote-testgit is now remote-testpy (as it's testing the python
framework, not really remote helpers). The tests are simplified, and exercise
more features of transport-helper, and unsuprisingly, find more bugs.

Some of these bugs are fixed in this patch series as well, for which I already
sent 3 versions, and they come at the end. I was surprised they did fix them,
but hey... good is good.

I know how to fix the rest of the issues, but I'm not going to bother sending a
patch because obvious... er, simple? fixes are not accepted, so there's no
chance of something less... evident? getting through.

Cheers.

Felipe Contreras (14):
  fast-export: avoid importing blob marks
  remote-testgit: fix direction of marks
  Rename git-remote-testgit to git-remote-testpy
  Add new simplified git-remote-testgit
  remote-testgit: get rid of non-local functionality
  remote-testgit: remove irrelevant test
  remote-testgit: cleanup tests
  remote-testgit: exercise more features
  remote-testgit: report success after an import
  remote-testgit: make clear the 'done' feature
  fast-export: trivial cleanup
  fast-export: fix comparison in tests
  fast-export: make sure updated refs get updated
  fast-export: don't handle uninteresting refs

 .gitignore                           |   2 +-
 Documentation/git-remote-testgit.txt |   2 +-
 Makefile                             |   2 +-
 builtin/fast-export.c                |  20 ++-
 git-remote-testgit                   |  82 +++++++++++
 git-remote-testgit.py                | 272 -----------------------------------
 git-remote-testpy.py                 | 272 +++++++++++++++++++++++++++++++++++
 git_remote_helpers/git/importer.py   |   2 +-
 t/t5800-remote-helpers.sh            | 148 -------------------
 t/t5800-remote-testpy.sh             | 148 +++++++++++++++++++
 t/t5801-remote-helpers.sh            | 153 ++++++++++++++++++++
 t/t9350-fast-export.sh               |  41 +++++-
 12 files changed, 712 insertions(+), 432 deletions(-)
 create mode 100755 git-remote-testgit
 delete mode 100644 git-remote-testgit.py
 create mode 100644 git-remote-testpy.py
 delete mode 100755 t/t5800-remote-helpers.sh
 create mode 100755 t/t5800-remote-testpy.sh
 create mode 100644 t/t5801-remote-helpers.sh

-- 
1.8.0

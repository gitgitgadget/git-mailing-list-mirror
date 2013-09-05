From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v4 0/5] Disable "git status" comment prefix
Date: Thu,  5 Sep 2013 11:50:13 +0200
Message-ID: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 05 11:50:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHWDA-0006iO-Su
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 11:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192Ab3IEJum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 05:50:42 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35592 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965115Ab3IEJul (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 05:50:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r859oJ94006905
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Sep 2013 11:50:19 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VHWCi-0006Vs-7E; Thu, 05 Sep 2013 11:50:20 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VHWCh-0008CA-RF; Thu, 05 Sep 2013 11:50:19 +0200
X-Mailer: git-send-email 1.8.4.4.g70bf5e8.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Sep 2013 11:50:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r859oJ94006905
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378979422.44395@7FrjewZ4S8xcyhwWCq6Xqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233948>

Compared to v2, this changes essentially:

* The prefix is actually disabled by default in this version. As a
  consequence, the option is renamed to status.oldStyle.

* Since this is the default, the tests are updated to test the new
  defaults. In a first patch, I'm setting status.oldStyle=true in test
  files that require it (to keep the patch short), and the last patch
  actually updates the test expected results. This was actually useful
  as I did find (and fix) a few bugs updating the tests:

  - the --columns option was still showing the comment prefix

  - "git commit --dry-run" and failed "git commit" were still
    displaying comments to stdout.

* The --for-status option is kept as a no-op.

Matthieu Moy (5):
  builtin/stripspace.c: fix broken indentation
  wt-status: use argv_array API
  submodule summary: ignore --for-status option
  status: disable display of '#' comment prefix by default
  tests: don't set status.oldStyle file-wide

 Documentation/config.txt           |   7 +
 builtin/commit.c                   |  10 +
 builtin/stripspace.c               |   8 +-
 git-submodule.sh                   |  13 +-
 t/t3001-ls-files-others-exclude.sh |   2 +-
 t/t7060-wtstatus.sh                | 109 +++--
 t/t7401-submodule-summary.sh       |  12 +-
 t/t7508-status.sh                  | 944 +++++++++++++++++++------------------
 wt-status.c                        |  85 +++-
 wt-status.h                        |   1 +
 10 files changed, 640 insertions(+), 551 deletions(-)

-- 
1.8.4.4.g70bf5e8.dirty

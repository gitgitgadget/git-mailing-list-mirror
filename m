From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 00/23] Enable options --signoff, --reset-author for pick, reword
Date: Thu,  7 Aug 2014 01:59:07 +0200
Message-ID: <cover.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 01:59:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB7b-0002aZ-JG
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 01:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963AbaHFX7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 19:59:48 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:46181 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbaHFX7r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 19:59:47 -0400
Received: by mail-qa0-f50.google.com with SMTP id s7so3241011qap.37
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 16:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tRnMLB4JUIArIMBGAesdO0SPuLGXmW3/8Xbu5fYmM20=;
        b=CffnWH6wz5FU9xZILHfnYOx+9xZvpyfswocBwXnKL5/oOtQ6KbYM8cyRBJuhZ3t3/y
         0ONE9EqMH9Tru0DAwsoicryNDlOQpumKak5JAzZ1apiRM82AkdpqFcftkbXUXzYzMdYd
         b7UE3qgEeABrSVKRt0hO/WBlMx9rPULhCiTkBdmzXKL86Afz9qQOolrKzFHtGFQEP/G2
         LgDlDy2OjIC2DQBXcHCJMsRvq/W3LU47+EkKpI+Pfk0rPoTDkUcI24GJAB/fTAlEboP+
         pTNUJObHsh9c70utME9uyRQMQcC7Qkvcm2l+B44Nc2EuuBheBtklueGGO3xmFsE3q//I
         XPdg==
X-Received: by 10.140.96.85 with SMTP id j79mr20194931qge.5.1407369586949;
        Wed, 06 Aug 2014 16:59:46 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.16.59.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 16:59:46 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <53A258D2.7080806@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254917>

Hi List,

this is the second reroll of the patch series fixing corner-case bugs
regarding empty commits, commits with no log message and root
commits, providing a uniform implementation of the to-do list
commands using the `do_pick` interface.

This reroll includes the following list of changes to PATCH v1 from
last week, mostly induced by Jeff's comments. However, I didn't get
around the most recent discussion from tonight yet.

 - new tests: allow replaying commits with empty log messages
     - coverage of all to-do list commands
 - new patch: allow squashing empty commits without complaints
     - do not complain about an empty squash commit unless it is the
       final one and --keep-empty is not specified on the command line
 - new tests: allow rewording empty commits without complaints
     - coverage of all to-do list commands
 - new patch: hide interactive command messages in verbose mode
     - make it possible to launch an editor inside 'output'
 - new patch: allow disabling pre-commit and commit-msg separately
     - add options --no-pre-commit and --no-commit-msg to git-commit
     - redefine --no-verify as synonym for the above two
 - new patch: squash skips commit-msg hook
     - run commit-msg hook for reworded _and_ squashed commits
 - a change to 'test_commit' options and 'fake_editor' debug output

Thanks for your time and reviews,
   Fabian

Fabian Ruch (23):
  rebase -i: allow replaying commits with empty log messages
  rebase -i: allow squashing empty commits without complaints
  rebase -i: allow rewording empty commits without complaints
  rebase -i: hide interactive command messages in verbose mode
  rebase -i: failed reword prints redundant error message
  commit: allow disabling pre-commit and commit-msg separately
  rebase -i: squash skips commit-msg hook
  rebase -i: reword executes pre-commit hook on interim commit
  rebase -i: teach do_pick the option --edit
  rebase -i: implement reword in terms of do_pick
  rebase -i: log the replay of root commits
  rebase -i: root commits are replayed with an unnecessary option
  rebase -i: commit only once when rewriting picks
  rebase -i: do not die in do_pick
  rebase -i: teach do_pick the option --amend
  rebase -i: teach do_pick the option --file
  rebase -i: prepare for squash in terms of do_pick --amend
  rebase -i: implement squash in terms of do_pick
  rebase -i: explicitly distinguish replay commands and exec tasks
  rebase -i: parse to-do list command line options
  rebase -i: teach do_pick the option --reset-author
  rebase -i: teach do_pick the option --signoff
  rebase -i: enable options --signoff, --reset-author for pick, reword

 Documentation/git-commit.txt  |   8 +-
 builtin/commit.c              |  32 ++++-
 git-rebase--interactive.sh    | 288 ++++++++++++++++++++++++++++++++++--------
 git-rebase.sh                 |  12 +-
 t/lib-rebase.sh               |   8 +-
 t/t3404-rebase-interactive.sh | 234 ++++++++++++++++++++++++++++++++--
 t/t3406-rebase-message.sh     |  18 +++
 t/t3412-rebase-root.sh        |  16 +++
 t/t7503-pre-commit-hook.sh    |  65 ++++++++--
 t/t7504-commit-msg-hook.sh    |  85 ++++++++++---
 t/test-lib-functions.sh       |  23 +++-
 11 files changed, 680 insertions(+), 109 deletions(-)

-- 
2.0.1

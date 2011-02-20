From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v4 0/4] CHERRY_PICK_HEAD
Date: Sat, 19 Feb 2011 23:12:25 -0500
Message-ID: <1298175149-41178-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 20 05:13:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr0fP-0002X4-67
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 05:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab1BTEM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 23:12:57 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53232 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab1BTEM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 23:12:56 -0500
Received: by qwd7 with SMTP id 7so1290012qwd.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 20:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=vtW/0H3/LA1qlpGms/r67Zw0+r8dq8hpJserpew6p7s=;
        b=LDruGnGxK2jVM+xK4t1np1gXOs52WYVMNcEyg4fuZKh1RC7y2ISvr1Knez8ozw+/oC
         TxFzzQ3Ixk3cfYsGdH7mu33N1TuiBv0gg8NaLDxU4cAf06wDEwNvufdYgZQ9IqefPU7r
         a9WkCHK8yIP9d6/CAMctLa72BdQol+ownG6rA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=oI7XFt4gljq+GnwOhVPRciPoq+MNxSnddwInMxr6DNybyRIZ4YwmB6vVjo1odSleeF
         JxIeYJYZiAtzA06q+eZ/7I1PppJ3xChTgLdUmrlnxtXYTAu92e4NZIjR10dkzDVwsIVM
         hAhaUFDUU2npQvWVE7jPVBEq9MdJqIsN/UKrs=
Received: by 10.224.6.82 with SMTP id 18mr1957343qay.216.1298175174797;
        Sat, 19 Feb 2011 20:12:54 -0800 (PST)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id g32sm2765386qck.22.2011.02.19.20.12.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 20:12:54 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.51.g615e0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167395>

As compared to v3:

- Adds pristine-detach to the start of the series. I thought it made sense to
  refactor before adding the additional tests instead of after.

- Fixes t3404#16. This was due to CHERRY_PICK_HEAD overriding the authorship set
  by git rebase --interactive when used with --no-commit. Now we just don't
  write CHERRY_PICK_HEAD when --no-commit is given. This also addresses Junio's
  concern that doing so would be a regression.

  (That said, I wonder if rebase --interactive should use --reset-author when
  committing after using cherry-pick --no-commit just in case.)

- Addresses (I think) the various other feedback given in
  http://thread.gmane.org/gmane.comp.version-control.git/167031

Jay Soffian (3):
  Introduce CHERRY_PICK_HEAD
  bash: teach __git_ps1 about CHERRY_PICK_HEAD
  Teach commit about CHERRY_PICK_HEAD

Jonathan Nieder (1):
  t3507: introduce pristine-detach helper

 Documentation/git-cherry-pick.txt      |   19 ++++
 Documentation/git-commit.txt           |    7 +-
 Documentation/revisions.txt            |    5 +-
 branch.c                               |    1 +
 builtin/commit.c                       |  156 +++++++++++++++++++++++---------
 builtin/merge.c                        |    7 ++
 builtin/revert.c                       |   75 +++++-----------
 contrib/completion/git-completion.bash |    2 +
 t/t3507-cherry-pick-conflict.sh        |  150 ++++++++++++++++++++-----------
 t/t7509-commit.sh                      |   29 ++++++
 wt-status.c                            |    4 +-
 wt-status.h                            |    9 ++-
 12 files changed, 308 insertions(+), 156 deletions(-)

-- 
1.7.4.1.51.g615e0

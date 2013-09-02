From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/6] Preparation for non-ff pulls by default
Date: Mon,  2 Sep 2013 17:17:52 -0500
Message-ID: <1378160278-14872-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 03 00:22:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGcWG-0000tw-Jm
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 00:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757298Ab3IBWWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 18:22:44 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:45443 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756218Ab3IBWWo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 18:22:44 -0400
Received: by mail-ob0-f171.google.com with SMTP id tb18so4978348obb.2
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 15:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Lpn8USbFAIWG5IqtXtSBpmbzfUtCAAV3I0nc+4Epjxc=;
        b=UMx2o10rTgo0Ec/HNahx8cZCktuWaE6y7IpPFPya774Y5z/B6zO/HzhdPRlJTkjas6
         S0A3fIOcag4Kn5KJriJeVUBSnyvYQ/1tjNh4WuNJJl+drsSSQJgdZCbZZCDkjXAafzRG
         2/ZCJ8L4Q971nj+hO53mFhqoMETSODjTBB+S42mnACRaXi+lWmgLy0rZ19+GA6AVDcgE
         aNLZWw2zKAUdJcAwmf3s5TpnY/RajX2t4pgtn1Q2abL0n+49m8ifJlhpS+sNb+EeDt+q
         cwxraJsaiz1/ZTztxqrnZU9JqsVUBd/MJACEcFC66UAYY99FGF+ny0v3Mjvxuc2QgrHg
         kp3A==
X-Received: by 10.60.133.233 with SMTP id pf9mr3599981oeb.46.1378160563527;
        Mon, 02 Sep 2013 15:22:43 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id bq4sm15199172obb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 15:22:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233665>

It is very typical for Git newcomers to inadvertently create merges and worst:
inadvertently pushing them. This is one of the reasons many experienced users
prefer to avoid 'git pull', and recommend newcomers to avoid it as well.

To avoid these problems and keep 'git pull' useful, it has been suggested
that 'git pull' barfs by default if the merge is non-fast-forward, which
unfortunately would break backwards compatibility.

This patch series leaves everything in place to enable this new mode, but it
only gets enabled if the user specifically configures it; pull.mode =
merge-ff-only.

Later on this mode can be enabled by default (e.g. in v2.0).

To achieve that first some configurations are renamed: for example: pull.rebase
=> pull.mode = rebase, but the old ones remain functional, thus there are no
functional changes.

Felipe Contreras (6):
  merge: simplify ff-only option
  t: replace pulls with merges
  pull: rename pull.rename to pull.mode
  pull: refactor $rebase variable into $mode
  pull: add --merge option
  pull: add merge-ff-only option

 Documentation/config.txt               | 24 +++++++------
 Documentation/git-pull.txt             | 10 ++++--
 branch.c                               |  4 +--
 builtin/merge.c                        | 20 +++++------
 git-pull.sh                            | 49 ++++++++++++++++++++-------
 t/annotate-tests.sh                    |  2 +-
 t/t3200-branch.sh                      | 40 +++++++++++-----------
 t/t4200-rerere.sh                      |  2 +-
 t/t5520-pull.sh                        | 62 ++++++++++++++++++++++++++++++++++
 t/t5601-clone.sh                       |  4 +--
 t/t9114-git-svn-dcommit-merge.sh       |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh |  2 +-
 12 files changed, 157 insertions(+), 64 deletions(-)

-- 
1.8.4-338-gefd7fa6

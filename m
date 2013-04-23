From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/7] Introduce rebase.autostash
Date: Tue, 23 Apr 2013 19:31:57 +0530
Message-ID: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 23 16:00:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUdly-00015C-3w
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 16:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218Ab3DWOAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 10:00:37 -0400
Received: from mail-da0-f42.google.com ([209.85.210.42]:63120 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077Ab3DWOAg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 10:00:36 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so353901dad.29
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=sm7EXBtcwoBe8C9uhb4EbQb6ZqRE5pFBlwQEk/5JaGI=;
        b=ApGqaUK9ZA3D6NUCpJDemqAv+YKFxPwgcZrSjUbzbe3Og3q/lQtZ/7Xr9uDjq8oJ1A
         EY0bqkkM4hR6n1T+j3dZrnS4Jj0tPLhT0fZcBW+YvFmSbFphOqCxlhXM5hwh50YLQ488
         T2AbN6mPYK9x4ub7fgmsQ9EQ71CtRpmoHqIM4tdrqrbWcauBNrE/jsZa/xsXhNaMhox9
         OuOuhWZuFThdEk8StgHn9EKGcX+WLlg5CsuUmbhN7CmbRa7BpD4dbTSvhsnJJm06PGb0
         pXfcVC5m2Y0BQTiCQeQswJln6yAKKiLzaOKZnrOg11iESof7H2jVcHOntjDcBz959Ni9
         6xOg==
X-Received: by 10.68.209.193 with SMTP id mo1mr40581111pbc.191.1366725636128;
        Tue, 23 Apr 2013 07:00:36 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id vk7sm29634120pbc.41.2013.04.23.07.00.33
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Apr 2013 07:00:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.578.ga933817
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222157>

Yes!

After struggling with shell for a couple of days, I finally managed to
achieve what I set out to do: implement a rebase.autostash without
leaking the autostash detail into specific rebases.  And I'm
absolutely elated with my approach.  Patches [1/7] to [6/7] make no
reference to autostash, and pretend to be nice by-the-way changes
unrelated to any new feature.  [7/7] suddenly introduces a little bit
of code in git-rebase.sh, and everything just starts working
magically.

Okay, now for the bad news.  I've mostly just worked backward from
tests, so I can't justify all my changs fully.  Also, there are no new
tests, because I don't know what to test: we pretty much have to run
the entire rebase testsuite with rebase.autostash turned on, right?

If you can't wait for a few weeks (reviews, iterations) and want to
use this immediately, just pull in the rebase.autostash branch from
gh:artagnon/git and enjoy.

Cheers.

Ramkumar Ramachandra (7):
  am: suppress error output from a conditional
  rebase -i: don't error out if $state_dir already exists
  am: tighten a conditional that checks for $dotest
  am: don't do housekeeping when rebasing
  rebase -i: return control to the caller, for housekeeping
  sh-setup: introduce require_clean_work_tree --quiet
  rebase: implement --[no-]autostash and rebase.autostash

 Documentation/config.txt     |  8 ++++++++
 Documentation/git-rebase.txt | 10 ++++++++++
 git-am.sh                    | 15 ++++++++++-----
 git-rebase--am.sh            |  8 ++++----
 git-rebase--interactive.sh   | 14 ++++++--------
 git-rebase.sh                | 41 ++++++++++++++++++++++++++++++++++++++++-
 git-sh-setup.sh              | 10 +++++++---
 7 files changed, 85 insertions(+), 21 deletions(-)

-- 
1.8.2.1.578.ga933817

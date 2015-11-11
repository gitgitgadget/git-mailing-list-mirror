From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH 0/5] ff-refs: builtin command to fast-forward local refs
Date: Tue, 10 Nov 2015 21:11:20 -0500
Message-ID: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net,
	dturner@twopensource.com, pclouds@gmail.com,
	sunshine@sunshineco.com, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 11 03:13:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwKub-0007Gn-1u
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 03:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbbKKCNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 21:13:20 -0500
Received: from mail-yk0-f196.google.com ([209.85.160.196]:35799 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbbKKCNU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 21:13:20 -0500
Received: by ykba77 with SMTP id a77so2574650ykb.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 18:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=E7Eez/Li1L2i1g/eenI3bToOIdojeWKQPepkhifEHjY=;
        b=W0L1+L2FeSh8IPxTusIKMJGCcJJHkKEZxxHPonmckUxrdtdIfaC0c2G/Jv/FUaRvZU
         5Jvc1f/MVYiQfPwyslYBJh/qdVKBwUXIYLPc0kR+5D0/5HaoN5h6KN89V0BZ8N8Kb5/F
         IAhYbtOPMkUaCYv6hEqUZKG4gYWk6CjK+i+HQmjSiYv/CwS8XJWHui8KX5jXzzMuOCo6
         8mDWr9Uu6MkL7QTwrE+pMqCxnYTuEm8HijJ78JWVZtn7UfX8wSSh1kBlbtGT/5g4aqGz
         gkPw25Q49nJTDSswTrnHVNTzIhlJF+gpOvifIQ0B4HynkQdkDx0ZJwHDTid8lCEaAD3W
         G8rA==
X-Received: by 10.129.73.212 with SMTP id w203mr6486447ywa.229.1447207999276;
        Tue, 10 Nov 2015 18:13:19 -0800 (PST)
Received: from localhost.localdomain (ool-18e4990e.dyn.optonline.net. [24.228.153.14])
        by smtp.gmail.com with ESMTPSA id m128sm7948819ywm.34.2015.11.10.18.13.17
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Nov 2015 18:13:18 -0800 (PST)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281145>

This patch series is built on (based on) 'next' because it relies on
worktree.c

`ff-refs` will update local branches which can be fast-forwarded to their
upstream tracking branch.  Any branch which has diverged from the upstream
will be left untouched by this command.  Additionally, there are options
for '--dry-run' and to '--skip-worktrees'.

There are two primary update mechanisms for fast-forwarding a branch.
  - For a checked out branch, emulate `git-merge --ff-only`
  - For a non-checked out branch, emulate `git update-ref`

When run on a repo with multiple worktrees (created with git-worktree add),
git-ff-refs will take that into account when fast-forwarding.  That is, it
will run in 'merge --ff-only' emulation mode when a branch is checked out
in a worktree, rather than in 'update-ref' mode.

The primary benefit of ff-refs will come for those who maintain several
local branches which track upstream remote branches that update often.  The
intended usage pattern is to run `git-fetch` followed by `git-ff-refs`.

Michael Rappazzo (5):
  ff-refs: builtin cmd to check and fast forward local refs to their
    upstream
  ff-refs: update each updatable ref
  ff-refs: add --dry-run and --skip-worktree options
  ff-refs: Add documentation
  ff-refs: Add tests

 .gitignore                    |   1 +
 Documentation/git-ff-refs.txt |  55 +++++++++
 Makefile                      |   1 +
 builtin.h                     |   1 +
 builtin/ff-refs.c             | 272 ++++++++++++++++++++++++++++++++++++++++++
 command-list.txt              |   1 +
 git.c                         |   1 +
 t/t7900-ff-refs.sh            | 164 +++++++++++++++++++++++++
 8 files changed, 496 insertions(+)
 create mode 100644 Documentation/git-ff-refs.txt
 create mode 100644 builtin/ff-refs.c
 create mode 100755 t/t7900-ff-refs.sh

-- 
2.6.2

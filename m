From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 00/44] Make git-am a builtin
Date: Sun, 28 Jun 2015 22:05:22 +0800
Message-ID: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:06:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DEY-0001VE-2g
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbbF1OGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:06:54 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34916 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbbF1OGv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:06:51 -0400
Received: by pactm7 with SMTP id tm7so91487798pac.2
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=zBfwe+L0Frm0kZCm8GszzFvqdApJxDrwvkRrAFSgdh4=;
        b=ZLP3C9ZD5+KOTyWVCiCR2ePAUp1J2E1QDXvpxcn2hJzZij54n4SQXH6H/QqFlsccHH
         3yihbyiBncDOl3oCEGo2X4j4n37V0SWhAEta2/0ndP9ng4Z9oxmJvG5mghSmlWbsn8g2
         iVWai3rHHMZjt9eD1yft6iLtDxMgKgAHYTBs+jDdhbcfTQOAFTNR6oSb0EvXGtwRz18f
         EMy4dQJoexnXMXiNdk8DVJnulLC524eTrLAZEeqq0b1mx7axpummwCm1JYjpXPT6fllZ
         iKGqw+3p+/12X1545jDVZTNleFO2LSQtF9CJSm4LOgvSf8hZjl+H9Kkr4oLzAz+HExwB
         f/Xg==
X-Received: by 10.70.125.129 with SMTP id mq1mr22605437pdb.19.1435500411088;
        Sun, 28 Jun 2015 07:06:51 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.06.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:06:24 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272876>

This patch series depends on pt/pull-builtin.

This is a re-roll of [WIP v3]. This patch series is now out of WIP, as the
git-am feature set is complete. I've marked out some features which lack tests
though, which I'm working on fixing.

Thanks Junio, Stefan, Johannes for the reviews last round.

Also, v4, with 44 patches ;-)

Previous versions:

[WIP v1] http://thread.gmane.org/gmane.comp.version-control.git/270048
[WIP v2] http://thread.gmane.org/gmane.comp.version-control.git/271381
[WIP v3] http://thread.gmane.org/gmane.comp.version-control.git/271967

git-am is a commonly used command for applying a series of patches from a
mailbox to the current branch. Currently, it is implemented by the shell script
git-am.sh. However, compared to C, shell scripts have certain deficiencies:
they need to spawn a lot of processes, introduce a lot of dependencies and
cannot take advantage of git's internal caches.

This WIP patch series rewrites git-am.sh into optimized C builtin/am.c, and is
part of my GSoC project to rewrite git-pull and git-am into C builtins[1].

[1] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1


Paul Tan (44):
  wrapper: implement xopen()
  wrapper: implement xfopen()
  builtin-am: implement skeletal builtin am
  builtin-am: implement patch queue mechanism
  builtin-am: split out mbox/maildir patches with git-mailsplit
  builtin-am: auto-detect mbox patches
  builtin-am: extract patch and commit info with git-mailinfo
  builtin-am: apply patch with git-apply
  builtin-am: implement committing applied patch
  builtin-am: refuse to apply patches if index is dirty
  builtin-am: implement --resolved/--continue
  builtin-am: implement --skip
  builtin-am: implement --abort
  builtin-am: reject patches when there's a session in progress
  builtin-am: implement -q/--quiet, GIT_QUIET
  builtin-am: exit with user friendly message on failure
  builtin-am: implement -s/--signoff
  cache-tree: introduce write_index_as_tree()
  builtin-am: implement --3way, am.threeway
  builtin-am: implement --rebasing mode
  builtin-am: bypass git-mailinfo when --rebasing
  builtin-am: handle stray state directory
  builtin-am: implement -u/--utf8
  builtin-am: implement -k/--keep, --keep-non-patch
  builtin-am: implement --[no-]message-id, am.messageid
  builtin-am: support --keep-cr, am.keepcr
  builtin-am: implement --[no-]scissors
  builtin-am: pass git-apply's options to git-apply
  builtin-am: implement --ignore-date
  builtin-am: implement --committer-date-is-author-date
  builtin-am: implement -S/--gpg-sign, commit.gpgsign
  builtin-am: invoke post-rewrite hook
  builtin-am: support automatic notes copying
  builtin-am: invoke applypatch-msg hook
  builtin-am: invoke pre-applypatch hook
  builtin-am: invoke post-applypatch hook
  builtin-am: rerere support
  builtin-am: support and auto-detect StGit patches
  builtin-am: support and auto-detect StGit series files
  builtin-am: support and auto-detect mercurial patches
  builtin-am: implement -i/--interactive
  builtin-am: implement legacy -b/--binary option
  builtin-am: check for valid committer ident
  builtin-am: remove redirection to git-am.sh

 Makefile                                |    2 +-
 builtin.h                               |    1 +
 builtin/am.c                            | 2335 +++++++++++++++++++++++++++++++
 cache-tree.c                            |   29 +-
 cache-tree.h                            |    1 +
 git-am.sh => contrib/examples/git-am.sh |    0
 git-compat-util.h                       |    2 +
 git.c                                   |    1 +
 wrapper.c                               |   43 +
 9 files changed, 2401 insertions(+), 13 deletions(-)
 create mode 100644 builtin/am.c
 rename git-am.sh => contrib/examples/git-am.sh (100%)

-- 
2.5.0.rc0.76.gb2c6e93

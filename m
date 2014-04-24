From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 00/12] Improvements to cherry-pick
Date: Wed, 23 Apr 2014 21:44:39 -0500
Message-ID: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 04:55:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd9or-0007Ei-R5
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 04:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbaDXCzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 22:55:20 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:59194 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbaDXCzS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 22:55:18 -0400
Received: by mail-ob0-f173.google.com with SMTP id wn1so2003860obc.4
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 19:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Ovq/NriG8TCJTeXdLFd3hJR8jjYwamH68wzPDy7mbOY=;
        b=LJkLsreVlfg0k1lOTjTm5wSF8VQ1W5elqR0vfu6F9yDHk7WxwxYOKw+YHEg6VXTAsp
         +5txw9drnRFrXQuDdr70S6NKfY4Lpp9yl/DEUNc0VBUEIxOIR7TPor+H6C1NGGEacaJM
         zzEZeb0L2utnLvPWHbIri3WU2TZ04QKwahlQ6PEKAMKNyuIUnF3oDFP7rICLqPrdiodU
         jH/gY0vo3mFMg+0D+lEi0hysev/iFeW1r6cgT+az/9PPLxk7tmWMpERK6AHPPWut4E/g
         LnhbSoxVIlb7lbD2S407LKeqE8tEyurHvTsdye4uMhi5NSzXF3HDzwc3PBHbwzl4se/u
         WaDQ==
X-Received: by 10.182.165.3 with SMTP id yu3mr45129868obb.14.1398308118143;
        Wed, 23 Apr 2014 19:55:18 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cn1sm11808623oeb.11.2014.04.23.19.55.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 19:55:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246916>

Hi,

In the process of revamping 'git rebase' I found many areas of improvments in
`git cherry-pick`, here are the patches to improve the situation.

These were prettuch sent before already, but this time I dropped the second
part of the series to improve 'git rebase'.


Felipe Contreras (12):
  cherry-pick: don't barf when there's nothing to do
  cherry-pick: add --skip-empty option
  revert/cherry-pick: add --quiet option
  revert/cherry-pick: add --skip option
  cherry-pick: remember rerere-autoupdate
  builtin: add rewrite helper
  cherry-pick: store rewritten commits
  cherry-pick: don't store skipped commit
  builtin: move run_rewrite_hook() to rewrite.c
  builtin: rewrite: add copy_rewrite_notes()
  cherry-pick: add --action-name option
  cherry-pick: copy notes and run hooks

 Documentation/config.txt            |   9 ++-
 Documentation/git-cherry-pick.txt   |  10 ++-
 Documentation/git-revert.txt        |   7 ++-
 Documentation/githooks.txt          |   8 +--
 Documentation/sequencer.txt         |   3 +
 Makefile                            |   2 +
 builtin/commit.c                    |  46 ++------------
 builtin/revert.c                    |  11 ++++
 git-rebase--interactive.sh          |   4 +-
 rewrite.c                           | 121 ++++++++++++++++++++++++++++++++++++
 rewrite.h                           |  20 ++++++
 sequencer.c                         | 105 ++++++++++++++++++++++++++++---
 sequencer.h                         |   8 ++-
 t/t3504-cherry-pick-rerere.sh       |  39 ++++++++++++
 t/t3508-cherry-pick-many-commits.sh |  13 ++++
 t/t3510-cherry-pick-sequence.sh     |  14 ++++-
 t/t3512-revert-cherry-notes.sh      |  18 ++++++
 t/t5407-post-rewrite-hook.sh        |  16 +++++
 18 files changed, 392 insertions(+), 62 deletions(-)
 create mode 100644 rewrite.c
 create mode 100644 rewrite.h
 create mode 100755 t/t3512-revert-cherry-notes.sh

-- 
1.9.2+fc1.2.gfbaae8c

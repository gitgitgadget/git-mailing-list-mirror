From: Hitoshi Mitake <h.mitake@gmail.com>
Subject: [PATCH v0 0/2] git-less: a specialized pager for git-log
Date: Fri, 23 Mar 2012 03:42:22 +0900
Message-ID: <1332441744-5142-1-git-send-email-h.mitake@gmail.com>
Cc: git@vger.kernel.org, Hitoshi Mitake <h.mitake@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 22 19:42:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAmyF-00089v-U4
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 19:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758779Ab2CVSmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 14:42:43 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47559 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab2CVSmm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 14:42:42 -0400
Received: by pbcun15 with SMTP id un15so1796657pbc.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 11:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=8TTT6WNXxYEULqtvuoZgDW4KXt4FR8MKRVodHDxEFrk=;
        b=kJjDAhX5jlpcka+4Qc/bSIHfjN/+yvy5n2i5AfCsuEYZG7QZQ+gi7T3Y6hBKripc1e
         Jk4VicKDx52uribYppNO4IV9UmnScCaxNCBFqri8Qbw9OuQIZUtReGlqCKQY0lCnukR2
         zLn3S6zhUfSS+r9P/lGOiP0a+BN3VTFX57qx1HlpqjqRmLi6hRLYqEp61IKtq3dxrN3T
         IlBq5jTvke8ftjNYZltX/bm8HIs1XlbR17xxH4OzJknL/r2baxOdwOlVc4P5avxjM6IG
         b6Pk9lej50aVExERuAnoGkfvP2iz1ozQamVonfInSr/2UI63ZyDv1cpy+3LHy9fz7RUC
         bz5g==
Received: by 10.68.235.106 with SMTP id ul10mr16177440pbc.91.1332441762273;
        Thu, 22 Mar 2012 11:42:42 -0700 (PDT)
Received: from localhost.localdomain (FL1-122-135-76-206.tky.mesh.ad.jp. [122.135.76.206])
        by mx.google.com with ESMTPS id b4sm4255081pbc.7.2012.03.22.11.42.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 11:42:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.29.g2a42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193676>

Hi Junio C Hamano and git people,

I'd like to post this patch series for adding a pager program for git-log,
named "git-less". It seems that less is today's the most popular pager for
git-log. But I don't think that less is confortable pager when its input is come
from git-log. Because less treats its input as a simple text. So less cannot
recognize the end of each commit.

If the pager can recognize the end of each commit, more confortable viewing of
git-log's output will be possible.

So I'd like to introduce git-less, and the modification of git itself to support
this pager.

The main difference between less and git-less is recognition of each commit.
With this feature, git-log specific functionalities can be implemented. e.g.
* move with commit unit. Under git-less, hitting 'h' key means move to previous
  (parent) commit, 'l' means move to next (child) commit.
* commit local regex search. regular expression search limiting its range within
  commit, not entire log. I assigned '\' for commit local forward regex search
  and '?' for commit local regex search.

And other features like yanking commit ID might be implemented simply (not
implemented yet).

For implementing this feature, I had to make modification of git-log
* Changed output for inserting ETX (0x03) between each commit.
* Added new configuration parameter for git-log only pager: "log.pager".
  git-less only focuses on git-log, so it is not suitable for git-grep, etc.

This is the reason why I'm posting this patch. git-less is not git-independent
program. The source code of git-less have to be integrated with the git tree.
I understand this is not so good manner. And the source code is still dirty and
may be buggy, but I believe that this new pager is useful. I'd like to hear your
feedbacks.

Thanks,

Hitoshi Mitake (2):
  git-less: a specialized pager for git-log
  git-less: git side support for git-less

 .gitignore                |    1 +
 Documentation/git-log.txt |    6 +-
 Makefile                  |    5 +
 builtin/log.c             |   32 ++
 cache.h                   |    1 +
 less.c                    |  899 +++++++++++++++++++++++++++++++++++++++++++++
 pager.c                   |    9 +-
 7 files changed, 949 insertions(+), 4 deletions(-)
 create mode 100644 less.c

-- 
1.7.10.rc1.33.g64ff3.dirty

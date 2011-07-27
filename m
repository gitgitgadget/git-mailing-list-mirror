From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v2 0/3] check for unpushed remotes in submodules
Date: Wed, 27 Jul 2011 20:10:47 +0200
Message-ID: <1311790250-32454-1-git-send-email-iveqy@iveqy.com>
Cc: gitster@pobox.com, iveqy@iveqy.com, jens.lehmann@web.de,
	hvoigt@hvoigt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 27 20:10:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm8ZL-0000Fh-3Y
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 20:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab1G0SKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 14:10:44 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:36941 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab1G0SKn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 14:10:43 -0400
Received: by eye22 with SMTP id 22so2218727eye.2
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 11:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=20KSvnnhuMmqFttIxrqiRseT3KQ1VlWw62CDh6eMHjs=;
        b=id/yxJADdz1HPPCXnlU5dNpL7AYmsxmBEvbq3mYxJpD9/6dnUKRTRb3/1JEZ62VL4Y
         8qyZ8bxylfzJPEcy86RlVjqQgZQf8m8tKnLKEf4T8E+RK/6fW4CmnG59Gmaf+oRHnFMk
         EPFPF/a6ZDTfChk1wzf9xpRzYFgRqvdn7BGLc=
Received: by 10.205.64.67 with SMTP id xh3mr29563bkb.282.1311790241932;
        Wed, 27 Jul 2011 11:10:41 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id d10sm35063bkt.60.2011.07.27.11.10.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 11:10:41 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1Qm8ZH-0008S0-89; Wed, 27 Jul 2011 20:10:51 +0200
X-Mailer: git-send-email 1.7.6.236.g7ad21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177992>

When working with submodules it is easy to end up in a state when submodule
commits required by the superproject only is present locally. This is most
often a human error (although technical errors such as connection failure
can be a reason).

This patch-series tries to prevent pushing a superproject if not all (by
the superproject used) submodules are pushed first. This will prevent the
human error of forgetting to push submodules before pushing the
superproject.

The first iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/176328/focus=176327

The changes from the previous iteration are in patch 0003.

Regarding the discussion of superprojects with submodules that have no
remote tracking branches: A push will still be denied.  After some
discussion we did not consider this a drawback since all submodules that
are added/handled using the submodule script will have remote tracking
branches. Even if the submodules are not pushable when the superproject
records a commit that is reachable from a remote branch the push will not
be denied.

A new test is added in this iteration to show a bug that now is fixed.

Fredrik Gustafsson (2):
  push: Don't push a repository with unpushed submodules
  push: Add the --no-recurse-submodules option

Heiko Voigt (1):
  test whether push checks for unpushed remotes in submodules

 Documentation/git-push.txt     |    6 ++
 builtin/push.c                 |    1 +
 submodule.c                    |  115 ++++++++++++++++++++++++++++++++++++++++
 submodule.h                    |    1 +
 t/t5531-deep-submodule-push.sh |   99 ++++++++++++++++++++++++++++++++++
 transport.c                    |   10 ++++
 transport.h                    |    1 +
 7 files changed, 233 insertions(+), 0 deletions(-)

-- 
1.7.6.236.g7ad21

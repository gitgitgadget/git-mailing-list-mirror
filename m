From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH 0/2] specify commit by negative pattern
Date: Wed,  3 Jun 2015 21:54:12 +0100
Message-ID: <1433364854-30088-1-git-send-email-wmpalmer@gmail.com>
Cc: Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 22:54:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0FgG-0003dO-JR
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 22:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114AbbFCUy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 16:54:28 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33390 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbbFCUyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 16:54:25 -0400
Received: by wiwd19 with SMTP id d19so930612wiw.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 13:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=J97/a6b++AE4uOZhTo/oGMXpYMBuBkXE0Rm1Qp1lL8g=;
        b=l+lbnj9dAim9zOH8kUU3WYD1R81ixEF1ueLDRCD3Nm8/RjsGmmez/KzQcNruUXHX9Z
         vwEkA4X+04KxCVfQCrNH2QWDsbcnnaRqpO3sLjrNt3zZOUmWDmtjAO+zDysFERzpi+nw
         d5KM/VDhrcmh3/CvY3P7wJ34sJ4hCx66KzzU5ze6rBKnjT4RCij8nuLyMNlbtpnjKV/U
         DmJgpfy63NZagfK+8QYSDIHL9RL28q2kxy/spM41mTDbVkaPSm2HTBRhzi9WqYrEmy6A
         n0MidqnK9l+CdvopCVbjTuzPkAPkuQ8vGlSnN3o0kxoysxwzzgOCI+0VTw00sN7LYajC
         0zRw==
X-Received: by 10.194.79.73 with SMTP id h9mr63373732wjx.125.1433364864229;
        Wed, 03 Jun 2015 13:54:24 -0700 (PDT)
Received: from localhost.localdomain (cpc12-folk2-2-0-cust138.1-2.cable.virginm.net. [81.109.109.139])
        by mx.google.com with ESMTPSA id h7sm1888220wig.13.2015.06.03.13.54.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Jun 2015 13:54:23 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270735>

add support for negative pattern matching in @^{/<pattern>} style
revision specifiers. So now you can find the first commit whose message
doesn't match a pattern, complementing the existing positive matching.
e.g.:

    $ git rebase -i @^{/!^WIP}

My use-case is in having a "work, work, work, rebase, push"-style
workflow, which generates a lot of "WIP foo" commits. While rebasing is
usually handled via "git rebase -i origin/master", occasionally I will
already have several "good, but not yet ready to push" commits hanging
around while I finish work on related commits. In these situations, the
ability to quickly "git diff @^{/!^WIP}" to get an overview of all
changes "since the last one I was happy with", can be useful.

Reading through the history of this type of revision specifier, it feels
like a negative match was always thought of as potentially useful
someday, but didn't fit well with the original patch's limitations
(namely: always searching across all refs).

Will Palmer (2):
  test for '!' handling in rev-parse's named commits
  object name: introduce '^{/!<negative pattern>}' notation

 Documentation/revisions.txt |  7 ++++---
 sha1_name.c                 | 22 ++++++++++++++++------
 t/t1511-rev-parse-caret.sh  | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 64 insertions(+), 10 deletions(-)

-- 
2.3.0.rc1

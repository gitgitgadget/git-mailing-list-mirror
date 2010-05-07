From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 0/3 v4] Make git log --follow find copies among unmodified files.
Date: Thu,  6 May 2010 21:52:26 -0700
Message-ID: <1273207949-18500-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 06:52:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAFYH-0008U9-C5
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 06:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781Ab0EGEwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 00:52:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55907 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab0EGEwf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 00:52:35 -0400
Received: by mail-gy0-f174.google.com with SMTP id 13so428683gyg.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 21:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=a+Useesu2kf+/RhkUUKw9ZaenlS/1NQR18HWGM9H2Uw=;
        b=JorD0t4A1XzL4aEDbMAgriqSF0WSDYkcrPBHU3rYzl9ESIUpI9DrEk+VKLrR1BqCJm
         WJkSNBjZy7ODOlBpam7ZpdS1PR1xHEXt5FSP54Iv2oqtOt5XLFoENGfC6OGjLXJ/pJDz
         QkLfMVqPWJSa+koimqh1DQjkhDb20zFkoCnhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=H1g1ujFOPS6UtkYax+oRFJ2sv9sCp/bJrRjg8z2Hn3BoZEgcg5D+S5ZlE7tXZ3UmjD
         N0vmqoN7fB9CczOWmEuesD1N/fsby44vlsQ4otnyAoFJWdFk9sZHirgYGmpvBvjsNMzy
         YZA92LeZU0FSuI4ZFPZHm/cqVQQHs/nTp1hVI=
Received: by 10.101.151.31 with SMTP id d31mr10009251ano.220.1273207954787;
        Thu, 06 May 2010 21:52:34 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id n2sm16458856ann.12.2010.05.06.21.52.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 21:52:33 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146520>

I have tried to make --follow to support finding copies among unmodified files. And the first patch is to fix a bug introduced by '--follow' and 'git log' combination.
We use the code:

    else if (--p->one->rename_used > 0)
        p->status = DIFF_STATUS_COPIED;

to detect copies and renames. So, if diffcore_std run more than one time, p->one->rename_used will be reduced to a 'R' from 'C'. And this patch will fix this by allowing diffcore_std can only run once before a diff_flush, which seems rationale for our code.

Bo Yang (3):
  Add a macro DIFF_QUEUE_CLEAR.
  Make diffcore_std only can run once before a diff_flush
  Make git log --follow find copies among unmodified files.

 Documentation/git-log.txt           |    2 +-
 diff.c                              |   21 ++++++++-----
 diffcore-break.c                    |    6 +--
 diffcore-pickaxe.c                  |    3 +-
 diffcore-rename.c                   |    3 +-
 diffcore.h                          |    7 ++++
 t/t4205-log-follow-harder-copies.sh |   56 +++++++++++++++++++++++++++++++++++
 tree-diff.c                         |    2 +-
 8 files changed, 82 insertions(+), 18 deletions(-)
 create mode 100755 t/t4205-log-follow-harder-copies.sh

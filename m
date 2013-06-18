From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/7] Re-roll rr/rebase-checkout-reflog
Date: Wed, 19 Jun 2013 00:25:30 +0530
Message-ID: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 20:58:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up17I-0002Ab-45
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 20:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933682Ab3FRS6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 14:58:47 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:48625 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933351Ab3FRS6q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 14:58:46 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so4182483pdc.5
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 11:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Bs5YJKq5Scv51ZiEnTJ3aksmogc6WD/UCmQ6dcwJwts=;
        b=xpxaFiIfnIh/xNbKuKYl2BHeX/ulwCsNA0lRYG+vOfAsz+D65WqOBDI3+qlWVUK4lB
         k7ijvP6CASBi6AE/YKYAgK15neGk7dE/cymV25AVDX6Y0EXgMIjx845MwwcgfIKXR4dK
         d0Otvv9wIBH+e9jTGIiIL8kvbFO5LoWPAK1oPlk8ZChV2LJsRxXUKhZuN+308s4U+Ymw
         JxUGVACa96ZTdsvpE8GnmAJI14isZsBmiwHMlVl5auWmkD0i454e2iTRAe6d0Y8jt+vE
         mn9n8NlyxWiXf7UmId8YrOcK6wQQtwHUsyqxevRhtTfZhF4GpKViqoUhuKIoAnryFMih
         cUIw==
X-Received: by 10.66.228.34 with SMTP id sf2mr3321928pac.134.1371581925497;
        Tue, 18 Jun 2013 11:58:45 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id ag4sm19432751pbc.20.2013.06.18.11.58.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 11:58:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.455.g5932b31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228296>

In this iteration, I've redone [6/7] and [7/7] to address the "do not
leak GIT_REFLOG_ACTION" problem that Junio talked about.  Predictably,
I couldn't convince myself to take Junio's subshell approach.
Instead, I've reworked the entire logic to have two variables:
GIT_REFLOG_ACTION and base_reflog_action.  It is now elegant and
correct.

I'm elated that I got the chance to do this right.

Thanks.

Junio C Hamano (1):
  t/t7512-status-help: test "HEAD detached from"

Ramkumar Ramachandra (6):
  wt-status: remove unused field in grab_1st_switch_cbdata
  t/t2012-checkout-last: test "checkout -" after a rebase
  status: do not depend on rebase reflog messages
  checkout: respect GIT_REFLOG_ACTION
  rebase: write better reflog messages
  rebase -i: write better reflog messages

 builtin/checkout.c            | 11 +++++++---
 git-am.sh                     |  4 +++-
 git-rebase--am.sh             |  5 +++++
 git-rebase--interactive.sh    | 14 +++++++++----
 git-rebase.sh                 | 13 ++++++++++--
 t/t2012-checkout-last.sh      | 34 +++++++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh | 15 ++++++++++++++
 t/t7512-status-help.sh        | 47 ++++++++++++++++++++++++-------------------
 wt-status.c                   |  7 ++++---
 9 files changed, 116 insertions(+), 34 deletions(-)

-- 
1.8.3.1.455.g5932b31

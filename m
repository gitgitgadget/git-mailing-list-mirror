From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 00/11] blame/log -L: additional tests and bug fixes
Date: Wed, 31 Jul 2013 04:15:34 -0400
Message-ID: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 10:21:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Rew-0000bv-V5
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 10:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394Ab3GaIQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 04:16:32 -0400
Received: from mail-ye0-f178.google.com ([209.85.213.178]:54158 "EHLO
	mail-ye0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708Ab3GaIQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 04:16:29 -0400
Received: by mail-ye0-f178.google.com with SMTP id r9so174352yen.37
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 01:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=UfUv9zaDyGlX88o9nbs46QdwTuaHGGKFn53vTW6QC8c=;
        b=giO9QZuNy7agvt/NBt4yOafKhxmqWlC/2ulpo3Qpgb9e2i4PRDQ7hjN5RcN43ctyAG
         7di2ltcZSdUciqFf3uSnJYUb5QcQi6tczNqcf6ewCKeVY82SsB/L2KmG8wE/2r8sErmF
         Pdg49679gvDZHhNToyXo6RY2j+kjzg/pH/SaWmcAtbuaP6wly7Z+luSwQ84sgwGqBiZP
         tiZqJtKPtzp3DQ3BdwKP3HckMooKxNR1HeSTVBWjLUo9dKFkbgbO/1f9LLTnb6dNUkDB
         odcOaaCr7JTs+cZxRrjZqHqS337akJAK+5uJ5LwPDxitbuJY5AM09+LpdIasF0egtC2y
         w6yA==
X-Received: by 10.236.207.2 with SMTP id m2mr31527497yho.214.1375258588788;
        Wed, 31 Jul 2013 01:16:28 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id i4sm636759yhg.16.2013.07.31.01.16.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 01:16:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231412>

While working on multiple -L support for git-blame, I encountered more
issues with the existing -L facility in git-blame and git-log. This
series fixes these problems and adds a slew of new tests.

Patch 6/11 (t4211: retire soon-to-be unimplementable tests) may be
controversial. Removal of these tests was effectively a decision made in
isolation since my request for input [1] regarding the issue generated
only a single response (from j6t).

This series complements (does not replace) earlier -L-related fixes [2],
[3], [4], [5].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/231035/focus=231126
[2]: http://thread.gmane.org/gmane.comp.version-control.git/229917
[3]: http://thread.gmane.org/gmane.comp.version-control.git/230532
[4]: http://git.661346.n2.nabble.com/PATCH-0-6-fix-blame-L-regression-add-tests-tp7592174.html
[5]: http://thread.gmane.org/gmane.comp.version-control.git/231035

Eric Sunshine (11):
  t8001/t8002: blame: decompose overly-large test
  t8001/t8002: blame: demonstrate -L bounds checking bug
  t8001/t8002: blame: add empty file & partial-line tests
  blame: fix -L bounds checking bug
  t4211: log: demonstrate -L bounds checking bug
  t4211: retire soon-to-be unimplementable tests
  log: fix -L bounds checking bug
  t8001/t8002: blame: demonstrate acceptance of bogus -LX,+0 and -LX,-0
  blame: reject empty ranges -LX,+0 and -LX,-0
  t8001/t8002: blame: demonstrate acceptance of bogus -L,+0 and -L,-0
  blame: reject empty ranges -L,+0 and -L,-0

 builtin/blame.c     |   4 +-
 line-log.c          |   4 +-
 line-range.c        |   4 +-
 t/annotate-tests.sh | 142 +++++++++++++++++++++++++++++++++++++++++++++++++---
 t/t4211-line-log.sh |  31 +++++++++---
 5 files changed, 166 insertions(+), 19 deletions(-)

-- 
1.8.3.4.1120.gc240c48

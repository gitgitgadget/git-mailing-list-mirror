From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/6] Memory leaks once again
Date: Fri, 27 Mar 2015 15:09:00 -0700
Message-ID: <1427494150-8085-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 27 23:10:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbcSE-00051z-AD
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbbC0WKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:10:09 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36857 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbbC0WKH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:10:07 -0400
Received: by iedm5 with SMTP id m5so81241452ied.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5Ea3CutNYWfNwvxMd3ph4ZJWCaHj0EQyMomTL39aEqQ=;
        b=EuV0okgqpAdb4uSUSPREWLYtr3/S2LQyl56VXkjNO0O3he/ZZ7w8yn4eAg1YpioDMi
         xqT+671tN7/JqlLOliHEW0yqKy8KW5GyFdtJ3DzWhuUIu1FqOPvDDuUwcrgtImbzYB/J
         HP8eX6LdJmGPpreHLpTo6dK4UaIsCs/g0g20U8cyBb73RuY6ngt5mAa8Zv8vDMeEdbN2
         uK56NI66P8xG1xBZUe6xFLN9TVaE2U1wDBZQ15HPb48nPOfNPol/OeHRQfv7/6MaCgKq
         7cPIjyCZdK0k7F5pM50Mdh/jzfpq/MMbbA4JTA6yOcMKVAnejBzpU8V4SLZldLP6/Bsq
         nP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Ea3CutNYWfNwvxMd3ph4ZJWCaHj0EQyMomTL39aEqQ=;
        b=lwQVACxclXezXi3b18mN7JYahfix6tm9Yocfv/7fXA2w5j7Y4DSSje7x6ZcN8xKeWG
         9CthiuEoUGMbtB8nqMw5pCjeY3No/eiHK08t5O4QQpJzTqCi5NcJuemkwIZZieq8NvqS
         t3S0oY4R/W3+oRsdPZxCFvfCVw5Ffd2NgQgzCL1j59Igwnb7SeOhgnfGxhVZaW6/zrMv
         lVEb/oUar8B+xmIKXLOXx15PFFxX41uMBjvqh7lTflk5gqTdzcnRo/Vcg37jq/g0BQqO
         rlmH8hJq0FCAxCiEERrN1lSMtLE43AwhJ7v35mr4Egyiv/HpTHk1jgolmnGwcMGbhG+M
         Gc1A==
X-Gm-Message-State: ALoCoQnFfEW9SaQsopdQQvwTsWM1M1X1x8k9uzan+NVgRD/zJ6SiROyJeTdV84udrOBtrfsD4sOY
X-Received: by 10.107.8.220 with SMTP id h89mr9517008ioi.34.1427494207030;
        Fri, 27 Mar 2015 15:10:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id b137sm2132267ioe.36.2015.03.27.15.10.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:10:06 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266381>

Here comes another bunch of memory leaks fixed.
patches 1-4 are safe bets, but 5 and 6 are not so.

In patch 5 I wonder if we need to fix more aggressively and
in patch 6 I just know there is a leak but I have no idea how to
actually fix it.

Stefan Beller (6):
  shallow: fix a memleak
  line-log.c: fix a memleak
  line-log.c: fix a memleak
  wt-status.c: fix a memleak
  pack-bitmap: fix a memleak
  WIP/RFC/entry.c: fix a memleak

 entry.c       |  4 +++-
 line-log.c    |  4 ++++
 pack-bitmap.c | 27 ++++++++++++++++++---------
 shallow.c     |  4 ++--
 wt-status.c   |  2 ++
 5 files changed, 29 insertions(+), 12 deletions(-)

-- 
2.3.0.81.gc37f363

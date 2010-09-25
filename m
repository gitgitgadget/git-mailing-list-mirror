From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 0/4] rev-parse: allow --flags to output rev-parse-like flags
Date: Sat, 25 Sep 2010 23:33:49 +1000
Message-ID: <1285421633-22684-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 25 15:31:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzUqP-00027D-3W
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 15:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691Ab0IYNbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 09:31:04 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:64110 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab0IYNbD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 09:31:03 -0400
Received: by pxi10 with SMTP id 10so1027519pxi.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=1WiIu/kISxYe1ZL/MxvMA5wWQAPZ/OgGoLxdCt5SKNA=;
        b=dpupAGffELdQ6bbfh8mtn+YJtx+3uJXT7c2sJ560q6Ms6dnu+H7s9x2ZNg2Uy9g08p
         NkibGBnNS1raZPxrS0qaYrMc7hcjScfeZ53qV+MKKxNa3NukX7rd+Vjc4Qu5rtYOwAUM
         upR4wtyJObjyB3IDtvPHb4F/hrDLRxmA+l69o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Z+cey5nJ76gOiyQeUNDniqYjWbanoiCq2x79xk9Fagna4oCBc3vPzOLOXlsRJVptvl
         OlfQUGl1UzkRhjyrAlbi2o5YtT3Rv2LbWkbiXd+cYZ4U1gHRPOvMfCo1IJE3IsDDZcS1
         HBAPvhxu0yu8atNs+1hT32zWrN5VVnZtsjVKo=
Received: by 10.143.41.15 with SMTP id t15mr4038862wfj.12.1285421462561;
        Sat, 25 Sep 2010 06:31:02 -0700 (PDT)
Received: from localhost.localdomain ([120.16.118.189])
        by mx.google.com with ESMTPS id l42sm3924235wfa.9.2010.09.25.06.30.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 06:31:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4.ge900b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157150>

This series allows git rev-parse --flags to output remaining flag-like arguments
even if such arguments are valid options to git rev-parse itself.

Previously:
  $ git rev-parse --flags -q -X --no-flags -- Y -Z
  -X
  $

Now:
  $ git rev-parse --flags -q -X --no-flags -- Y -Z
  -q -X --no-flags
  $

This series also changes the interpretation of --flags so that
specification of this option implies --no-revs.

Previously:
  $ git rev-parse --flags HEAD
  HEAD
  $

Now:
  $ git rev-parse --flags HEAD
  $

Reviewers attention is drawn to the following behaviour which, while
unchanged from current behaviour, differs from the behaviour specified
by the documentation. Specifically:

  $ git rev-parse -X --no-flags
  -X
  $ git rev-parse --no-flags -X
  $

In other words, a git rev-parse option only ever affects the 
interpretation of succeeding options, never preceding options.

Aevar's feedback on v2 of this series has been incorporated.

Jon Seymour (4):
  rev-parse: stop interpreting flags as options to rev-parse once
    --flags is specified
  rev-parse: add tests for git rev-parse --flags.
  rev-parse: update documentation of --flags and --no-flags options
  rev-parse: make --flags imply --no-revs for remaining arguments.

 Documentation/git-rev-parse.txt |   12 ++++
 builtin/rev-parse.c             |   14 +++++-
 t/t1510-rev-parse-flags.sh      |  109 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 1 deletions(-)
 create mode 100755 t/t1510-rev-parse-flags.sh

-- 
1.7.3.3.gc4c52.dirty

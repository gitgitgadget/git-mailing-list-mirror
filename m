From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 0/4] rev-parse: allow --flags to output rev-parse-like flags
Date: Sun, 26 Sep 2010 02:18:31 +1000
Message-ID: <1285431515-21321-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 25 18:15:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzXPW-0000RJ-P2
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 18:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640Ab0IYQPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 12:15:33 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:60935 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031Ab0IYQPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 12:15:32 -0400
Received: by pxi10 with SMTP id 10so1046574pxi.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ZCHk9EWzmhjZiWA7mA92Vd0J8Q6wVoZsHEnHOZeWNe4=;
        b=mAVhHEed4f7ydb5j/YysD7zAIRZeCWCytWtMS1oMNq9PUywmtpMxY3cj6nCoK5L2eJ
         lC4+QmysXsriizvKK8OZWzgOyl2AIt/rU92oeQ1ZfqhifIWXZzO71Z/VFZ8CcWsC0Nfj
         /qS1X82Jiss51GxFvx2tO2Lx3ysci8fd8VT7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GxOi/6m6H8Pj4Es7DgP464DGrZm/mO5fZO6xs1oCLJ2cfULaGPLZ9YpSCSL5htlYPz
         nUgo/flWte3LkKU9txwa3qjpMzNcoSN0HzfAvOYzFLDn9jqqJNioy/gROgX319TNEUXY
         JmtgmPyuj6XQaVZqeyv8/KOAVb6FsV80Nv2ro=
Received: by 10.114.57.14 with SMTP id f14mr5498934waa.60.1285431332139;
        Sat, 25 Sep 2010 09:15:32 -0700 (PDT)
Received: from localhost.localdomain (124-169-4-134.dyn.iinet.net.au [124.169.4.134])
        by mx.google.com with ESMTPS id c24sm6056766wam.7.2010.09.25.09.15.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 09:15:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4.g73371.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157159>

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

Aevar's feedback on v2 and v4 of this series has been incorporated.

v5 fixes a breakage in support of --no-revs option introduced by v4
and updates the test to add tests that would have prevented that breakage
being introduced.

Jon Seymour (4):
  rev-parse: stop interpreting flags as options to rev-parse once
    --flags is specified
  rev-parse: add tests for git rev-parse --flags.
  rev-parse: update documentation of --flags and --no-flags options
  rev-parse: make --flags imply --no-revs for remaining arguments.

 Documentation/git-rev-parse.txt |   12 ++++
 builtin/rev-parse.c             |   14 ++++-
 t/t1510-rev-parse-flags.sh      |  127 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 1 deletions(-)
 create mode 100755 t/t1510-rev-parse-flags.sh

-- 
1.7.3.4.g9eb38

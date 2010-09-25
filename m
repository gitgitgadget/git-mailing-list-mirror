From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH/RFC v2 0/4] rev-parse: allow --flags to output rev-parse-like flags
Date: Sat, 25 Sep 2010 19:04:09 +1000
Message-ID: <1285405454-12521-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: robbat2@gentoo.org, casey@nrlssc.navy.mil, git@vger.kernel.org,
	brian@gernhardtsoftware.com
X-From: git-owner@vger.kernel.org Sat Sep 25 11:01:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzQdY-0001gS-Kg
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 11:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092Ab0IYJBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 05:01:25 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49476 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab0IYJBY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 05:01:24 -0400
Received: by pwj6 with SMTP id 6so815188pwj.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 02:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=WMs5NqyIxLVCP900IBxK846ECtoh6VTNzQZmG13nWfU=;
        b=wLBzD1VQcVigNq4C6UzY+/kOGKWwqvrD8Xi5kHn7xgcVq7HzbP/zyuXlKDFVqgWNyy
         UWxZgVHArRdoZVO1wkcDKLeTKZRIXSerYGvj9cqeR119SMU/OHwS26h+bFrNPj5y71NO
         7uqbHtCvZ9GF1q1cFp2GNk4fiuNdb0ocS8PuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=YUaAJyIDuGH4IbCIA9TUE39CeDbQLv/qg0jDKh8eg3BQwZTMN64fgrOEuMY0YHzIZL
         6ZCSzEdzhcV7ofO2MMreSliT3DValKhpE5DbOwL8aG8KRmqbtfgzIhxDPzwnHL7+hiis
         1+02k33eqwiZsuNhCBaWr8GIIrU6gXACzJeM0=
Received: by 10.142.216.2 with SMTP id o2mr3819242wfg.142.1285405283804;
        Sat, 25 Sep 2010 02:01:23 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.90])
        by mx.google.com with ESMTPS id y36sm3574521wfd.6.2010.09.25.02.01.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 02:01:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.gc81ce.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157133>

This series allows git rev-parse --flags to output remaining flag-like arguments
even if such arguments are valid options to git rev-parse itself.

Previously:
  $> git rev-parse --flags -q -X --no-flags -- Y -Z
  -X

Now:
  $> git rev-parse --flags -q -X --no-flags -- Y -Z
  -q -X --no-flags

Also:
  $> git rev-parse --symbolic --no-flags --flags -X HEAD
  HEAD

Note: git rev-parse --flags still seems broken w.r.t. documentation because:
  $> git rev-parse --symbolic --flags HEAD
  HEAD
even though the documentation states that --flags does not output non-flag
arguments.

Jon Seymour (4):
  rev-parse: stop interpreting flags as options to rev-parse once
    --flags is specified
  rev-parse: Don't recognise --flags as an option if --no-flags has
    been specified.
  rev-parse: add tests for git rev-parse --flags.
  rev-parse: update documentation of --flags and --no-flags options

 Documentation/git-rev-parse.txt |   10 +++-
 builtin/rev-parse.c             |   11 ++++
 t/t1510-rev-parse-flags.sh      |  116 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 2 deletions(-)
 create mode 100755 t/t1510-rev-parse-flags.sh

-- 
1.7.3.1.gc81ce.dirty

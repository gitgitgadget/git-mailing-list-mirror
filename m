From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 0/4] git p4: label import/export
Date: Tue, 24 Apr 2012 09:08:12 +0100
Message-ID: <1335254897-15242-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 10:08:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMans-00082N-RP
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 10:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581Ab2DXIIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 04:08:34 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:48480 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861Ab2DXII1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 04:08:27 -0400
Received: by wejx9 with SMTP id x9so230902wej.19
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 01:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=wDB4sH/fU6OYxb/cdU/XIQSB6pIt6SCzNbRMR9gxCHw=;
        b=U9aSq7nv/6iaMj4XoY/W5ooeQLVduALn9r5V8R2/gBvmdfCuPICS78jOQfsyACK8O4
         YH6n+PDk2zpmZbXokNsySQZdoF9M8G4BmK+CcwHfbdaQP8LmRtSEDr47FJBobFK1b0ub
         1sTMAZNaFEzj2Rv/GxmC+HClLauQsFDE8iUupJ/SBR9GCDnyMuy5S+eyhIaAQsfOfgG6
         IIr3CY55J9WTb8tV5eSd4m2jWO6wQC4aox2QCQb8day+kVSqDhx0gQDspI06c9v9prjv
         tg4G5yDAMQhv0yvHDJIHoaqe9ypQdChPGu3CnzZdDcfwyOTLRW3VzdJyBtEd7uAAPZy3
         Z54A==
Received: by 10.180.92.71 with SMTP id ck7mr28941927wib.2.1335254904273;
        Tue, 24 Apr 2012 01:08:24 -0700 (PDT)
Received: from ethel.diamand (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id fl2sm44448146wib.2.2012.04.24.01.08.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 01:08:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.381.gb484f
X-Gm-Message-State: ALoCoQlgM8FC2QkRwsImbftLBKE5aSynpu4ZqkDiKSmVnmOpXm5QD4nC/oV/fA4Ezsndh1HmDbuW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196204>

This is a reworked version of my earlier patches for adding
improved label import/export support to "git p4", and
incorporates comments from Pete Wyckoff and Junio:

Comments from Pete:

* The verbose flag has been hoisted to the Command class.
* Uses the existing functions to fish out p4 changelist numbers.
* Config options renamed to be self-consistent, and regexp
  now includes lower-case characters.

I have left the tests in t9811 where they are, so that the t9804
script can be used solely for "--detect-labels".

Comments from Junio:

* P4EDITOR is set to the always-true value in the test harness
* Treat an empty P4EDITOR the same as an unset P4EDITOR.

There was a discussion about having "git p4" fall back to a default in
the same way that "p4" does, but this would change the existing behavior
(use git var GIT_EDITOR) and confuse users.

This patch series was reworked against ld/git-p4-tags-and-labels and
also has a very small documentation fix.

Luke Diamand (5):
  git p4: Fixing script editor checks
  git p4: Squash P4EDITOR in test harness
  git p4: Ignore P4EDITOR if it is empty
  git p4: import/export of labels to/from p4
  git p4: move verbose to base class

 Documentation/git-p4.txt       |   54 ++++++--
 git-p4.py                      |  289 ++++++++++++++++++++++++++++++++--------
 t/lib-git-p4.sh                |    1 +
 t/t9800-git-p4-basic.sh        |    4 +-
 t/t9811-git-p4-label-import.sh |  202 ++++++++++++++++++++++++++++
 5 files changed, 482 insertions(+), 68 deletions(-)
 create mode 100755 t/t9811-git-p4-label-import.sh

-- 
1.7.10.381.gb484f

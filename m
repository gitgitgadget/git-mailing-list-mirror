From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1] git-p4: label import, tag export
Date: Tue,  3 Apr 2012 08:38:33 +0100
Message-ID: <1333438715-14902-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 09:38:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEyKH-0005RC-Mq
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 09:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692Ab2DCHin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 03:38:43 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60808 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab2DCHin (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 03:38:43 -0400
Received: by wgbdr13 with SMTP id dr13so3453069wgb.1
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 00:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=KxdrL5GRe9mHzKcav27YituTaI0zK7dmjsqhZY85Htk=;
        b=GsMyTo2QxoxykvmvopFe1hr1d954u/v48s72i68iECCeB55kK8IEmzmXX++Z8kgVuH
         Ycqsgq2h8gFwgzkC7ExpHuwPa/xIHtMtCQTShqbAb+j3a/2soN1F5GhAiiBiErfcCXnN
         +ppEbYMnaHdAWZiMKn9Kexew8QpKWiccJdl0oAVmCLYeF7qWIWiU4ywA8dc5u5I9mn0K
         H0etY00d7MejqT05PXf4FsRt1slr2bSF3L44UWBdG/hp/4NCsHCjJR9cgLiBNicdKLCG
         evOAu53nwz8u7bGNsmTuxwJug2TEaSZ96tKpIAfJtylcA5d5E1w2RYq2cCAI1Xd/L8sB
         odvg==
Received: by 10.180.104.231 with SMTP id gh7mr33497814wib.10.1333438721913;
        Tue, 03 Apr 2012 00:38:41 -0700 (PDT)
Received: from halilbut.cam.broadcom.com (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id ff2sm66101034wib.9.2012.04.03.00.38.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 00:38:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0.158.gd9e55
X-Gm-Message-State: ALoCoQmsS7reqdCoNM4xeG1wkFpb/so9PJUXpIx9m1joJw+FsnSMvWyWfcXmmP3WzriI6i/F+u2M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194600>

This is an updated version of my earlier RFC/patch for importing
p4 labels into git, incorporating comments from Pete Wyckoff,
and git export support.

It operates by getting the sets of git tags and p4 labels, finding
out what is missing, and creating tags/labels as necessary. This
is in contrast to the existing detect-labels code which looks
for p4 labels associated with the changelist being imported and
which therefore misses tags on older changelists.

Git tag export is done during the sync phase because that's when
the commit/changelist mapping is first known.

There is also a small fix to t9800 for a problem I found while
testing this.

Luke Diamand (2):
  git-p4: fix t9800 editor check
  git-p4: import/export of labels to/from p4

 Documentation/git-p4.txt       |   39 ++++++-
 contrib/fast-import/git-p4     |  249 ++++++++++++++++++++++++++++++++++------
 t/t9800-git-p4-basic.sh        |    4 +-
 t/t9811-git-p4-label-import.sh |  145 +++++++++++++++++++++++
 4 files changed, 400 insertions(+), 37 deletions(-)
 create mode 100755 t/t9811-git-p4-label-import.sh

-- 
1.7.10.rc0.158.gd9e55

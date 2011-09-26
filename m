From: Luke Diamand <luke@diamand.org>
Subject: [PATCH/RFCv1] git-p4: handle files with shell metacharacters
Date: Mon, 26 Sep 2011 22:29:14 +0100
Message-ID: <1317072555-23438-1-git-send-email-luke@diamand.org>
Cc: pw@padd.com, vitor.hda@gmail.com, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 23:29:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Ijz-0005bR-3F
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 23:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab1IZV30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 17:29:26 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49085 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab1IZV30 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 17:29:26 -0400
Received: by wyg34 with SMTP id 34so6352714wyg.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 14:29:25 -0700 (PDT)
Received: by 10.227.3.2 with SMTP id 2mr6603825wbl.4.1317072564863;
        Mon, 26 Sep 2011 14:29:24 -0700 (PDT)
Received: from localhost.localdomain (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id h20sm32836725wbo.22.2011.09.26.14.29.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Sep 2011 14:29:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g4db0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182166>

git-p4 uses the shell to execute perforce and git. This leads to problems
where files contain shell metacharacters or spaces. I first hit this
when someone checked in files with dollars ($) in their name, but in theory
you could cause complete havoc with other characters: backticks in a
filename would be especially entertaining.

Make git-p4 use subprocess.Popen() and subprocess.call() instead, and
pass in argv[] style arrays instead, at least for cases where filenames
are involved. Add test cases.

Notes:

This patch is based on Pete Wyckoff's recent patch series for refactoring
the git-p4 test harness, so it won't apply to the current next or master
branches.

I tried testing it on Cygwin as well, but the test harness appears to be
very broken on that platform as it is unable to start p4d.

Luke Diamand (1):
  git-p4: handle files with shell metacharacters

 contrib/fast-import/git-p4     |  174 +++++++++++++++++++++++++---------------
 t/t9800-git-p4.sh              |    2 +-
 t/t9803-git-shell-metachars.sh |   70 ++++++++++++++++
 3 files changed, 179 insertions(+), 67 deletions(-)
 create mode 100755 t/t9803-git-shell-metachars.sh

-- 
1.7.6.347.g4db0d

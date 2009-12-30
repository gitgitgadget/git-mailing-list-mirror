From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [Updated PATCH 0/2] Improve remote helpers exec error reporting
Date: Wed, 30 Dec 2009 12:52:16 +0200
Message-ID: <1262170338-11574-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 11:52:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPwAF-00021l-EA
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 11:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbZL3KwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 05:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbZL3KwX
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 05:52:23 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:59084 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbZL3KwW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 05:52:22 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 07A0513AD18
	for <git@vger.kernel.org>; Wed, 30 Dec 2009 12:52:21 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0573F04986; Wed, 30 Dec 2009 12:52:21 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id EA9CC158A6E
	for <git@vger.kernel.org>; Wed, 30 Dec 2009 12:52:19 +0200 (EET)
X-Mailer: git-send-email 1.6.6.3.gaa2e1
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135878>

This reroll fixes the following from previous round:
- Split loop-trying-to-close to its own inline function.
- Don't rely on pipe(2) preserving fd array in case of failure.
- Don't try to use partially received error codes.
- Don't send error about partial write as it would go to who knows where.
- Add a testcase (ENOENT is detected correctly).

Ilari Liusvaara (2):
  Report exec errors from run-command
  Improve transport helper exec failure reporting

 Makefile               |    1 +
 run-command.c          |   79 ++++++++++++++++++++++++++++++++++++++++++++++--
 t/t0061-run-command.sh |   13 ++++++++
 test-run-command.c     |   35 +++++++++++++++++++++
 transport-helper.c     |   14 ++++++--
 5 files changed, 135 insertions(+), 7 deletions(-)
 create mode 100755 t/t0061-run-command.sh
 create mode 100644 test-run-command.c

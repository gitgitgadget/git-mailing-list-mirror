From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] t3301-notes: Test the creation of reflog entries
Date: Mon, 29 Mar 2010 15:05:57 +0200
Message-ID: <d6c334ec855bf04d9edb432b9cdc3590ab96d6e9.1269867675.git.git@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 15:09:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwEiE-0007zF-AJ
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 15:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931Ab0C2NIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 09:08:51 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:46079 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750903Ab0C2NIu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 09:08:50 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B4C8AE9A26;
	Mon, 29 Mar 2010 09:08:49 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 29 Mar 2010 09:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=lUkWp1hte780QGAouYw4VE6wKiM=; b=McggwmHqjsPisovX640rFxizTOkjy7DLfCBZykYYSBo9E2LNAPbsey42k/y5M6GOpPvVGnOvDZOoI+zQOwwOSgk85nfWfORErx1QsotYLbZRmYwmVzjChAsjZZZWIsOovwvghxxHRXcr5wLSf04WjcqQZynDj9Y4Qhyob9I8UBw=
X-Sasl-enc: OwBm49FtkissTvEJCy8QONXI9jdpfltD+XMusTI048pV 1269868129
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2EDAF49B6F9;
	Mon, 29 Mar 2010 09:08:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.3.448.g82eeb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143470>

Test whether the notes code writes reflog entries. It intends to
(setting up the reflog messages) but currently does not.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t3301-notes.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 1d6cd45..5410a6d 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -65,6 +65,15 @@ test_expect_success 'create notes' '
 	test_must_fail git notes show HEAD^
 '
 
+cat >expect <<EOF
+d423f8c refs/notes/commits@{0}: notes: Notes added by 'git notes add'
+EOF
+
+test_expect_failure 'create reflog entry' '
+	git reflog show refs/notes/commits >output &&
+	test_cmp expect output
+'
+
 test_expect_success 'edit existing notes' '
 	MSG=b3 git notes edit &&
 	test ! -f .git/NOTES_EDITMSG &&
-- 
1.7.0.3.448.g82eeb

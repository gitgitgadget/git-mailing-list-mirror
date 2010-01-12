From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [BUGFIX] Unbork remote helper execution
Date: Tue, 12 Jan 2010 20:49:17 +0200
Message-ID: <1263322157-21354-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 19:49:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUlnx-0005M3-EW
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 19:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab0ALStV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 13:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927Ab0ALStU
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 13:49:20 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:53517 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab0ALStU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 13:49:20 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id C46C3EF541
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 20:49:18 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A03C04C5043; Tue, 12 Jan 2010 20:49:18 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id B63C827D9B
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 20:49:17 +0200 (EET)
X-Mailer: git-send-email 1.6.6.102.gd6f8f.dirty
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136749>

Someone that obiviously didn't test the change did the following (the
code blames to me, but I didn't write this):

code = start_command(helper);
if (code < 0 && errno == ENOENT)
	die("Unable to find remote helper for '%s'", data->name);
else
	exit(code);

Which is obiviously wrong. The code shouldn't exit if code is 0.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport-helper.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index fece6d6..7012101 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -121,7 +121,7 @@ static struct child_process *get_helper(struct transport *transport)
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
 		die("Unable to find remote helper for '%s'", data->name);
-	else
+	else if (code != 0)
 		exit(code);
 
 	data->helper = helper;
-- 
1.6.6.102.gd6f8f.dirty

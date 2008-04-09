From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH 5/8] test-lib.sh: Add a test_set_editor function to safely set $VISUAL
Date: Tue,  8 Apr 2008 21:30:01 -0400
Message-ID: <1207704604-30393-5-git-send-email-bdonlan@fushizen.net>
References: <>
 <cover.1207702130.git.bdonlan@fushizen.net>
 <1207704604-30393-1-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-2-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-3-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-4-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 03:31:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjPAC-0007qD-Cu
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 03:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbYDIBap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 21:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbYDIBap
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 21:30:45 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:49016 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbYDIBao (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 21:30:44 -0400
Received: from hillmannl2.umeres.maine.edu ([130.111.243.252] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JjP8b-0007dQ-Fd; Wed, 09 Apr 2008 01:30:09 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JjP8W-0007vD-I6; Tue, 08 Apr 2008 21:30:04 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207704604-30393-4-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79060>

In particular, this function correctly handles cases where the pwd contains
spaces, quotes, and other troublesome metacharacters.

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 t/test-lib.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 17d4bc0..6f43376 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -160,6 +160,15 @@ die () {
 
 trap 'die' exit
 
+test_set_editor () {
+	# If the editor path contains a quote, just using VISUAL='"path"' isn't
+	# enough.
+	FAKE_EDITOR="$1"
+	export FAKE_EDITOR
+	VISUAL='"$FAKE_EDITOR"'
+	export VISUAL
+}
+
 test_tick () {
 	if test -z "${test_tick+set}"
 	then
-- 
1.5.5.8.gbbd98

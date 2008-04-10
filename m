From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v2 04/10] test-lib.sh: Add a test_set_editor function to safely set $VISUAL
Date: Thu, 10 Apr 2008 02:50:10 -0400
Message-ID: <1207810216-27871-5-git-send-email-bdonlan@fushizen.net>
References: <cover.1207702130.git.bdonlan@fushizen.net>
 <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-2-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-3-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-4-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 08:52:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjqeT-0003IA-69
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 08:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbYDJGwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 02:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755455AbYDJGwJ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 02:52:09 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:34057 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbYDJGwI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 02:52:08 -0400
Received: from [130.111.236.232] (helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1Jjqbz-0003wH-JW; Thu, 10 Apr 2008 06:50:19 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1Jjqbw-0007Fx-VP; Thu, 10 Apr 2008 02:50:16 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207810216-27871-4-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79180>

In particular, this function correctly handles cases where the pwd contains
spaces, quotes, and other troublesome metacharacters.

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 t/test-lib.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7c2a8ba..d7ad13b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -160,6 +160,22 @@ die () {
 
 trap 'die' exit
 
+# The semantics of the editor variables are that of invoking
+# sh -c "$EDITOR \"$@\"" files ...
+#
+# If our trash directory contains shell metacharacters, they will be
+# interpreted if we just set $EDITOR directly, so do a little dance with
+# environment variables to work around this.
+#
+# In particular, quoting isn't enough, as the path may contain the same quote
+# that we're using. 
+test_set_editor () {
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
1.5.5.33.gc0a39.dirty

From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 12/14] am: add t4255 for submodule updates
Date: Sun, 15 Jun 2014 19:03:53 +0200
Message-ID: <539DD1F9.7030005@web.de>
References: <539DD029.4030506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 19:04:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwDqk-0005F2-Vo
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 19:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbaFOREH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 13:04:07 -0400
Received: from mout.web.de ([212.227.15.14]:49831 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632AbaFOREF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 13:04:05 -0400
Received: from [192.168.178.41] ([84.132.144.103]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lvjn6-1WfXvS1tTY-017RcU; Sun, 15 Jun 2014 19:03:54
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD029.4030506@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:oRdVDOU14PrxkYxsk/gMF82h/JxHbWnjq63vQjt8PyEuSW6jffX
 SCu0A5Ux6QWXiRnrRMsNRu5DOhdFsOiTe7rvzM77BUoA5Zp5njJ9obqtVwcw/J1aqOx7W90
 nib2JgU+SFfLLMH/r74dBLjjb+cm1XWZt77S++RGT9zPli1fVvtYTTMPCb1wPluuVAzYJak
 gAqmtatbtJ+yFzQvAkk5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251694>

Test that the am command updates the work tree as expected (for submodule
changes which don't result in conflicts). To make that work add two
helper functions that use format-patch to create the input for am.

Add the KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES
switch to expect the known failure that --no-ff merges attempt to merge
the new files in the former submodule directory with those of the removed
submodule.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/t4255-am-submodule.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 t/t4255-am-submodule.sh

diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
new file mode 100755
index 0000000..8bde7db
--- /dev/null
+++ b/t/t4255-am-submodule.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+test_description='git am handling submodules'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-submodule-update.sh
+
+am () {
+	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am -
+}
+
+test_submodule_switch "am"
+
+am_3way () {
+	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am --3way -
+}
+
+KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
+test_submodule_switch "am_3way"
+
+test_done
-- 
2.0.0.275.gc479268

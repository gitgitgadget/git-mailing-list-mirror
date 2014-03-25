From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC/PATCH 4/4] apply: add t4137 for submodule updates
Date: Tue, 25 Mar 2014 18:06:01 +0100
Message-ID: <5331B779.3050306@web.de>
References: <5331B6F6.60501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 18:06:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSUnk-0002CH-ET
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 18:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197AbaCYRGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 13:06:06 -0400
Received: from mout.web.de ([212.227.15.14]:49291 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779AbaCYRGE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 13:06:04 -0400
Received: from [192.168.178.41] ([84.132.146.250]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lx7Mz-1X7uC30loX-016iQZ; Tue, 25 Mar 2014 18:06:02
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5331B6F6.60501@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:a1TxpVdmHKALoRtYnhGeinKz+MdY1+X8yj0miVSNMgQn6X4IaQC
 cP7tJu6XBgh3EPzZzVv3sZwMtE3MrH076hNqRCfYBBTGdc0y1Xd63vkxi7gJvY3bThGhlXw
 8rJWFx9/bibNk8dd121AntLsnZ22lIW2S+f+BfPDBJdD+9EPTrwN6pz8qda6tm7FL1xk8MZ
 5JAeZj48MuB8wi3mBFdFQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245049>

Test that the apply command updates the work tree as expected for the
'--index' and the '--3way' options (for submodule changes which don't
result in conflicts).

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

And this shows how to use the new framework when more than a single command
is needed to switch to a new work tree.

 t/t4137-apply-submodule.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100755 t/t4137-apply-submodule.sh

diff --git a/t/t4137-apply-submodule.sh b/t/t4137-apply-submodule.sh
new file mode 100755
index 0000000..f0a0500
--- /dev/null
+++ b/t/t4137-apply-submodule.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+test_description='git am handling submodules'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-submodule-update.sh
+
+apply_index () {
+    git diff --ignore-submodules=dirty "..$1" | git apply --index -
+}
+
+test_submodule_switch "apply_index"
+
+apply_3way () {
+    git diff --ignore-submodules=dirty "..$1" | git apply --3way -
+}
+
+test_submodule_switch "apply_3way"
+
+test_done
-- 
1.9.1.327.g3d8d896

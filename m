From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 03/21] t/test-lib-functions.sh: generalize test_cmp_rev
Date: Sun, 10 Apr 2016 15:18:56 +0200
Message-ID: <1460294354-7031-4-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:20:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFHi-0008VL-0O
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbcDJNUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:20:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:52936 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbcDJNUF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:05 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MQ7sF-1atLsS2BWt-005ECP; Sun, 10 Apr 2016 15:19:59
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:mYItI0Sr3Gj45x22H0Xh8s5xKKn7KIKsJt+ZbdyaYGXRL0ph2M3
 J/O2EI64btjpUubMIH1Zt3fTfc86qKMys85y1Py0zttqAhWy4W+8YWoRyMyZ4X6MyxyIpL1
 UedYqx8jDqIhmo5bZTWWpSewi2xaM/EA+i8bMttDsgh6sskJpy1odgIrasGBOnKG56A7Obv
 PVnd+poAjwHsYUkoN9qXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V8SRivU6NCE=:2kO/pfrQfyaplij2x0iiZh
 Aoknb/UoId817d+f1XFPhwaV39fkSbmEwZcz552Of3lxlPlKwzqycr/TySDRBhQblY+O6diU8
 Pq/VT7nw2G3ugER5P/J/+hY2ludm2yazVGSnczn6KqKYiwSw+D0v4ZxPHpp+CREwvVNX7K2++
 K/JFID6bcUGp7b9tlZl7cjJf6ftJJVvnAUeUXnKXugFyK8O+JvqZeZ/aAJu7Fs36UynhTxDWB
 NJSIQTxr9pzVcNW35qVKj675xxg0W4ahVE6/AvbwjBJzozCB5AN/ye+u20NNRoRjcPsb998h5
 62Kp7akPAZgv4E8wf0Exg0N6Ov9ZPoGpLdU7s49vaTgHS0JrbFXX50X3pMSleNnc4kiNQEXdV
 n3Q+Icv2RljCxkoa7eLqAJW7P5JYZOXWzyVaQ0H2HP0eTelaqnTxx9NORt6ELZAMyKeanS9Q6
 KYdD5w7IvOgEe74UjX/CnNeicuz21g4cPzQ7XOp5tADq/7oemycUzNeNMdHLgifO5Jl5cDb0/
 OPd6moaDINZ+B56a6FlSYbTGfCX3AGlES+LVz6zcHnatlu7jKCPOm7xQLP+17PXqxP+ZrnH0V
 QwHDk2HSpaM4vo93mOjFW4qC/3uXqtkrbxmTAdgcfKn8VjcTkRMISDWZTH3uJNVjyjvo+Ld9i
 liZJdQSb1rd4TFZTK3GWmwlxGQe4tu9gbGxLKrxss78GPoWhht0peUBDlP/vAMHrOIAQNqZlh
 ecoGbe5sDfEnC8uQhzM3yIV9ECJV3mMgBYvp1Sv8dUi+XraI8nPMqnSgK7M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291148>

test_cmp_rev() took exactly two parameters, the expected revision
and the revision to test. This commit generalizes this function
such that it takes any number of at least two revisions: the
expected one and a list of actual ones. The function returns true
if and only if at least one actual revision coincides with the
expected revision.

While at it, the side effect of generating two (temporary) files
is removed.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 t/test-lib-functions.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8d99eb3..8caf59c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -711,11 +711,17 @@ test_must_be_empty () {
 	fi
 }
 
-# Tests that its two parameters refer to the same revision
+# Tests that the first parameter refers to the same revision
+# of at least one other parameter
 test_cmp_rev () {
-	git rev-parse --verify "$1" >expect.rev &&
-	git rev-parse --verify "$2" >actual.rev &&
-	test_cmp expect.rev actual.rev
+	hash1="$(git rev-parse --verify "$1")" || return
+	shift
+	for rev
+	do
+		hash2="$(git rev-parse --verify "$rev")" || return
+		test "$hash1" = "$hash2" && return 0
+	done
+	return 1
 }
 
 # Print a sequence of numbers or letters in increasing order.  This is
-- 
2.8.1.137.g522756c

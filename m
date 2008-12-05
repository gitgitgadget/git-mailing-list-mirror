From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] git-am: propagate --3way options as well
Date: Thu,  4 Dec 2008 18:22:59 -0800
Message-ID: <1228443780-3386-4-git-send-email-gitster@pobox.com>
References: <1228443780-3386-1-git-send-email-gitster@pobox.com>
 <1228443780-3386-2-git-send-email-gitster@pobox.com>
 <1228443780-3386-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 03:24:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8QN2-0002VO-UD
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 03:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911AbYLECXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 21:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbYLECXS
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 21:23:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbYLECXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 21:23:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 70539846D9
	for <git@vger.kernel.org>; Thu,  4 Dec 2008 21:23:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D1D78846D8 for
 <git@vger.kernel.org>; Thu,  4 Dec 2008 21:23:15 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.60.g1d1d7
In-Reply-To: <1228443780-3386-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: ACA4B642-C273-11DD-BBB0-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102392>

The reasoning is the same as the previous patch, where we made -C<n>
and -p<n> propagate across a failure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index ed54e71..13c02d6 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -247,10 +247,11 @@ else
 		exit 1
 	}
 
-	# -s, -u, -k, --whitespace, -C and -p flags are kept
+	# -s, -u, -k, --whitespace, -3, -C and -p flags are kept
 	# for the resuming session after a patch failure.
-	# -3 and -i can and must be given when resuming.
+	# -i can and must be given when resuming.
 	echo " $git_apply_opt" >"$dotest/apply_opt_extra"
+	echo "$threeway" >"$dotest/threeway"
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
 	echo "$keep" >"$dotest/keep"
@@ -283,6 +284,10 @@ if test "$(cat "$dotest/keep")" = t
 then
 	keep=-k
 fi
+if test "$(cat "$dotest/threeway")" = t
+then
+	threeway=t
+fi
 git_apply_opt=$(cat "$dotest/apply_opt_extra")
 if test "$(cat "$dotest/sign")" = t
 then
-- 
1.6.1.rc1.60.g1d1d7

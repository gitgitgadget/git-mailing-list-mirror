From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] git-repack: resist stray environment variable
Date: Sat, 28 Feb 2009 01:15:06 -0800
Message-ID: <2478dc84b5fb2617bfab3a8f65f1270de578b94a.1235812035.git.gitster@pobox.com>
References: <cover.1235812035.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 10:17:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdLK5-0001wI-8i
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 10:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755743AbZB1JP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 04:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbZB1JPZ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 04:15:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42088 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814AbZB1JPW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 04:15:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8ED479D468
	for <git@vger.kernel.org>; Sat, 28 Feb 2009 04:15:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 223AE9D467 for
 <git@vger.kernel.org>; Sat, 28 Feb 2009 04:15:19 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2.99.g9f3bb
In-Reply-To: <cover.1235812035.git.gitster@pobox.com>
X-Pobox-Relay-ID: 5279D2A4-0578-11DE-AA38-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111759>

The script used $args and $existing without initializing it to empty.  It
would have been confused by an environment variable the end user had
before running it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-repack.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 458a497..8600015 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -60,6 +60,7 @@ case ",$all_into_one," in
 	args='--unpacked --incremental'
 	;;
 ,t,)
+	args= existing=
 	if [ -d "$PACKDIR" ]; then
 		for e in `cd "$PACKDIR" && find . -type f -name '*.pack' \
 			| sed -e 's/^\.\///' -e 's/\.pack$//'`
-- 
1.6.2.rc2.99.g9f3bb

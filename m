From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t3600: Avoid "cp -a" which is a GNUism
Date: Tue, 18 Dec 2012 18:55:11 -0800
Message-ID: <7vtxrida40.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 03:55:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl9oo-0004ij-L3
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 03:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab2LSCzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 21:55:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752924Ab2LSCzN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 21:55:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7194AAAD7;
	Tue, 18 Dec 2012 21:55:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=R
	qGo+ylyDgH/sh12d6PkDYDiiT8=; b=MXCPp6qCb2fXIQC43UEnK9aYjIjwsJpR4
	Tj8kWK5zS7gV0LUmEZYzPWKMJESzZAXIQGiCngAAJUTB3+r/zRq1r/dhJmaMJOAH
	gMJxguKnsL0c9nxCbrWJNKI9ThCDDw24njLI/MElA65nCpqxUmdwHQOBZP1bKVve
	3f/iVHQtqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=gdG
	8rxXC80y8xZiKgSe7gXiBAvwrCjTEkjvxThyHss7isF6KezSetnQmHTvN2+t52M+
	pOelisilC+z/qvbvWO+Q2YWZDBRtW+pGi+gHNNkAwKxUzmIUuK4jxQULldcpMvmN
	oRTCpyPS7QRng0h+7zg0FH2kbwDftBfieD0SDt9U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F3BDAAD6;
	Tue, 18 Dec 2012 21:55:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B229CAAD5; Tue, 18 Dec 2012
 21:55:12 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82245338-4987-11E2-8A01-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211800>

With d4a7ffa (tests: "cp -a" is a GNUism, 2012-10-08), we got rid of
most of them, but a topic that was still in flight was missed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3600-rm.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 97254e8..324924e 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -457,7 +457,7 @@ test_expect_success 'rm of a conflicted populated submodule with a .git director
 	git submodule update &&
 	(cd submod &&
 		rm .git &&
-		cp -a ../.git/modules/sub .git &&
+		cp -R ../.git/modules/sub .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
 	test_must_fail git merge conflict2 &&
@@ -491,7 +491,7 @@ test_expect_success 'rm of a populated submodule with a .git directory fails eve
 	git submodule update &&
 	(cd submod &&
 		rm .git &&
-		cp -a ../.git/modules/sub .git &&
+		cp -R ../.git/modules/sub .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
 	test_must_fail git rm submod &&
@@ -589,7 +589,7 @@ test_expect_success 'rm of a populated nested submodule with a nested .git direc
 	git submodule update --recursive &&
 	(cd submod/subsubmod &&
 		rm .git &&
-		cp -a ../../.git/modules/sub/modules/sub .git &&
+		cp -R ../../.git/modules/sub/modules/sub .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
 	test_must_fail git rm submod &&
-- 
1.8.1.rc2.196.g90926c8

From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] git-bisect: use update-ref to mark good/bad commits
Date: Thu, 15 Nov 2007 01:01:29 -0800
Message-ID: <7vk5oj6fx2.fsf@gitster.siamese.dyndns.org>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 10:02:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isaby-0004sV-9Q
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 10:02:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757045AbXKOJBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 04:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757084AbXKOJBf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 04:01:35 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59522 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757026AbXKOJBe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 04:01:34 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C1CEA2EF;
	Thu, 15 Nov 2007 04:01:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5787394AEE;
	Thu, 15 Nov 2007 04:01:53 -0500 (EST)
In-Reply-To: <20071115081807.06fe092b.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 15 Nov 2007 08:18:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65094>

This removes the last instance of making a ref by hand with
"echo SHA1 >.git/refs/$refname" from the script and replaces it
with update-ref.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-bisect.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 3a21033..4b74a7b 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -130,7 +130,7 @@ bisect_write() {
 		good|skip)	tag="$state"-"$rev" ;;
 		*)		die "Bad bisect_write argument: $state" ;;
 	esac
-	echo "$rev" >"$GIT_DIR/refs/bisect/$tag"
+	git update-ref "refs/bisect/$tag" "$rev"
 	echo "# $state: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
 	test -z "$nolog" && echo "git-bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
 }
-- 
1.5.3.5.1780.gca2b

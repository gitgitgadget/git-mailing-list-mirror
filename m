From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] t4200: fix rerere test
Date: Sun, 22 Jun 2008 02:48:04 -0700
Message-ID: <7v7ichol63.fsf@gitster.siamese.dyndns.org>
References: <20080616110113.GA22945@elte.hu>
 <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu>
 <7vskvd9kai.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sun Jun 22 11:49:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAMCB-0006KK-Fg
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 11:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbYFVJsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 05:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbYFVJsM
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 05:48:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbYFVJsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 05:48:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A041A422;
	Sun, 22 Jun 2008 05:48:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3EA5CA420; Sun, 22 Jun 2008 05:48:06 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 52B93794-4040-11DD-9D15-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85760>

The test used "diff-files -q" which is not about reporting if there is
a difference at all.  Instead, make sure that the path remains as
conflicting in the index after rerere autoresolves it, as we will be
adding rerere.autoupdate configuration with the next patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4200-rerere.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 85d7e3e..afb3e3d 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -193,9 +193,9 @@ test_expect_success 'resolution was recorded properly' '
 	echo Bello > file3 &&
 	git add file3 &&
 	git commit -m version2 &&
-	! git merge fifth &&
-	git diff-files -q &&
-	test Cello = "$(cat file3)"
+	test_must_fail git merge fifth &&
+	test Cello = "$(cat file3)" &&
+	test 0 != $(git ls-files -u | wc -l)
 '
 
 test_done
-- 
1.5.6.12.g73f03

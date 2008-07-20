From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refresh-index: fix bitmask assignment
Date: Sun, 20 Jul 2008 00:28:16 -0700
Message-ID: <7v3am5f20f.fsf@gitster.siamese.dyndns.org>
References: <7vtzelf4mf.fsf@gitster.siamese.dyndns.org>
 <7vk5fhf35p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 09:29:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKTMI-0001k5-5T
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 09:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbYGTH2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 03:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbYGTH2b
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 03:28:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbYGTH2b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 03:28:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3E8AE2D9ED;
	Sun, 20 Jul 2008 03:28:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 91AF02D9EC; Sun, 20 Jul 2008 03:28:25 -0400 (EDT)
In-Reply-To: <7vk5fhf35p.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 20 Jul 2008 00:03:30 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 71B8C418-562D-11DD-BB13-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89168>

Junio C Hamano <gitster@pobox.com> writes:

> This hopefully protects the previous fix (and other --refresh related
> options) from future  breakages.
>
> I'll squash it in to the previous one.

Actually, I'll squash this further on top, for a reason that will become
clear with the next series...

---
 t/t2103-update-index-ignore-missing.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t2103-update-index-ignore-missing.sh b/t/t2103-update-index-ignore-missing.sh
index 332694e..4fbf855 100755
--- a/t/t2103-update-index-ignore-missing.sh
+++ b/t/t2103-update-index-ignore-missing.sh
@@ -62,10 +62,9 @@ test_expect_success '--unmerged --refresh' '
 	test_must_fail git update-index --refresh &&
 	git update-index --unmerged --refresh &&
 	echo 2 >two &&
+	echo "two: needs update" >expect &&
 	test_must_fail git update-index --unmerged --refresh >actual &&
-	grep two actual &&
-	! grep one actual &&
-	! grep three actual
+	test_cmp expect actual
 '
 
 test_expect_success '--ignore-submodules --refresh (1)' '

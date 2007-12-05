From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cosmetic git-am interactive bug
Date: Tue, 04 Dec 2007 23:01:30 -0800
Message-ID: <7v8x491v79.fsf@gitster.siamese.dyndns.org>
References: <4755A836.1050408@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Wed Dec 05 08:02:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzoGe-0000Bi-TX
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 08:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbXLEHBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 02:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbXLEHBf
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 02:01:35 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47482 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXLEHBe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 02:01:34 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 59BDE2F2;
	Wed,  5 Dec 2007 02:01:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E1DFB99FF2;
	Wed,  5 Dec 2007 02:01:53 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67115>

Jeff Garzik <jeff@garzik.org> writes:

> The use of the older one-line summary led me to believe that it had
> not committed my changelog edits.  Looking at the result, however,
> proved that the commit changelog was my new, corrected version.

I knew about this for quite some time but it was a very low priority for
me.  This should fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

diff --git a/git-am.sh b/git-am.sh
index 2e40708..339d863 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -117,6 +117,10 @@ It does not apply to blobs recorded in its index."
     unset GITHEAD_$his_tree
 }
 
+reread_subject () {
+	git stripspace <"$1" | sed -e 1q
+}
+
 prec=4
 dotest=.dotest sign= utf8=t keep= skip= interactive= resolved= binary=
 resolvemsg= resume=
@@ -376,6 +380,7 @@ do
 		[aA]*) action=yes interactive= ;;
 		[nN]*) action=skip ;;
 		[eE]*) git_editor "$dotest/final-commit"
+		       SUBJECT=$(reread_subject "$dotest/final-commit")
 		       action=again ;;
 		[vV]*) action=again
 		       LESS=-S ${PAGER:-less} "$dotest/patch" ;;

From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] rebase: make the warning more useful when the work tree is unclean.
Date: Tue, 02 Oct 2007 22:30:12 -0700
Message-ID: <7vejgchijf.fsf_-_@gitster.siamese.dyndns.org>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
	<7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
	<7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
	<7v3awunjup.fsf@gitster.siamese.dyndns.org>
	<49137EAF-BB73-40DC-973C-E60C14B3FA7F@zib.de>
	<vpq641qroae.fsf@bauges.imag.fr>
	<7vlkamm16s.fsf@gitster.siamese.dyndns.org>
	<vpqr6keos6e.fsf@bauges.imag.fr>
	<7vd4vxmmxr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Oct 03 07:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcwoZ-0003d2-JL
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 07:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756313AbXJCFaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 01:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755785AbXJCFaV
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 01:30:21 -0400
Received: from rune.pobox.com ([208.210.124.79]:36627 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796AbXJCFaT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 01:30:19 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 52813140A9C;
	Wed,  3 Oct 2007 01:30:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9EB11140A82;
	Wed,  3 Oct 2007 01:30:36 -0400 (EDT)
In-Reply-To: <7vd4vxmmxr.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 02 Oct 2007 10:44:00 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59788>

Instead of letting "update-index --refresh" report paths needing
updates and merges, use git-status to give more useful output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I won't be a good judge of the updated behaviour, as I never
   start rebase in an unclear tree.  Running git-status in a
   large tree may be too expensive to be worth changing the
   output.

 git-rebase.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 1583402..93e3b3c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -254,7 +254,11 @@ else
 fi
 
 # The tree must be really really clean.
-git update-index --refresh || exit
+git update-index -q --refresh || {
+	git status
+	printf "cannot rebase: the work tree is not clean.\n"
+	exit 1
+}
 diff=$(git diff-index --cached --name-status -r HEAD)
 case "$diff" in
 ?*)	echo "cannot rebase: your index is not up-to-date"
-- 
1.5.3.3.1144.gf10f2

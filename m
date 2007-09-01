From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] rebase--interactive: do not use one-or-more (\+) in sed.
Date: Sat, 01 Sep 2007 02:05:22 -0700
Message-ID: <7vejhiu565.fsf_-_@gitster.siamese.dyndns.org>
References: <200709010925.27926.johannes.sixt@telecom.at>
	<7vmyw6u5ca.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Sep 01 11:05:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IROv5-0003xk-0Y
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 11:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbXIAJF1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 05:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbXIAJF1
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 05:05:27 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:50388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbXIAJF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 05:05:27 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 492D212C34B;
	Sat,  1 Sep 2007 05:05:46 -0400 (EDT)
In-Reply-To: <7vmyw6u5ca.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 01 Sep 2007 02:01:41 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57261>

This is a continuation of the other one to avoid one-or-more operator
in sed.  At the same time, it actually tightens error checking,
because the numbers in the squash messages are not padded with
leading zero and cannot begin with 0.

With this, I think we do not have any more use of one-or-more
(\+) in sed scripts.

---

 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ec798a1..abc2b1c 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -190,7 +190,7 @@ nth_string () {
 
 make_squash_message () {
 	if test -f "$SQUASH_MSG"; then
-		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([0-9]\+\).*/\1/p" \
+		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p" \
 			< "$SQUASH_MSG" | tail -n 1)+1))
 		echo "# This is a combination of $COUNT commits."
 		sed -n "2,\$p" < "$SQUASH_MSG"

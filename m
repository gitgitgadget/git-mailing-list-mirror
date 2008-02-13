From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug] git-status shows bad instructions prior to first commit
Date: Wed, 13 Feb 2008 14:02:20 -0800
Message-ID: <7vodako6qb.fsf@gitster.siamese.dyndns.org>
References: <F1B5775C-1C11-4C30-B72E-9EB4076613A5@gmail.com>
 <7vzlu66f5g.fsf@gitster.siamese.dyndns.org>
 <20080212054518.GA24817@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rhodes, Kate" <masukomi@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 13 23:03:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPPhO-0005oC-Dw
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 23:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935026AbYBMWCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 17:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934519AbYBMWCv
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 17:02:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933016AbYBMWCt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 17:02:49 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ABF23B0D;
	Wed, 13 Feb 2008 17:02:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 600E53B0C; Wed, 13 Feb 2008 17:02:38 -0500 (EST)
In-Reply-To: <20080212054518.GA24817@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 12 Feb 2008 00:45:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73820>

Jeff King <peff@peff.net> writes:

> status: suggest "git rm --cached" to unstage for initial commit
>
> It makes no sense to suggest "git reset HEAD" since we have
> no HEAD commit. This actually used to work but regressed in
> f26a0012.

In order to avoid regressing again, we must have something like
this included in your change, which I squashed in.

This goes to 'maint'.  Thanks for the fix.

 t/t7502-status.sh |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index 9ce50ca..b64ce30 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -17,6 +17,9 @@ test_expect_success 'setup' '
 	: > dir1/tracked &&
 	: > dir1/modified &&
 	git add . &&
+
+	git status >output &&
+
 	test_tick &&
 	git commit -m initial &&
 	: > untracked &&
@@ -28,6 +31,12 @@ test_expect_success 'setup' '
 	git add dir2/added
 '
 
+test_expect_success 'status (1)' '
+
+	grep -e "use \"git rm --cached <file>\.\.\.\" to unstage" output
+
+'
+
 cat > expect << \EOF
 # On branch master
 # Changes to be committed:
@@ -51,7 +60,7 @@ cat > expect << \EOF
 #	untracked
 EOF
 
-test_expect_success 'status' '
+test_expect_success 'status (2)' '
 
 	git status > output &&
 	git diff expect output

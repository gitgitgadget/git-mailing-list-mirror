From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 1/2] checkout: Add test for diff.ignoreSubmodules
Date: Sat, 28 Aug 2010 16:49:25 +0200
Message-ID: <4C7921F5.1050701@web.de>
References: <alpine.DEB.1.00.1008251225200.4020@intel-tinevez-2-302> <4C755778.7010306@web.de> <7vlj7uqwr6.fsf@alter.siamese.dyndns.org> <4C7591D7.9050508@web.de> <4C7921BD.7030600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 16:49:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpMiz-0003M2-QE
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 16:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869Ab0H1Ot1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 10:49:27 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:54102 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab0H1Ot0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 10:49:26 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 88F3215E4273B;
	Sat, 28 Aug 2010 16:49:25 +0200 (CEST)
Received: from [93.240.119.11] (helo=[192.168.178.29])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OpMij-00087S-00; Sat, 28 Aug 2010 16:49:25 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <4C7921BD.7030600@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/sdHvDC9nrjOENclndZPvC3VX5cuttZPyBRoKc
	vVSK0B66lf8h5qCgA0rD4YZeyJM6+ZddzQpdxuRGUjhYFrkOkg
	tpSooACo0EMBSLdyRD/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154645>

While at it, document that checkout uses this flag too in the Documentation.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/config.txt      |    3 ++-
 t/t2013-checkout-submodule.sh |    7 +++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0510ac7..cda6721 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -829,7 +829,8 @@ diff.renames::
 diff.ignoreSubmodules::
 	Sets the default value of --ignore-submodules. Note that this
 	affects only 'git diff' Porcelain, and not lower level 'diff'
-	commands such as 'git diff-files'.
+	commands such as 'git diff-files'. 'git checkout' also honors
+	this setting when reporting uncommitted changes.

 diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index fda3f0a..3beb0b3 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -39,4 +39,11 @@ test_expect_success '"checkout <submodule>" updates the index only' '
 	git diff-files --quiet
 '

+test_expect_success '"checkout <submodule>" honors diff.ignoreSubmodules' '
+	git config diff.ignoreSubmodules dirty &&
+	echo x> submodule/untracked &&
+	git checkout HEAD >actual 2>&1 &&
+	! test -s actual
+'
+
 test_done
-- 
1.7.2.2.515.g13860

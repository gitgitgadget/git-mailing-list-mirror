From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/8] checkout: check for "Previous HEAD" notice in t2020
Date: Sat, 01 Oct 2011 17:38:34 +0200
Message-ID: <4E8733FA.6070201@lsrfire.ath.cx>
References: <4DF6A8B6.9030301@op5.se> <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk> <4E84B89F.4060304@lsrfire.ath.cx> <201109291411.06733.mfick@codeaurora.org> <4E8587E8.9070606@lsrfire.ath.cx> <7vfwjeotv1.fsf@alter.siamese.dyndns.org> <4E8607B6.2040800@lsrfire.ath.cx> <4E8731AF.2040305@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Oct 01 17:38:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA1eT-0001Uy-HH
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 17:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643Ab1JAPit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 11:38:49 -0400
Received: from india601.server4you.de ([85.25.151.105]:55610 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435Ab1JAPis (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 11:38:48 -0400
Received: from [192.168.2.104] (p4FFDAD66.dip.t-dialin.net [79.253.173.102])
	by india601.server4you.de (Postfix) with ESMTPSA id 3EA3D2F803A;
	Sat,  1 Oct 2011 17:38:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <4E8731AF.2040305@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182556>

If we leave a detached head, exactly one of two things happens: either
checkout warns about it being an orphan or describes it as a courtesy.
Test t2020 already checked that the warning is shown as needed.  This
patch also checks for the description.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t2020-checkout-detach.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 2366f0f..068fba4 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -12,11 +12,14 @@ check_not_detached () {
 }
 
 ORPHAN_WARNING='you are leaving .* commit.*behind'
+PREV_HEAD_DESC='Previous HEAD position was'
 check_orphan_warning() {
-	test_i18ngrep "$ORPHAN_WARNING" "$1"
+	test_i18ngrep "$ORPHAN_WARNING" "$1" &&
+	test_i18ngrep ! "$PREV_HEAD_DESC" "$1"
 }
 check_no_orphan_warning() {
-	test_i18ngrep ! "$ORPHAN_WARNING" "$1"
+	test_i18ngrep ! "$ORPHAN_WARNING" "$1" &&
+	test_i18ngrep "$PREV_HEAD_DESC" "$1"
 }
 
 reset () {
-- 
1.7.7

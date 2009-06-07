From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 1/2] add a test case for threaded mails without chain-reply-to
Date: Sun,  7 Jun 2009 17:20:18 +0200
Message-ID: <1244388019-12763-1-git-send-email-markus.heidelberg@web.de>
References: <200906061414.27371.markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 17:20:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDKAs-0003iV-2a
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 17:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029AbZFGPUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 11:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754867AbZFGPUa
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 11:20:30 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:57063 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692AbZFGPU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 11:20:29 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7D8F0104B039C;
	Sun,  7 Jun 2009 17:20:31 +0200 (CEST)
Received: from [89.59.87.118] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDKAh-0001nD-00; Sun, 07 Jun 2009 17:20:31 +0200
X-Mailer: git-send-email 1.6.3.2.216.g24c61
In-Reply-To: <200906061414.27371.markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18TRoKCrIpvxrt3Uw/ohn+/xujaZFxkMAuLO97Q
	Ov1xCedAzIkcfMEXY+eYJkeZnfgKatR2+Gc7QN8sDnO09i7Rdm
	8ItnEU8WG57t+aO2E2qQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120977>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

> Markus Heidelberg, 06.06.2009:
> > Markus Heidelberg (4):
> >   Don't count the submenu entries for checking if it is empty
> >   Correctly count the entries in the revs context menu
> >   Avoid submenus with merely 1 entry
> >   Create a separate submenu for tags
> 
> Hmm, no In-Reply-To in 1..4/4
> 
> I think I managed to do this earlier with just
>   $ git format-patch -4 -s
>   $ git send-email 000*
> 
> But not even
>   $ git send-email --thread 000*
> seems to work.
> 
> Only 
>   $ git format-patch -4 -s --thread
>   $ git send-email 000*

Indeed a regression.

 t/t9001-send-email.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index ce26ea4..576bbd3 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -621,4 +621,15 @@ test_expect_success 'in-reply-to but no threading' '
 	grep "In-Reply-To: <in-reply-id@example.com>"
 '
 
+test_expect_failure 'threading but no chain-reply-to' '
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--thread \
+		--no-chain-reply-to \
+		$patches $patches |
+	grep "In-Reply-To: "
+'
+
 test_done
-- 
1.6.3.2.216.g24c61

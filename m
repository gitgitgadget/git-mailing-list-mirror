From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/2] t5004: ignore pax global header file
Date: Thu, 09 May 2013 15:10:48 +0200
Message-ID: <518BA058.6050300@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 09 15:11:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaQcn-0008QW-Vz
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 15:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab3EINKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 09:10:53 -0400
Received: from india601.server4you.de ([85.25.151.105]:51316 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab3EINKw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 09:10:52 -0400
Received: from [192.168.2.105] (p4FFD9FB6.dip0.t-ipconnect.de [79.253.159.182])
	by india601.server4you.de (Postfix) with ESMTPSA id 7CB2C4B9;
	Thu,  9 May 2013 15:10:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223729>

Versions of tar that don't know pax headers -- like the ones in NetBSD 6
and OpenBSD 5.2 -- extract them as regular files.  Explicitly ignore the
file created for our global header when checking the list of extracted
files, as this is normal and harmless fall-back behaviour.  This fixes
test 3 of t5004 on these platforms.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Fixes a failure of a test added after v1.8.2.

 t/t5004-archive-corner-cases.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index bfdb56a..ddf6e35 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -23,7 +23,7 @@ check_dir() {
 			echo "$dir/$i"
 		done
 	} | sort >expect &&
-	find "$dir" -print | sort >actual &&
+	find "$dir" ! -name pax_global_header -print | sort >actual &&
 	test_cmp expect actual
 }
 
-- 
1.8.2.1

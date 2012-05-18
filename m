From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] archive-tar: keep const in checksum calculation
Date: Fri, 18 May 2012 07:18:11 +0200
Message-ID: <4FB5DB93.9000904@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 18 07:18:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVFZx-0000qs-1c
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 07:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760107Ab2ERFSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 01:18:12 -0400
Received: from india601.server4you.de ([85.25.151.105]:60861 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759216Ab2ERFSM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 01:18:12 -0400
Received: from [192.168.2.105] (p4FFD9588.dip.t-dialin.net [79.253.149.136])
	by india601.server4you.de (Postfix) with ESMTPSA id B00992F806F;
	Fri, 18 May 2012 07:18:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197939>

For correctness, don't needlessly drop the const qualifier when casting.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-tar.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 93387ea..dc91c6b 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -139,13 +139,13 @@ static void strbuf_append_ext_header(struct strbuf *sb, const char *keyword,
 
 static unsigned int ustar_header_chksum(const struct ustar_header *header)
 {
-	char *p = (char *)header;
+	const char *p = (const char *)header;
 	unsigned int chksum = 0;
 	while (p < header->chksum)
 		chksum += *p++;
 	chksum += sizeof(header->chksum) * ' ';
 	p += sizeof(header->chksum);
-	while (p < (char *)header + sizeof(struct ustar_header))
+	while (p < (const char *)header + sizeof(struct ustar_header))
 		chksum += *p++;
 	return chksum;
 }
-- 
1.7.10.2

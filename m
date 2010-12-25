From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] close file on error in read_mmfile()
Date: Sat, 25 Dec 2010 13:38:46 +0100
Message-ID: <4D15E5D6.2040800@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 25 13:39:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWTOy-0000ju-Pr
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 13:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab0LYMjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Dec 2010 07:39:07 -0500
Received: from india601.server4you.de ([85.25.151.105]:49962 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab0LYMjG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Dec 2010 07:39:06 -0500
Received: from [10.0.1.102] (p4FFDA3B9.dip.t-dialin.net [79.253.163.185])
	by india601.server4you.de (Postfix) with ESMTPSA id 92BDC2F8046;
	Sat, 25 Dec 2010 13:39:04 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164173>

Reported in http://qa.debian.org/daca/cppcheck/sid/git_1.7.2.3-2.2.html.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 xdiff-interface.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index cd2285d..cd9fa33 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -212,8 +212,10 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 		return error("Could not open %s", filename);
 	sz = xsize_t(st.st_size);
 	ptr->ptr = xmalloc(sz ? sz : 1);
-	if (sz && fread(ptr->ptr, sz, 1, f) != 1)
+	if (sz && fread(ptr->ptr, sz, 1, f) != 1) {
+		fclose(f);
 		return error("Could not read %s", filename);
+	}
 	fclose(f);
 	ptr->size = sz;
 	return 0;
-- 
1.7.3.4

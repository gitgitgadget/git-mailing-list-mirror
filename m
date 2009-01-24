From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: [PATCH v2] Makefile: Use libc strlcpy on OSX >= 10.2
Date: Sat, 24 Jan 2009 20:01:04 +0100
Message-ID: <7f978c810901241101h227c5437p88ca7c9cc54abc9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 24 20:02:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQnm3-0000SQ-HN
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 20:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbZAXTBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 14:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbZAXTBI
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 14:01:08 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:36356 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbZAXTBH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 14:01:07 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1815680fkf.5
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 11:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=v+7ibd8b2Wear1JL6L+TujsdHB4wAwqVteQFR3ZKZ/0=;
        b=bdDvZR0yUcqyBeNFZEVg9ptEm0HY5dt21+hN90ORYI0i9c4zuKbZJwT2CN80kCdQnv
         fvbLpYkezGREMKaCq5/PqsYIFWMTwT6L+KsQIA6MvceUY738eL7w4wzcBwzBdEa2a46D
         lAT8TmXCIZL4XkjURjjavxs5VzwCvVNa5wAXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=RCCbrvyYuomBVNHtzgIUczwSP7viGLOVi9Z/TDpD7sk1m1RMeXwyBirIeE7bRTVnV/
         Bs//RjMaDcL6+1e4avX2AGTCLPqUsV9rDTy8sMG1JX7+mBr2JPsXrAdnvYNlOREAp/Vg
         SiXveS9DJ4Me7Ly9E/LjHmf3Sz529d9dU1fto=
Received: by 10.103.226.10 with SMTP id d10mr2840004mur.84.1232823664563; Sat, 
	24 Jan 2009 11:01:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106991>

OSX supports strlcpy(3) since 10.2 so we don't need
to use our own. This revised also patch checks the darwin
version. 10.0 is darwin v1.3; 10.1 is darwin v1.4.

Signed-off-by: Benjamin Kramer <benny.kra@gmail.com>
---
 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index b4d9cb4..7dd5224 100644
--- a/Makefile
+++ b/Makefile
@@ -643,7 +643,9 @@ ifeq ($(uname_S),Darwin)
 	ifneq ($(shell expr "$(uname_R)" : '9\.'),2)
 		OLD_ICONV = UnfortunatelyYes
 	endif
-	NO_STRLCPY = YesPlease
+	ifeq ($(shell expr "$(uname_R)" : '1\.'),2)
+		NO_STRLCPY = YesPlease
+	endif
 	NO_MEMMEM = YesPlease
 	THREADED_DELTA_SEARCH = YesPlease
 endif
-- 
1.6.1.285.g3454

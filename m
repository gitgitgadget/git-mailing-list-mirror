From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 4/4] Cygwin 1.7 supports mmap
Date: Fri, 19 Jul 2013 19:08:30 -0400
Message-ID: <1374275310-22388-4-git-send-email-mlevedahl@gmail.com>
References: <51E9C69F.7080309@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 20 01:08:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Jn8-0004g2-Eh
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 01:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112Ab3GSXIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 19:08:42 -0400
Received: from mail-qa0-f52.google.com ([209.85.216.52]:59802 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab3GSXIk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 19:08:40 -0400
Received: by mail-qa0-f52.google.com with SMTP id hv16so184985qab.4
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 16:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SpxnGERfW6heEpwc2fx4LCAtD4NpONo2qVqEp/+8C5I=;
        b=avcxmHKgFXWELafmqazP6mHhmNpDfspTuRderghDGBLVX7cArroCWWLkOBU7AIlXgO
         Sz/8mDR8nyFf2ERnoMuiF0qDYnsjvCaqfZi/MpZR+o4g0Zd8IaNiWvVr4fAXdGHX5Vgz
         TDD4Mwr1TY4PfA4LgezYYjmWP+fKVkXXnY3odjopUZ5sZrfVt3qL6l8DafS3z0ZIHQXD
         m68wrULPVyxiuAUXpkqM0b3yGGTh13CWAei9kl41E1U16F8Cm8qDqODI76iURxZChFlq
         htjrh+rBRpVV7iVBXbIIqaOJ99AQ6dQmL4A7kV9+VJ19x1BZY0gMZ06S0vY+HaKKC2Np
         fVBA==
X-Received: by 10.224.166.6 with SMTP id k6mr20405314qay.39.1374275319989;
        Fri, 19 Jul 2013 16:08:39 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id s9sm22498999qeo.3.2013.07.19.16.08.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 16:08:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.0.13
In-Reply-To: <51E9C69F.7080309@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230862>

git has shipped for years with MMAP enabled in the stock distribution,
there are no reports of problems / failures on the list relating to
this. Leave the default as-is on v1.5 due to lack of knowlege of this
working on earlier Cygwin.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 config.mak.uname | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 048c252..32e8332 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -161,16 +161,16 @@ ifeq ($(uname_O),Cygwin)
 		NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
 		OLD_ICONV = UnfortunatelyYes
 		NO_THREAD_SAFE_PREAD = YesPlease
+		# There are conflicting reports about this.
+		# On some boxes NO_MMAP is needed, and not so elsewhere.
+		# Try commenting this out if you suspect MMAP is more efficient
+		NO_MMAP = YesPlease
 	else
 		NO_REGEX = UnfortunatelyYes
 	endif
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
-	# There are conflicting reports about this.
-	# On some boxes NO_MMAP is needed, and not so elsewhere.
-	# Try commenting this out if you suspect MMAP is more efficient
-	NO_MMAP = YesPlease
 	X = .exe
 	COMPAT_OBJS += compat/cygwin.o
 	UNRELIABLE_FSTAT = UnfortunatelyYes
-- 
1.8.3.2.0.13

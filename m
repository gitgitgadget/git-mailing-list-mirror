From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH 2/2] gettext.h: add parentheses around N_ expansion
Date: Tue,  6 Jan 2015 02:34:19 -0800
Message-ID: <f67db70c63f8dcbfc58d7ffda86ff10@74d39fa044aa309eaea14b9f57fe79c>
References: <ecb18f9d6ac56da0a61c3b98f8f2236@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 11:40:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8RTA-0006Pm-Cp
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 11:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbbAFKed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 05:34:33 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:62621 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbbAFKeb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 05:34:31 -0500
Received: by mail-pd0-f179.google.com with SMTP id fp1so30259043pdb.10
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 02:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M9QlcwfwVt/XddskmNL/Hm+FkCxwGPYxYVCimTThAwk=;
        b=xM4ZCllupOaimaOkGG9/tSdI/Fab6sVU42pGYBllF4Vz7lLVOEi+iLk7nwkZQKgdjV
         cl1WPPOgRY3TI8LLZwckge/9RM29XCU5foOf4SakkfjuB5NBeoHt+sm8QKQPlk9toF72
         HfxZ2B5sHMIE/92ZRYVk00Z2OoF9eadSTE5AioD6mLv4P0+us5LQ0oX00w0oFXAEo5rl
         widbB8MvjS3QktjYyNhqOqQKAKfuYR/jrOSZkZQ94pLStFQJ48+idhdmKnvFB8V6hWcO
         hacBG3nWAKp129AaIzB+qkJvBPSCxuj2v8lOEHFByG3VWiGuuupmA1JtoXXbrfaZBc1O
         P+8Q==
X-Received: by 10.68.201.201 with SMTP id kc9mr156138165pbc.79.1420540471378;
        Tue, 06 Jan 2015 02:34:31 -0800 (PST)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id x10sm56985818pas.18.2015.01.06.02.34.30
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 02:34:30 -0800 (PST)
In-Reply-To: <ecb18f9d6ac56da0a61c3b98f8f2236@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262053>

The N_ macro is used to mark strings for translation without
actually translating them.  At runtime the string is expected
to be passed to the gettext API for translation.

If two N_ macro invocations appear next to each other with only
whitespace (or nothing at all) between them, the two separate
strings will be marked for translation, but the preprocessor
will then combine the strings into one and at runtime the
string passed to gettext will not match the strings that were
translated.

Avoid this by adding parentheses around the expansion of the
N_ macro so that instead of ending up with two adjacent strings
that are then combined by the preprocessor, two adjacent strings
surrounded by parentheses result instead which causes a compile
error so the mistake can be quickly found and corrected.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
This patch is optional, but prevents the problem fixed by 1/2
from recurring.

 gettext.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gettext.h b/gettext.h
index 7671d09d..d11a4139 100644
--- a/gettext.h
+++ b/gettext.h
@@ -63,6 +63,6 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
 }
 
 /* Mark msgid for translation but do not translate it. */
-#define N_(msgid) msgid
+#define N_(msgid) (msgid)
 
 #endif
-- 
2.1.4

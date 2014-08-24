From: Benoit Sigoure <tsunanet@gmail.com>
Subject: [PATCH] Undefine strlcpy if needed.
Date: Sat, 23 Aug 2014 21:32:21 -0700
Message-ID: <1408854741-13956-1-git-send-email-tsunanet@gmail.com>
Cc: Benoit Sigoure <tsunanet@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 06:33:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLPV2-0007Iu-5d
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 06:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbaHXEds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 00:33:48 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:49217 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbaHXEds (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 00:33:48 -0400
Received: by mail-qc0-f172.google.com with SMTP id i8so12667878qcq.31
        for <git@vger.kernel.org>; Sat, 23 Aug 2014 21:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4uMk8s30/TOq4Y5U6hFOkmnYQTVbF2n3aLYLwVm0bNk=;
        b=HWjHXRgEaSosRdpAvzRATFDcqSPuYHZq84WJ7jHJF9AxZ0lZZGG9egGTp91WoZJPYj
         eIzVG3pxBDlwtVs/DHqIKcLKFGANOhIJ6CwyIRiq9fq0RZMtgoPTYDZwb4WEA0X+o1dY
         nK2bYoOHPKddDbeAfffUIeWPj/Peqmv0yHt5U4biQQObEpOYyO5fvjvHTzXRZrJMtLRh
         v990QjLXIzAWxDn2KwdarK9GADjds72BAh9nRQFnsMoCNWBg7D1+BAFaWxGsigRm1nV4
         Iye8rXVxWZxhUtGOswXATI0CxRn4MEs/uXHL8MjQ0lXeLKyEa2SPTMCmrBwcH6T9P61G
         B9kg==
X-Received: by 10.229.65.135 with SMTP id j7mr22290597qci.22.1408854825561;
        Sat, 23 Aug 2014 21:33:45 -0700 (PDT)
Received: from magrathea.tsunanet.net (magrathea.tsunanet.net. [142.4.212.106])
        by mx.google.com with ESMTPSA id n3sm70249650qai.14.2014.08.23.21.33.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Aug 2014 21:33:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255777>

On OS X, strlcpy is already #define'd, which causes warnings
in all the files that include `git-compat-util.h'.  Note that
this only occurs when building without running ./configure.
---
 git-compat-util.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index f587749..8c001e2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -495,6 +495,9 @@ extern char *gitstrcasestr(const char *haystack, const char *needle);
 #endif
 
 #ifdef NO_STRLCPY
+#ifdef strlcpy
+#undef strlcpy
+#endif
 #define strlcpy gitstrlcpy
 extern size_t gitstrlcpy(char *, const char *, size_t);
 #endif
-- 
1.9.2.460.gfb82504

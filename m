From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 04/18] revert: Don't check lone argument in get_encoding
Date: Wed, 27 Jul 2011 08:49:01 +0530
Message-ID: <1311736755-24205-5-git-send-email-artagnon@gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 27 05:22:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qluhy-0005xW-Lt
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 05:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001Ab1G0DWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 23:22:36 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35904 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab1G0DWf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 23:22:35 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1938359pzk.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 20:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zH4jtYIMaNijlWLhSnRRUUmjlqcFtudxvRPPc6Q68Zo=;
        b=qEnaUReNVKdhu4VTcm8K6bNa5+y8AdyER4M0DxJ84Ys08XZQHP+j9Rc0NhBJPtzwqd
         GZknP3AQtc4MiDu1XLuhwGIf5VE6SKNXGbZHn5pKmzdwfuOnR1A4HG063aw4UbjB4Lb/
         6irdz90vvyXZb4X7e2Lj/SbvNhDGLSLQKu6QE=
Received: by 10.68.30.195 with SMTP id u3mr10866675pbh.465.1311736955451;
        Tue, 26 Jul 2011 20:22:35 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id p7sm1210706pbn.65.2011.07.26.20.22.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 20:22:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177908>

The get_encoding function has only one callsite, and its caller makes
sure that a NULL argument isn't passed.  Remove a string marked for
translation that will never be shown by not unnecessarily
double-checking the argument.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 7dfe295..30b39c0 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -167,9 +167,6 @@ static char *get_encoding(const char *message)
 {
 	const char *p = message, *eol;
 
-	if (!p)
-		die (_("Could not read commit message of %s"),
-				sha1_to_hex(commit->object.sha1));
 	while (*p && *p != '\n') {
 		for (eol = p + 1; *eol && *eol != '\n'; eol++)
 			; /* do nothing */
-- 
1.7.4.rc1.7.g2cf08.dirty

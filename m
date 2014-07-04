From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 2/5] Don't define away __attribute__ on gcc
Date: Fri,  4 Jul 2014 16:43:49 -0700
Message-ID: <1404517432-25185-3-git-send-email-andi@firstfloor.org>
References: <1404517432-25185-1-git-send-email-andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 01:44:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3DA0-0006Ag-Lq
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jul 2014 01:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760297AbaGDXow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2014 19:44:52 -0400
Received: from one.firstfloor.org ([193.170.194.197]:53373 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760272AbaGDXou (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2014 19:44:50 -0400
Received: from basil.firstfloor.org (184-100-237-164.ptld.qwest.net [184.100.237.164])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 2433D86779;
	Sat,  5 Jul 2014 01:44:48 +0200 (CEST)
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id 2E193A18A2; Fri,  4 Jul 2014 16:43:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1404517432-25185-1-git-send-email-andi@firstfloor.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252906>

From: Andi Kleen <ak@linux.intel.com>

Profile feedback sets -DNO_NORETURN, which causes the compat
header file to go into a default #else block. That #else
block defines away __attribute__(). Doing so causes all
kinds of problems with the Linux and gcc system headers:
in particular it makes the xmmintrin.h headers error out,
breaking the build.

Don't define away __attribute__ when __GNUC__ is set.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 git-compat-util.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 96f5554..01e8695 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -291,10 +291,12 @@ extern char *gitbasename(char *);
 #else
 #define NORETURN
 #define NORETURN_PTR
+#ifndef __GNUC__
 #ifndef __attribute__
 #define __attribute__(x)
 #endif
 #endif
+#endif
 
 /* The sentinel attribute is valid from gcc version 4.0 */
 #if defined(__GNUC__) && (__GNUC__ >= 4)
-- 
2.0.1

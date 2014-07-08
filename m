From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 2/4] Don't define away __attribute__ on gcc
Date: Mon,  7 Jul 2014 23:35:09 -0700
Message-ID: <1404801311-15365-3-git-send-email-andi@firstfloor.org>
References: <1404801311-15365-1-git-send-email-andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 08:35:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4P0F-0005EQ-8d
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 08:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbaGHGfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 02:35:32 -0400
Received: from one.firstfloor.org ([193.170.194.197]:33414 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbaGHGfa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 02:35:30 -0400
Received: from basil.firstfloor.org (184-100-237-164.ptld.qwest.net [184.100.237.164])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 8E7228677B;
	Tue,  8 Jul 2014 08:35:28 +0200 (CEST)
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id 69F61A207A; Mon,  7 Jul 2014 23:35:16 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1404801311-15365-1-git-send-email-andi@firstfloor.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253007>

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

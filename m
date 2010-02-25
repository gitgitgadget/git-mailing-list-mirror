From: Filippo Negroni <fnegroni@flexerasoftware.com>
Subject: [PATCH] Fix gitmkdtemp: correct test for mktemp() return value
Date: Thu, 25 Feb 2010 10:01:31 +0000
Message-ID: <4B864A7B.9000500@flexerasoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 11:02:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkaXk-0004o7-1q
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 11:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692Ab0BYKB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 05:01:56 -0500
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:6167 "EHLO
	TX2EHSOBE010.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390Ab0BYKBz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 05:01:55 -0500
Received: from mail128-tx2-R.bigfish.com (10.9.14.244) by
 TX2EHSOBE010.bigfish.com (10.9.40.30) with Microsoft SMTP Server id
 8.1.240.5; Thu, 25 Feb 2010 10:01:54 +0000
Received: from mail128-tx2 (localhost [127.0.0.1])	by
 mail128-tx2-R.bigfish.com (Postfix) with ESMTP id CEEDB78837D;	Thu, 25 Feb
 2010 10:01:54 +0000 (UTC)
X-SpamScore: 2
X-BigFish: VPS2(zba6lz936eMab9bha4b1kzz1202hzzz2dh6bh43h61h)
X-Spam-TCS-SCL: 0:0
Received: from mail128-tx2 (localhost.localdomain [127.0.0.1]) by mail128-tx2
 (MessageSwitch) id 1267092109554516_21636; Thu, 25 Feb 2010 10:01:49 +0000
 (UTC)
Received: from TX2EHSMHS026.bigfish.com (unknown [10.9.14.251])	by
 mail128-tx2.bigfish.com (Postfix) with ESMTP id 4101A11013A;	Thu, 25 Feb 2010
 10:01:36 +0000 (UTC)
Received: from schexch.acresso.com (64.244.204.10) by TX2EHSMHS026.bigfish.com
 (10.9.99.126) with Microsoft SMTP Server id 14.0.482.39; Thu, 25 Feb 2010
 10:01:33 +0000
Received: from mhexch.acresso.com ([10.41.0.8]) by schexch.acresso.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Thu, 25 Feb 2010 04:01:33 -0600
Received: from [10.41.10.67] ([10.41.10.67]) by mhexch.acresso.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Thu, 25 Feb 2010 10:01:32 +0000
User-Agent: Thunderbird 2.0.0.23 (X11/20090820)
X-OriginalArrivalTime: 25 Feb 2010 10:01:32.0094 (UTC) FILETIME=[81B6BDE0:01CAB601]
X-Reverse-DNS: unknown
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141042>

>From 5e3b362cdd86150de901312c01beac9596b7e2ba Mon Sep 17 00:00:00 2001
From: Filippo Negroni <fnegroni@flexerasoftware.com>
Date: Thu, 25 Feb 2010 09:39:56 +0000
Subject: [PATCH] Fix gitmkdtemp: correct test for mktemp() return value

In gitmkdtemp, the return value of mktemp is not tested correctly.
mktemp() always returns its 'template' argument, even upon failre.
Upon failure, mktemp sets template to be an empty string: its first character is '\0'.
This patch ensures the return value of mktemp is correctly tested by dereferencing the pointer returned by it.

Signed-off-by: Filippo Negroni <fnegroni@flexerasoftware.com>
---
 compat/mkdtemp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/mkdtemp.c b/compat/mkdtemp.c
index 34d4b49..1136119 100644
--- a/compat/mkdtemp.c
+++ b/compat/mkdtemp.c
@@ -2,7 +2,7 @@
 
 char *gitmkdtemp(char *template)
 {
-       if (!mktemp(template) || mkdir(template, 0700))
+       if (!*mktemp(template) || mkdir(template, 0700))
                return NULL;
        return template;
 }
-- 
1.6.4

From: Deskin Miller <deskinm@umich.edu>
Subject: [RFC PATCH 1/4] Expose reflog_info struct in header
Date: Wed, 25 Feb 2009 23:44:04 -0500
Message-ID: <2a946d8679c4f2065bd6965a2417cde74a049791.1235622145.git.deskinm@umich.edu>
References: <cover.1235622145.git.deskinm@umich.edu>
Cc: trast@student.ethz.ch, Deskin Miller <deskinm@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 05:46:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcY8K-0000kl-N3
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 05:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbZBZEoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 23:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbZBZEoT
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 23:44:19 -0500
Received: from el-out-1112.google.com ([209.85.162.178]:26516 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbZBZEoS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 23:44:18 -0500
Received: by el-out-1112.google.com with SMTP id b25so351897elf.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 20:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:in-reply-to
         :references;
        bh=coyJytpZAI/vH1jxhYIb81A4YT6t3eKO1V7gaEdzLLw=;
        b=P3VEEq10a+lXCMCrc0FARvDdljSOvxsKGr6jkEvmWszU8gLVot/UUk43EUpl84QJbt
         ATjr6by4/SNZPZs65FQFo4cu2eklcCuH+jyv6M5r42EHOljdFXAiIPQQGk/jO/vGwTrn
         wnpOpGP25fv8YFQu/a/8Hp9/k0bxva/zFpFz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=DqujfQkR+BskgeTxwCXPxAb236IoScuV9nsCPM5O2tYxe49RvLV5KvVZO2ILdqNai2
         ooG4HAYqCU7z2lCVPOpZocP9gUSOp6Jw2F/OIQ3qoo+tOXCineK9X5xWPyjYWHpKo6If
         DnXgHEEF9zElQlZUJJJOBoEVegQqsyNm4Qbc0=
Received: by 10.231.16.199 with SMTP id p7mr1342994iba.40.1235623456236;
        Wed, 25 Feb 2009 20:44:16 -0800 (PST)
Received: from localhost.localdomain (67-194-38-22.wireless.umnet.umich.edu [67.194.38.22])
        by mx.google.com with ESMTPS id s35sm3517319qbs.6.2009.02.25.20.44.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 20:44:15 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.90.g0753
In-Reply-To: <cover.1235622145.git.deskinm@umich.edu>
In-Reply-To: <cover.1235622145.git.deskinm@umich.edu>
References: <cover.1235622145.git.deskinm@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111522>

The pretty-printing code needs to know this struct in order to print
fields from it in log output.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
 reflog-walk.c |    8 +-------
 reflog-walk.h |   10 ++++++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index f751fdc..dd172ae 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -8,13 +8,7 @@
 
 struct complete_reflogs {
 	char *ref;
-	struct reflog_info {
-		unsigned char osha1[20], nsha1[20];
-		char *email;
-		unsigned long timestamp;
-		int tz;
-		char *message;
-	} *items;
+	struct reflog_info *items;
 	int nr, alloc;
 };
 
diff --git a/reflog-walk.h b/reflog-walk.h
index 7ca1438..7b00993 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -1,6 +1,16 @@
 #ifndef REFLOG_WALK_H
 #define REFLOG_WALK_H
 
+struct reflog_walk_info;
+
+struct reflog_info {
+	unsigned char osha1[20], nsha1[20];
+	char *email;
+	unsigned long timestamp;
+	int tz;
+	char *message;
+};
+
 extern void init_reflog_walk(struct reflog_walk_info** info);
 extern int add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name);
-- 
1.6.2.rc0.90.g0753

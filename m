From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 03/14] revert: Don't check lone argument in get_encoding
Date: Wed,  6 Jul 2011 07:54:17 +0000
Message-ID: <1309938868-2028-4-git-send-email-artagnon@gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 09:55:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeMxE-0006Db-Jj
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 09:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab1GFHzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 03:55:15 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43982 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab1GFHye (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 03:54:34 -0400
Received: by mail-qw0-f46.google.com with SMTP id 3so3221737qwk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 00:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jKHHePCYrrfwBoNdrewv2cXTaDLmFTfvc0UDxFNzdf8=;
        b=g8H4jajJTn4tPHJ1Qk5DZXRXPuONFgpQn5An3kYyCmbRN/QiBRor539LHRRe/iL6VO
         pr9u4lldzPhF4ThXZ8UxktkdZ89dmwLdEaw+tyX5t2L5z6e83Xhn2JPffZZi0RiJvXQd
         LCo7zVQp9JVSNDuA+zQ6uoPXNXPUfN+d2fg0Y=
Received: by 10.229.2.160 with SMTP id 32mr6041073qcj.280.1309938874382;
        Wed, 06 Jul 2011 00:54:34 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id e18sm6212790qcs.5.2011.07.06.00.54.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 00:54:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176661>

The get_encoding function has only one callsite, and its caller makes
sure that a NULL argument isn't passed.  Don't unnecessarily double
check the same argument in get_encoding.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 19d604c..a6b51b1 100644
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
1.7.5.GIT

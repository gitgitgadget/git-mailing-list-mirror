From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 1/2] status -s: respect the status.relativePaths option
Date: Thu, 26 Nov 2009 16:24:38 +0100
Message-ID: <62c5bb36940485deefbf73f4bdc3fd45bbea069e.1259248243.git.git@drmicha.warpmail.net>
References: <cover.1259248243.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 16:26:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDgEU-0007vN-Ly
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 16:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510AbZKZPZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 10:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755310AbZKZPZq
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 10:25:46 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:48375 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755226AbZKZPZp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 10:25:45 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 97975C2ABD;
	Thu, 26 Nov 2009 10:25:51 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 26 Nov 2009 10:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=Zz2piVQu29eay1rxVELff7S2krk=; b=uXBUlnQRXig90w40c6CW18q4iLngNd+3QmBx8gl5dONUl7G3phJPtcBuAK9yCjmOxt0BKFvg8enfcEUceC0PUg8zAorIGYuXbZT3333TipgUEn33JNSjgP7sBe/fy1896+OUuekXnOI5kZteqwFfurSgcsPM6Z7oK/2LJ232Pyk=
X-Sasl-enc: TuG04WA8YjyxcFtybA7AKkP0rDWyoShgAhJBTssao33R 1259249151
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0B2E772FEE;
	Thu, 26 Nov 2009 10:25:50 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc0.274.g71380
In-Reply-To: <cover.1259248243.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133800>

so that 'status' and 'status -s' in a subdir produce the same file
names.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Anything else would be highly surprising. Note that the porcelain case
is unchanged, of course.

 builtin-commit.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 7f888fe..c103beb 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1113,6 +1113,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	switch (status_format) {
 	case STATUS_FORMAT_SHORT:
+		if (s.relative_paths)
+			s.prefix = prefix;
 		short_print(&s, null_termination);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
-- 
1.6.6.rc0.274.g71380

From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 04/18] revert: Don't check lone argument in get_encoding
Date: Thu,  4 Aug 2011 16:09:02 +0530
Message-ID: <1312454356-3070-5-git-send-email-artagnon@gmail.com>
References: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 12:42:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QovO3-0006tS-13
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 12:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034Ab1HDKml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 06:42:41 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63604 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008Ab1HDKmj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 06:42:39 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1836868pzk.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 03:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=50nfeRasjxzEHRMPESPALanrv3JapLSiCsBdOiGbz0M=;
        b=nSzVcunKQsq1qoRXGrPkW8H4JyoWgixfo9LL2QBwguaaUu6ZimORtUkTAGynXAmlOw
         xAGr/ccx0aKUXrURSLUJlAdnSZvd21/+mBSLzPXcmdnM4TPDS/BAeqTPfm23dJl7FvS0
         ZXqOXBSz4nXfr8OLb8hRYKKOcxDmfG+P43Nu8=
Received: by 10.142.5.37 with SMTP id 37mr157197wfe.378.1312454559171;
        Thu, 04 Aug 2011 03:42:39 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id m7sm2090440pbk.6.2011.08.04.03.42.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 03:42:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178720>

The only place get_encoding uses the global "commit" variable is when
writing an error message explaining that its lone argument was NULL.
Since the function's only caller ensures that a NULL argument isn't
passed, we can remove this check with two beneficial consequences:

1. Since the function doesn't use the global "commit" variable any
   more, it won't need to change when we eliminate the global variable
   later in the series.
2. Translators no longer need to localize an error message that will
   never be shown.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
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
1.7.6.351.gb35ac.dirty

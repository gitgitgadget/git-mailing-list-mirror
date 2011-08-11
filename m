From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/6] revert: Free memory after get_message call
Date: Fri, 12 Aug 2011 00:21:41 +0530
Message-ID: <1313088705-32222-3-git-send-email-artagnon@gmail.com>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 11 20:54:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QraPB-00034S-7R
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 20:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122Ab1HKSyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 14:54:51 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63951 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab1HKSyu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 14:54:50 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so4115440pzk.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=s+bj0Cf8DgROL4Lws5o1HkUFFoyspmRJD22t/jLrEAo=;
        b=Jn71DbPXlCIO9In/dj9q7EjyHiq98b5WIRSitC5ron2fM4fySIhwJeO1XFX8EKsJYn
         LkSipJzCQ4FIJo8rnMB0OlYIUblgIsQj9aduq/Fr7aIF4s/k5dpteK+nK1FL9dXJVcfS
         hvAa4jzNt67ttkQMdgat97Z8xuiUmH3SBvtSE=
Received: by 10.142.225.2 with SMTP id x2mr2153594wfg.412.1313088890429;
        Thu, 11 Aug 2011 11:54:50 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id t7sm1117355wfl.2.2011.08.11.11.54.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 11:54:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179130>

The format_todo function leaks memory because it forgets to call
free_message after get_message.  Fix this.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index a548a14..1a4187a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -688,6 +688,7 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 			return error(_("Cannot get commit message for %s"), sha1_abbrev);
 		strbuf_addf(buf, "%s %s %s\n", action_str, sha1_abbrev, msg.subject);
 	}
+	free_message(&msg);
 	return 0;
 }
 
-- 
1.7.6.351.gb35ac.dirty

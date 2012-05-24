From: David Barr <davidbarr@google.com>
Subject: [PATCH 1/7] vcs-svn: prefer constcmp to prefixcmp
Date: Fri, 25 May 2012 00:04:13 +1000
Message-ID: <1337868259-45626-2-git-send-email-davidbarr@google.com>
References: <1337868259-45626-1-git-send-email-davidbarr@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 24 16:05:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXYfX-0003mX-Oi
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 16:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609Ab2EXOF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 10:05:27 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50024 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233Ab2EXOF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 10:05:26 -0400
Received: by dady13 with SMTP id y13so11360466dad.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 07:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=q2lZe1X2hMZReFZryybwxfBif0Br5vFYtzAqw0Qnj8g=;
        b=GXVMACjg96k7iRMGVj/Rz78UTaXRwOsH+aKXNgbtQ/x/+ssWfnGfehR4CIzy27xDfV
         2rSqhZWi7htXhtED4QPp2zB2QWym8dQaQ+fi7SxcUM2J28DpN3jLdMStB5cO81e5aW9L
         EZQQpWN9C/jMQieS40UkB1In5U9j+/gWEsaxUDNqoE2R7VpW62yfDVF+ImXiHJ36AcDv
         2Q2IBbJ5IV3ZDkQrgCjZfqHreUFdiBdjJVCxHv5pxI02Ur7+nfLOVl8WKQ3oPIT2F9Um
         EYoGV9p+mQhp2m0uG/hQ4oKwF3WHj3RaXCgrp/APVaKaIvwYuIJxRLM+agHIU9JraJFJ
         ynTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=q2lZe1X2hMZReFZryybwxfBif0Br5vFYtzAqw0Qnj8g=;
        b=bgIuMupAnQDBwNRC7JHpjuiJWug7tc24wAtCecLA0Jt0yXxLA4NDS9R/qwxetnfoVh
         E1AD4R6HAoiZe4hOiVh76+dG65mxzK4cjrwDBR4zXJF+md7rCZJVzjBTAxHg9OSbOPnc
         udyq4hA9/Bnwcv6sY82bJPWtH8GzPwZOzM1llHaE70zs7/Zf2UmnRzCCLWRSynb4berC
         QY4dlZesFBD1FbkVHaKtBKEbzcYztMeXakvDZLNugZ1MFq2ucDgNTsnacZeHXmpslDjp
         BA6OQ155MDDjNB5qYNyG6g9Dw/ysBOU4qIhkepweRNiO0pWZ6JRjqvTnVupvDgObQrWR
         cIBA==
Received: by 10.68.131.38 with SMTP id oj6mr21796453pbb.39.1337868325650;
        Thu, 24 May 2012 07:05:25 -0700 (PDT)
Received: by 10.68.131.38 with SMTP id oj6mr21796411pbb.39.1337868325392;
        Thu, 24 May 2012 07:05:25 -0700 (PDT)
Received: from localhost.localdomain (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id rv8sm5565332pbc.64.2012.05.24.07.05.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 May 2012 07:05:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1337868259-45626-1-git-send-email-davidbarr@google.com>
X-Gm-Message-State: ALoCoQm2vZFZ8Mv5AUK9vBi5YkpCZFW0YxlsycPHEkzjzzrXa2dBjKimA6HwmwLTiwF6uIsMFLixmkn9wG6s0i1Y45uQch2CUtq+iBIUqh5No/ZHcSQ3We9jA6MT07o6b0meN1bWKaca726cMb+k1Hp1a9XcumAEBxZ2Vtn8P0hm1DkTIRoFQck=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198377>

Comparisons in svndump.c are always guarded by length.
As a bonus, elimate dependency on prefixcmp for upstream.

Signed-off-by: David Barr <davidbarr@google.com>
---
 vcs-svn/svndump.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 0899790..8d0ae9c 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -361,7 +361,7 @@ void svndump_read(const char *url)
 			reset_rev_ctx(atoi(val));
 			break;
 		case sizeof("Node-path"):
-			if (prefixcmp(t, "Node-"))
+			if (constcmp(t, "Node-"))
 				continue;
 			if (!constcmp(t + strlen("Node-"), "path")) {
 				if (active_ctx == NODE_CTX)
-- 
1.7.10.2

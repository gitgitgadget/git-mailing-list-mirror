From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/8] am: tighten a conditional that checks for $dotest
Date: Fri, 10 May 2013 19:56:40 +0530
Message-ID: <1368196005-5354-4-git-send-email-artagnon@gmail.com>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 16:25:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoGD-000780-TY
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196Ab3EJOZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:25:20 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:51227 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756237Ab3EJOZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:25:16 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa7so2799842pbc.25
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=6bzF4yPU/9X5n+Jh2MVNe2IDYLT8ZaIe09ZpoRiHZgo=;
        b=w4FoTee9L9KHBbF+VkZt9K8k/o7tBmRuAmc1SnadhLnVubZ+kXjwINE7XCqqOkcm16
         m+dY4s9M3v4Hvhy0KoR3fUI4aukE8ist7mRY6z5tQSq9OvZYdq5xc1NxsUD+OhNmWzKb
         g8pphMgBPUrA81NsQeZ4pwIbXqkj4rSlE6ZO+G3IzvdEzqL6pKhSKBZ0wvsGFoUQJqWs
         EEaM1ODDti1EqkBkp67bSxmj/u6MI6f4W7G2w6BpzRC1jyN7PGgAHN/8NRleowkPkPbA
         eWLCx9+40xPEvYFTNnsbVKm7YUS8rHvCt+NbBP+6wCo9InDyyYg0kjJ7k2cPieXPKd8f
         nE1w==
X-Received: by 10.68.136.198 with SMTP id qc6mr17828696pbb.117.1368195916360;
        Fri, 10 May 2013 07:25:16 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id nt2sm2915928pbc.17.2013.05.10.07.25.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 07:25:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.gc14258d
In-Reply-To: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223840>

We currently assume that, if a $dotest directory exists, an am had
been called earlier.  This assumption might get our conditional to
match a stray $dotest directory created somewhere else, and result in
failures down the line. So, tighten the conditional by additionally
looking for the file $dotest/last.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index 88aa438..f4ef8fc 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -454,7 +454,7 @@ then
    rm -fr "$dotest"
 fi
 
-if test -d "$dotest"
+if test -d "$dotest" && test -f "$dotest/last"
 then
 	case "$#,$skip$resolved$abort" in
 	0,*t*)
-- 
1.8.3.rc1.52.gc14258d

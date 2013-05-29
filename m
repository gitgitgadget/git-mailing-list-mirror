From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 3/8] rebase: cherry-pick: fix sequence continuation
Date: Tue, 28 May 2013 23:16:35 -0500
Message-ID: <1369801000-3705-4-git-send-email-felipe.contreras@gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 06:18:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXqS-0002Lk-CI
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 06:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933578Ab3E2ESb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 00:18:31 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:52224 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab3E2ESa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 00:18:30 -0400
Received: by mail-oa0-f49.google.com with SMTP id k14so11176517oag.36
        for <git@vger.kernel.org>; Tue, 28 May 2013 21:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sqcNtejhueHD8M/2u7OcFG3+9nd3s0uc5ng3gOKVJ6I=;
        b=gckcz6YoBg/RjU8HgSiPTcLi1ZVt4W/1seREazniyB/NpKlxbEjS44p4PimRjQ7laK
         uWI8QxRon0ant1+qjY8VSHv7WGMMEu2pM3/pqsykcvXSSorsMo6HlRBts7mopfT86hnM
         SgMed5sUUR8Z+IJpu7jtdlUTrstJedjVZetPjfRmTqrDxfUbpmkDu8BqbZ4JgJAsi823
         ZIvzRIeHRS6bi2ffnsR9o2R6thT6s4cPMuy6iKmN4kbJahXFagEHlsHyIhS1gqeIBiVa
         BWV1uvtQYQfVbUPOoWBsWUFWIsaDer6/SmrkyEJe0Ym9D7o8zjmZQWupyJws/mdY/NLj
         HnSQ==
X-Received: by 10.60.59.198 with SMTP id b6mr535925oer.84.1369801110135;
        Tue, 28 May 2013 21:18:30 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm39325120oez.4.2013.05.28.21.18.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 21:18:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225726>

We are not in am mode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index 51354af..2fa4993 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -5,13 +5,15 @@
 
 case "$action" in
 continue)
-	git am --resolved --resolvemsg="$resolvemsg" &&
-	move_to_original_branch
+	git cherry-pick --continue &&
+	move_to_original_branch &&
+	rm -rf "$state_dir"
 	exit
 	;;
 skip)
-	git am --skip --resolvemsg="$resolvemsg" &&
-	move_to_original_branch
+	git cherry-pick --skip &&
+	move_to_original_branch &&
+	rm -rf "$state_dir"
 	exit
 	;;
 esac
-- 
1.8.3.rc3.312.g47657de

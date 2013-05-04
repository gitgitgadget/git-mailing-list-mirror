From: Vikrant Varma <vikrant.varma94@gmail.com>
Subject: [PATCH v2 2/2] merge: use help_unknown_ref
Date: Sat,  4 May 2013 05:34:20 +0530
Message-ID: <1367625860-20746-3-git-send-email-vikrant.varma94@gmail.com>
References: <1367625860-20746-1-git-send-email-vikrant.varma94@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Vikrant Varma <vikrant.varma94@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 04 02:06:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYPzE-0000sT-Of
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 02:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762352Ab3EDAF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 20:05:57 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:43819 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755932Ab3EDAF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 20:05:56 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so1175357pad.37
        for <git@vger.kernel.org>; Fri, 03 May 2013 17:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2F+xllLJknlYwOQCnVDea8LCwRwgpaI75cpPeCgQadQ=;
        b=ia7X4iWPPLQ25sotfsD8pKfT82DUKxBl6otMTALW1945UF5p+3Wn2fAOqT4GaAo4pa
         xNXix4ZjScMBk29Ywz0Pq980W1nsFotjRuMBRgsEy4xSrF/yVta/Ywqf3F7vziqzytpY
         IeIMutBBk+urtWh7fTDioHrmouEuKUe+aGSSdbwnIEistyamp4RPa9WqZzxsdxk/6/of
         CFwuRDt8NSSHQ37r+tdTrRGVQKOVJxDZjL9bE793zQ9NTYYjwJLlLfSUxUJeUT99H+AJ
         MWFUdFQ5j8+4d+pURcTEwegtyW0iApr1cF+Hs2ECQaUBfmD/Orn6W5N6vtbVKnaQkV0l
         /wNQ==
X-Received: by 10.66.119.5 with SMTP id kq5mr16647694pab.193.1367625956072;
        Fri, 03 May 2013 17:05:56 -0700 (PDT)
Received: from localhost.localdomain (triband-mum-59.183.134.119.mtnl.net.in. [59.183.134.119])
        by mx.google.com with ESMTPSA id ea15sm14689710pad.16.2013.05.03.17.05.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 03 May 2013 17:05:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1367625860-20746-1-git-send-email-vikrant.varma94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223339>

Use help.c:help_unknown_ref instead of die to provide a friendlier error
message before exiting, when one of the refs specified in a merge is unknown.

Signed-off-by: Vikrant Varma <vikrant.varma94@gmail.com>
---
 builtin/merge.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 3e2daa3..2ebe732 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1054,7 +1054,8 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 	for (i = 0; i < argc; i++) {
 		struct commit *commit = get_merge_parent(argv[i]);
 		if (!commit)
-			die(_("%s - not something we can merge"), argv[i]);
+			help_unknown_ref(argv[i], "merge",
+					 "not something we can merge");
 		remotes = &commit_list_insert(commit, remotes)->next;
 	}
 	*remotes = NULL;
-- 
1.7.10.4

From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH] string-list.h: Add a value to string_list initializer lists
Date: Mon,  2 Jun 2014 01:58:24 -0700
Message-ID: <1401699504-29826-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 11:00:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrO6f-0007h6-Rw
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 11:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbaFBJAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 05:00:34 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:40597 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbaFBJAd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 05:00:33 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so3965536pbb.8
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 02:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wVz9dOWWnjbecpQbXkP1Sc8nXFi6Y0RgvBRSucrCVwg=;
        b=uRFVcwf0u5yBrKtaNDMZRKTGqwCPsJmaUJbhU4sf8iY+mvLyofv4QNryWYlCL9qfP3
         XastOzNscWQyloLsShUzv9emPPvWK5ig6v2Ybybb0DbNyuCKcnRi+5BQa/294GZrb993
         wsGEnZHpK+P8+zh3RpH6Tj4JyajB0usMYWRD9+BWlF3JO9OcMCQd60xxtnWBgTiFsg+c
         6NxQsFqvS8dEG1G/SguJErpQ5wsifGeDiFbVL6zbSngSzUSo0AnvERjhBYLmXUKokdNa
         9jzPdIAI6TUfLlC3hMyDFWBvLq5fnzgJxYkkSJo7ej2KMOTC1Q3xBAJghjbD417g//Qd
         R55A==
X-Received: by 10.66.162.137 with SMTP id ya9mr39314952pab.31.1401699632763;
        Mon, 02 Jun 2014 02:00:32 -0700 (PDT)
Received: from localhost.localdomain ([117.254.219.180])
        by mx.google.com with ESMTPSA id ir10sm19314337pbc.59.2014.06.02.02.00.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Jun 2014 02:00:32 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250560>

Add a NULL value in the end of STRING_LIST_INIT_NODUP and
STRING_LIST_DUP to initialize `compare_strings_fn`.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
When I used a malloced string_list to play around with string-list API and
used the default init_list, it caused a seg fault. After an hour of debugging
I saw that comapre_strings_fn should be initialized to NULL. In C, even an
incomplete initialzer initializes every value to NULl or 0, so in normal
usage in the codebase this problem never occurs. Still it is better to be
thorough.

 string-list.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/string-list.h b/string-list.h
index de6769c..87ee419 100644
--- a/string-list.h
+++ b/string-list.h
@@ -15,8 +15,8 @@ struct string_list {
 	compare_strings_fn cmp; /* NULL uses strcmp() */
 };
 
-#define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0 }
-#define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1 }
+#define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0, NULL }
+#define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
 
 void print_string_list(const struct string_list *p, const char *text);
 void string_list_clear(struct string_list *list, int free_util);
-- 
1.9.0.GIT

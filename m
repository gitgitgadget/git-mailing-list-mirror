From: crquan@gmail.com
Subject: [PATCH 3/3] git-remote: simplifying get_one_entry
Date: Mon, 17 Nov 2008 19:15:51 +0800
Message-ID: <1226920551-28303-3-git-send-email-crquan@gmail.com>
References: <1226920551-28303-1-git-send-email-crquan@gmail.com>
 <1226920551-28303-2-git-send-email-crquan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 12:17:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L226J-0001aE-JD
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 12:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbYKQLPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 06:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753381AbYKQLPl
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 06:15:41 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:39452 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbYKQLPk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 06:15:40 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1511274tic.23
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 03:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2JdL+u3n3/pFpfT56vSV8WGIPbiejKBcj+DxVHchW4A=;
        b=syuq2JuOV3m5jQfbi3lglj7Oq/owMFvr2fwRJoiB6hChfLdBv6mcOQ+mHMZzYkBFvy
         CHHGApyC27nztRzVaTXfUsGVQt6Lo0pqjQBK7k7ijH4Y5yeGaPUz3cYqyMsGLSgTNLOK
         f9+LSyA2TKVrZMCzaCIG59ddctMRr239tkreQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HXrPJfuL8w3Y3O3rpJs9J+cuR67AIFbY4cXXNRyEDN4PJI4E45K2fAQ3i/wPfxz5Jy
         RQGXhPQK5xLmYSfYjQg3UCXSavMeSkEMvd9cah37Ug9pFc0ogoTOhWh9VCkcVAX+VY3q
         tOXm8kVG3x72hO/l0ZhITOKvGvWU3MvdykRP8=
Received: by 10.110.49.6 with SMTP id w6mr5036439tiw.9.1226920539329;
        Mon, 17 Nov 2008 03:15:39 -0800 (PST)
Received: from tux ([219.134.89.155])
        by mx.google.com with ESMTPS id a14sm382339tia.12.2008.11.17.03.15.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Nov 2008 03:15:37 -0800 (PST)
Received: by tux (sSMTP sendmail emulation); Mon, 17 Nov 2008 19:16:23 +0800
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1226920551-28303-2-git-send-email-crquan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101222>

From: Cheng Renquan <crquan@gmail.com>

The loop for remote->url_nr is really useless,
set to the last one directly is better.

Signed-off-by: Cheng Renquan <crquan@gmail.com>
---
 builtin-remote.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index fff9920..59d69a5 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -839,13 +839,9 @@ static int get_one_entry(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
 
-	if (remote->url_nr > 0) {
-		int i;
-
-		for (i = 0; i < remote->url_nr; i++)
-			string_list_append(remote->name, list)->util = (void *)remote->url[i];
-	} else
-		string_list_append(remote->name, list)->util = NULL;
+	string_list_append(remote->name, list)->util =
+		remote->url_nr > 0
+		? (void *)remote->url[remote->url_nr-1] : NULL;
 
 	return 0;
 }
-- 
1.6.0.2

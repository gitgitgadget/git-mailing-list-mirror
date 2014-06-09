From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 12/19] http-backend: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:31 -0700
Message-ID: <1b2452210b15aedeb3006ae8952220086f9420e5.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:21:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7wH-0000vF-2l
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbaFIWVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:21:10 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:49834 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWVI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:21:08 -0400
Received: by mail-pd0-f178.google.com with SMTP id v10so5344638pde.23
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=znrZgb1lHQQcCU8OCxcdeUgG7Rp3aZfZA7gpjrU+ccw=;
        b=z+kNOYMVi5msD5vMpRmgEmATnfZF5dskFkAGCLXEoxNn8hencgxYTMrT/WINmZtqzB
         gczf9ZOHP3CXSiHMooK4iCXDOA0kkP3r+804jC7RF+cdM98l+JouKHhpJlR9I4pU++7/
         mDZp/X0QQB4+mNLECNqiR1d7JJOZ1VEWMldJ4Q/3Osy3r6IoURSdrL0hEpqSO3uqokHH
         fxqWSTFMt1ORMH4oHSkDGKy8ggJNAUijATwMd8+HEXWZE0v1Xmtgtr4Pul+cMw6pSgA6
         Htr5HQh2VL0GGcpqpJISJiWhY+mDzTQlWAfgzludjcMsaKYBBtH7n100J7NnZQEEFWwB
         XI7w==
X-Received: by 10.68.132.42 with SMTP id or10mr7411745pbb.80.1402352468428;
        Mon, 09 Jun 2014 15:21:08 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id it4sm65819281pbc.39.2014.06.09.15.21.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:21:07 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:21:04 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251120>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 http-backend.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index d2c0a62..25c7435 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -489,14 +489,12 @@ static void service_rpc(char *service_name)
 	struct rpc_service *svc = select_service(service_name);
 	struct strbuf buf = STRBUF_INIT;
 
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "application/x-git-%s-request", svc->name);
+	strbuf_setf(&buf, "application/x-git-%s-request", svc->name);
 	check_content_type(buf.buf);
 
 	hdr_nocache();
 
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "application/x-git-%s-result", svc->name);
+	strbuf_setf(&buf, "application/x-git-%s-result", svc->name);
 	hdr_str(content_type, buf.buf);
 
 	end_headers();
-- 
2.0.0.592.gf55b190

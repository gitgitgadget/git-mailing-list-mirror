From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH 1/3] add strnncmp() function
Date: Mon, 16 Jun 2014 12:13:56 -0700
Message-ID: <58e0ac866bdeb8cc6e06cf553a459af351ccfd1b.1402945507.git.jmmahler@gmail.com>
References: <cover.1402945507.git.jmmahler@gmail.com>
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 21:14:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwcMN-0000nK-2z
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 21:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755352AbaFPTOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 15:14:23 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:59580 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503AbaFPTOW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 15:14:22 -0400
Received: by mail-pd0-f173.google.com with SMTP id r10so4713865pdi.4
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 12:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kdR/nEp9qiPSmv/oEs3TFKAM02UyVjZQ3sF1HozDIco=;
        b=t0Ys7btVpfSrTpLBOXZh/6y+ZR0ZLhSj+eP6kUY+NCLz7y3/W2myXQl5KAoZVBffx3
         sQzF4zODC1C3ONveh2+7Hag4xC/Lt4u9QKZBnqMSMr7sjt8Zo7QgjEHsEc1mKZE6ivse
         /NwB7iB+spXBfNd0EsimaGb6zVqhI9NiSO9PPStfAcM2MeGXM9ElSQmefobj28teeCNU
         50Q/syQXApUY9pLdyeepBvXyjiJMRmzQxLB60n8UAmpihi/UfPxwOqXlSU8U1YY9Dbq2
         6DLOOcSDQuTvcbFWBuu+9f+OwDl0+TT0P4pvoCL7gmbn7rKJS3KXfTvG3FO4R8C03vs5
         QEag==
X-Received: by 10.66.155.227 with SMTP id vz3mr26248560pab.26.1402946061869;
        Mon, 16 Jun 2014 12:14:21 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id su8sm20118251pbc.72.2014.06.16.12.14.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jun 2014 12:14:20 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1402945507.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402945507.git.jmmahler@gmail.com>
References: <cover.1402945507.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251801>

Add a strnncmp() function which behaves like strncmp() except it uses
the length of both strings instead of just one.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 strbuf.c | 6 ++++++
 strbuf.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index ac62982..bd486c3 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -600,3 +600,9 @@ char *xstrdup_tolower(const char *string)
 	result[i] = '\0';
 	return result;
 }
+
+int strnncmp(const char *a, int len_a, const char *b, int len_b)
+{
+	int min_len = (len_a < len_b) ? len_a : len_b;
+	return (memcmp(a, b, min_len) || (len_a - len_b));
+}
diff --git a/strbuf.h b/strbuf.h
index e9ad03e..88af9bf 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -187,4 +187,6 @@ extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
 
+extern int strnncmp(const char *a, int len_a, const char *b, int len_b);
+
 #endif /* STRBUF_H */
-- 
2.0.0

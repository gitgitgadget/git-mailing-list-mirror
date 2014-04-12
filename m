From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/5] transport-helper: remove barely used xchgline()
Date: Sat, 12 Apr 2014 15:33:28 -0500
Message-ID: <1397334812-12215-2-git-send-email-felipe.contreras@gmail.com>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 22:44:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ4mU-0004Oy-B5
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 22:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230AbaDLUnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 16:43:41 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:50871 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580AbaDLUng (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 16:43:36 -0400
Received: by mail-oa0-f41.google.com with SMTP id j17so7785025oag.0
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 13:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hvZ/6IUwYK+JwVVqZTQV1gqU1nRmLtg+Ildm8P5rLn4=;
        b=qHZAuI40DaEBtrXkNpEq7vZFUbJMo3lMygL1p+rh1iziNTswuWMvurs6yhrFSa/pkZ
         C0wyKINqr/iWKZbk6OBgb2/XvFRJvHl+ppF5ULwLFi6NRIeoKDd7gp7qeYTbDFlLG7Iu
         y+dnGg9YXOoSfFBazIWh2qa7NtdlQih7W01sa8h3i6sPD8LDd1qbJMMWFgrEjLizKM/S
         f1CEWoplYQR81F+mfxNDyd4301EkqBGdi7WF439uaVqlZJ5PnlsLzaLG/XuyGoVSzqtJ
         ujrPaXgMzx1PLHM9CkhxAXYMS65bop5WJ2guRCscLzk+HOoA8IEk26C2i3qJ9RtnpZ7t
         nePQ==
X-Received: by 10.60.142.229 with SMTP id rz5mr26064128oeb.1.1397335416151;
        Sat, 12 Apr 2014 13:43:36 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id g4sm19256906obe.5.2014.04.12.13.43.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 13:43:34 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246188>

It's only used once, we can just call the two functions inside directly.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index ad72fbd..bf329fd 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -71,12 +71,6 @@ static int recvline(struct helper_data *helper, struct strbuf *buffer)
 	return recvline_fh(helper->out, buffer, helper->name);
 }
 
-static void xchgline(struct helper_data *helper, struct strbuf *buffer)
-{
-	sendline(helper, buffer);
-	recvline(helper, buffer);
-}
-
 static void write_constant(int fd, const char *str)
 {
 	if (debug)
@@ -307,7 +301,8 @@ static int set_helper_option(struct transport *transport,
 		quote_c_style(value, &buf, NULL, 0);
 	strbuf_addch(&buf, '\n');
 
-	xchgline(data, &buf);
+	sendline(data, &buf);
+	recvline(data, &buf);
 
 	if (!strcmp(buf.buf, "ok"))
 		ret = 0;
-- 
1.9.1+fc3.9.gc73078e

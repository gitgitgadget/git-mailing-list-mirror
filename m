From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] drop unnecessary copying in credential_ask_one
Date: Thu,  2 Jan 2014 09:06:33 +0800
Message-ID: <1388624793-5563-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>, Jeff King <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 02 02:07:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyWkZ-0005pF-2g
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 02:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbaABBGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jan 2014 20:06:48 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:42569 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbaABBGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jan 2014 20:06:48 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so13664162pdj.9
        for <git@vger.kernel.org>; Wed, 01 Jan 2014 17:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rBRB4nx8r/R9ToVGGX+BJqN+fwz8dbaaujJOq3U9F+I=;
        b=etW5oFMmVlDljFpnXsy9zEUei2OOTXcrjOayAyQp8p1JFlPHH9QsDM9hU19dadveKX
         YN8w4uBcn+21FAvTl9NUo/QK9LWfzqYmMR59M/ToQc5M8eR80rd+qxBAaMkFnwrMSdYy
         62ak5LBthNnOyThp85ZGV9fB4wdoGSae5zHw7t2pXURx3JZv0jmivS/eDfzyQuxaq7oF
         iNw85yyHNxgiesROvRluwRgGSL4U2v8t6WVy2u3FSFNhxsiGfHALRj6mMM/k2xRlqpNw
         jAktClD5piM3ASBXFvbv6ajBGXrqWfoCiIBVAt967nHS5AYyloOBcXYES8Mk1HBOn/R4
         WYRQ==
X-Received: by 10.67.4.169 with SMTP id cf9mr27082406pad.45.1388624807622;
        Wed, 01 Jan 2014 17:06:47 -0800 (PST)
Received: from localhost.localdomain (spnp46141.spnp.nus.edu.sg. [137.132.46.151])
        by mx.google.com with ESMTPSA id rx5sm58896948pbc.44.2014.01.01.17.06.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 Jan 2014 17:06:47 -0800 (PST)
X-Mailer: git-send-email 1.8.5-rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239848>

We were leaking memory in there, as after obtaining a string from
git_getpass, we returned a copy of it, yet no one else held the original
string, apart from credential_ask_one.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 credential.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/credential.c b/credential.c
index 86397f3..0d02ad8 100644
--- a/credential.c
+++ b/credential.c
@@ -54,7 +54,7 @@ static char *credential_ask_one(const char *what, struct credential *c)
 
 	strbuf_release(&desc);
 	strbuf_release(&prompt);
-	return xstrdup(r);
+	return r;
 }
 
 static void credential_getpass(struct credential *c)
-- 
1.8.5-rc2

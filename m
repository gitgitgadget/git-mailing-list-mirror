From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 11/31] refs.c: null terminate the string in copy_msg
Date: Wed, 14 May 2014 15:13:10 -0700
Message-ID: <1400105610-21194-12-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:15:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhSG-0000ZF-Rv
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbaENWPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:15:08 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:57847 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbaENWNg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:36 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so51645pbc.0
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jiJRCrk/adUsuF5tRhiGfRMgKLtITueFFXAnUcvEiyI=;
        b=JXwqMTckvgyhtseY4aO5m9k1AtXaxWujRuzFzUyDltUQCnQFdLEX3iG4Cu1RxmYCaK
         Aj2pVeL1+x3r05DGtnBJUS4ylgscVjG1Tzse3PBOk9z0p8TOyuPRrDjQYupISveZO9B8
         2sMaYgkvnUuhHAkEL738L53xPcO/pX+vAvz/lUhb4jNL/7IW7CSIQ7eLvd8UVvAWFQkz
         EqNcIyPzhk2X+YjuM35BFvorXAYJa0JdBVi8RvTkqSSkv+MD+uX1zK62v5AWI8uCw97p
         EYKxTf7YUb05cu2es9r7Fvd16r+UcHs80sy48cVA2kL/DyAsfTDl0KCVFrW3FennZ1xj
         A31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jiJRCrk/adUsuF5tRhiGfRMgKLtITueFFXAnUcvEiyI=;
        b=mD1hDmJf3Cg04tJqTRf468bjvCnVqUaEWDBqie4bRoz7UfyaLybfhudwyxm8RskdnB
         dTJJRhlNA9kEHMlA3d+YAv5XEE3lhOOMjPwtuCoGfBntzHvUF2FqwjgnRTRxtu9vAnyR
         bmdiBWcabBjgxONurnBwAfu2/BK4odNAKCJ78E4y+6CwrRYhtyJRYHF04+/MlocSxw69
         MQMe11+8CyhoMbhbtYc0u3I7ztZpwgUTzPSPHAwxerZuWBuKlXr3SSNrcWpCxWUoECQM
         iWdrQlW5n5xYuq7UwVt8pZi6t9JjR/c0fzpHad5YLXlyBDFCl1G7NydbvP8/4jOFWlK9
         54LQ==
X-Gm-Message-State: ALoCoQlMjfPyhkmPBms7wkfswCQxDD104A3qJyioM+R/BE+pvSUDT8spfka4A+DHWaTWlAgcMGwK
X-Received: by 10.66.197.131 with SMTP id iu3mr538464pac.15.1400105616089;
        Wed, 14 May 2014 15:13:36 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r79si152496yhj.2.2014.05.14.15.13.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:36 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E0F875A4202;
	Wed, 14 May 2014 15:13:35 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C1CE1E038E; Wed, 14 May 2014 15:13:35 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249033>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs.c b/refs.c
index 5a5f9df..58bbf1b 100644
--- a/refs.c
+++ b/refs.c
@@ -2707,6 +2707,7 @@ static int copy_msg(char *buf, const char *msg)
 	while (buf < cp && isspace(cp[-1]))
 		cp--;
 	*cp++ = '\n';
+	*cp = 0;
 	return cp - buf;
 }
 
-- 
2.0.0.rc3.506.g3739a35

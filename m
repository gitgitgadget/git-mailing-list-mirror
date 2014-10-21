From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH 1/2] transport: Free leaking head in  transport_print_push_status
Date: Mon, 20 Oct 2014 18:50:44 -0700
Message-ID: <1413856245-5443-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 21 03:51:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgObK-00047F-UF
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 03:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbaJUBuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 21:50:50 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:55288 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbaJUBut (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 21:50:49 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so262421pdb.31
        for <git@vger.kernel.org>; Mon, 20 Oct 2014 18:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=pQgdKXxTRvbN/c2F4OcY2tWVGRqqgSBrTUe3Yid7sLw=;
        b=m4mYd9VuO7WSwgJOIUsaDokDz0Ef6RS/AT4VJE0dHHC+4m7aMH4HPfDH4rVn82Lfgm
         tjs4XnySrjaEysG9iYIg5/O6qdM8fqgvQHRc6v6gOoLt61dIrSU//IFC/wYoS7e7wrEK
         /RzydGTAMPJnzT0hhRmV5MhkIPyZSA/0W/wI06/CnpsVffnP4izuwvzww+QIiE/Bc3d4
         LHNcoerL0epHhTJYPu2V/iE+bmqW2RMPc4zPNuNjCzvgyv9zgrPsRb+3Id799lSJ4Yq3
         W4yGY6nPLMn2z0H+Nh2nW28WBNYQ8X/iSZxixlrEBsPMlDWTStOSe94B2s7cF7NfLX7t
         Tyhg==
X-Received: by 10.70.35.111 with SMTP id g15mr205560pdj.155.1413856249113;
        Mon, 20 Oct 2014 18:50:49 -0700 (PDT)
Received: from localhost (c-76-102-52-132.hsd1.ca.comcast.net. [76.102.52.132])
        by mx.google.com with ESMTPSA id ow7sm10261408pbc.30.2014.10.20.18.50.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 18:50:47 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.332.g8071e93
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Found by scan.coverity.com (ID: 1248110)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/transport.c b/transport.c
index 055d2a2..fbab6ee 100644
--- a/transport.c
+++ b/transport.c
@@ -774,6 +774,7 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 			*reject_reasons |= REJECT_NEEDS_FORCE;
 		}
 	}
+	free(head);
 }
 
 void transport_verify_remote_names(int nr_heads, const char **heads)
-- 
2.1.2.332.g8071e93

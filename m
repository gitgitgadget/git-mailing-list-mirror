From: Stefan Saasen <ssaasen@atlassian.com>
Subject: [PATCH] Documentation: distinguish between ref and offset deltas in pack-format
Date: Fri, 12 Apr 2013 15:56:24 +1000
Message-ID: <1365746184-75910-1-git-send-email-ssaasen@atlassian.com>
Cc: s022018@student.dtu.dk, Stefan Saasen <ssaasen@atlassian.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 12 07:56:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQWyZ-0001SV-2N
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 07:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab3DLF4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 01:56:36 -0400
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:38771 "HELO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752939Ab3DLF4f (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Apr 2013 01:56:35 -0400
Received: from mail-pd0-f199.google.com ([209.85.192.199]) (using TLSv1) by na3sys009aob137.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUWeiEzk0wxW674psZKvF8Xl+YLLEHQnR@postini.com; Thu, 11 Apr 2013 22:56:35 PDT
Received: by mail-pd0-f199.google.com with SMTP id 10so1964083pdc.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 22:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=NQgL6lr+rLvbKH4c6TMwr82MB95oRbDQF0XJPQKzJAA=;
        b=nCZzikU7wsvqwoi1gnzDPvcDgxyN4XLQ6BlcxYrqcUJ+Zbv+hd+4497rhYrWh8cCNg
         aN+Ucvkh2Vxf1M0xm8mbLoAZ4mLYSje+R1u//84aLWXejiutKcMRk3jKOJijIfGesS6E
         u78qTvJrbBclmmNUGoue8Mtn0rt1cfEjvGVml7b8+a9j+j8hPr4p3lTm4GJPn8sfDLyn
         lxI+A9Ev8ZfSNe7Muk32zwl5r0Wbajg2shTYBXGGt2m3m9S2HkUaovzsv4j9E13vSjMX
         U/Syg/hgFxpZKp4QVi/1Um5YQvT9rdrPXZzfVQNkeB6KRsFmStHhkI8C90quJRgwvEcX
         Tj8g==
X-Received: by 10.68.216.37 with SMTP id on5mr13313963pbc.35.1365746193554;
        Thu, 11 Apr 2013 22:56:33 -0700 (PDT)
X-Received: by 10.68.216.37 with SMTP id on5mr13313955pbc.35.1365746193474;
        Thu, 11 Apr 2013 22:56:33 -0700 (PDT)
Received: from monteiths.dyn.syd.atlassian.com (eth59-167-133-100.static.internode.on.net. [59.167.133.100])
        by mx.google.com with ESMTPS id dg5sm7125656pbc.29.2013.04.11.22.56.32
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 22:56:32 -0700 (PDT)
Received: by monteiths.dyn.syd.atlassian.com (Postfix, from userid 501)
	id 3CA4CB3F935; Fri, 12 Apr 2013 15:56:29 +1000 (EST)
X-Mailer: git-send-email 1.8.2
X-Gm-Message-State: ALoCoQnvDz93PqSzxG2yR/KxVFpAG3Dc8wDLB1dpUJK+Mj+ag9v5PwKq92AurmJkO93gxQhHmwHj+NycEudoH4dgANEPjtWoRPdfTLbEO2fB1AbsAx3nAgJ6T2hhwZN9bPOxWfaKf5VCLGxdki3NhacLTnoXWGeo/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220957>

eb32d236 introduced the OBJ_OFS_DELTA object that uses a relative offset to
identify the base object instead of the 20-byte SHA1 reference. The pack file
documentation only mentions the SHA1 based reference in its description of the
deltified object entry.

Update the pack format documentation to clarify that the deltified object
representation refers to its base using either a relative negative offset or
the absolute SHA1 identifier.

Signed-off-by: Stefan Saasen <ssaasen@atlassian.com>
---
 Documentation/technical/pack-format.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 0e37ec9..61445c2 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -26,7 +26,9 @@ Git pack format
 
      (deltified representation)
      n-byte type and length (3-bit type, (n-1)*7+4-bit length)
-     20-byte base object name
+     20-byte base object name if OBJ_REF_DELTA or a negative relative
+         offset from the delta object's position in the pack if this
+         is an OBJ_OFS_DELTA object
      compressed delta data
 
      Observation: length of each object is encoded in a variable
-- 
1.8.2

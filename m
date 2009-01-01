From: Alexander Potashev <aspotashev@gmail.com>
Subject: [PATCH] use || instead of | in logical expressions
Date: Fri, 2 Jan 2009 01:39:53 +0300
Message-ID: <20090101223953.GA16680@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 01 23:41:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIWEM-0004JI-OS
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 23:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbZAAWkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 17:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbZAAWkB
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 17:40:01 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:43881 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbZAAWkA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 17:40:00 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2210771fgg.17
        for <git@vger.kernel.org>; Thu, 01 Jan 2009 14:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=LWTKuY9Ml1rkA1MOH0PK6SsjjJLr/vzgh5f3U18ZD9U=;
        b=GQVyqtT7FCdXv+woWoSS+UPsQw64+Fkge4J5dEisKw3s16ycFenVOleC6X4CuJhjJD
         X7pk/BdUicYPM4n3/4wGsXfKyDeFRUMATVCT2xFt4xn+AeCO5rXU34jTAuFS6xdUNpwv
         Qeza9/AxZBQuqNwHZp2EwxaL2PDZrbKFLyHFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=c7WceQj8zbGq7onQutWeLYF+JFYH1ag1beJ4z/+beDX+ik9ubDJuJNN1uXpKRak6cC
         qQ0XlDri7iBNu2nobzVDHB/e/C3gChDV9WEK46Rt9lmP0ig7867VaN84d4t12wrzreNb
         MCxM1DcOJzLnQ2Tqtuymo+aDSeWyA7stymTUk=
Received: by 10.86.92.7 with SMTP id p7mr10127480fgb.54.1230849597261;
        Thu, 01 Jan 2009 14:39:57 -0800 (PST)
Received: from smtp.gmail.com ([91.78.102.214])
        by mx.google.com with ESMTPS id e11sm11780430fga.12.2009.01.01.14.39.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jan 2009 14:39:56 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Fri, 02 Jan 2009 01:39:53 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104337>

Bit OR ('|') is probably faster and it always works correctly (but '&'
doesn't!), but it looks horrible here.

Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
---
 builtin-apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 07244b0..c71afa1 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2487,7 +2487,7 @@ static int check_patch(struct patch *patch)
 		ok_if_exists = 0;
 
 	if (new_name &&
-	    ((0 < patch->is_new) | (0 < patch->is_rename) | patch->is_copy)) {
+	    (0 < patch->is_new || 0 < patch->is_rename || patch->is_copy)) {
 		if (check_index &&
 		    cache_name_pos(new_name, strlen(new_name)) >= 0 &&
 		    !ok_if_exists)
-- 
1.6.0.6

From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines
 at end of file
Date: Sat, 19 May 2007 15:12:50 +0200
Message-ID: <464EF7D2.4030406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 15:13:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpOkA-00080p-Dr
	for gcvg-git@gmane.org; Sat, 19 May 2007 15:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757375AbXESNNA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 09:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757465AbXESNNA
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 09:13:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:36527 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757375AbXESNNA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 09:13:00 -0400
Received: by ug-out-1314.google.com with SMTP id 44so711390uga
        for <git@vger.kernel.org>; Sat, 19 May 2007 06:12:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=mL8VRsT6MOhye4Q3k6povL+MrV8As+W6qq0bkJJzbL9vltFgwcJO8EmmC+oeYVJjUT9rV1/TGtZPcu6FMIP7d7a61AgefZEiZX/45XXosMLsc7+4hxX3kPzVa1j22msQdSRcb9NesySrR+ULrhpftRKXOSaldhlzkWEX3SW5Axw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=FbmJEm51xuuR5UqSXpG61K7fMUbxXl0gVEaVGFe38a1Ps9zOXuPo2Y5OY2oHw4f6oE7t4QIzKqLEKw0eeAMCrTMJ+Pm5rLfXDdnsRaoi2V7F4n4WGKPm2TP678cGJhW2eVUs1lQt2u9QTVYIFe3fLIFEwZHpo0kSBhV1ckfPEn8=
Received: by 10.67.116.1 with SMTP id t1mr1844801ugm.1179580378904;
        Sat, 19 May 2007 06:12:58 -0700 (PDT)
Received: from ?10.0.0.13? ( [151.70.113.229])
        by mx.google.com with ESMTP id 50sm2781469ugb.2007.05.19.06.12.57;
        Sat, 19 May 2007 06:12:58 -0700 (PDT)
User-Agent: Thunderbird 2.0b2 (X11/20070313)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47748>

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
  builtin-apply.c |    4 ++++
  1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 0399743..f17f838 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1738,6 +1738,10 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
  		newsize--;
  	}

+	if (new_whitespace == strip_whitespace)
+		while (newsize > 1 && !strncmp(new + newsize - 2, "\n\n", 2))
+			newsize--;
+
  	oldlines = old;
  	newlines = new;
  	leading = frag->leading;
-- 
1.5.2.rc3.87.g404fd-dirty

From: Chris Larson <clarson@kergoth.com>
Subject: [PATCH] Fix bug in parse_color that prevented the user from changing
 the background colors.
Date: Tue, 05 Feb 2008 10:34:34 -0700
Message-ID: <47A89E2A.9010905@kergoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 18:35:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMRhW-00079O-OZ
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 18:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbYBERel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 12:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752934AbYBERel
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 12:34:41 -0500
Received: from hs-out-0708.google.com ([64.233.178.240]:2078 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752778AbYBERej (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 12:34:39 -0500
Received: by hs-out-2122.google.com with SMTP id 54so2225432hsz.5
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 09:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:sender;
        bh=401UPS6NhgEmW1o58qB+Eh0rKUJ/lD1AdC/+/yLZRJg=;
        b=ba478VnUjAXItdhQmSVToQsK0uPKzCh478DWUH0EW04qANGynEynnbkbEQL6s6kxnS+6Z7ObogYFipV/MokJTfaIEriuspVsMySCxUb8m9qghDUwe4KunVV+Ryu0XsTZEObXt5XVpUwlNPUF3cVFf5LIOdZwyp5haAdRmyQ28nk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:sender;
        b=oz+K1jzdXGjlXsVkEDSRIooNBIiNux5MJ/SC8SmGifAA+GR8bdUJ0+shsI2XRFBORNEVf4fJJyYcLcN4FPlB+X6AjaSNMCjfVYTkwg3QKCAsDGbenxB6YqoD2sHc5lMB2Y4lTHTOOCnyzWhBqWQnVVxfhAHhUp0le/HOUk3YywY=
Received: by 10.101.71.16 with SMTP id y16mr18422382ank.50.1202232878890;
        Tue, 05 Feb 2008 09:34:38 -0800 (PST)
Received: from ?0.0.0.0? ( [63.81.120.158])
        by mx.google.com with ESMTPS id b29sm18980761ana.19.2008.02.05.09.34.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Feb 2008 09:34:38 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72675>

The comments in color.c indicate that the syntax for the color options 
in the
git config is [fg [bg]] [attr], however the implementation fails if 
strtol is
unable to convert the string in its entirety into an integer.

Signed-off-by: Chris Larson <clarson@kergoth.com>
---
 color.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/color.c b/color.c
index 7f66c29..62518fa 100644
--- a/color.c
+++ b/color.c
@@ -17,7 +17,7 @@ static int parse_color(const char *name, int len)
             return i - 1;
     }
     i = strtol(name, &end, 10);
-    if (*name && !*end && i >= -1 && i <= 255)
+    if (*name && i >= -1 && i <= 255)
         return i;
     return -2;
 }
-- 
1.5.4.29.g43ce-dirty

From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK FIX)] gitk: Fix a bug in collapsing deeply nested trees.
Date: Mon, 8 Sep 2008 11:28:16 +0400
Organization: HOME
Message-ID: <200809081128.16215.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 09:30:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcbCj-0005wA-MP
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 09:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247AbYIHH31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 03:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbYIHH31
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 03:29:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:21041 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbYIHH30 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 03:29:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1385409fgg.17
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 00:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=BV/PtNBABgAZBgdU1Hy9ByL0qJZjSqv7gw+oYzR0q30=;
        b=K4icAUbyPeFaZ9ux2ZZ6NTenZgYG3wtZz87CccdQ9jHWo/NfV0z4DeYsHCMrkxLexn
         NQWTZ8G1/YJjrs3oBXjBvgaaYgrgqQRjvr/273kLY//MEuAQmONnyzGCB4TLRK1A42qF
         3Owx7yFBQpL9Cig5a0oSstFjDA8EZne/rxd/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=mx0K7D4q9SeYGLRxI3cMwBvkPrejSEo+NZGqvZaRe6u9u5XVRjkv3MIu9Xr1+H+xP8
         aZOCqj8j3zGzuH7cX8zDwlU7whixqHlkiqtoHXORrd6dl4INKwAB8FlYJsx6x8sFfQ8n
         aRo0Po+WGIPGHw5C6CD/2qw4BCoSWWSZSawZQ=
Received: by 10.86.23.17 with SMTP id 17mr11037956fgw.44.1220858965035;
        Mon, 08 Sep 2008 00:29:25 -0700 (PDT)
Received: from ?192.168.100.3? ( [92.255.85.78])
        by mx.google.com with ESMTPS id l19sm4116485fgb.7.2008.09.08.00.29.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 08 Sep 2008 00:29:24 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95224>

To reproduce: expand a tree like this, then collapse A:

+A
 +B
   C
   D

The result is:

-A
   C
   D

I.e. sub-nodes expanded from the last sub-node of the item
being collapsed are not removed.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index dbc6064..989a3f7 100755
--- a/gitk
+++ b/gitk
@@ -2705,7 +2705,7 @@ proc treeopendir {w dir} {
 	    $w insert e:$ix $e [highlight_tag $de]
 	}
     }
-    $w mark gravity e:$ix left
+    $w mark gravity e:$ix right
     $w conf -state disabled
     set treediropen($dir) 1
     set top [lindex [split [$w index @0,0] .] 0]
-- 
1.6.0.20.g6148bc

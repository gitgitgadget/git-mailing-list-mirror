From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 24/28] disp no longer processes backslashes.
Date: Fri, 21 Mar 2014 08:32:02 +0100
Message-ID: <1395387126-13681-25-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:34:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtxz-00035m-MJ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbaCUHd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:58 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:32884 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759820AbaCUHdh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:37 -0400
Received: by mail-la0-f43.google.com with SMTP id e16so1392931lan.16
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ch77URjt2j+OBR4/Zq/n6z6O5X6R3Q0ABFU34iHvLDU=;
        b=KIf3H86ydJGOfyCIBaTfIcVqaEldAJs50q6Py2vJ5Nv4wu7e8GtuNy95EobxkQCuKf
         KWUPprh4nnWh3DlA4xD2Yyt4+2NFZEZvkfJm+rb0n+c5sXF6tzXdApLMS8cuiSftF6/q
         oItybrq+6nrsQawHTj68RZ8XxNgTup4Jh/n9fV8OuHPhZGWGPK+xWSJEnXFuRa++PAaT
         J9jH0OTvuYGQUBi7PdkSe4oSE3jl2pA+deT/KokBDisv9pBrvAxCbXxbxt67p3E8Q/jf
         GHYMoPshyEh+axWtf8xVFaS5Ykv2wM0B+uU7nTh/dmAexRN/M3CNzf83dOA9/LgAUbTL
         dG5g==
X-Gm-Message-State: ALoCoQnPCJm47erJA5tb2VG3NqOziw0TSP2VyN4t6ZWuLTyL6mCgcTWCtEpipY2wpPt2gLqvWCXR
X-Received: by 10.112.140.202 with SMTP id ri10mr31400749lbb.9.1395387216128;
        Fri, 21 Mar 2014 00:33:36 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244656>

Only one invocation of "disp" or "_disp" actually needed backslash
processing.  In quite a few instances, it was wrong to do backslash
processing, as the message contained data derived from the user.

Created the new function "disp_e" that should be used when backslash
processing is required, and changed "disp" and "disp_" to use printf
code %s instead of "%b".

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/guilt b/guilt
index ca922aa..36cfd1e 100755
--- a/guilt
+++ b/guilt
@@ -36,15 +36,24 @@ usage()
 	exit 1
 }
 
-# echo -n is a bashism, use printf instead
+# Print arguments, but no trailing newline.
+# (echo -n is a bashism, use printf instead)
 _disp()
 {
-	printf "%b" "$*"
+	printf "%s" "$*"
 }
 
-# echo -e is a bashism, use printf instead
+# Print arguments.
+# (echo -E is a bashism, use printf instead)
 disp()
 {
+	printf "%s\n" "$*"
+}
+
+# Print arguments, processing backslash sequences.
+# (echo -e is a bashism, use printf instead)
+disp_e()
+{
 	printf "%b\n" "$*"
 }
 
@@ -117,7 +126,7 @@ else
 
 	disp ""
 	disp "Example:"
-	disp "\tguilt push"
+	disp_e "\tguilt push"
 
 	# now, let's exit
 	exit 1
-- 
1.8.3.1

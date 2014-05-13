From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 24/29] disp no longer processes backslashes.
Date: Tue, 13 May 2014 22:31:00 +0200
Message-ID: <1400013065-27919-25-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:37:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJSX-0008Ka-10
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbaEMUhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:37:48 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:58579 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbaEMUhl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:37:41 -0400
Received: by mail-lb0-f181.google.com with SMTP id u14so712145lbd.12
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=osPRQvIPlirQTs+P3sQohtqN6y3XlGMMOIjtQQDqm8E=;
        b=Qwkc4yi5QRezukxIQNzc0b1C/Cl3CrKOfZmJKZQqh8AizaTdvbJTHSB2VYS9aTzR9r
         ZEcnbiNZ69fMNR6AGTBxYuh+9UuKK8glnqZrjpQ2HmNs8bTSc3CHsohHbCq3mnum22wy
         +279pjd3sF0WN+A/Sty5Drck6lTF7p4pGTM9Bjz3pNdyd24RNfIFKDz2yv0ZMM6md83b
         mmJBi4I9hrTM7yW7FIqEZyNjFFZT0waOr/buxIZ3OgggbzHjCUzHm+kEQPXt8QrwManB
         W7oEB6KS+71Enmn967ExrqDbLW3UKDyNN00pZ4KmZGLtYFeS+N9lVByUPVyzIkUatyfY
         cZoQ==
X-Gm-Message-State: ALoCoQk+ssbzmrxOJg75EatYYKWJ1gqa1YFIT5nbQFE8i+th7aUaOsqgQw4rwL0O0y76T3ZAFWPw
X-Received: by 10.152.20.194 with SMTP id p2mr19460093lae.13.1400013460727;
        Tue, 13 May 2014 13:37:40 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.37.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:37:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248840>

Only one invocation of "disp" or "_disp" actually needed backslash
processing.  In quite a few instances, it was wrong to do backslash
processing, as the message contained data derived from the user.

Created the new function "disp_e" that should be used when backslash
processing is required, and changed "disp" and "_disp" to use printf
code %s instead of "%b".

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/guilt b/guilt
index 23cc2da..9947acc 100755
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

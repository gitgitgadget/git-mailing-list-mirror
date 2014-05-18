From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 24/33] disp no longer processes backslashes.
Date: Mon, 19 May 2014 00:00:00 +0200
Message-ID: <1400450409-30998-25-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:11:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9IY-0005zP-Sr
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbaERWLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:11:11 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:44153 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbaERWLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:11:09 -0400
Received: by mail-la0-f52.google.com with SMTP id gl10so3469862lab.39
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3b7xZMSoZmrZf8qHsU9z76Y8VCBeAZgzU79C4cyKGHE=;
        b=mSikyodX3covywLU2m/tjbgAvhiyrWMj3shTv4sSOeFgdW5GllV0RaWByWX+cDB9Eb
         ggW1zdWO77jm8z0cLS1vKxtAmhRRNl43ITt5qt5SOB7A5PnQwiV2Y0RzfIc956BQ7IFj
         bNVvwEIoNhUF0I19I7ZGW1uoQh18FKU0Az7QG8PAPbnnwZEG6wAdSduYYoJUxGi5QqzR
         jfKlR9Mv+o5GRR3Y37TH0GyDygGRrRknESfmWw26aR/l9TJ9Srf4V6nPixWnpFDlipU3
         uUaIyBGQwn6viLnbtTuIxJJsguHth9IAAa4I0TJW7B9MeAU73Nz27d1dZYnZ5FhmpS2N
         nbBA==
X-Gm-Message-State: ALoCoQk+fVfktv6+I4ygrYMxqPJqQpA1KU404zVm10TDFJKiQm+rirCWRsChY7ECqzJ9gSSqp/bI
X-Received: by 10.153.5.37 with SMTP id cj5mr3645498lad.48.1400451068495;
        Sun, 18 May 2014 15:11:08 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.11.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:11:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249539>

Only one invocation of "disp" or "_disp" actually needed backslash
processing.  In quite a few instances, it was wrong to do backslash
processing, as the message contained data derived from the user.

Created the new function "disp_e" that should be used when backslash
processing is required, and changed "disp" and "_disp" to use printf
code "%s" instead of "%b".

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/guilt b/guilt
index 9567a78..0500500 100755
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

From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 05/29] "guilt new": Accept more than 4 arguments.
Date: Tue, 13 May 2014 22:30:41 +0200
Message-ID: <1400013065-27919-6-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:33:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJNq-0000OY-L4
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833AbaEMUc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:32:56 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:40519 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbaEMUcv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:32:51 -0400
Received: by mail-lb0-f181.google.com with SMTP id u14so697413lbd.40
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P/UBtkyS4x5yp+uLdAKyYSdwdgNBIs1qtCfLGd2nzws=;
        b=dmuBxYk5DGNlxhLf+jCaFPhRLTS+FaAq3fDqI0OVuEitJUqxIgbuH2Cfu180PFoEli
         8rGBRgkgDqi/vk/gJcZAsZdLi0d3XsoKeTGDVzaRSCyow3G42t3R6vy2csZQOEydQjSZ
         ENAvccuEwIZ1UBdk9SyFXoOGAHgcFySR37U36RsXgjWb5YzPAnrOxwYms1DB7MDvZzYX
         uG1U+DLw4jd+vEVnqCGeyIvFlMkuw1cgn1iooImIaN9HTweAHm6bOPm4PIe8bbl5op47
         0sF/h/swyy1U/X7sayWnfpiov9V7/NQXNn2a05KIn46CYSlEb+mKzdDNdOvdBH0Wvur8
         E9Gg==
X-Gm-Message-State: ALoCoQl3O7z/6Gspzwm7om4vCuFtyNMgJZWaQn/EFNn/AS0NI8OKSanLS3ZTamIKMnpIpaF96FZf
X-Received: by 10.112.219.73 with SMTP id pm9mr3210114lbc.48.1400013169398;
        Tue, 13 May 2014 13:32:49 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.32.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:32:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248820>

The argument parser arbitrarily refused to accept more than 4
arguments.  That made it impossible to run "guilt new -f -s -m msg
patch".  Removed the checks for the number of arguments from the
"guilt new" parser -- the other checks that are already there are
enough to catch all errors.

Give a better error message if "-m" isn't followed by a message
argument.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt-new | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/guilt-new b/guilt-new
index bb68924..9528438 100755
--- a/guilt-new
+++ b/guilt-new
@@ -11,10 +11,6 @@ fi
 
 _main() {
 
-if [ $# -lt 1 ] || [ $# -gt 4 ]; then
-	usage
-fi
-
 while [ $# -gt 0 ] ; do
 	case "$1" in
 		-f)
@@ -31,6 +27,9 @@ while [ $# -gt 0 ] ; do
 			fi
 			;;
 		-m)
+			if [ $# -eq 1 ]; then
+				usage
+			fi
 			msg="$2"
 			shift
 
-- 
1.8.3.1

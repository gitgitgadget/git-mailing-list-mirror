From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 05/33] "guilt new": Accept more than 4 arguments.
Date: Sun, 18 May 2014 23:59:41 +0200
Message-ID: <1400450409-30998-6-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:04:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9Bx-0007hU-Gr
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbaERWEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:04:22 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:48034 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbaERWEV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:04:21 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so3486949lab.17
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P/UBtkyS4x5yp+uLdAKyYSdwdgNBIs1qtCfLGd2nzws=;
        b=bhqwrs+yUhaGjR5+jkDZtYHrFTLDGeVc5pAIsDd1yYkMylfVJJhe7GTwoJvXI3yqhy
         oxvuYiK7vkHX46JeModUWDstG5fyW5TFnzdU3yxXzK9pPFb3CJsjY5EYOnF5KcLnhjwL
         jApLSAL5b6HpP1QHeqPPPz9AqxSl3IIn6c8JfSIWDCozDd/w6GrzAhjWuStuVA+KNgVH
         gc60DZkP0Uo/ADzLlmWth/AlTbGlnYvckqfQ7FH71g/zFZyxpF3gKV2SwZvwZC568mZu
         68YkgOa4tqAyB1v75Otba/t96hdUguNAm/FVf3UamCKsSeaeMf3g+JwMz7xZ+bYl+Jc3
         s7ug==
X-Gm-Message-State: ALoCoQmZX2/iQTe7sOzNY74ICNRetEeCuXQlbvK1hIzE9pQwcd4V6IEYbYr+1LnulajnFe5U+B/6
X-Received: by 10.112.173.201 with SMTP id bm9mr22316555lbc.16.1400450660067;
        Sun, 18 May 2014 15:04:20 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.04.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:04:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249520>

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

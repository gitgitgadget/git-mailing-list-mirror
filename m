From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 05/28] "guilt new": Accept more than 4 arguments.
Date: Fri, 21 Mar 2014 08:31:43 +0100
Message-ID: <1395387126-13681-6-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:34:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtyT-0003nr-Sw
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759525AbaCUHdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:25 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35761 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174AbaCUHdH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:07 -0400
Received: by mail-lb0-f171.google.com with SMTP id w7so1382809lbi.16
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/zbGvtbLE+xNkM5fQ7y6cga/gwdDUI0VBwzjMAWmAqQ=;
        b=Kd7hLQKBO7jVrmS8Fd5Bk5TrizLi3W0PoJxQdqy+RcU+qBUhaxwFOdjI9+x+XxecIA
         ZKaQNvCrN1OHX3lCOxmu8RWkmfExgzVH0BvlVqhp5KER85lFzpi4/o/RoeVA1lrNCfjM
         zijBdaTmddboKIR+ovOlWKkJgAot5l5XCl3BNhmHZ6/RZUBQvlZ/4Z4FJA6uXT4C6Byj
         Zwre8+/xxSwC0d8iI/USVbIafE4NNXWBZJBPxUjBVvaU+UgIdpzc923SVh7EGy7NH16a
         q36CTGgYeD8HxcFGwcOJ/RVOaY6U0lPhB07MwE/YspoLzgvgcElPJ524VEN3UtnXivto
         1MmA==
X-Gm-Message-State: ALoCoQkXsz3rrUd2+bYKBgbbEvkCZdGb3Xx3WomWE3sjw4UZlOCoZ8a0Ota+A1elm3fxa2CUHFf+
X-Received: by 10.112.137.5 with SMTP id qe5mr31379289lbb.16.1395387186480;
        Fri, 21 Mar 2014 00:33:06 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244667>

The argument parser arbitrarily refused to accept more than 4
arguments.  That made it impossible to run "guilt new -f -s -m msg
patch".  Removed the checks for the number of arguments from the
"guilt new" parser -- the other checks that are already there are
enough to catch all errors.

Give a better error message if "-m" isn't followed by a message
argument.

Signed-off-by: Per Cederqvist <cederp@opera.com>
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

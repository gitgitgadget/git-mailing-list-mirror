From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 13/20] t/t0026-eol-config.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:56 -0700
Message-ID: <1402066563-28519-14-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZX-000227-0e
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbaFFO4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:21 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:64228 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbaFFO4U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:20 -0400
Received: by mail-pd0-f177.google.com with SMTP id g10so2491659pdj.8
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yhe972udipuwvYWurnC9AvtsmOckJOXHyppp9zrd+8I=;
        b=lzXgkycf8Uv5W6GHswdwu1lgZpaYRFq7ucb0+T7F25ML2AxzOnr8PrqU1aYIvLKpI2
         pYa3C09kldEKoe9UmyURXRNNjUvY+29p/LYGX38Q+JrC5QIeIFivK7X7eZbKqI065iiR
         ZYmRkrdBDnzC+GfNPm3rrWVCoU0xEIJvTNEazix3wQ7QyQe7hCDbKkGxx4IEmi/mKulD
         Mhdwq5CB/8kPb0iszuLDJDGRjaAVMAGUEnuIikli/9R9pkfypdMGoqEGprZfZkKsR5mm
         TPIa7kp9XtLiqF019hPOvm/ZsFMS/iANwvpB1dxqAa4FY8vWnpNhiIlxkBf1Ys6YZ8w3
         nPbw==
X-Received: by 10.68.254.70 with SMTP id ag6mr7617204pbd.33.1402066579975;
        Fri, 06 Jun 2014 07:56:19 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.19
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250932>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t0026-eol-config.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
index e1126aa..4807b0f 100755
--- a/t/t0026-eol-config.sh
+++ b/t/t0026-eol-config.sh
@@ -36,7 +36,7 @@ test_expect_success 'eol=lf puts LFs in normalized file' '
 	! has_cr two &&
 	onediff=$(git diff one) &&
 	twodiff=$(git diff two) &&
-	test -z "$onediff" -a -z "$twodiff"
+	test -z "$onediff" && test -z "$twodiff"
 '
 
 test_expect_success 'eol=crlf puts CRLFs in normalized file' '
@@ -49,7 +49,7 @@ test_expect_success 'eol=crlf puts CRLFs in normalized file' '
 	! has_cr two &&
 	onediff=$(git diff one) &&
 	twodiff=$(git diff two) &&
-	test -z "$onediff" -a -z "$twodiff"
+	test -z "$onediff" && test -z "$twodiff"
 '
 
 test_expect_success 'autocrlf=true overrides eol=lf' '
@@ -63,7 +63,7 @@ test_expect_success 'autocrlf=true overrides eol=lf' '
 	has_cr two &&
 	onediff=$(git diff one) &&
 	twodiff=$(git diff two) &&
-	test -z "$onediff" -a -z "$twodiff"
+	test -z "$onediff" && test -z "$twodiff"
 '
 
 test_expect_success 'autocrlf=true overrides unset eol' '
@@ -77,7 +77,7 @@ test_expect_success 'autocrlf=true overrides unset eol' '
 	has_cr two &&
 	onediff=$(git diff one) &&
 	twodiff=$(git diff two) &&
-	test -z "$onediff" -a -z "$twodiff"
+	test -z "$onediff" && test -z "$twodiff"
 '
 
 test_done
-- 
1.7.10.4

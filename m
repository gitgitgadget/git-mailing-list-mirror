From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 12/20] t/t0025-crlf-auto.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:55 -0700
Message-ID: <1402066563-28519-13-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZB-0001nQ-9l
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbaFFO4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:22 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:53459 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbaFFO4T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:19 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so2565668pbc.16
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jV/pq3DuqVMi76hQZEZTOJAACwCaxdaNOwIQdKO2HoM=;
        b=lCsILUYQNqv5HevGymN9ED4SOoqrFGzhEu0/m9/eb8tHiccka1jr0kxfB+ZulYYkDR
         CLIIEtQf/Azh61E7CGKOLQ8Pf5bkWsnpbawTvDlRdba2vAVFXe1kzk5zraFmqr1A1z6R
         akxdb0I0EykXwj3gYd84aytbaJA/YmHd5ibU3SJaqWkczvfFaxmVP0/n74MVc/BP8Ig2
         k3QaEudkck54TmMiZU3L9/UDLQ9YGX85AxHF3xKVKlT6Um7urRG1Orwl08LI6yQs+zW4
         FYOHF/2jq4ZSkw2uuQ7sJt+d+XkxWRpFmhhnjPSsya0hoeUA4PHf3LYQpCN6iYHnH7Bo
         ewsg==
X-Received: by 10.68.135.100 with SMTP id pr4mr1658419pbb.46.1402066579004;
        Fri, 06 Jun 2014 07:56:19 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250924>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t0025-crlf-auto.sh |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index b0e5694..28102de 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -36,7 +36,7 @@ test_expect_success 'default settings cause no changes' '
 	onediff=$(git diff one) &&
 	twodiff=$(git diff two) &&
 	threediff=$(git diff three) &&
-	test -z "$onediff" -a -z "$twodiff" -a -z "$threediff"
+	test -z "$onediff" && test -z "$twodiff" && test -z "$threediff"
 '
 
 test_expect_success 'crlf=true causes a CRLF file to be normalized' '
@@ -111,7 +111,7 @@ test_expect_success 'autocrlf=true does not normalize CRLF files' '
 	onediff=$(git diff one) &&
 	twodiff=$(git diff two) &&
 	threediff=$(git diff three) &&
-	test -z "$onediff" -a -z "$twodiff" -a -z "$threediff"
+	test -z "$onediff" && test -z "$twodiff" && test -z "$threediff"
 '
 
 test_expect_success 'text=auto, autocrlf=true _does_ normalize CRLF files' '
@@ -126,7 +126,7 @@ test_expect_success 'text=auto, autocrlf=true _does_ normalize CRLF files' '
 	onediff=$(git diff one) &&
 	twodiff=$(git diff two) &&
 	threediff=$(git diff three) &&
-	test -z "$onediff" -a -n "$twodiff" -a -z "$threediff"
+	test -z "$onediff" && test -n "$twodiff" && test -z "$threediff"
 '
 
 test_expect_success 'text=auto, autocrlf=true does not normalize binary files' '
-- 
1.7.10.4

From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 2/2] log -L: improve error message on malformed argument
Date: Mon, 20 Apr 2015 14:09:07 +0200
Message-ID: <1429531747-15082-2-git-send-email-Matthieu.Moy@imag.fr>
References: <CAHYJk3RQwDrtox+vB7G70qu1iCDcxCNDfxWyFS7_2CZQZCAgLA@mail.gmail.com>
 <1429531747-15082-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, mikachu@gmail.com, ramsay@ramsay1.demon.co.uk,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 20 14:09:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkAW9-0001eB-Di
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 14:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbbDTMJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 08:09:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46977 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754548AbbDTMJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 08:09:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t3KC9Lu9011197
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 20 Apr 2015 14:09:21 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3KC9M38007545;
	Mon, 20 Apr 2015 14:09:22 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1YkAVu-00042B-CX; Mon, 20 Apr 2015 14:09:22 +0200
X-Mailer: git-send-email 2.4.0.rc1.42.g9642cc6
In-Reply-To: <1429531747-15082-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 20 Apr 2015 14:09:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3KC9Lu9011197
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1430136563.44067@zyvJ/sZkhJhP77c4cVaJKg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267466>

The old message did not mention the :regex:file form.

To avoid overly long lines, split the message into two lines (in case
item->string is long, it will be the only part truncated in a narrow
terminal).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No change since v1 (except Junio's changes).

 line-log.c          | 2 +-
 t/t4211-line-log.sh | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/line-log.c b/line-log.c
index b7864ad..1a6bc59 100644
--- a/line-log.c
+++ b/line-log.c
@@ -575,7 +575,7 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
 
 		name_part = skip_range_arg(item->string);
 		if (!name_part || *name_part != ':' || !name_part[1])
-			die("-L argument '%s' not of the form start,end:file",
+			die("-L argument not 'start,end:file' or ':funcname:file': %s",
 			    item->string);
 		range_part = xstrndup(item->string, name_part - item->string);
 		name_part++;
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 0901b30..4451127 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -54,14 +54,14 @@ canned_test "-L 4:a.c -L 8,12:a.c simple" multiple-superset
 canned_test "-L 8,12:a.c -L 4:a.c simple" multiple-superset
 
 test_bad_opts "-L" "switch.*requires a value"
-test_bad_opts "-L b.c" "argument.*not of the form"
-test_bad_opts "-L 1:" "argument.*not of the form"
+test_bad_opts "-L b.c" "argument not .start,end:file"
+test_bad_opts "-L 1:" "argument not .start,end:file"
 test_bad_opts "-L 1:nonexistent" "There is no path"
 test_bad_opts "-L 1:simple" "There is no path"
-test_bad_opts "-L '/foo:b.c'" "argument.*not of the form"
+test_bad_opts "-L '/foo:b.c'" "argument not .start,end:file"
 test_bad_opts "-L 1000:b.c" "has only.*lines"
 test_bad_opts "-L 1,1000:b.c" "has only.*lines"
-test_bad_opts "-L :b.c" "argument.*not of the form"
+test_bad_opts "-L :b.c" "argument not .start,end:file"
 test_bad_opts "-L :foo:b.c" "no match"
 
 test_expect_success '-L X (X == nlines)' '
-- 
2.4.0.rc1.42.g9642cc6

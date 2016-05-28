From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 5/8] xdiff: -W: don't include common trailing empty lines
 in context
Date: Sat, 28 May 2016 17:03:16 +0200
Message-ID: <5749B334.7030404@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
 <5749AF59.2070704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 17:03:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6fm3-00064n-PK
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 17:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbcE1PDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 11:03:30 -0400
Received: from mout.web.de ([212.227.15.3]:53814 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbcE1PD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 11:03:29 -0400
Received: from [192.168.178.36] ([79.213.120.97]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Lw0vl-1bZzJY2vsL-017ou0; Sat, 28 May 2016 17:03:17
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <5749AF59.2070704@web.de>
X-Provags-ID: V03:K0:HUKJDA7VNCs9S/5h4lXcU1MqjqFLFiRLrm3KOhH+eq1FchI9wVr
 O7EasvUQKMbhNDH8G2oIzqGGQnwAkYmz+jcq/OAFdTTyo6XE+xVPzwU6UaN4rWiKIMGcaEN
 X/pHe3A9mz3tr0Sgh9maDOhb66OkqY7XhYYRnTXhZCZIRq7iVM1PuxCwVXI1KXWBOT0hdWz
 AoarC8zN7cvnRyhfURGAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/+enB17+iwE=:kNFp759hdYgGlOttSgWz9f
 SVloid7RJsnr9rd3Bkn+V+r2U2bNZ6vLrpCx+K1Cw5YzOpsETLgujnGKlN1JJVmimuvVI9KtD
 aJB6rVyZDo9I1iLlsVeWj1VnV4ogNSkwswjeSKhLQrG8+ktH13Auf6Z0ptI40yvYb80VBTS1e
 UjcQgvATAP4oHRlf3itjk/XXbiUOA49Uj6M3QftrqXCBjOPAwDtK4KsWcj8U/gj0N+557kEEn
 CMqTXyTt9M9Ra9TyTY79AT4j5Z9DcbkX7+lekDwJSBJDp5vg1gJve6q7OvmEJSI0OupwvTRP4
 H3XUHsjQ/SugOVgTjQYDpxQ2xxT1jGmHgnE8/SuEYzOK/ULMXEGRD8aEjfTSJs2DgRBGC4CfM
 +Q9YpAowVb+RGAoCMTtT1SWCBSU7yfVQW1Cv5Ayy2owPsrM57HDRjuMJT4C3JFTl1V2GIORBq
 fgE1ZUqHYZaKAqv7x9SDTSyvmHJG1WhtP9kfMVFtBwYvDr1pw3LlIWHsohN8xyHLK4V4IkVqk
 SKiS8PgK+PjW7o1ybXdPf3M/NK7yDfblatEoAii4tXZoRNE3l3Puya1iBUI06yEcQ71DC38V4
 IkooiZUeRmgyuBSn/k5ktLINApFZE47XwA4ytf8wWJRekGtCq2/dzZT61iavUaj7sqFZ5tI5x
 +8gqyRlD4x9N2innWlSkvMUkF4lZ9IkvPmkIgYY5e13uW2ax2ytxIVhdpSGtRUNusn+CI5nSb
 PY9lS66oUN9eh4CRK+VlCvDA97TqWWcgrWfG2fGSbSyuAqWPCojQpJ1LoUBvG4OrCF7Xxzdf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295822>

Empty lines between functions are shown by diff -W, as it considers them
to be part of the function preceding them.  They are not interesting in
most languages.  The previous patch stopped showing them in the special
case of a function added at the end of a file.

Stop extending context to those empty lines by skipping back over them
from the start of the next function.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t4051-diff-function-context.sh | 4 ++--
 xdiff/xemit.c                    | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index b191c655..9fe590f 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -85,7 +85,7 @@ test_expect_success ' context does not include preceding empty lines' '
 	test "$(first_context_line <changed_hello.diff)" != " "
 '
 
-test_expect_failure ' context does not include trailing empty lines' '
+test_expect_success ' context does not include trailing empty lines' '
 	test "$(last_context_line <changed_hello.diff)" != " "
 '
 
@@ -103,7 +103,7 @@ test_expect_success ' context does not include other functions' '
 	test $(grep -c "^[ +-].*Begin" changed_includes.diff) -le 1
 '
 
-test_expect_failure ' context does not include trailing empty lines' '
+test_expect_success ' context does not include trailing empty lines' '
 	test "$(last_context_line <changed_includes.diff)" != " "
 '
 
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 29cec12..bfa53d3 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -231,6 +231,8 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			long fe1 = get_func_line(xe, xecfg, NULL,
 						 xche->i1 + xche->chg1,
 						 xe->xdf1.nrec);
+			while (fe1 > 0 && is_empty_rec(&xe->xdf1, fe1 - 1))
+				fe1--;
 			if (fe1 < 0)
 				fe1 = xe->xdf1.nrec;
 			if (fe1 > e1) {
-- 
2.8.3

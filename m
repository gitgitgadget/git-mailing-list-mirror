From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5b 09/17] ref-filter: make "%(symref)" atom work with the ':short' modifier
Date: Mon, 25 Apr 2016 20:47:50 +0530
Message-ID: <1461597478-31855-9-git-send-email-Karthik.188@gmail.com>
References: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 17:18:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auiHT-0005mc-Pk
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 17:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbcDYPSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 11:18:31 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35482 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932606AbcDYPS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 11:18:29 -0400
Received: by mail-pa0-f41.google.com with SMTP id iv1so16579731pac.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 08:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=100t404QkxvNUAJm6eEDHKr5nXna+qK+wJ1B40pgE+s=;
        b=T2FlE/zigeJoD0g39ZmrDCv+N3Ust0Iw2eeehDtPFq3WYjFNsKOGGcnBUX5lRkNAAx
         546l2JW/zEiehxkiXVOeV2wDSu7T1ODvL+ePmBdRMpf1Htpj+yAdiTf/akt9WbHgICgu
         oWYscqT1MPtO7DwDdwus+Uo1MltpWN2PB752S2uDxCK/hR21LOhqOKJTlgcwv6A8oFt0
         i3c6JCHDKQIu/6MSTlx9Owt5N/Njv2FKZ4Amr1aADbPOOB10echOs4Y3LmzUN5Q9FRA9
         79Flpiw3rE48vCM898vKjgSjDZvUOit5IzvIt+yvqRR66E4+yD9SArt+90qrHpbwI2YN
         Uigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=100t404QkxvNUAJm6eEDHKr5nXna+qK+wJ1B40pgE+s=;
        b=ASm3TLu7QERGspV2IFCTlsk7OEw++4nsQg2IsIYGX41+udnBRhwQRx/to716u+5k9O
         qCgStfGIT4vo+loDjAcy5u1hPEis2JEcEJ/Su/bCheNq1cOwaPUEsUXb+W5hXz/SBclc
         tLgcfwXCY2JIElc4irhavvOV4EXlCePuCfQPJkzbZB9XnF0rdfXcsaHggDK68yPH9Cun
         MoApS80LQ+CHPOsG3TXTBZwvwEhp20ynzLUuJUlYsCU4tb25II2sOyd1ghwK3MG1BcwV
         Ti3/IMleWKaDKyJ3tfS9UUWUqmooTnlPIjIp6GLxDZQVtfjBKd7bC7EMlY/FMjRvv/gN
         ufoA==
X-Gm-Message-State: AOPr4FVqlCaV6lWwA/dgBKoQQl/xDANUOrxD+Zh7tRdpp6u+5P7xXR9Pfyc5Zt/yS3hv2w==
X-Received: by 10.67.8.100 with SMTP id dj4mr49821340pad.88.1461597508748;
        Mon, 25 Apr 2016 08:18:28 -0700 (PDT)
Received: from ashley.localdomain ([106.51.234.108])
        by smtp.gmail.com with ESMTPSA id ut1sm30812527pac.46.2016.04.25.08.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 08:18:27 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292493>

The "%(symref)" atom doesn't work when used with the ':short' modifier
because we strictly match only 'symref' for setting the 'need_symref'
indicator. Fix this by using comparing with valid_atom rather than used_atom.

Add tests for %(symref) and %(symref:short) while we're here.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c            |  2 +-
 t/t6300-for-each-ref.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index b898bcd..083cc27 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -338,7 +338,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 		valid_atom[i].parser(&used_atom[at], arg);
 	if (*atom == '*')
 		need_tagged = 1;
-	if (!strcmp(used_atom[at].name, "symref"))
+	if (!strcmp(valid_atom[i].name, "symref"))
 		need_symref = 1;
 	return at;
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2c5f177..b06ea1c 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -38,6 +38,7 @@ test_atom() {
 	case "$1" in
 		head) ref=refs/heads/master ;;
 		 tag) ref=refs/tags/testtag ;;
+		 sym) ref=refs/heads/sym ;;
 		   *) ref=$1 ;;
 	esac
 	printf '%s\n' "$3" >expected
@@ -565,4 +566,27 @@ test_expect_success 'Verify sort with multiple keys' '
 		refs/tags/bogo refs/tags/master > actual &&
 	test_cmp expected actual
 '
+
+test_expect_success 'Add symbolic ref for the following tests' '
+	git symbolic-ref refs/heads/sym refs/heads/master
+'
+
+cat >expected <<EOF
+refs/heads/master
+EOF
+
+test_expect_success 'Verify usage of %(symref) atom' '
+	git for-each-ref --format="%(symref)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+heads/master
+EOF
+
+test_expect_success 'Verify usage of %(symref:short) atom' '
+	git for-each-ref --format="%(symref:short)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.8.0

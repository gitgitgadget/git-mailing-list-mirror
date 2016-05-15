From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 09/17] ref-filter: make "%(symref)" atom work with the ':short' modifier
Date: Sun, 15 May 2016 16:15:25 +0530
Message-ID: <1463309133-14503-10-git-send-email-Karthik.188@gmail.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 12:47:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1tZI-00043d-CR
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 12:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183AbcEOKqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 06:46:09 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36493 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbcEOKqD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 06:46:03 -0400
Received: by mail-pf0-f195.google.com with SMTP id g132so13141877pfb.3
        for <git@vger.kernel.org>; Sun, 15 May 2016 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QDuTs7SdWiwMw8rbObSBj8BcecGHjoWSNB8sXMkyo+s=;
        b=Pv+VwLnUtBSWDxJ/F4ewePDCDSvmJdgl5+VSI7KsJuAVqhuukNbgavHLUiIXRebisG
         IMF862aLfjW4g3gxwy4Si/XdZgH9PZhLsHkL4XB77m7gZA1wThrqsPspX+bW6eswVC8U
         ACYSaACLieMgHvH+DgW3xBSTzBfZTi2b8yfJ9WCZNuM4di/jaYZul1KwkCFaEcGZoFkk
         O7SelrPau39/dtPrbo2hAHUePQf4f+RjhiNtJLPGJkgB4aHCbFO9+P6ePyVDhBNLaABW
         a75tOpU6ORne2JcZ1lFsFcO7M4jyCe0S5JqYo1TMIeBK2ZovJhk6Ap1A0YbdvoDyRApB
         DojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QDuTs7SdWiwMw8rbObSBj8BcecGHjoWSNB8sXMkyo+s=;
        b=Rb9UatpOBn6EBZ+9G4YXAd4vubq57vj1vHXZxxrSfb4bOvziGWzVTQrMObw3bgZb9C
         nO2rdXLhnB15v1mpCi3YJTNlAGEtYCqLrY6QnhOuXTUMyDFI2QdPS/+MbCeHOpmtV19j
         H7TozBJEGGxwIB2khQbmGXAtToJWhDA7Ry8ATL8ozVU+1uPu+rrjYJgh7u83vgC4U2Ut
         ptunHmKt4zI59WDdCTVDpMRRP7ODfvV44nzbFTkCDBJH3/w0eG2qAiyyibS0hhr962S+
         TqihtjQkCbNUwD0+0EJB9LlK+wzmwl1bP9GPTRv+ahDxcwCrA9iKlFI8Y2q0u2VaOwpc
         Ziyg==
X-Gm-Message-State: AOPr4FUqeeMIU6g1LVAr1U/NlbE7hbq+VD5OvuKEfWdHXjzw6l/R3QNJwdYqG7fd+u3zfQ==
X-Received: by 10.98.52.195 with SMTP id b186mr36828770pfa.9.1463309163009;
        Sun, 15 May 2016 03:46:03 -0700 (PDT)
Received: from ashley.localdomain ([106.51.133.65])
        by smtp.gmail.com with ESMTPSA id 71sm39866747pfy.32.2016.05.15.03.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 May 2016 03:46:02 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294665>

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
2.8.2

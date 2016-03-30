From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 09/16] ref-filter: make "%(symref)" atom work with the ':short' modifier
Date: Wed, 30 Mar 2016 15:09:53 +0530
Message-ID: <1459330800-12525-10-git-send-email-Karthik.188@gmail.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 11:41:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alCcl-00022C-93
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 11:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbcC3Jkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 05:40:41 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36677 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbcC3Jki (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 05:40:38 -0400
Received: by mail-pf0-f177.google.com with SMTP id e128so16662664pfe.3
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 02:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i9cdzmpjJguux+dqMtc7at43Wp+lYKI6YdPHUaFCNA8=;
        b=uaIOX/hyf0SQVCE48hSu7EOSOvhXKtfhu32l32bM3fYJlOyjBXQLe3UdIrZGlGmWgA
         4D228RMrmeR7lPjz8U5maHZ1mnyi8S0JfCizVbIHES8iX9Ro8wE9ufsTEZEoLAvyf/SX
         TGAYTby5lKS5dnNTQd5ALj6yJm+au6dCQwmrmkd/peFZCTqbx3l6aROhvRX6ObL4Yowj
         1zuAbF8i4NOk/D8htFBs4LfYiTs6UXxnX5sT5RAREtjMZynmuLqNS7egimpFr9mEpbwQ
         0esXLxTgOw3ush4YOUSke9CxB9IBsmBeV7WBy6mm74Jkz4bG4/ZtZ+/jFW+7T6u4rGC1
         6yGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i9cdzmpjJguux+dqMtc7at43Wp+lYKI6YdPHUaFCNA8=;
        b=MLKmTaKLaPtwD6FvFxXmBeIGgc++50HpLZVmbZBxuphhSh3zCjXhMTT668hP+z4fEB
         SO0oWFMXFDnyXdWFNIEfUtZu35SkvwGLfZYmP5RjVKLP0URBnChOU3NB6Wwr9q69k2Xe
         ICgGrA6PGuuWtRMu3xsViBJWTMTYuIgnhhUPjcsrFRP0g8yJQXfTtYHykJNuymQp2a0C
         KAOtC/qJkjcR77/JQFvW46fc0MQC78qHSInUeEPvn83UbisTjjSMRWZcTeFRFksr0sFW
         Yizg+RtsYvSonxP9889ZQVjLC72gNRTvWEns2JSOSCLLmD55cvIQQsYVW+GuxKxVzkgV
         Zidw==
X-Gm-Message-State: AD7BkJJ0XSou5ogVFUy2eoBlaWR04kLsZM1H8fiE3SDzvLoDadlk9czNmLdz9aAhocps+Q==
X-Received: by 10.98.68.145 with SMTP id m17mr11301509pfi.65.1459330831406;
        Wed, 30 Mar 2016 02:40:31 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.45])
        by smtp.gmail.com with ESMTPSA id r65sm4402606pfa.27.2016.03.30.02.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 02:40:30 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290295>

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
index 8c97cdb..5c59b17 100644
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
2.7.4

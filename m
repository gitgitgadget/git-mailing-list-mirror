From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 08/16] ref-filter: make "%(symref)" atom work with the ':short' modifier
Date: Sat, 23 Apr 2016 00:33:59 +0530
Message-ID: <1461351847-22903-9-git-send-email-Karthik.188@gmail.com>
References: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 21:05:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atgNz-0008Fb-3b
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 21:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbcDVTE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 15:04:58 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36766 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbcDVTE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 15:04:57 -0400
Received: by mail-pf0-f196.google.com with SMTP id p185so10496290pfb.3
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=100t404QkxvNUAJm6eEDHKr5nXna+qK+wJ1B40pgE+s=;
        b=kCNv2ngVaULaI4+B7caUMq9K60fa1m82Jfg3mX+fqzkOsJ1hMyyv2NhaBdb18wHBNA
         qVlw6OXqg6KpDjD08oXfJbv8uty1yxZwvsWXGaFvO90CyoTLsBPFsReViSZJvEaRk6CF
         ta5hTsbn9IAtTttgpZ4HTOH0xLul392NpabnBCfJp+9+Iib2z4uWu0Pq5GFUnijL/06e
         Ct3IBGLnOaObHs1Kb5K9EhD3+WByavnwM7xZJXS8I2coFfQkSp5m6+a3U2mghfkNpAS4
         dFhTQtgjlnB4PQw81gBvpM9iS0fdmNhI20ZiaI/O28o7elYE3BI4rXsJMder6auDFKmh
         bItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=100t404QkxvNUAJm6eEDHKr5nXna+qK+wJ1B40pgE+s=;
        b=Afsgdf9s556cMB88gMZZN+5tvhUYqM+LK1ZXzVXnkeHVS1Px1FdIr4sv0ZTC5YhdNo
         pHAsoRAxA3BkQdcB/prPOX1Q0PYX27G/n+HvFNinPoUD5OGjxE81CR1peWRxwOp8SsAw
         Mr7eu5G+Azb4mseyrS0HpWzah0KXanpOXOeFye601kSx6TBvpjWLLKtvfnefdggh04PP
         UsIf/ANdUL8VLCkCB9BqMmKeokOmoBkPRN/FzR3MMEJ5HzsmHJP50JdAEDywE8J6/K3D
         dEm+f5nbbSUZrHm9f8rK+XlxqP7g5vPa2w0vxt7BT/UM52FEldoGpwg8CZYJKE1v+It3
         zuvA==
X-Gm-Message-State: AOPr4FXrVeW9Dn3nl6yeUokhVWkei/wp6zinU9XAOuY0UNpCCAg/FiNiiyydttflyDA3mw==
X-Received: by 10.98.8.75 with SMTP id c72mr31023601pfd.39.1461351896913;
        Fri, 22 Apr 2016 12:04:56 -0700 (PDT)
Received: from ashley.localdomain ([106.216.186.206])
        by smtp.gmail.com with ESMTPSA id t1sm11266470paa.17.2016.04.22.12.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 12:04:56 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292253>

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

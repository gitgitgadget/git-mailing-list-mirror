From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 24/27] t5500, t5539: tests for shallow depth excluding a ref
Date: Sun, 12 Jun 2016 17:54:06 +0700
Message-ID: <20160612105409.22156-25-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:56:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC34S-0004A1-P5
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbcFLK4p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:56:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33752 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbcFLK4o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:56:44 -0400
Received: by mail-pf0-f196.google.com with SMTP id c74so8477098pfb.0
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sG+3CScm5ARkfAdUAsrD3swBy2r6r9ocWOrHgZRGyqc=;
        b=e6NEFEqaXsiWOq4EcXDCpXI8FClbc65ufnRsrph4cYvgP4lUpriBX6RJxripEpuPso
         d1jDAClZ0eQzZzC2y3hXJxsMtku6ZBEHp4JZCK1NoODJ/2gt/pZOWdwNucMwR7p1nB6G
         Rj+bz+Z6wbekNqZKzPJa6lwS3XZs1cEyT7dDlUQTQE2JscWvbVXj8oYsVUeu9/7KFTCA
         Nsikpp6Tq39XWkbZ0skqNXkRvLA7Ux9+afzuu0+fD0Zc/jpTQH9VgBSY2NKmyEVHe6WK
         u4tP6Q2uRF0M8cL5aGFfSwTU8YitnVBrnEJRmqTZL95pbTxe1WxTemBCcEDZYDaFNEwL
         pF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sG+3CScm5ARkfAdUAsrD3swBy2r6r9ocWOrHgZRGyqc=;
        b=dJbqhIAgxOs+cfftT+St9QPOsz0dW7nstqZbxFaHN/0GitN7osdkmKformLdN5Sc7D
         ynfXf5YqT0w5fr/4NXK5Rs1WeywxJhcke9oxhscBlNj19U7d4UL291eGimaIXJVul7SP
         5U4MIaUrSQveLY63422b8hW1vhf0limqRjhw61rRcNwE3hm1Z25hGIPZCOffmOAAlEaP
         sKBQYwJX3S+E8rjSnpp1Jt8XROg8Fnhs7dNP5uckVjaxyXRRY0FPMv+RkbixQVzEVCnl
         3obYaG6wdtxrRBki89ZaYufHJOldLGYX+H2NTSU+Db9mX67+S+c5yjn7FhJnerQLeyNX
         TTvw==
X-Gm-Message-State: ALyK8tKjiDK2T8qtQ7nBuSy0Q0oi+q0iB5fNXIXToG7Hoc7Uuuj8dOb28M4655DvlHo5iQ==
X-Received: by 10.98.89.147 with SMTP id k19mr14457059pfj.156.1465729003664;
        Sun, 12 Jun 2016 03:56:43 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id t10sm1553001pan.34.2016.06.12.03.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:56:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:56:39 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297130>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5500-fetch-pack.sh         | 21 +++++++++++++++++++++
 t/t5539-fetch-http-shallow.sh | 22 ++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 26f050d..145b370 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -661,4 +661,25 @@ test_expect_success 'fetch shallow since ...' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'shallow clone exclude tag two' '
+	test_create_repo shallow-exclude &&
+	(
+	cd shallow-exclude &&
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	git clone --shallow-exclude two "file://$(pwd)/." ../shallow12 &&
+	git -C ../shallow12 log --pretty=3Dtformat:%s HEAD >actual &&
+	echo three >expected &&
+	test_cmp expected actual
+	)
+'
+
+test_expect_success 'fetch exclude tag one' '
+	git -C shallow12 fetch --shallow-exclude one origin &&
+	git -C shallow12 log --pretty=3Dtformat:%s origin/master >actual &&
+	test_write_lines three two >expected &&
+	test_cmp expected actual
+'
+
 test_done
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow=
=2Esh
index 704753c..8e38c1b 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -98,5 +98,27 @@ test_expect_success 'fetch shallow since ...' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'shallow clone exclude tag two' '
+	test_create_repo shallow-exclude &&
+	(
+	cd shallow-exclude &&
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	mv .git "$HTTPD_DOCUMENT_ROOT_PATH/shallow-exclude.git" &&
+	git clone --shallow-exclude two $HTTPD_URL/smart/shallow-exclude.git =
=2E./shallow12 &&
+	git -C ../shallow12 log --pretty=3Dtformat:%s HEAD >actual &&
+	echo three >expected &&
+	test_cmp expected actual
+	)
+'
+
+test_expect_success 'fetch exclude tag one' '
+	git -C shallow12 fetch --shallow-exclude one origin &&
+	git -C shallow12 log --pretty=3Dtformat:%s origin/master >actual &&
+	test_write_lines three two >expected &&
+	test_cmp expected actual
+'
+
 stop_httpd
 test_done
--=20
2.8.2.524.g6ff3d78

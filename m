Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBA9C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E36220656
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYmX9a7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgHUREP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgHURAl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 13:00:41 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C84FC06179A
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:00:19 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q1so1081286pjd.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SnwZdWiZ7Px/29uFhZtEzcy68tcyXj0Eupyu8JdP+Ng=;
        b=cYmX9a7hLya0OCAbthxI0WlCWdbQtiGKeloOTVoSsDS4jK9Pjdtt+LncnmkX5grKET
         x79LMYahiKjYGtowa4e2ASqyV3rm0xuXQMWlX8SOQTEEq1oeE5vna+E+mbJRZnbH29qF
         VUDQnc58LVepxv1FfV8BskmAyc6lIHQ10eIYGuzk/FJCLOCM83x2tixEzqSKPtv8qF8G
         AB3ymE6YGK5B0AvGbxSPRRASMGZhHsNj+w2828elMkHEmAnvTUUa9keYa3kl48JjnWMO
         pV+2AixqmPIW4FVpP44PmLbLv7khwmOoYCwSk3FkEEs1bCbW8E7iJ3ws8keDxGmBiaH2
         P/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SnwZdWiZ7Px/29uFhZtEzcy68tcyXj0Eupyu8JdP+Ng=;
        b=kRY+Xf5cdzw5ipJbOw/NkF1frO665kQZ53r0rSPebNCnC+p1307WF2qqrCvx7xId/+
         6HKThIwLOiXJY6OlE40DsRzikGgdmDMTA5OKzB1Vcm/27BCdh/a/D5yFIbyzS2G73L+h
         jfJZ0ZgavHO70MdgDu4Caha7OmMFejWZc+XQrw9juelD6ynlWKLScIO+sDe2grTX5Qll
         hGsxRj9bzPeik9YbsARX8SLzOMvvThyAjXCe5Wsy2r251pSku/s/wC+KGtihI4wP41dS
         Yrh+JulY6FngeQfnwd+VSLiNEck4pJejMT41G4Qgev9alYmnDZSrpffJrQ6BRtDVBvQg
         g2+w==
X-Gm-Message-State: AOAM532Cvs7aBuoZM0zdF0IGC4nS4HuyQQxytoBYLWW+aGwln9rOzsmE
        W5J2FDGDOwSFdTs2rBs9MzIPAotwN2ppKQ==
X-Google-Smtp-Source: ABdhPJzUr6+tIt+aBQH5leoON6NG5uTd45YxTigtbVIzjORrYewYi1IAmpFP5tNqrMx/C+CQogGvHA==
X-Received: by 2002:a17:902:c154:: with SMTP id 20mr3211167plj.64.1598029218448;
        Fri, 21 Aug 2020 10:00:18 -0700 (PDT)
Received: from localhost.localdomain ([125.99.204.38])
        by smtp.gmail.com with ESMTPSA id q7sm3043505pfu.133.2020.08.21.10.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 10:00:17 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, me@ttaylorr.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@taylorr.com>
Subject: [PATCH v3 4/5] t7401: change indentation for enhanced readability
Date:   Fri, 21 Aug 2020 22:29:51 +0530
Message-Id: <20200821165952.14376-5-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821165952.14376-1-shouryashukla.oo@gmail.com>
References: <20200821165952.14376-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the indentation of expected outputs for enhanced readability of
the tests. Also modify the heredoc string limiter in a test which lacks
it to support the indentation change.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Taylor Blau <me@taylorr.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh | 130 +++++++++++++++++------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 3f580455f7..1491ab6448 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -38,10 +38,10 @@ test_expect_success 'added submodule' "
 	git add sm1 &&
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 0000000...$head1 (2):
-  > Add foo2
+	* sm1 0000000...$head1 (2):
+	  > Add foo2
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
@@ -52,10 +52,10 @@ test_expect_success 'added submodule (subdirectory)' "
 		git submodule summary >../actual
 	) &&
 	cat >expected <<-EOF &&
-* ../sm1 0000000...$head1 (2):
-  > Add foo2
+	* ../sm1 0000000...$head1 (2):
+	  > Add foo2
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
@@ -73,10 +73,10 @@ test_expect_success 'added submodule (subdirectory with explicit path)' "
 		git submodule summary ../sm1 >../actual
 	) &&
 	cat >expected <<-EOF &&
-* ../sm1 0000000...$head1 (2):
-  > Add foo2
+	* ../sm1 0000000...$head1 (2):
+	  > Add foo2
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
@@ -86,20 +86,20 @@ head2=$(add_file sm1 foo3)
 test_expect_success 'modified submodule(forward)' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head1...$head2 (1):
-  > Add foo3
+	* sm1 $head1...$head2 (1):
+	  > Add foo3
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
 test_expect_success 'modified submodule(forward), --files' "
 	git submodule summary --files >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head1...$head2 (1):
-  > Add foo3
+	* sm1 $head1...$head2 (1):
+	  > Add foo3
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
@@ -110,10 +110,10 @@ test_expect_success 'no ignore=all setting has any effect' "
 	git config diff.ignoreSubmodules all &&
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head1...$head2 (1):
-  > Add foo3
+	* sm1 $head1...$head2 (1):
+	  > Add foo3
 
-EOF
+	EOF
 	test_cmp expected actual &&
 	git config --unset diff.ignoreSubmodules &&
 	git config --remove-section submodule.sm1 &&
@@ -131,11 +131,11 @@ head3=$(
 test_expect_success 'modified submodule(backward)' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head2...$head3 (2):
-  < Add foo3
-  < Add foo2
+	* sm1 $head2...$head3 (2):
+	  < Add foo3
+	  < Add foo2
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
@@ -144,25 +144,25 @@ head4_full=$(GIT_DIR=sm1/.git git rev-parse --verify HEAD)
 test_expect_success 'modified submodule(backward and forward)' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head2...$head4 (4):
-  > Add foo5
-  > Add foo4
-  < Add foo3
-  < Add foo2
+	* sm1 $head2...$head4 (4):
+	  > Add foo5
+	  > Add foo4
+	  < Add foo3
+	  < Add foo2
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
 test_expect_success '--summary-limit' "
 	git submodule summary -n 3 >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head2...$head4 (4):
-  > Add foo5
-  > Add foo4
-  < Add foo3
+	* sm1 $head2...$head4 (4):
+	  > Add foo5
+	  > Add foo4
+	  < Add foo3
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
@@ -177,20 +177,20 @@ mv sm1-bak sm1
 test_expect_success 'typechanged submodule(submodule->blob), --cached' "
 	git submodule summary --cached >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head4(submodule)->$head5(blob) (3):
-  < Add foo5
+	* sm1 $head4(submodule)->$head5(blob) (3):
+	  < Add foo5
 
-EOF
+	EOF
 	test_i18ncmp expected actual
 "
 
 test_expect_success 'typechanged submodule(submodule->blob), --files' "
 	git submodule summary --files >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head5(blob)->$head4(submodule) (3):
-  > Add foo5
+	* sm1 $head5(blob)->$head4(submodule) (3):
+	  > Add foo5
 
-EOF
+	EOF
 	test_i18ncmp expected actual
 "
 
@@ -199,9 +199,9 @@ git checkout-index sm1
 test_expect_success 'typechanged submodule(submodule->blob)' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head4(submodule)->$head5(blob):
+	* sm1 $head4(submodule)->$head5(blob):
 
-EOF
+	EOF
 	test_i18ncmp expected actual
 "
 
@@ -211,10 +211,10 @@ head6=$(add_file sm1 foo6 foo7)
 test_expect_success 'nonexistent commit' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head4...$head6:
-  Warn: sm1 doesn't contain commit $head4_full
+	* sm1 $head4...$head6:
+	  Warn: sm1 doesn't contain commit $head4_full
 
-EOF
+	EOF
 	test_i18ncmp expected actual
 "
 
@@ -222,10 +222,10 @@ commit_file
 test_expect_success 'typechanged submodule(blob->submodule)' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head5(blob)->$head6(submodule) (2):
-  > Add foo7
+	* sm1 $head5(blob)->$head6(submodule) (2):
+	  > Add foo7
 
-EOF
+	EOF
 	test_i18ncmp expected actual
 "
 
@@ -234,9 +234,9 @@ rm -rf sm1
 test_expect_success 'deleted submodule' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head6...0000000:
+	* sm1 $head6...0000000:
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
@@ -249,22 +249,22 @@ test_expect_success 'create second submodule' '
 test_expect_success 'multiple submodules' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head6...0000000:
+	* sm1 $head6...0000000:
 
-* sm2 0000000...$head7 (2):
-  > Add foo9
+	* sm2 0000000...$head7 (2):
+	  > Add foo9
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
 test_expect_success 'path filter' "
 	git submodule summary sm2 >actual &&
 	cat >expected <<-EOF &&
-* sm2 0000000...$head7 (2):
-  > Add foo9
+	* sm2 0000000...$head7 (2):
+	  > Add foo9
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
@@ -272,24 +272,24 @@ commit_file sm2
 test_expect_success 'given commit' "
 	git submodule summary HEAD^ >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head6...0000000:
+	* sm1 $head6...0000000:
 
-* sm2 0000000...$head7 (2):
-  > Add foo9
+	* sm2 0000000...$head7 (2):
+	  > Add foo9
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
 test_expect_success '--for-status' "
 	git submodule summary --for-status HEAD^ >actual &&
-	test_i18ncmp - actual <<EOF
-* sm1 $head6...0000000:
+	test_i18ncmp - actual <<-EOF
+	* sm1 $head6...0000000:
 
-* sm2 0000000...$head7 (2):
-  > Add foo9
+	* sm2 0000000...$head7 (2):
+	  > Add foo9
 
-EOF
+	EOF
 "
 
 test_expect_success 'fail when using --files together with --cached' "
-- 
2.28.0


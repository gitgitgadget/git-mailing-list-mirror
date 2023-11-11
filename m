Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63A514AB0
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie1VuKnA"
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B140F3865
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 05:27:53 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32ded3eb835so1991721f8f.0
        for <git@vger.kernel.org>; Sat, 11 Nov 2023 05:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699709272; x=1700314072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV7JWfISEzXM9guO459MhboJtZ7dwDebeWyfo222wK8=;
        b=Ie1VuKnARj9NbMucqKqOgkxfmx7WV3Pl/zq37Ds9EboQOmmRTyaKY8NQlZccvMKYt9
         VCGJvEEHX91wkVtKt2Oo5SXwRTzA0uNco4P3MapqFQ/Tmx0bXl8ylO2+mRJa1pdXg6jQ
         KetCZM0IMCpAwK026hH+mHa8Hz/5ux59cjnKyYpLoHfoR4Y9XwekyVLNKO3ObZkbb5Jq
         4QJJ6Vs7DCnFbbGLYDaMJhTmIs1y3zBZ0gEaVL8DHusftZf2tG14kW1tE56ORlCNk/Pq
         DtGduCLx6hx0hfbs7dwWg5EY7yz6qSqL8Z7akBhLjR4tXTBVrjOp4trpK/OvXPrQbvBT
         JAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699709272; x=1700314072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aV7JWfISEzXM9guO459MhboJtZ7dwDebeWyfo222wK8=;
        b=j3xGU+cwVHDBdsraGJ7CpaF1ei0vrYtQdtN5EZ4xllkadQ1gA03o+5zUYXDQlGmjfs
         kgO/85DykOxFpJn55Jywc0RcI0sqkZTnUDiik+roHLXdGPzpaPtzY/AOhyoDBvcR8PXa
         9g4bdykwDmlvS6bQVYElRV4JcEPDHOxZ4Rh+KPmWalrZUdRUsqL5Txge9wR88SHMlAB6
         9bSEmX7PwQ724FWyj9s9gas4mBMj6Ct/ae6VczZrC7n22HdJ/RG6VNxAt375Wmmxz0v6
         RZTPgAdN7/y5okl8R2FlpgtmoaATWr/bNpKnLULBp0O/a1A1FexJZc3pMckWsuUJ4qoj
         dtPw==
X-Gm-Message-State: AOJu0YxCEPDZf9CUg7VW/cem6GMKgxkMOP4gS6WKvN94B8SZ8r56ziKg
	1kdn/D1jRyoGGVHUdmL+NnK9gePq3Sq27A==
X-Google-Smtp-Source: AGHT+IEwzf5+/AjbIliSYRAtBLcMtd4KeVU1dr1PWGMkPTv0QR11CE99Vt5HEw9puJflNvvlIlKSvg==
X-Received: by 2002:adf:e4c4:0:b0:32d:a2c4:18bf with SMTP id v4-20020adfe4c4000000b0032da2c418bfmr1643244wrm.59.1699709272006;
        Sat, 11 Nov 2023 05:27:52 -0800 (PST)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id h4-20020adff4c4000000b0031ad5fb5a0fsm1467102wrp.58.2023.11.11.05.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 05:27:51 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	newren@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v4 3/4] rebase: test autosquash with and without -i
Date: Sat, 11 Nov 2023 13:27:17 +0000
Message-ID: <20231111132720.78877-4-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc1
In-Reply-To: <20231111132720.78877-1-andy.koppe@gmail.com>
References: <20231105000808.10171-1-andy.koppe@gmail.com>
 <20231111132720.78877-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Amend t3415-rebase-autosquash.sh to test the --autosquash option and
rebase.autoSquash config with and without -i.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 t/t3415-rebase-autosquash.sh | 38 ++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index a364530d76..fcc40d6fe1 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -43,7 +43,7 @@ test_auto_fixup () {
 
 	git tag $1 &&
 	test_tick &&
-	git rebase $2 -i HEAD^^^ &&
+	git rebase $2 HEAD^^^ &&
 	git log --oneline >actual &&
 	if test -n "$no_squash"
 	then
@@ -61,15 +61,24 @@ test_auto_fixup () {
 }
 
 test_expect_success 'auto fixup (option)' '
-	test_auto_fixup final-fixup-option --autosquash
+	test_auto_fixup fixup-option --autosquash &&
+	test_auto_fixup fixup-option-i "--autosquash -i"
 '
 
-test_expect_success 'auto fixup (config)' '
+test_expect_success 'auto fixup (config true)' '
 	git config rebase.autosquash true &&
-	test_auto_fixup final-fixup-config-true &&
+	test_auto_fixup ! fixup-config-true &&
+	test_auto_fixup fixup-config-true-i -i &&
 	test_auto_fixup ! fixup-config-true-no --no-autosquash &&
+	test_auto_fixup ! fixup-config-true-i-no "-i --no-autosquash"
+'
+
+test_expect_success 'auto fixup (config false)' '
 	git config rebase.autosquash false &&
-	test_auto_fixup ! final-fixup-config-false
+	test_auto_fixup ! fixup-config-false &&
+	test_auto_fixup ! fixup-config-false-i -i &&
+	test_auto_fixup fixup-config-false-yes --autosquash &&
+	test_auto_fixup fixup-config-false-i-yes "-i --autosquash"
 '
 
 test_auto_squash () {
@@ -87,7 +96,7 @@ test_auto_squash () {
 	git commit -m "squash! first" -m "extra para for first" &&
 	git tag $1 &&
 	test_tick &&
-	git rebase $2 -i HEAD^^^ &&
+	git rebase $2 HEAD^^^ &&
 	git log --oneline >actual &&
 	if test -n "$no_squash"
 	then
@@ -105,15 +114,24 @@ test_auto_squash () {
 }
 
 test_expect_success 'auto squash (option)' '
-	test_auto_squash final-squash --autosquash
+	test_auto_squash squash-option --autosquash &&
+	test_auto_squash squash-option-i "--autosquash -i"
 '
 
-test_expect_success 'auto squash (config)' '
+test_expect_success 'auto squash (config true)' '
 	git config rebase.autosquash true &&
-	test_auto_squash final-squash-config-true &&
+	test_auto_squash ! squash-config-true &&
+	test_auto_squash squash-config-true-i -i &&
 	test_auto_squash ! squash-config-true-no --no-autosquash &&
+	test_auto_squash ! squash-config-true-i-no "-i --no-autosquash"
+'
+
+test_expect_success 'auto squash (config false)' '
 	git config rebase.autosquash false &&
-	test_auto_squash ! final-squash-config-false
+	test_auto_squash ! squash-config-false &&
+	test_auto_squash ! squash-config-false-i -i &&
+	test_auto_squash squash-config-false-yes --autosquash &&
+	test_auto_squash squash-config-false-i-yes "-i --autosquash"
 '
 
 test_expect_success 'misspelled auto squash' '
-- 
2.43.0-rc1


Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDDE301472
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468568; cv=pass; b=Z0syz/Gg1mQUBg0fGNxPMCCVpm+ODKlVIhtG1B984I8qaRs0G0hImeiKyG2OluSjVHKPhUxKgQOoKLUFFap8TUVmahXNkVXuUhh0f50thNzJw01rccSLmJBRmQkqEKRD4mceGycDOS7ERlO/uXlIetwQ4nNnNJbBD7rIMcNDX9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468568; c=relaxed/simple;
	bh=7xfVU0PiLnVZDORQKIzKIHwSgiGVHWDicw3PA9aWQ+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+W61DRTjoIT4lC6feiuS+vDw+/e/LKW4knaDIDXhHGEKf/Dce+tLKL+enACuu8ij5VPnLekAHGoFpyBVw/LBAozmi2KCQkddGyGg0XjVuCpiaQm5JHTpMIMUSw6F220Hof459cZmleta+rY4TBeNwp69xoRyOLmaQ4WaIEvimY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=O5G3qwtQ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="O5G3qwtQ"
ARC-Seal: i=1; a=rsa-sha256; t=1774468556; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=doQcJfPOmeBVN+XVSR+LsEP96vO0H+drnHECfH5t4xP2O7gthS74ItiKo+bWqD+NL1cIwlITlj2VXGNT/Aom+1fLF3fUHJt+tnViM9k2+ZQY96GQVKttbo/pcnXCLOOX9FC1P+axvd2wkPE8FE+erYc+XPsCp3niQc4u3RTIrQQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774468556; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=elA5g80Ora1OXwWsgmluw17COHUWBC855ljGhqQTIKA=; 
	b=gHHmLY8kdbqkk79dBWU2FpqYwcF4WWtljoqSYE2yavDO0JflvkDQHfOiQVPMQraZuv/xwIUobL1a+1O1OivuG2TPcoqcSqgwFrDUYbMwFj+fUX8M0URoOEMpS2205+Z4iO8t1HQ6WkIYnJej+KiGGbDZ0CTBZ0/FKQwWet2sPEI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774468556;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=elA5g80Ora1OXwWsgmluw17COHUWBC855ljGhqQTIKA=;
	b=O5G3qwtQ2/ppsExK47hrmEbYh25Htqbp3pgaUrevNTDTEHMwj4uzb9RBdOM42/fS
	zEWxxSWh5rHZ+Jw/Xjmvsb31UKnhTuDXFaAXOuaSofgBGSVynTSRF5ZaFNaxP8hApWL
	DbQuhKm/KF2YMtD7NX4Ci65/uN8ieJGiVQXvqxLM=
Received: by mx.zohomail.com with SMTPS id 1774468554499301.6295528339972;
	Wed, 25 Mar 2026 12:55:54 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 08/12] t1800: add test to verify hook execution ordering
Date: Wed, 25 Mar 2026 21:54:59 +0200
Message-ID: <20260325195503.1139418-9-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260325195503.1139418-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260325195503.1139418-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

There is a documented expectation that configured hooks are
run before the hook from the hookdir. Add a test for it.

While at it, I noticed that `git hook list -h` runs twice
in the `git hook usage` test, so remove one invocation.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 t/t1800-hook.sh | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 952bf97b86..7eee84fc39 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -25,7 +25,6 @@ test_expect_success 'git hook usage' '
 	test_expect_code 129 git hook &&
 	test_expect_code 129 git hook run &&
 	test_expect_code 129 git hook run -h &&
-	test_expect_code 129 git hook list -h &&
 	test_expect_code 129 git hook run --unknown 2>err &&
 	test_expect_code 129 git hook list &&
 	test_expect_code 129 git hook list -h &&
@@ -381,6 +380,34 @@ test_expect_success 'globally disabled hook can be re-enabled locally' '
 	test_cmp expected actual
 '
 
+test_expect_success 'configured hooks run before hookdir hook' '
+	setup_hookdir &&
+	test_config hook.first.event "pre-commit" &&
+	test_config hook.first.command "echo first" &&
+	test_config hook.second.event "pre-commit" &&
+	test_config hook.second.command "echo second" &&
+
+	cat >expected <<-\EOF &&
+	first
+	second
+	hook from hookdir
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual &&
+
+	# "Legacy Hook" is the output of the hookdir pre-commit script
+	# written by setup_hookdir() above.
+	cat >expected <<-\EOF &&
+	first
+	second
+	"Legacy Hook"
+	EOF
+
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'git hook run a hook with a bad shebang' '
 	test_when_finished "rm -rf bad-hooks" &&
 	mkdir bad-hooks &&
-- 
2.52.0.732.gb351b5166d.dirty


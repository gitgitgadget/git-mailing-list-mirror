Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E371244675
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017705; cv=pass; b=COgW/goDeC+IGPBxmQkNbQD6ez3MhrTp9JNcTq94XTvgdAqITHS6PBnJY4MRNlkXBdZ2fqCyVp21bfTU1J60pbYCRFg15J/RHCnAlecTn6AZR95LoIKr9beR6jtuSsSBI6VTwpg4hq0dMXq2f22OiEbF+oxjxvyj1riLO1sy9QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017705; c=relaxed/simple;
	bh=7xfVU0PiLnVZDORQKIzKIHwSgiGVHWDicw3PA9aWQ+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2+DMLZ9Vg2YHoS8ajrv+Unon08SJfSP8ffTHcCNxcyoX5H1Pmp3Ccnui8aM4OM+AuG/tFJGRIQ0AMdgkW2HhPjDEllelobg2fYnkZDuVSbi974nTFIm51xpNClv6Wh3PBCUggQGOGb6t3AME0Yv/bOIlyo80tTp+ArKzpsww7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=KtShmqH/; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="KtShmqH/"
ARC-Seal: i=1; a=rsa-sha256; t=1773017691; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kBc7D92E7Xqr1umkjCIc0l5fAGX+Awn/GLenJAl2/K8IoEnzNQrsVT1rFwCoLQEw4ydFoKMLvczuznHLpQLuT/K7U4vbOu9Jhy6KcbcmWlM8OPmSSSF8e3236ES9KlOdRKWMGeiHLpilL7FqO5x3ITTE84E9y6q13PgSfseO9zw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773017691; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=elA5g80Ora1OXwWsgmluw17COHUWBC855ljGhqQTIKA=; 
	b=REfdbsmCJfKYMf1EAe67pnsfXlKDir0wYFALPRzsfdYsiVPw2XfwIfS2gDPFxPEBwr4lagzXbE463sFa+2m37LINgYdbU6gz9ozxv0e/hApxlRsT9ky28a8lLrOlzDpfPYfrt/jq5ejQvJ8IfwiHqKrO/CowpCkjy3bgfeXTtms=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773017691;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=elA5g80Ora1OXwWsgmluw17COHUWBC855ljGhqQTIKA=;
	b=KtShmqH/amlPcFKzNsOGdKzkU49fmKAoG+na4rhz+oo9I5f1bXBWHRBqz5qou5BA
	iftNxjylAoRRfhh52ohyXGeMSwBCBBXMfRyv3caXeH1r7mx6RrkFXch7tmeKpkWX/b4
	LwDWIS/yCJZWt6rSbBFfoGKHSMSg8pTneL1M20wc=
Received: by mx.zohomail.com with SMTPS id 1773017688709839.37073875545;
	Sun, 8 Mar 2026 17:54:48 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 07/10] t1800: add test to verify hook execution ordering
Date: Mon,  9 Mar 2026 02:54:13 +0200
Message-ID: <20260309005416.2760030-8-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
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


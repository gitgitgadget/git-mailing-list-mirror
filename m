Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9CE3AA4EC
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007597; cv=pass; b=Zj8mCQItbL7DMh0sfvelIGloPu2tJP4wzQnqB2aYlpewbYBPBm5bMdtC1Za6Uycu7bOl7EWHgzWGQsLPNHVHTh4kftJESXbLy2EuMZcMqfsA1BXrNe9xsQqVNeQBILKpgBYMQ+jwqri8U6sDKj8h5pSKh2WNPgkpugw8lX+lZCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007597; c=relaxed/simple;
	bh=7xfVU0PiLnVZDORQKIzKIHwSgiGVHWDicw3PA9aWQ+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoulHXUDiX793DeSIDjCYDzbkMf53V/1WYCSmRduSYsTXlM0iRIjqNA7zflfw7eJ5DVaHehMKAjitfBn7TeTrMXk/4IHAbotZJ/tmaeLtXHcE5+dOZGklEVKAk0gsOVmvm8wklCkyIbfZO6YH7DOJg2kq4v+Gvi5p0ZuAUigjI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Mzz7K5bL; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Mzz7K5bL"
ARC-Seal: i=1; a=rsa-sha256; t=1774007584; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DVLjGuQWaSihPsBXBlTNrhtXDgSCNHXCOi9oFZ9sBANERHCoTwW3Z4dQat3YAhR6dRtjiTtVEHl8PgfA9xVu8IkJGtEac1YbnK4MmpZMM9S0wnqPb82CucIy7lXmEyrQcOVUoRtebesyzHIb9uqi6C+Go0nlABRKkytLbXobfo4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774007584; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=elA5g80Ora1OXwWsgmluw17COHUWBC855ljGhqQTIKA=; 
	b=agXZ2LhdUqCfdS8QfiqxNXQXaNVFGQtxOOLEt22WHrAApsGjL4QPMqrRx5ntz/ZH4VdRQq84hkuEM/yUdTFDqwQTBp8lVA48ttIAVSDLNXpe53rqLuUbgTkmts6GrE03U7LJyryuBMLHYVIwN95weUUCPXhTUDWtODuwc7ayICk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774007584;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=elA5g80Ora1OXwWsgmluw17COHUWBC855ljGhqQTIKA=;
	b=Mzz7K5bLcbG1Ke8xqKv+QfMbJ2yiB9lT9J1TtiCy28e2aieDCnMZdKq6BHniFfVP
	xnMprwsMzX05nZgK+3fYLbI+qPRK/JEkW5oydB6lAhCZQ1h2QZfshbrpipSXT/9ytan
	WP9NRJzVWJTQongDqzfvH3YGWZ1gllX1Q+PdCOvo=
Received: by mx.zohomail.com with SMTPS id 1774007582516139.3042395209053;
	Fri, 20 Mar 2026 04:53:02 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 07/10] t1800: add test to verify hook execution ordering
Date: Fri, 20 Mar 2026 13:52:08 +0200
Message-ID: <20260320115211.177351-8-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260320115211.177351-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-1-adrian.ratiu@collabora.com>
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

